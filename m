Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0871175A07
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 13:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCBMJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 07:09:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40946 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727497AbgCBMJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583150956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZ2xJwN1TAuj2eEmBgNnYZoxdDxugiWmVbQd23vU95o=;
        b=co856hF4d2/7HQNUbxAtijQ+OJixYfN2FqCL/oGF4+fCsTlqD9JeWE/f8Yz6+Rgm4LEPxx
        GzCFSWoVNNsSLoexWNGTWjpR012+xbFLWfRgjko0tX+DZWARL2+wK8rw1XEAJqyxqz1YVS
        kjSBs5zQrexztZ1Nyh8h+tWlbWBvpwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-ZYR_4tyyMimtrkww2b8zPw-1; Mon, 02 Mar 2020 07:09:12 -0500
X-MC-Unique: ZYR_4tyyMimtrkww2b8zPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ECFE1005510;
        Mon,  2 Mar 2020 12:09:11 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-127.ams2.redhat.com [10.36.116.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDB495C1D6;
        Mon,  2 Mar 2020 12:09:08 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
References: <96563.1582901612@warthog.procyon.org.uk>
        <20200228152427.rv3crd7akwdhta2r@wittgenstein>
        <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
        <20200302115239.pcxvej3szmricxzu@wittgenstein>
Date:   Mon, 02 Mar 2020 13:09:06 +0100
In-Reply-To: <20200302115239.pcxvej3szmricxzu@wittgenstein> (Christian
        Brauner's message of "Mon, 2 Mar 2020 12:52:39 +0100")
Message-ID: <8736arnel9.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christian Brauner:

>> But that's inconsistent with the rest of the system.  And for example,
>> if you make /etc/resolv.conf a symbolic link, a program which uses a new
>> I/O library (with the new interfaces) will not be able to read it.
>
> Fair, but I expect that e.g. a C library would simply implement openat()
> on top of openat2() if the latter is available and thus could simply
> pass RESOLVE_SYMLINKS so any new I/O library not making use of the
> syscall directly would simply get the old behavior. For anyone using the
> syscall directly they need to know about its exact semantics anyway. But
> again, maybe just having it opt-in is fine.

I'm more worried about fancy new libraries which go directly to the new
system calls, but set the wrong defaults for a general-purpose open
operation.

Can we pass RESOLVE_SYMLINKS with O_NOFLLOW, so that we can easily
implement open/openat for architectures that provide only the openat2
system call?

>> AT_SYMLINK_NOFOLLOW only applies to the last pathname component anyway,
>> so it's relatively little protection.
>
> So this is partially why I think it's at least worth considerings: the
> new RESOLVE_NO_SYMLINKS flag does block all symlink resolution, not just
> for the last component in contrast to AT_SYMLINK_NOFOLLOW. This is
> 278121417a72d87fb29dd8c48801f80821e8f75a

RESOLVE_NO_SYMLINKS shouldn't be the default, though (whoever is
responsible for applying that default).  Otherwise system administrators
can no longer move around data between different file systems and set
symbolic links accordingly.

Thanks,
Florian

