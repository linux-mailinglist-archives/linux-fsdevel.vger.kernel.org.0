Return-Path: <linux-fsdevel+bounces-30243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA4A9883D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4AD1F2133F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 12:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851E818B474;
	Fri, 27 Sep 2024 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HreBdGkz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CF61FCE;
	Fri, 27 Sep 2024 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438602; cv=none; b=SPhwq6iBw7A5AHJSVJC+R1ouwFoMD7Zc9O/9iT+ErDs4yMG4IW8X0vkqpHMwfZp2YYU743kmsj7eFToHXN/EOXySI26XS4jAI0gsdBgYwkHnQs5sOED+pTn1dRKdYRClcRqeKTnfd6xoO+G4IGm9631p1X41zL2alGQrfImm0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438602; c=relaxed/simple;
	bh=UrWY7OTU1UoGyyUUzsqFBb1AIuPIeooFBg78qnJeh8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZCTL8+/nE9VRFAaeAOSJ0A/ksSEQuS+ldYT+hPXyTDKEG8CdMCP2nP3YhYEF29jkWequADTGfK07L/NyaCrnmdnXfMWKNke8klBb3eZsbIz0FiyxmoL7zxLxKQIEw5V/p/jnRP/dCfEWpET8M6z1uFRsjm8yRz5pUHjfXGUgpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HreBdGkz; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a99e8d5df1so186465085a.2;
        Fri, 27 Sep 2024 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727438599; x=1728043399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ien4lPw09mlafs2YgqQEs4Jx+N6Q89EVx3qb97kHkOw=;
        b=HreBdGkzG9BxLONh5m29gb8BxV2VNFvXuNmPmTnNRBwTiyJHgDiOn0PrrM/V5iKBT3
         HXGbOagsYqcA7a1CmsNFYmujx5D+7HZ8/rK4ILwiX1uw/5hICbGQsFXMqZCEaevpdd6J
         UOo5oMD7gdj+XL07UBf8iRfM28T8L5e6IuR2MVLmnwJDB6xwYEBO28vY0VtlvL5AvLgb
         ou+mWBJqI2E2zPhS26n0Mjr0FckUh0B29rX/hX+WygHg85oblja2yViHwmg49DRlnNBn
         Ftk9zL9zBFd/0CrpWehXkfQf/d0e5w7pBfV9xrcOFWK6meXrFslo6M2ZQNQ0zFRAQFyc
         5DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727438599; x=1728043399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ien4lPw09mlafs2YgqQEs4Jx+N6Q89EVx3qb97kHkOw=;
        b=qBq3I/u2YrxF638sALN3mspzKEbegB5YDcHgvJhfoJPSQH+mrPMILsYEhK5iMnUh9N
         g8aUfNA1c7bknzdSTRdeWcqw1KnKHjWp25W3TOj868xRU5JFaZtkrpD34cckmeh3O/Gn
         FrmzX2dwyp3hd9XfhrW9kHk97EpvObFuu8C3zy4zmHtBalYT09c9pJY6wIPtriZhygvA
         LqMx5+GMn6B++AX7gGcaO+tlKVyocvG/EYfsdtCxwf3argKEhIhrkNFpGKBQLcVgyQR+
         puhCPrXfCOC4Kwxzr/9m7MBswJmZWCmU2uFIuII6i1RpDlm6e1lqj2EVPbeVBu8Gczb7
         nNHA==
X-Forwarded-Encrypted: i=1; AJvYcCU6r9GPhy2L+dhxKM2eKqYd2wQyFB2MZGrC2rZEnBw1p227OlvAd1ZWaxViDDsSUTuGsKd0M0qiTqmlSzXe@vger.kernel.org, AJvYcCUWWEMbUjBDe3tFOzrFTWM6/VnHuyzOQr648zRhwWa+R7bxy/iIcdUImSAx2kmZhDx+A7kzVOgwbzH/lENV7w==@vger.kernel.org, AJvYcCVs36w/ExU/TvogSQRl1Kz5H/SHGrhVQMehDsajXLKPBYm+xux7+8Wz13gXOrvgVtIbNJCRfWspz1B4B0zW@vger.kernel.org
X-Gm-Message-State: AOJu0YwNF7iwv/3h5AqKC8f16XePngknIMT/q/yCjBowlHLd70X1MMTs
	x58ImFInMqDyk+TwXlzAWChNYu66K1/MG9u5dND2qc0q8raWpW3vjDcGjt17q1s/23o7AiJuWFo
	CW1TdCxOdp3+4oanrpjMkbwoHAg0=
X-Google-Smtp-Source: AGHT+IEvoF9mwgTLcAuSVa+Xp4oXZXGcBCFvJyQtw2z10Ya7vZXTvtIti1wQJGe6WjK5yS0GELWoZ/ad/HEfri7pN6Q=
X-Received: by 2002:a05:620a:1a18:b0:7ac:de4d:9129 with SMTP id
 af79cd13be357-7ae3785918fmr452213985a.31.1727438599209; Fri, 27 Sep 2024
 05:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <k53rd76iiguxb6prfmkqfnlfmkjjdzjvzc6uo7eppjc2t4ssdf@2q7pmj7sstml>
In-Reply-To: <k53rd76iiguxb6prfmkqfnlfmkjjdzjvzc6uo7eppjc2t4ssdf@2q7pmj7sstml>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Sep 2024 14:03:07 +0200
Message-ID: <CAOQ4uxhXbTZS3wmLibit-vP_3yQSC=p+qmBLxKkBHL1OgO5NBQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_llseek
To: Leo Stone <leocstone@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: syzbot+d9efec94dcbfa0de1c07@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001467e7062318a4e2"

--0000000000001467e7062318a4e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 9:10=E2=80=AFAM Leo Stone <leocstone@gmail.com> wro=
te:
>
> Add a check to avoid using an invalid pointer if ovl_open_realfile fails.
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 2b7a5a3a7a2f..67f75eeb1e51 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -117,7 +117,11 @@ static int ovl_real_fdget_meta(const struct file *fi=
le, struct fd *real,
>                 struct file *f =3D ovl_open_realfile(file, &realpath);
>                 if (IS_ERR(f))
>                         return PTR_ERR(f);
> -               real->word =3D (unsigned long)ovl_open_realfile(file, &re=
alpath) | FDPUT_FPUT;
> +               f =3D ovl_open_realfile(file, &realpath);
> +               if (IS_ERR(f))
> +                       return PTR_ERR(f);
> +               real->word =3D (unsigned long)f;
> +               real->word |=3D FDPUT_FPUT;
>                 return 0;
>         }
>
>

No, that's the wrong fix.
There is a braino and a file leak in this code.

Linus,

Could you apply this braino fix manually before releasing rc1.

Thanks,
Amir.

--0000000000001467e7062318a4e2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ovl-fix-file-leak-in-ovl_real_fdget_meta.patch"
Content-Disposition: attachment; 
	filename="0001-ovl-fix-file-leak-in-ovl_real_fdget_meta.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1ko8gok0>
X-Attachment-Id: f_m1ko8gok0

RnJvbSA5OTRkNWE2MTg1NWRhMjc1MjkyNzgwYWY3Mjk0OGQ3MjA3MDI1ZWM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDI3IFNlcCAyMDI0IDEzOjU0OjIzICswMjAwClN1YmplY3Q6IFtQQVRDSF0gb3Zs
OiBmaXggZmlsZSBsZWFrIGluIG92bF9yZWFsX2ZkZ2V0X21ldGEoKQoKb3ZsX29wZW5fcmVhbGZp
bGUoKSBpcyB3cm9uZ2x5IGNhbGxlZCB0d2ljZSBhZnRlciBjb252ZXJzaW9uIHRvCm5ldyBzdHJ1
Y3QgZmQuCgpGaXhlczogKCI4OGEyZjY0NjhkMDEgc3RydWN0IGZkOiByZXByZXNlbnRhdGlvbiBj
aGFuZ2UiKQpSZXBvcnRlZC1ieTogc3l6Ym90K2Q5ZWZlYzk0ZGNiZmEwZGUxYzA3QHN5emthbGxl
ci5hcHBzcG90bWFpbC5jb20KU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2ls
QGdtYWlsLmNvbT4KLS0tCiBmcy9vdmVybGF5ZnMvZmlsZS5jIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvb3Zlcmxh
eWZzL2ZpbGUuYyBiL2ZzL292ZXJsYXlmcy9maWxlLmMKaW5kZXggMmI3YTVhM2E3YTJmLi40NTA0
NDkzYjIwYmUgMTAwNjQ0Ci0tLSBhL2ZzL292ZXJsYXlmcy9maWxlLmMKKysrIGIvZnMvb3Zlcmxh
eWZzL2ZpbGUuYwpAQCAtMTE3LDcgKzExNyw3IEBAIHN0YXRpYyBpbnQgb3ZsX3JlYWxfZmRnZXRf
bWV0YShjb25zdCBzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGZkICpyZWFsLAogCQlzdHJ1Y3Qg
ZmlsZSAqZiA9IG92bF9vcGVuX3JlYWxmaWxlKGZpbGUsICZyZWFscGF0aCk7CiAJCWlmIChJU19F
UlIoZikpCiAJCQlyZXR1cm4gUFRSX0VSUihmKTsKLQkJcmVhbC0+d29yZCA9ICh1bnNpZ25lZCBs
b25nKW92bF9vcGVuX3JlYWxmaWxlKGZpbGUsICZyZWFscGF0aCkgfCBGRFBVVF9GUFVUOworCQly
ZWFsLT53b3JkID0gKHVuc2lnbmVkIGxvbmcpZiB8IEZEUFVUX0ZQVVQ7CiAJCXJldHVybiAwOwog
CX0KIAotLSAKMi4zNC4xCgo=
--0000000000001467e7062318a4e2--

