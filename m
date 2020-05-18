Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210681D741F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 11:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgERJdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 05:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgERJdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 05:33:00 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B0CC061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 02:32:59 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i16so3441244edv.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2VgpfXcNwy7TREHNFQ18NMpwIG1aLQl5IHZiO+aFRFg=;
        b=QP0+JFbB42FP8b0D9HjpzR1E6N6d/ZxgiGmuevEMpNy/a4lrt5vm2EhQ69w6loWJox
         rm0jIH0TyynJRmaTlQIb2HZjZK8kJb9um+WHblQIWyBSZNEd/VAQavvEIGPP++Ts15Hs
         TK/p0qGwPdEzXNxKh3RcttUAAjZlLZbQfP0A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2VgpfXcNwy7TREHNFQ18NMpwIG1aLQl5IHZiO+aFRFg=;
        b=aqJxcpstah2b4hwLL822n/HiwIE14u9iq7HScLVtlA2xsrrfwbZvllBnQ6BzKIvaWr
         OT4HaOf9O/R6kLL3VSjh/2f51iF462PqsyhCovT+58E7pkmui27HrY+JKFsCf2+FID/h
         wUHyHkXvk4JGkkeNN13JtujAeWtpBS9hc5RIeUj7PEIG5CjATwFrm240QXVMGBh4M/Vz
         522dEv3Szs3MPFsuAFIcw6uloqjymwrsZfScdQbkfVXtjzMDiIXHXMEE9oqHqHof+MB8
         P/uoJm83BJcRT7wKg+TcSWfbLRklhM9rncDxoSDtVz/l+oTIOXPK6S4aLjCz5UPP+OKP
         5V2A==
X-Gm-Message-State: AOAM5300CQ4GlPjw1UrXfQ+VsRlvrVcI/TnWII2cTnr7BQU0BPbHinJz
        0g2EheOQtH0CCdWc2kNHKDrIjwM3+0bbVEk31heAx66mIjy/Tw==
X-Google-Smtp-Source: ABdhPJyxA0x8w1n4vgblorzwwP4PlDWFNBc8JIRKpAEQZKkJ4OJZMc0y6wP/gBfFHC6ii/HQOSa8g5ffD8mMnZKb9bY=
X-Received: by 2002:a05:6402:1296:: with SMTP id w22mr12015540edv.364.1589794378263;
 Mon, 18 May 2020 02:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <871rnlq82d.fsf@vostro.rath.org>
In-Reply-To: <871rnlq82d.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 May 2020 11:32:46 +0200
Message-ID: <CAJfpegs7wwnxgnWc4JRqRdTjVwFGd-KjhFqtmaJfpSxA4uzBrg@mail.gmail.com>
Subject: Re: Unable to access fuse mountpoint with seteuid()
To:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        miklos <mszeredi@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000002f01d505a5e8d942"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000002f01d505a5e8d942
Content-Type: text/plain; charset="UTF-8"

On Fri, May 15, 2020 at 10:05 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> Hello,
>
> I've written a setuid root program that tries to access a FUSE
> mountpoint owned by the calling user. I'm running seteuid(getuid()) to
> drop privileges, but still don't seem to be able to access the
> mountpoint.
>
> Is that a bug or a feature? If it's a feature, is there any other way to
> get access to the mountpoint? All I want is the st_dev value...

It's a feature:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/fuse/dir.c?h=v5.6#n1071

However, st_dev is definitely not something that could be used for DoS
(it's not even controlled by the fuse daemon).  The attached patch
(untested) allows querying st_dev with statx(2) and a zero mask
argument.

The other option is to parse /proc/self/mountinfo, but that comes with
some caveats.

Thanks,
Miklos

--0000000000002f01d505a5e8d942
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-always-allow-query-of-st_dev.patch"
Content-Disposition: attachment; 
	filename="fuse-always-allow-query-of-st_dev.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kacahr9g0>
X-Attachment-Id: f_kacahr9g0

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGlyLmMgYi9mcy9mdXNlL2Rpci5jCmluZGV4IGRlMWUyZmRl
NjBiZC4uMjZmMDI4YmM3NjBiIDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rpci5jCisrKyBiL2ZzL2Z1
c2UvZGlyLmMKQEAgLTE2ODksOCArMTY4OSwxOCBAQCBzdGF0aWMgaW50IGZ1c2VfZ2V0YXR0cihj
b25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwgc3RydWN0IGtzdGF0ICpzdGF0LAogCXN0cnVjdCBpbm9k
ZSAqaW5vZGUgPSBkX2lub2RlKHBhdGgtPmRlbnRyeSk7CiAJc3RydWN0IGZ1c2VfY29ubiAqZmMg
PSBnZXRfZnVzZV9jb25uKGlub2RlKTsKIAotCWlmICghZnVzZV9hbGxvd19jdXJyZW50X3Byb2Nl
c3MoZmMpKQorCWlmICghZnVzZV9hbGxvd19jdXJyZW50X3Byb2Nlc3MoZmMpKSB7CisJCWlmICgh
cmVxdWVzdF9tYXNrKSB7CisJCQkvKgorCQkJICogSWYgdXNlciBleHBsaWNpdGx5IHJlcXVlc3Rl
ZCAqbm90aGluZyogdGhlbiBkb24ndAorCQkJICogZXJyb3Igb3V0LCBidXQgcmV0dXJuIHN0X2Rl
diBvbmx5LgorCQkJICovCisJCQlzdGF0LT5yZXN1bHRfbWFzayA9IDA7CisJCQlzdGF0LT5kZXYg
PSBpbm9kZS0+aV9zYi0+c19kZXY7CisJCQlyZXR1cm4gMDsKKwkJfQogCQlyZXR1cm4gLUVBQ0NF
UzsKKwl9CiAKIAlyZXR1cm4gZnVzZV91cGRhdGVfZ2V0X2F0dHIoaW5vZGUsIE5VTEwsIHN0YXQs
IHJlcXVlc3RfbWFzaywgZmxhZ3MpOwogfQo=
--0000000000002f01d505a5e8d942--
