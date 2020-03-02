Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B84175990
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCBLa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 06:30:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58532 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727717AbgCBLaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583148654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9IY3G3KV70/MnD62Hf8Yen6UaJhR5WJT6Ca0OFN7E5g=;
        b=ITUT/GaNVsd7HT1EJVnZ3avmFppDQwaoAK05A75wZ/9xSGmI5yCCQTFeGF1IaVKQliJFT3
        Uwgv0B+0cVuYm8SSAW1uchOTcveG9EuqvjbJ06UlWparY4PxasaXZYc/zAE7icW9zxJPmT
        vOkSl8f940KnOkjA269y9z8MpuW/zBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-edjuqXfzMkSDux5kDW0btQ-1; Mon, 02 Mar 2020 06:30:53 -0500
X-MC-Unique: edjuqXfzMkSDux5kDW0btQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B24A800053;
        Mon,  2 Mar 2020 11:30:51 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-127.ams2.redhat.com [10.36.116.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C842A1001B2C;
        Mon,  2 Mar 2020 11:30:48 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
References: <96563.1582901612@warthog.procyon.org.uk>
        <20200228152427.rv3crd7akwdhta2r@wittgenstein>
Date:   Mon, 02 Mar 2020 12:30:47 +0100
In-Reply-To: <20200228152427.rv3crd7akwdhta2r@wittgenstein> (Christian
        Brauner's message of "Fri, 28 Feb 2020 16:24:27 +0100")
Message-ID: <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christian Brauner:

> [Cc Florian since that ends up on libc's table sooner or later...]

I'm not sure what you are after here =E2=80=A6

> On Fri, Feb 28, 2020 at 02:53:32PM +0000, David Howells wrote:
>>=20=09
>> I've been told that RESOLVE_* flags, which can be found in linux/openat2=
.h,
>> should be used instead of the equivalent AT_* flags for new system calls=
.  Is
>> this the case?
>
> Imho, it would make sense to use RESOLVE_* flags for new system calls
> and afair this was the original intention.
> The alternative is that RESOLVE_* flags are special to openat2(). But
> that seems strange, imho. The semantics openat2() has might be very
> useful for new system calls as well which might also want to support
> parts of AT_* flags (see fsinfo()). So we either end up adding new AT_*
> flags mirroring the new RESOLVE_* flags or we end up adding new
> RESOLVE_* flags mirroring parts of AT_* flags. And if that's a
> possibility I vote for RESOLVE_* flags going forward. The have better
> naming too imho.
>
> An argument against this could be that we might end up causing more
> confusion for userspace due to yet another set of flags. But maybe this
> isn't an issue as long as we restrict RESOLVE_* flags to new syscalls.
> When we introduce a new syscall userspace will have to add support for
> it anyway.

I missed the start of the dicussion and what this is about, sorry.

Regarding open flags, I think the key point for future APIs is to avoid
using the set of flags for both control of the operation itself
(O_NOFOLLOW/AT_SYMLINK_NOFOLLOW, O_NOCTTY) and properaties of the
resulting descriptor (O_RDWR, O_SYNC).  I expect that doing that would
help code that has to re-create an equivalent descriptor.  The operation
flags are largely irrelevant to that if you can get the descriptor by
other means.

>>  (*) It has been suggested that AT_SYMLINK_NOFOLLOW should be the defaul=
t, but
>>      only RESOLVE_NO_SYMLINKS exists.
>
> I'd be very much in favor of not following symlinks being the default.
> That's usually a source of a lot of security issues.

But that's inconsistent with the rest of the system.  And for example,
if you make /etc/resolv.conf a symbolic link, a program which uses a new
I/O library (with the new interfaces) will not be able to read it.

AT_SYMLINK_NOFOLLOW only applies to the last pathname component anyway,
so it's relatively little protection.

Thanks,
Florian

