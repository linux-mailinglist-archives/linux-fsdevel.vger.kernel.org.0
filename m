Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2098D173A2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 15:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgB1Oou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 09:44:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22441 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727167AbgB1Oou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582901089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXGpTAeTsc+HYb8q55xKk+dP/T7Dt1sKVwoGRCyxIxk=;
        b=PMUK1n34XBZwz0JIyWyNPKJfmeKQXU8FtR9bd2Q7Tnim+GTxJOPWW3A/bZSYtx8Cug5o6e
        /G6BxxU8CHwy5YRD/BAlGFENcRU08z4w6XvEvP/rzx1VPcJCTL8JopwiqfhL9iYzVyIdHS
        XsZyAUuvGooL2IpHGAeKCn7zHluP4oQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-BJGbG-SrMxWfLot1IfDJjQ-1; Fri, 28 Feb 2020 09:44:48 -0500
X-MC-Unique: BJGbG-SrMxWfLot1IfDJjQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37D04800D5A;
        Fri, 28 Feb 2020 14:44:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 412941CB;
        Fri, 28 Feb 2020 14:44:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200226022913.i2b3rnb3ua4dlym3@yavin.dot.cyphar.com>
References: <20200226022913.i2b3rnb3ua4dlym3@yavin.dot.cyphar.com> <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk> <158230816405.2185128.14624101691579582829.stgit@warthog.procyon.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] fsinfo: Add fsinfo() syscall to query filesystem information [ver #17]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95824.1582901083.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 28 Feb 2020 14:44:43 +0000
Message-ID: <95825.1582901083@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Aleksa Sarai <cyphar@cyphar.com> wrote:

> > If params is given, all of params->__reserved[] must be 0.
> =

> I would suggest that rather than having a reserved field for future
> extensions, you make use of copy_struct_from_user() and have extensible
> structs:

Yeah.  I seem to recall that special support was required for 6-arg syscal=
ls
on some arches, though I could move the dfd argument into the parameter bl=
ock
and make AT_FDCWD the default.

> I dropped the "const" on fsinfo_params because the planned CHECK_FiELDS
> feature for extensible-struct syscalls requires writing to the struct.

Ummm...  Why?  You shouldn't be trying to alter the parameters structure. =
 It
could feasibly be stored static const in userspace (though I'm not sure ho=
w
likely it would be that someone would do that).

> I also switched the flags field to u64 because CHECK_FiELDS is intended =
to
> use (1<<63) for all syscalls (this has the nice benefit of removing the =
need
> of a padding field entirely).

 	struct fsinfo_params {
 		__u32	flags;
 		__u32	at_flags;
 		__u32	request;
 		__u32	Nth;
 		__u32	Mth;
 	};

What padding? ;-)

Though possibly the struct does need forcing to 64-bit alignment for futur=
e
expansion.

> > dfd, filename and params->at_flags indicate the file to query.  There =
is no
> > equivalent of lstat() as that can be emulated with fsinfo() by setting
> > AT_SYMLINK_NOFOLLOW in params->at_flags.
> =

> Minor gripe -- can we make the default be AT_SYMLINK_NOFOLLOW and you
> need to explicitly pass AT_SYMLINK_FOLLOW? Accidentally following
> symlinks is a constant source of security bugs.

Someone else has said that all new syscalls should be using RESOLVE_* flag=
s in
preference to AT_* flags (even though RESOLVE_* flags are not a superset o=
f
AT_* flags and appear to be in a header named specifically for the openat2=
()
syscall, not generic).

I'm not sure who authored openat2.h, but they went with a RESOLVE_NO_SYMLI=
NKS
rather than a RESOLVE_SYMLINKS ;-)

> > There is also no equivalent of fstat() as that can be emulated by
> > passing a NULL filename to fsinfo() with the fd of interest in dfd.
> =

> Presumably you also need to pass AT_EMPTY_PATH?

Actually, you need to set FSINFO_FLAGS_QUERY_FD in fsinfo_params::flags.  =
I
need to update the description for this.

> Sounds good, though I think we should zero-fill the tail end of the
> buffer (if the buffer is larger than the in-kernel one).

I do that.  I should make it clearer in the patch description.

David

