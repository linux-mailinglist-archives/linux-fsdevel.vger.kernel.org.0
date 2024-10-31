Return-Path: <linux-fsdevel+bounces-33315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B929B73C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 05:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888FF2817C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 04:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66B126BF5;
	Thu, 31 Oct 2024 04:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gnkUv/Dv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA1015D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 04:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730348206; cv=none; b=XzPfq7xPogOfxWQhz8WzDuv9mTIWiPooHjsQdPROLFIxpgL5JJJOt++yEH3+KWnTEUiUKrISfsyBhAWXq65/0RlkEuBpRbTpmEDeoM55XKiDsiKQGnK2OQqqBluKXAaKQALMMqkVHhCij34+HGdsFM0XSTk6SCG+u8VssLkZ1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730348206; c=relaxed/simple;
	bh=xdTMB5mH53eRmMhNGiRJf3MOmUeu1DjlabGahGpGkSE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RvinlMn2eDf3VtRvTomZShI38wz13Ih+Swvn646+y7Nc6WLWQ1nQyToS5RMPOD9OSGBY/5T0laRqtH6+oT8FCfe1w/bcrDrwQmN9t+pSbl1V3OHgJWXzizMbaxDPtO2IEwQo82PGspQcdkeuIps2snHRSeIn7qwB/BCD8MTLWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gnkUv/Dv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cb6704ff6bso716170a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 21:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730348202; x=1730953002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PjUUN+pUu7aAtkLIEjQSxN2sW69Zq1jbLWcrZXOkFzM=;
        b=gnkUv/Dv3W7AB9w3KaVhbQFDVp5QniC0X5qU0YrWM3sA5zPljXhlG5QI7G5HaEDFg6
         LYc6b+GYydJxpZjooNpg7YviR079chvjxfOe1hSMHOxvatTzHi6cyZ9eGuH4CaFSc4tE
         IgQ+HgI3IRjSm4DLnjpEL8ThtTMff2dL77D3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730348202; x=1730953002;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjUUN+pUu7aAtkLIEjQSxN2sW69Zq1jbLWcrZXOkFzM=;
        b=mW2XU/gBuXswn39+WL881XeA0bimupxpBZ7Q+pQ8DNYzgnpwcOmkDkssIX/yjlK/Uo
         Z/n7WMjfbMUgJ/yffdEZFnpt2D4UfNP8LHQbmzmCRq6ML4fUDzDdhZwy/pTvNRQZS34O
         7kZPmxko79MezXNjsmwe3QQEE+DU6M+QZJXygnv3Fzj+ljT7c+k1Ph4XKueMSlsb2Ubj
         biP6G0khmxE4ySSiwN38uwAs3nHEcM6JKUxuy66c1ptAIUJHtES8KJuGgd/s/NY7Hw8V
         6FBlQhs2R+pj5YL5VmtDnnaOi+fl7FvECvmCBJEVkZJ+N9EdUpz4sfnMgVeyHwBV0ePj
         XIyg==
X-Gm-Message-State: AOJu0YzoxZpwG7rRZh7d6QxPyVu6BEfopGpIBSDdtbJiZA5vX36JTp2b
	dVKFJAzIp3lKfzeT3VwvhtumD+uFay0DFemP22ASJrZUq7D8k0deZ9Tu0RaqsRzAuAhfOa7F9SA
	jBlg=
X-Google-Smtp-Source: AGHT+IHxWXc7/f6u20FNK+fL9s5pFbGyulbs+GzYw6kALANTDEMrF19p/jryOnmFyzJ6wak+VoRtyg==
X-Received: by 2002:a17:906:f5a6:b0:a9a:f84:fefd with SMTP id a640c23a62f3a-a9de5edbf04mr1752209866b.36.1730348201554;
        Wed, 30 Oct 2024 21:16:41 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c5348sm23822766b.49.2024.10.30.21.16.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 21:16:40 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso59471366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 21:16:39 -0700 (PDT)
X-Received: by 2002:a17:907:6d09:b0:a99:f887:ec09 with SMTP id
 a640c23a62f3a-a9de5ecade8mr1642383366b.35.1730348199083; Wed, 30 Oct 2024
 21:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Oct 2024 18:16:22 -1000
X-Gmail-Original-Message-ID: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
Message-ID: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
Subject: generic_permission() optimization
To: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000bebb0b0625be152e"

--000000000000bebb0b0625be152e
Content-Type: text/plain; charset="UTF-8"

So call me crazy, but due to entirely unrelated changes (the x86
barrier_nospec optimization) I was doing some profiles to check that
everything looked fine.

And just looking at kernel profiles, I noticed that
"generic_permission()" wasn't entirely in the noise. It was right
there along with strncpy_from_user() etc. Which is a bit surprising,
because it should be really cheap to check basic Unix permissions?

It's all really just "acl_permission_check()" and that code is
actually fairly optimized, except that the whole

        vfsuid = i_uid_into_vfsuid(idmap, inode);

to check whether we're the owner is *not* cheap. It causes a call to
make_vfsuid(), and it's just messy.

Which made me wonder: we already have code that says "if the Group and
Other permission bits are the same wrt the mask we are checking, don't
bother doing the expensive group checks".

Why not extend that to "if any of the UGO choices are ok with the
permissions, why bother looking up ownership at all?"

Now, there is one reason to look up the owner: POSIX ACL's don't
matter to owners, but do matter to others.

But we could check for the cached case of "no POSIX ACLs" very
cheaply, and only do it for that case.

IOW, a patch something like the attached.

No, I didn't really check whether it makes any difference at all. But
my gut feel is that a *lot* of permission checks succeed for any user,
with things like system directories are commonly drwxr-xr-x, so if you
want to check read or execute permissions, it really doesn't matter
whether you are the User, the Group, or Other.

So thus the code does that

        unsigned int all;
        all = mode & (mode >> 3); // combine g into o
        all &= mode >> 6;         // ... and u into o

so now the low three bits of 'all' are the bits that *every* case has
set. And then

        if (!(mask & ~all & 7))
                return 0;

basically says "if what we are asking for is not zero in any of those
bits, we're good".

And it's entirely possible that I'm missing something silly and am
being just stupid. Somebody hit me with the clue bat if so.

               Linus

--000000000000bebb0b0625be152e
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m2wskrgv0>
X-Attachment-Id: f_m2wskrgv0

IGZzL25hbWVpLmMgfCAzMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxl
IGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9uYW1laS5jIGIvZnMv
bmFtZWkuYwppbmRleCA0YTRhMjJhMDhhYzIuLjZhZWFiZGUwZWM5ZiAxMDA2NDQKLS0tIGEvZnMv
bmFtZWkuYworKysgYi9mcy9uYW1laS5jCkBAIC0zMjYsNiArMzI2LDI1IEBAIHN0YXRpYyBpbnQg
Y2hlY2tfYWNsKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLAogCXJldHVybiAtRUFHQUlOOwogfQog
CisvKgorICogVmVyeSBxdWljayBvcHRpbWlzdGljICJ3ZSBrbm93IHdlIGhhdmUgbm8gQUNMJ3Mi
IGNoZWNrLgorICoKKyAqIE5vdGUgdGhhdCB0aGlzIGlzIHB1cmVseSBmb3IgQUNMX1RZUEVfQUND
RVNTLCBhbmQgcHVyZWx5CisgKiBmb3IgdGhlICJ3ZSBoYXZlIGNhY2hlZCB0aGF0IHRoZXJlIGFy
ZSBubyBBQ0xzIiBjYXNlLgorICoKKyAqIElmIHRoaXMgcmV0dXJucyB0cnVlLCB3ZSBrbm93IHRo
ZXJlIGFyZSBubyBBQ0xzLiBCdXQgaWYKKyAqIGl0IHJldHVybnMgZmFsc2UsIHdlIG1pZ2h0IHN0
aWxsIG5vdCBoYXZlIEFDTHMgKGl0IGNvdWxkCisgKiBiZSB0aGUgaXNfdW5jYWNoZWRfYWNsKCkg
Y2FzZSkuCisgKi8KK3N0YXRpYyBpbmxpbmUgYm9vbCBub19hY2xfaW5vZGUoc3RydWN0IGlub2Rl
ICppbm9kZSkKK3sKKyNpZmRlZiBDT05GSUdfRlNfUE9TSVhfQUNMCisJcmV0dXJuIGxpa2VseSgh
UkVBRF9PTkNFKGlub2RlLT5pX2FjbCkpOworI2Vsc2UKKwlyZXR1cm4gdHJ1ZTsKKyNlbmRpZgor
fQorCiAvKioKICAqIGFjbF9wZXJtaXNzaW9uX2NoZWNrIC0gcGVyZm9ybSBiYXNpYyBVTklYIHBl
cm1pc3Npb24gY2hlY2tpbmcKICAqIEBpZG1hcDoJaWRtYXAgb2YgdGhlIG1vdW50IHRoZSBpbm9k
ZSB3YXMgZm91bmQgZnJvbQpAQCAtMzQ4LDYgKzM2NywxOSBAQCBzdGF0aWMgaW50IGFjbF9wZXJt
aXNzaW9uX2NoZWNrKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLAogCXVuc2lnbmVkIGludCBtb2Rl
ID0gaW5vZGUtPmlfbW9kZTsKIAl2ZnN1aWRfdCB2ZnN1aWQ7CiAKKwkvKgorCSAqIENvbW1vbiBj
aGVhcCBjYXNlOiBldmVyeWJvZHkgaGFzIHRoZSByZXF1ZXN0ZWQKKwkgKiByaWdodHMsIGFuZCB0
aGVyZSBhcmUgbm8gQUNMcyB0byBjaGVjay4gTm8gbmVlZAorCSAqIHRvIGRvIGFueSBvd25lci9n
cm91cCBjaGVja3MuCisJICovCisJaWYgKG5vX2FjbF9pbm9kZShpbm9kZSkpIHsKKwkJdW5zaWdu
ZWQgaW50IGFsbDsKKwkJYWxsID0gbW9kZSAmIChtb2RlID4+IDMpOyAvLyBjb21iaW5lIGcgaW50
byBvCisJCWFsbCAmPSBtb2RlID4+IDY7CSAgLy8gLi4uIGFuZCB1IGludG8gbworCQlpZiAoISht
YXNrICYgfmFsbCAmIDcpKQorCQkJcmV0dXJuIDA7CisJfQorCiAJLyogQXJlIHdlIHRoZSBvd25l
cj8gSWYgc28sIEFDTCdzIGRvbid0IG1hdHRlciAqLwogCXZmc3VpZCA9IGlfdWlkX2ludG9fdmZz
dWlkKGlkbWFwLCBpbm9kZSk7CiAJaWYgKGxpa2VseSh2ZnN1aWRfZXFfa3VpZCh2ZnN1aWQsIGN1
cnJlbnRfZnN1aWQoKSkpKSB7Cg==
--000000000000bebb0b0625be152e--

