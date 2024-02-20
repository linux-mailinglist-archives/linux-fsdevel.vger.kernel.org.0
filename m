Return-Path: <linux-fsdevel+bounces-12109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE485B555
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE0AEB22678
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB465CDEE;
	Tue, 20 Feb 2024 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bjkWS5zD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8285B1F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418173; cv=none; b=IodyqCuh4u1pNxlDo5CVch91w05ClqxMHOnC63Bd5ulX0i2eG37wk64Zd6uv4FqEjC8o3OgOVwBVC7vBEohI7CsXzWU4+WEelF9XIsbBYOT9+Z0KhPdt+tjGjpm9ATlALzYnc8tAYcY/I9/t+698JdDm1F9gku0ZJVQPUClfsXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418173; c=relaxed/simple;
	bh=W9DEF9d7A3fW1gVpBh4xGwNz5NwKwroxskuUv285xgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9EJiLMduXpxG04SSK1f0RmcQVQesyy4XcGBzwVJebZ+dDClPHaZVD7+sy0JBLYrRF+Zp1tGgrVIVTMX/fhoEzrrapUBd4QFI2i3xvk02PpbRf2qknTZzRBoTi1vI5/oX/dGsedArfr1Txlsw+W3tHibhgKfMpKk00OMpsk8vrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bjkWS5zD; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e82664d53so245763166b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 00:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708418167; x=1709022967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W9DEF9d7A3fW1gVpBh4xGwNz5NwKwroxskuUv285xgs=;
        b=bjkWS5zD0jwb0ruk2upeQds3csYxyTtFLGE4wpWQt8q/WjfpO12QrdgS3AYtIhPils
         D45e13MyZJjx280qm78y1Am4KfIVXW/BTf4Sn1ZVsLST3tq9vQL/AEreGqp4BGw0aFF0
         u9UfSYtt4KDGgGR2F/D3p7PyYnmNKZTw3wm/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418167; x=1709022967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9DEF9d7A3fW1gVpBh4xGwNz5NwKwroxskuUv285xgs=;
        b=ebKDs8b0LPIXHVtkqOR0ctn2SznSWbvU5ySRKP3L9FKZ+MnMvOL87MR4NGaAzH2Ymn
         mM47bkj04nXKhFhxVBjymXURRMYuLc6oMG6bPYPGMiJxXDALMqe+aPJeI6aPL2sDtUeM
         j0DkA0kaSmXq4t+63aIpteO3jCLZqL0k4cGagYErAODx437ddnkzgfMNO4NYQfkmYosl
         0+7kvI0g4ULyyriIw9u5afNt6vJuteCTAZ6xIb7Jfm10htpNO5bddT5Uqo3unLdcgRSW
         0cXZCaO/+kJpJSqSGF0N7TPTy+CcEyXOO8Td5GN920gSxXQma+i+NVAZFU5tqaO5ir9i
         eWtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzydo0dq55cZsat/2Uxw9j8+f4xFJIk7oecKEmOXrHO/fr3vQcBYb0g+4tmQrGcL9A4KRDSLdKjbpiHDGF88kHPLl5ttHEvoLgnur5Yw==
X-Gm-Message-State: AOJu0YyHqh42ztMZsBX/qRKrv7eeAdDREEm3+0ekn47SR2AOu7FL9OZo
	poYSefw1oiGNMvlFTFzR9poBRnm8syPbbXgqWJtQTnCMb4RV1wLFvnVsioAjOokDNJstnuWW+MQ
	Xw7VcmJrGJX0Kpvl1DmCvQLulyk3VfHZm3UVaUIhijgU5uq/2
X-Google-Smtp-Source: AGHT+IGR7IsxNbjO+Mghl34y64sko+82Rx3WuINVzyrfemLPnYkaKZepf5xPVbnVWd1wuoe3XpRsrEIghgMuE4H5+FY=
X-Received: by 2002:a17:906:c786:b0:a3e:58df:fb08 with SMTP id
 cw6-20020a170906c78600b00a3e58dffb08mr3919434ejb.44.1708418167391; Tue, 20
 Feb 2024 00:36:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com>
 <b9cec6b7-0973-4d61-9bef-120e3c4654d7@spawn.link> <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com>
 <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link> <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm>
 <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
 <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com> <5b7139d5-52fd-4fd0-8fa0-df0a38d96a33@spawn.link>
In-Reply-To: <5b7139d5-52fd-4fd0-8fa0-df0a38d96a33@spawn.link>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 20 Feb 2024 09:35:55 +0100
Message-ID: <CAJfpeguvX1W2M9kY-4Tx9oJhSYE2+nHQuGXDNPw+1_9jtMO7zA@mail.gmail.com>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="000000000000fef2360611cc1955"

--000000000000fef2360611cc1955
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 20:54, Antonio SJ Musumeci <trapexit@spawn.link> wrote:
>
> On 2/19/24 13:38, Miklos Szeredi wrote:
> > On Mon, 19 Feb 2024 at 20:05, Antonio SJ Musumeci <trapexit@spawn.link> wrote:
> >
> >> This is what I see from the kernel:
> >>
> >> lookup(nodeid=3, name=.);
> >> lookup(nodeid=3, name=..);
> >> lookup(nodeid=1, name=dir2);
> >> lookup(nodeid=1, name=..);


Can you please try the attached patch?

Thanks,
Miklos

--000000000000fef2360611cc1955
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-fix-bad-root.patch"
Content-Disposition: attachment; filename="fuse-fix-bad-root.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lsu41v3v0>
X-Attachment-Id: f_lsu41v3v0

LS0tCiBmcy9mdXNlL2Rpci5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgotLS0gYS9mcy9mdXNlL2Rpci5jCisrKyBiL2ZzL2Z1c2UvZGly
LmMKQEAgLTEyMTAsNyArMTIxMCw3IEBAIHN0YXRpYyBpbnQgZnVzZV9kb19zdGF0eChzdHJ1Y3Qg
aW5vZGUgKmkKIAlpZiAoKChzeC0+bWFzayAmIFNUQVRYX1NJWkUpICYmICFmdXNlX3ZhbGlkX3Np
emUoc3gtPnNpemUpKSB8fAogCSAgICAoKHN4LT5tYXNrICYgU1RBVFhfVFlQRSkgJiYgKCFmdXNl
X3ZhbGlkX3R5cGUoc3gtPm1vZGUpIHx8CiAJCQkJCSBpbm9kZV93cm9uZ190eXBlKGlub2RlLCBz
eC0+bW9kZSkpKSkgewotCQltYWtlX2JhZF9pbm9kZShpbm9kZSk7CisJCWZ1c2VfbWFrZV9iYWQo
aW5vZGUpOwogCQlyZXR1cm4gLUVJTzsKIAl9CiAK
--000000000000fef2360611cc1955--

