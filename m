Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AEF2D2655
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 09:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgLHIhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 03:37:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgLHIhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607416567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0DvwN+nbpM7GczMlB5PaNqfbUXqBsL7aXUwvB7aLZR4=;
        b=WC1vYy7Zwia9RI9KbcpXEZT3HwXd9L/U+Ep6I3GCAYciol1GAcTdYA4ztBOzr+ZHY8FaEv
        lIomJnghxhYN70y9PCYPSjh48n5C1N6aUoq3Pk14QFOsimFyeeLwmWSlAhBRS1pG43CghN
        uvrbvMndemReJt5v1TcTN8AzPwyUmGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-dxz25ZAtOHqbSlHdfc70PQ-1; Tue, 08 Dec 2020 03:36:05 -0500
X-MC-Unique: dxz25ZAtOHqbSlHdfc70PQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F77380EDA3;
        Tue,  8 Dec 2020 08:36:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99B985D6AB;
        Tue,  8 Dec 2020 08:36:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6db2af99-e6e3-7f28-231e-2bdba05ca5fa@infradead.org>
References: <6db2af99-e6e3-7f28-231e-2bdba05ca5fa@infradead.org> <0000000000002a530d05b400349b@google.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: memory leak in generic_parse_monolithic [+PATCH]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <928042.1607416561.1@warthog.procyon.org.uk>
Date:   Tue, 08 Dec 2020 08:36:01 +0000
Message-ID: <928043.1607416561@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> Otherwise please look at the patch below.

The patch won't help, since it's not going through sys_fsconfig() - worse, it
introduces two new errors.

>  		fc->source = param->string;
> -		param->string = NULL;

This will cause the string now attached to fc->source to be freed by the
caller.  No, the original is doing the correct thing here.  The point is to
steal the string.

> @@ -262,7 +262,9 @@ static int vfs_fsconfig_locked(struct fs
>
> -		return vfs_parse_fs_param(fc, param);
> +		ret = vfs_parse_fs_param(fc, param);
> +		kfree(param->string);
> +		return ret;

But your stack trace shows you aren't going through sys_fsconfig(), so this
function isn't involved.  Further, this introduces a double free, since
sys_fsconfig() frees param.string after it drops uapi_mutex.

Looking at the backtrace:

>      kmemdup_nul+0x2d/0x70 mm/util.c:151
>      vfs_parse_fs_string+0x6e/0xd0 fs/fs_context.c:155
>      generic_parse_monolithic+0xe0/0x130 fs/fs_context.c:201
>      do_new_mount fs/namespace.c:2871 [inline]
>      path_mount+0xbbb/0x1170 fs/namespace.c:3205
>      do_mount fs/namespace.c:3218 [inline]
>      __do_sys_mount fs/namespace.c:3426 [inline]
>      __se_sys_mount fs/namespace.c:3403 [inline]
>      __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3403

A couple of possibilities spring to mind from that: maybe
vfs_parse_fs_string() is not releasing the param.string - but that's not the
problem since we stole the string and the free is definitely there at the
bottom of the function:

	int vfs_parse_fs_string(struct fs_context *fc, const char *key,
				const char *value, size_t v_size)
	{
	...
		kfree(param.string);
		return ret;
	}

or fc->source is not being cleaned up in vfs_clean_context() - but that's
there as well:

	void vfs_clean_context(struct fs_context *fc)
	{
	...
		kfree(fc->source);
		fc->source = NULL;

In either of these cases, I would expect this to have already become evident
from other filesystem mounts as there would be a lot of leaking going on,
particularly with the first.

Now the backtrace only shows what the state was when the string was allocated;
it doesn't show what happened to it after that, so another possibility is that
the filesystem being mounted nicked what vfs_parse_fs_param() had rightfully
stolen, transferring fc->source somewhere else and then failed to release it -
most likely on mount failure (ie. it's an error handling bug in the
filesystem).

Do we know what filesystem it was?

David

