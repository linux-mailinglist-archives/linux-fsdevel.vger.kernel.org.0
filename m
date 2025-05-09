Return-Path: <linux-fsdevel+bounces-48622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9005AB1821
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D076500EDE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3379F23504C;
	Fri,  9 May 2025 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="mePIzA6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99354233736;
	Fri,  9 May 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803481; cv=none; b=fQMWBX9P5CaSSom0VpJy6FrH/V7J9NEJJs5IUic9oe65Im07BQCq0n8dyxX3CeqoWehDliErX8/GkoInmK7xHNkX948ojcMxlqJGt4TJKrhn7tfWRTy2q007Flf3o3bfrC/EkaH4ZKkVaaE9ebWwrcjdasCwfQ8swRUao47txVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803481; c=relaxed/simple;
	bh=wVbUZiJAxeDC/B1GW4wWjjz3I64q+hCyr2e5P1x2TMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGF2DkSw+ISMNxCNKGW5EKM3p5586U8Vy7715lPRTEGF8VFzngH9p3fvcY7cv+DlbTBJHwjZjEtsAJvvXi5tvKFCQpAHRCNb/viWfL/aUVNYE0qjMRmk+fqy2VxM++hITP4G7cECkRMgucDAdAUh+mBSJX1NQAcxYu2yWr6N2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mePIzA6+; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746803459;
	bh=EwvPymuHFztd0+nGFButAnqaFfGdcLMgfM3pGmY+mRc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=mePIzA6+iAJOVfZmBPVtAbAUotQnwXoPlDbv+Nnkk/gt320R6+sROT37nM5A7zzGu
	 sbNJojTDhQDG4799WyMgWu/H5Zr7cwrpSDbMkeNyUuIgv+edt5ldLN1+1rfN2fwSiq
	 2Uh56oBVO1/7e/bt80tmka/EQqeNnHk3OHIqVEjk=
X-QQ-mid: zesmtpgz3t1746803457t69466426
X-QQ-Originating-IP: RgQoCLH0gPJM8iS09BOsduU3Kcz3Kmtz/ogGb/fxMXA=
Received: from mail-yb1-f181.google.com ( [209.85.219.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 23:10:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16312323404495128176
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e73e9e18556so2221473276.0;
        Fri, 09 May 2025 08:10:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK2PbbtX2DI40LthO/h7TBUEFrShloVH08I60hisE1XV/nqjM93dpmwxMZjpg8HHqg9r8Y5wwsfIa8Pq8d@vger.kernel.org, AJvYcCXMu312M0fyxgSyAp29GN+Si9SfCcDkKYC4xlZ4oKY9xJD6xr4dNg8JsDmIPRFaxxsI4XX8b/7z0V93I71k@vger.kernel.org
X-Gm-Message-State: AOJu0YyGNH+PRuPrekxfSj8X96O/HcHqIToW96gWVoS5r+7RdhYHJHXI
	ssNmjgt/cTG+IiOO5mDpHSKS2kKtEn6WZkUsTVLOftxHddRu1Z//gjmrm0pgFyGj7J3CMOflVYa
	/nyjU9mfmy2wRLnCI6uszPDgJR9g=
X-Google-Smtp-Source: AGHT+IGxjJFvLSFrjsRKXRvh4VuMV45vppGwGleT2kXSaVpYif5t84ll8QrWO2n6mpu1nZtqjidpdzxWhuazXN8Ds6g=
X-Received: by 2002:a05:6902:2846:b0:e5b:4651:b5c6 with SMTP id
 3f1490d57ef6-e78fe0d9882mr5087468276.23.1746803454684; Fri, 09 May 2025
 08:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com> <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
In-Reply-To: <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Fri, 9 May 2025 23:10:43 +0800
X-Gmail-Original-Message-ID: <B876C9239B0EFB0D+CAC1kPDMweHDtktTt=aSFamPNUWjt8nKw09U_2EqyDNu28H6WWg@mail.gmail.com>
X-Gm-Features: ATxdqUGOm0hFg70ZmDrG1cg3KWtHrUA1YP0QsfD7GpyT5NSHmAdCwARBM67uKMw
Message-ID: <CAC1kPDMweHDtktTt=aSFamPNUWjt8nKw09U_2EqyDNu28H6WWg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M4KjHSRLf+eQEsLAW0W2N4DCm7Y6OTFxwVc6lRmHcNiefodcYfpxFK+k
	NRWH7tRVag4nR7RkkY9zAdoLUd4707qPQR9JG9yzo0MlRSJGSc0I/YfPUAvk4NSROluYDB6
	idEtEyczxHgIFiW/UHDCQ3Bcl872BjVpD6PVzFPZ6mSd1mqCufNHzvfUKPe1EGDcGGACA45
	r8DvsCXyVtlyBQ+B+/Uqg9kI2glh3OrJyDEvV9c3+NSL8VJQJyoNheysDnxGN77SxxgMO4p
	APGv4LXAS2fhde9jRvRY0RvBiRi3kVrLqXWGp0gB2SIvT5igPFpRvHiaRt9szh8u3n+Adq3
	2K179/VVuh8scwcMG3BFDaKNMMScZFz8o68f0E48nc7euavXxqLnmtDkdTWRP9BsINYQxNP
	lhlR8AQ6h4Ql4rBWeYMJZCvBfnJ7adOoT49k00iwPo68bCmzqgPfip5WvgGOQF/qhTxbXnv
	HsIJI62Df08oqB4qJIniO2oLOAyq5Xm1qPeeb8/CePdIQdcFhdZa/LuDRZxk7zluzs8haf8
	c2K6ugQrbxCTqrEfHIOHUtkm314D4wBxOenYRUofZzsnvCVFjKTPY0Pyq0nW3B7eebjpLam
	YDFcjsW5IrQ69Tk37sMjur85/QCn0RFBtFHYISciOxtuo9iKGt8aERgt9PfxAUuq0JaVcgL
	1fVpwhkeUopb/JERo0RXmOLvap5Yhd/dG1SiO5Q7ecUpJ8CWUVxStHx8IbZqgL+k6Z85o7c
	NrVn4CQcy4Hv8fm4BNEQKMVrOVj7KMpSBalcUnrhs/vOLV9WPutNHoa9zGVjypxVEJwZere
	CXGMyzdIciGNuquiN5TYKWEO1Y9OXNQ1BHZFBBw4zUfGF/7elvXtkZeW4JGEv08h60mHIGL
	4/fjw/G7iOEZtgtJZisO00V8OaellLeL255BMRayv6S0sMdTyVykVCviZ6CD39Aq54m/gcN
	8+fnyzmX5O7M7IgcEX5oaNZMOUh7+/FfFpcSg7eYAgjvnDhrxg4BBkrMWDHd3d6qT5DtOrF
	uAKCcDI/rWKmMJS0+HdO2+ixHlAovW6J0xvK93Yvjt6HZvrCIq
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Fri, May 9, 2025 at 10:59=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:

> And that has limitations, since fdinfo lacks a hierarchy.  E.g.
> recursively retrieving "hidden files" info is impractical.

What does "recursively" refer to in this context?
I am not entirely sure what kind of situation it implies.
Do you mean, for example, when a fixed file is a FUSE fd and it has a
backing file?

Thanks,
Chen Linxuan

