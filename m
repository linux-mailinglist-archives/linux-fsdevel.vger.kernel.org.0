Return-Path: <linux-fsdevel+bounces-51423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DA2AD6B7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 10:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0963A3A74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF9C223339;
	Thu, 12 Jun 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fibZEYV2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255D21CC6D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718601; cv=none; b=p988uvlVbHTVHkx+gyJwfLDU/ee6hKD25cG0393fWvy+PJ9PEEJhgYBUPoLHq9OGt/M8VyGai0g1bUNp6DisVoP2xH8fJ0qgk89w3GnHkYk5q/l/h3IT1UpAye3DAksuMsAoB822/LjX9225UzHSNiSwYk7/ZRsX4O2KnO4jQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718601; c=relaxed/simple;
	bh=OXO9Ksx6UGvju2TD4wjBJsg6mvgy3QZrrLoi3fnzs0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPN/HCHQENDc3e3PHb83WnM79WDEJox5MtTQvA3qkLCUERfoqIbp6b4LNuVe9liAgubl+UXvLyNTZ/Nay7pSp1howhABLN6zcbDu02MzfrvkZJMXeZwi1pxVDP5JKU7jAnNtxiMygTLDgnLpbHVfr7STt6JcWgouQIFRTCXR64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fibZEYV2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a4bb155edeso9837281cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1749718598; x=1750323398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OXO9Ksx6UGvju2TD4wjBJsg6mvgy3QZrrLoi3fnzs0M=;
        b=fibZEYV29jFSNqzXfqDAouKqW3q+/+eFFjkQLT5Wn2hlCs0NDQMk3hpWBlfhMOvhSz
         Y00DDg1bB0udSJ/p0eI4Sm7CZDgmW3BGuQhhpqKUfJqLjj5YDM1Ui9D1AQ/VmJVGfSEc
         ex17z+m0Lsq5IV6PvG7avnqHSFzjXpWFtcYd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749718598; x=1750323398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXO9Ksx6UGvju2TD4wjBJsg6mvgy3QZrrLoi3fnzs0M=;
        b=skT1xLMaQk8F+zc676xKNudkD8N2fc7hwDpBspgkLyr/TGPzUxP4NUJmynuHaZ/9SM
         KAibZuzXJQ+k7diBiA082Pof4tVe2D2JlgzEKKEWER+NYemfXNZLVU0L3HkNspkd9UoD
         FVbs6x53+s1g4L9mejTv8UHK9BHlIfu1snSDRJX82P9tg7gkorkGfL6Ks+0ySywNTAnD
         FIkPQGAab2kv+IX55tKNszS0kx/LsYker46xqMCrC4zE7t7Tuhgdf3lTeKsET4RAIs8P
         LaUq96Ivtwue7pRx4UOiFbMWzZLmjcpm+V5oK4Qccq/wQqoEAK9g8Tak4nqoQOHSUIfh
         JsQg==
X-Forwarded-Encrypted: i=1; AJvYcCXB9Vb6ZTXLPgHmVgy21+tx5IwmCImK5CgE6+ktw2PYIXisbObkiTwB8NUZE6nBpRHUH641slWcEg6v1Q/V@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHhsXl0610utkpXYfynU+CSWfvbSi73Oxb2BVGDOmTjYD/w84
	8A8QPQ12goOEJQDRR1qQNQWf6jjXAj96MoCHnUjEO+84ITv04gYTOMmQuduxYynwnLmIH3/ca8G
	XIuxWsxCm4SF5zOL7jeIf3tvQG4mshme6M/cr5ZkMGw==
X-Gm-Gg: ASbGnctdc8RPtHMlKQqDG/mhJAWX+M6esbCnIr0pNAedvNSD37V7PgoJ6pFeodUDQ/Y
	ITeWpZSLPehofICAznVuPBoYvB7oJiJY0NPqtTSb6w9VD67itASnYij8n0gZXrjPHI6xjcxU9Nj
	etK7lafFX388B1KOabR7lBB8QYt+6/fyAvjbAmfpN7EsDG
X-Google-Smtp-Source: AGHT+IGYeO7fVzidztBGxxJplzm+jm0i0+5bLXNJiagXaREvn8LewE0tDyeq+8GDj9n5nD9Pqh7fmUjqjBeek1GEfYc=
X-Received: by 2002:a05:622a:191d:b0:477:6f1e:f477 with SMTP id
 d75a77b69052e-4a713bbf66amr118143031cf.19.1749718598017; Thu, 12 Jun 2025
 01:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610021007.2800329-2-chenlinxuan@uniontech.com>
In-Reply-To: <20250610021007.2800329-2-chenlinxuan@uniontech.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Jun 2025 10:56:26 +0200
X-Gm-Features: AX0GCFsde1G6EBQoyCCDtWUSQ8g7tbKacMMtsK7I7Ff8_JzJPwy-4V8vuvYrXKI
Message-ID: <CAJfpegt8Hk6nt5+iPg-if9iquWqr3eecgDSKYZvJY0OX+y5b9A@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] selftests: filesystems: Add functional test for
 the abort file in fusectl
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Shuah Khan <shuah@kernel.org>, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Amir Goldstein <amir73il@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007e07d906375c1ba4"

--0000000000007e07d906375c1ba4
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Jun 2025 at 04:10, Chen Linxuan <chenlinxuan@uniontech.com> wrote:
>
> This patch add a simple functional test for the "abort" file
> in fusectlfs (/sys/fs/fuse/connections/ID/about).
>
> A simple fuse daemon is added for testing.
>
> Related discussion can be found in the link below.
>
> Link: https://lore.kernel.org/all/CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com/
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks.

I suggest setting up a userns environment, see attached patch (also
fixes a EBUSY on umount/rmdir).

Thanks,
Miklos

--0000000000007e07d906375c1ba4
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-abort-test-userns.patch"
Content-Disposition: attachment; filename="fuse-abort-test-userns.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mbt58rz80>
X-Attachment-Id: f_mbt58rz80

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ZpbGVzeXN0ZW1zL2Z1c2UvZnVz
ZWN0bF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9maWxlc3lzdGVtcy9mdXNlL2Z1
c2VjdGxfdGVzdC5jCmluZGV4IDcwNTBmYmUwOTcwZS4uOGQxMjRkMWNhY2IyIDEwMDY0NAotLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9maWxlc3lzdGVtcy9mdXNlL2Z1c2VjdGxfdGVzdC5j
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ZpbGVzeXN0ZW1zL2Z1c2UvZnVzZWN0bF90
ZXN0LmMKQEAgLTE0LDYgKzE0LDcgQEAKICNpbmNsdWRlIDxzeXMvd2FpdC5oPgogI2luY2x1ZGUg
PHVuaXN0ZC5oPgogI2luY2x1ZGUgPGRpcmVudC5oPgorI2luY2x1ZGUgPHNjaGVkLmg+CiAjaW5j
bHVkZSA8bGludXgvbGltaXRzLmg+CiAKICNpbmNsdWRlICIuLi8uLi9rc2VsZnRlc3RfaGFybmVz
cy5oIgpAQCAtMjMsNiArMjQsMTcgQEAKICNkZWZpbmUgRlVTRV9ERVZJQ0UgIi9kZXYvZnVzZSIK
ICNkZWZpbmUgRlVTRUNUTF9URVNUX1ZBTFVFICIxIgogCitzdGF0aWMgdm9pZCB3cml0ZV9maWxl
KHN0cnVjdCBfX3Rlc3RfbWV0YWRhdGEgKmNvbnN0IF9tZXRhZGF0YSwKKwkJICAgICAgIGNvbnN0
IGNoYXIgKnBhdGgsIGNvbnN0IGNoYXIgKnZhbCkKK3sKKwlpbnQgZmQgPSBvcGVuKHBhdGgsIE9f
V1JPTkxZKTsKKwlzaXplX3QgbGVuID0gc3RybGVuKHZhbCk7CisKKwlBU1NFUlRfR0UoZmQsIDAp
OworCUFTU0VSVF9FUSh3cml0ZShmZCwgdmFsLCBsZW4pLCBsZW4pOworCUFTU0VSVF9FUShjbG9z
ZShmZCksIDApOworfQorCiBGSVhUVVJFKGZ1c2VjdGwpewogCWNoYXIgZnVzZV9tb3VudHBvaW50
W3NpemVvZihGVVNFX01PVU5UUE9JTlQpXTsKIAlpbnQgY29ubmVjdGlvbjsKQEAgLTMzLDYgKzQ1
LDE4IEBAIEZJWFRVUkVfU0VUVVAoZnVzZWN0bCkKIAljb25zdCBjaGFyICpmdXNlX21udF9wcm9n
ID0gIi4vZnVzZV9tbnQiOwogCWludCBzdGF0dXMsIHBpZDsKIAlzdHJ1Y3Qgc3RhdCBzdGF0YnVm
OworCXVpZF90IHVpZCA9IGdldHVpZCgpOworCWdpZF90IGdpZCA9IGdldGdpZCgpOworCWNoYXIg
YnVmWzMyXTsKKworCS8qIFNldHVwIHVzZXJucyAqLworCUFTU0VSVF9FUSh1bnNoYXJlKENMT05F
X05FV05TfENMT05FX05FV1VTRVIpLCAwKTsKKwlzcHJpbnRmKGJ1ZiwgIjAgJWQgMSIsIHVpZCk7
CisJd3JpdGVfZmlsZShfbWV0YWRhdGEsICIvcHJvYy9zZWxmL3VpZF9tYXAiLCBidWYpOworCXdy
aXRlX2ZpbGUoX21ldGFkYXRhLCAiL3Byb2Mvc2VsZi9zZXRncm91cHMiLCAiZGVueSIpOworCXNw
cmludGYoYnVmLCAiMCAlZCAxIiwgZ2lkKTsKKwl3cml0ZV9maWxlKF9tZXRhZGF0YSwgIi9wcm9j
L3NlbGYvZ2lkX21hcCIsIGJ1Zik7CisJQVNTRVJUX0VRKG1vdW50KCIiLCAiLyIsIE5VTEwsIE1T
X1JFQ3xNU19QUklWQVRFLCBOVUxMKSwgMCk7CiAKIAlzdHJjcHkoc2VsZi0+ZnVzZV9tb3VudHBv
aW50LCBGVVNFX01PVU5UUE9JTlQpOwogCkBAIC03Myw3ICs5Nyw3IEBAIEZJWFRVUkVfU0VUVVAo
ZnVzZWN0bCkKIAogRklYVFVSRV9URUFSRE9XTihmdXNlY3RsKQogewotCXVtb3VudChzZWxmLT5m
dXNlX21vdW50cG9pbnQpOworCXVtb3VudDIoc2VsZi0+ZnVzZV9tb3VudHBvaW50LCBNTlRfREVU
QUNIKTsKIAlybWRpcihzZWxmLT5mdXNlX21vdW50cG9pbnQpOwogfQogCg==
--0000000000007e07d906375c1ba4--

