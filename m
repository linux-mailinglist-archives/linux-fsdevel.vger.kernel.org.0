Return-Path: <linux-fsdevel+bounces-45461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BFDA77EFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 17:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483AB16C21A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF74A20AF92;
	Tue,  1 Apr 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CC+Q2tvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA71F1517
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521603; cv=none; b=H9yjrWj10X+U2T4LfqeCECWUwD333IdRDVGJXzzjrOm6IsbwcU3G71HggiQzk5ICygysWX94sHmHXdkIw8xKo3wuNinmpzyeukGJH7QPD9NtACmGbcNmrjJxosJjbRtefR899gawxrdYvh/VcK6A6GYCDoBZ2bHltMLE7ZPEegI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521603; c=relaxed/simple;
	bh=t+Qib5nHnDXjaJVocaTTtqnSJieem+VXXFLu3b2856M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HplZvoynUba0j8LwE5rPCcGdN0Qh1WU2Bzxdx9aEYofSr9sg1xJF3W/PMVnXo9X+gq7sma36cvAfPuI2DPrPD05LMCf109wY28k4BMEA3kkgv6Efjn4Y4NyHiwVPJ8p+YSJUbw/CSm+RNcb/VdMAbi/+jrIrWgWiZrabfucUJn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CC+Q2tvS; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47688ae873fso57921371cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1743521599; x=1744126399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t+Qib5nHnDXjaJVocaTTtqnSJieem+VXXFLu3b2856M=;
        b=CC+Q2tvShJN7qO5N+sWoFKT5/UApGhIEDpGdEnuWuB46XjhF7tPqWf+nXoydnNBGlk
         8XPLhP39jtwkuvZfcC1KQ8SE2YRZsNK5fchVQlphu4UyGank/hdBFHp3cCtoNYR1d3LZ
         Iean5Wm4zOCV0rOf0LRDsbO+vZVWYHcm8WljI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743521599; x=1744126399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+Qib5nHnDXjaJVocaTTtqnSJieem+VXXFLu3b2856M=;
        b=dRUlhB/SmCHWfJNZ6u+yNjtv7hWu2WvNg/J4O2thBQ3K0ytfZXULcO9KrkQ1CrzZd4
         +/u3/bce1riL6EcARhkTrNk0yRKxLnC1RE3yttwEifti/AcEYmf+I1AHFSq5UdlK+vse
         rLZoVK8RUhU4F/3BnkU8hdTp3gwl1rnjQYXLA8G4EdX6PfTIzkFgpreZDgXZplaJcPa6
         Ib5Ro3L5hujeXdf2k83LY6xzpF0jGjmV6BaWwLA95vS/4FawHfFRWwy7v22AwDg7/vvK
         fOn3UpYzGq5lKRnRWzYYfey+82GcdaCG2T7mS3wo/K3Y+yB7AnOMwB4k0BkmYhouoMb/
         RR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHn07KBqv3ib/6ogVwhS4+xOpvG9Hscjf74aDouCiuT6sovYq7a0S1SVZrIv2TTUldZmOqhwSjsmHmv6vH@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVioeVg8SIWDT3bj78Q3InwwgRl3GgojzvHJAKTeGwuu5Roco
	JzzamGC8gutioeQygmjuSHP3+ihEfT9zc+mKygVZw13QOyN2JqstrJtU4bH63YNbtYOx6RuZbaN
	QONG9ojcOq6LVevCcYUmA2eSuUv3JaK3DbcNAPQ==
X-Gm-Gg: ASbGncsfvXNa87mCTlg6Fn5vvae62K1AApBKUdWeJgb0pJaGcMFZ5SXm/uz4zhfwJLE
	zd61PeEN+2NO4jyEpQ1CgXhlXuYtMzlIfjlSBoLaqAqxwg4zJB37txb1zmuld54BMAUBqBLOF8p
	wuCAJaB83h+qm17f6iUVJzKmQp4HaNeh+y+ML2
X-Google-Smtp-Source: AGHT+IHa116vmL2Z5Aq2fV2WY+Y2v/VkQaYSGka903hF+BoTbYKsBMlvaSypu1+9o1neeUM2mpRF+p5KebfED8HkIdg=
X-Received: by 2002:ac8:5cd2:0:b0:476:91a5:c832 with SMTP id
 d75a77b69052e-477f7aeaf03mr234289051cf.32.1743521599578; Tue, 01 Apr 2025
 08:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314221701.12509-1-jaco@uls.co.za> <20250401142831.25699-1-jaco@uls.co.za>
 <20250401142831.25699-3-jaco@uls.co.za> <CAJfpegtOGWz_r=7dbQiCh2wqjKh59BqzqJ0ruhtYtsYBB+GG2Q@mail.gmail.com>
 <19df312f-06a2-4e71-960a-32bc952b0ed2@uls.co.za>
In-Reply-To: <19df312f-06a2-4e71-960a-32bc952b0ed2@uls.co.za>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 1 Apr 2025 17:33:06 +0200
X-Gm-Features: AQ5f1JqNKTmfouI8hy05YpWvpZNhzZZXyko9L4FgdKti0LZRHnYUJqPtKnHWr74
Message-ID: <CAJfpegseKMRLpu3-yS6PeU2aTmh_qKyAvJUWud_SLz1aCHY_tw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer size.
To: Jaco Kroon <jaco@uls.co.za>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr, 
	joannelkoong@gmail.com, rdunlap@infradead.org, trapexit@spawn.link, 
	david.laight.linux@gmail.com
Content-Type: multipart/mixed; boundary="0000000000009a16360631b941a6"

--0000000000009a16360631b941a6
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 17:04, Jaco Kroon <jaco@uls.co.za> wrote:

> Because fuse_simple_request via fuse_args_pages (ap) via fuse_io_args
> (ia) expects folios and changing that is more than what I'm capable off,
> and has larger overall impact.

Attaching a minimally tested patch.

Thanks,
Miklos

--0000000000009a16360631b941a6
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-kvmalloc-readdir-buf.patch"
Content-Disposition: attachment; filename="fuse-kvmalloc-readdir-buf.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m8ynpz2y0>
X-Attachment-Id: f_m8ynpz2y0

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvcmVhZGRpci5jIGIvZnMvZnVzZS9yZWFkZGlyLmMKaW5kZXgg
MTdjZTk2MzZhMmIxLi4xOGUzOTUwZTVmZjUgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvcmVhZGRpci5j
CisrKyBiL2ZzL2Z1c2UvcmVhZGRpci5jCkBAIC0zMzIsMzUgKzMzMiwzMSBAQCBzdGF0aWMgaW50
IGZ1c2VfcmVhZGRpcl91bmNhY2hlZChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGRpcl9jb250
ZXh0ICpjdHgpCiB7CiAJaW50IHBsdXM7CiAJc3NpemVfdCByZXM7Ci0Jc3RydWN0IGZvbGlvICpm
b2xpbzsKIAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9pbm9kZShmaWxlKTsKIAlzdHJ1Y3Qg
ZnVzZV9tb3VudCAqZm0gPSBnZXRfZnVzZV9tb3VudChpbm9kZSk7CiAJc3RydWN0IGZ1c2VfaW9f
YXJncyBpYSA9IHt9OwotCXN0cnVjdCBmdXNlX2FyZ3NfcGFnZXMgKmFwID0gJmlhLmFwOwotCXN0
cnVjdCBmdXNlX2ZvbGlvX2Rlc2MgZGVzYyA9IHsgLmxlbmd0aCA9IFBBR0VfU0laRSB9OworCXN0
cnVjdCBmdXNlX2FyZ3MgKmFyZ3MgPSAmaWEuYXAuYXJnczsKKwl2b2lkICpidWY7CisJc2l6ZV90
IGJ1ZnNpemUgPSAxMzEwNzI7CiAJdTY0IGF0dHJfdmVyc2lvbiA9IDAsIGV2aWN0X2N0ciA9IDA7
CiAJYm9vbCBsb2NrZWQ7CiAKLQlmb2xpbyA9IGZvbGlvX2FsbG9jKEdGUF9LRVJORUwsIDApOwot
CWlmICghZm9saW8pCisJYnVmID0ga3ZtYWxsb2MoYnVmc2l6ZSwgR0ZQX0tFUk5FTCk7CisJaWYg
KCFidWYpCiAJCXJldHVybiAtRU5PTUVNOwogCisJYXJncy0+b3V0X2FyZ3NbMF0udmFsdWUgPSBi
dWY7CisKIAlwbHVzID0gZnVzZV91c2VfcmVhZGRpcnBsdXMoaW5vZGUsIGN0eCk7Ci0JYXAtPmFy
Z3Mub3V0X3BhZ2VzID0gdHJ1ZTsKLQlhcC0+bnVtX2ZvbGlvcyA9IDE7Ci0JYXAtPmZvbGlvcyA9
ICZmb2xpbzsKLQlhcC0+ZGVzY3MgPSAmZGVzYzsKIAlpZiAocGx1cykgewogCQlhdHRyX3ZlcnNp
b24gPSBmdXNlX2dldF9hdHRyX3ZlcnNpb24oZm0tPmZjKTsKIAkJZXZpY3RfY3RyID0gZnVzZV9n
ZXRfZXZpY3RfY3RyKGZtLT5mYyk7Ci0JCWZ1c2VfcmVhZF9hcmdzX2ZpbGwoJmlhLCBmaWxlLCBj
dHgtPnBvcywgUEFHRV9TSVpFLAotCQkJCSAgICBGVVNFX1JFQURESVJQTFVTKTsKKwkJZnVzZV9y
ZWFkX2FyZ3NfZmlsbCgmaWEsIGZpbGUsIGN0eC0+cG9zLCBidWZzaXplLCBGVVNFX1JFQURESVJQ
TFVTKTsKIAl9IGVsc2UgewotCQlmdXNlX3JlYWRfYXJnc19maWxsKCZpYSwgZmlsZSwgY3R4LT5w
b3MsIFBBR0VfU0laRSwKLQkJCQkgICAgRlVTRV9SRUFERElSKTsKKwkJZnVzZV9yZWFkX2FyZ3Nf
ZmlsbCgmaWEsIGZpbGUsIGN0eC0+cG9zLCBidWZzaXplLCBGVVNFX1JFQURESVIpOwogCX0KIAls
b2NrZWQgPSBmdXNlX2xvY2tfaW5vZGUoaW5vZGUpOwotCXJlcyA9IGZ1c2Vfc2ltcGxlX3JlcXVl
c3QoZm0sICZhcC0+YXJncyk7CisJcmVzID0gZnVzZV9zaW1wbGVfcmVxdWVzdChmbSwgYXJncyk7
CiAJZnVzZV91bmxvY2tfaW5vZGUoaW5vZGUsIGxvY2tlZCk7CiAJaWYgKHJlcyA+PSAwKSB7CiAJ
CWlmICghcmVzKSB7CkBAIC0zNjksMTYgKzM2NSwxNCBAQCBzdGF0aWMgaW50IGZ1c2VfcmVhZGRp
cl91bmNhY2hlZChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpCiAJ
CQlpZiAoZmYtPm9wZW5fZmxhZ3MgJiBGT1BFTl9DQUNIRV9ESVIpCiAJCQkJZnVzZV9yZWFkZGly
X2NhY2hlX2VuZChmaWxlLCBjdHgtPnBvcyk7CiAJCX0gZWxzZSBpZiAocGx1cykgewotCQkJcmVz
ID0gcGFyc2VfZGlycGx1c2ZpbGUoZm9saW9fYWRkcmVzcyhmb2xpbyksIHJlcywKLQkJCQkJCWZp
bGUsIGN0eCwgYXR0cl92ZXJzaW9uLAorCQkJcmVzID0gcGFyc2VfZGlycGx1c2ZpbGUoYnVmLCBy
ZXMsIGZpbGUsIGN0eCwgYXR0cl92ZXJzaW9uLAogCQkJCQkJZXZpY3RfY3RyKTsKIAkJfSBlbHNl
IHsKLQkJCXJlcyA9IHBhcnNlX2RpcmZpbGUoZm9saW9fYWRkcmVzcyhmb2xpbyksIHJlcywgZmls
ZSwKLQkJCQkJICAgIGN0eCk7CisJCQlyZXMgPSBwYXJzZV9kaXJmaWxlKGJ1ZiwgcmVzLCBmaWxl
LCBjdHgpOwogCQl9CiAJfQogCi0JZm9saW9fcHV0KGZvbGlvKTsKKwlrdmZyZWUoYnVmKTsKIAlm
dXNlX2ludmFsaWRhdGVfYXRpbWUoaW5vZGUpOwogCXJldHVybiByZXM7CiB9Cg==
--0000000000009a16360631b941a6--

