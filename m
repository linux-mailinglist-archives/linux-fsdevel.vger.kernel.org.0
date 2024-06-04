Return-Path: <linux-fsdevel+bounces-20897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6238FAA68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5C1B2214D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C233136E2B;
	Tue,  4 Jun 2024 06:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHb2Cq95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB15385
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717481018; cv=none; b=YL8lMgTFEaJpDbgFdi/K0vfZXicaqampMsQ2/bt+DxmoFxeDjpw/TlNmSEPtffzejqXvmXNixKEhkGznnSq3bcITOfHKuZc5lLFZbolT6O3yRCM9FK19Fyjj16gd3wgD8Hqao64JjOJdWbu+Ws/YAOeYzD1xHPrTGYTQeFk6OXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717481018; c=relaxed/simple;
	bh=0vM76PvYOkGteEkfaJrs90f7OQoAH1n38tag4lrXYIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YVMTANEAq+ESilGlSlDzbWvMbdpEkkEFg0ytonifB7niRei2GcQjBdRgTbSkkwyJ9hZ7T4jh+xuzrzjusWJ8GkrVGVSSfBaESX2E2/vg2+B3Vc4Y/2GIWeVQH6qHDe4vaXtxPSIsrFe+5mQdhrSENCP8HzYcZEqSXAkgbxKLf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHb2Cq95; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so24245041fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 23:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717481014; x=1718085814; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDQREv9unSY1McFUrnQnKhLpPAPhEO8yFy+NPoIQDoo=;
        b=aHb2Cq95HNXpH3ebXcMHUEqMmgMaxkPukSZs2dw2xxuaPxbzWPm7n6WVs25I7OcZtn
         ArfiOqfooSKaaov6Q4iUHEf28uHhsslSd53uLBjVAOXCo6vQwyPu2xMUQwch0vCEhgv9
         fbS+WW+fqr7XMILXEvv0UlZlofj5QHZGCtt6RfB8cH1/8bb+DU81jZ6gV8K8qWwXMDsl
         EhR0hIurEFbfScqhc7LUF1EXnW1kjbyGJUWM1iJCJu5S933OQpwAmM16SS/ys9JH9ieZ
         FOPQYEK24uETVkBGkyVaMVdRmmu3+zqLGMX2aaQnlY+6xPm6bcVtUumLoOYyA9v5V6c2
         t7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717481014; x=1718085814;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDQREv9unSY1McFUrnQnKhLpPAPhEO8yFy+NPoIQDoo=;
        b=hkGrMUOD1X+Ka2CeoMz+lZjVyIXNU3QB19yLBdsUojo1eL3Cgo3rq+s/+aww0NbaxT
         74XWbaCKRQGI7q8wFF39gGWOcDI08fyc+rqs6Ajrvl+ynMljUW0VlXDJK4tNnWv4vCrm
         ZUeTXnCwqyQC9sArAk83YgDVUwcVMh/xm3D/yookamI0a14fJnsnoliNmRSy7284LbFg
         aUK/0YfZDBzc8Vv4l6CNWcOBXLL7b6A5KP6/sn1oR7xsSdjocCNrCOWS+hK5Z3GhVTII
         gA1VOPMKkFIZL8bbU4BUe1nRTlmCzlR3sG4WA2sRGrL2ta8+mt1p6tm+A+7C/2dTNhhX
         fWEQ==
X-Gm-Message-State: AOJu0Yxspx4D47nBt+Q+Lel/PRklZkDS78egunAf8Sh1Ono7hRXGb0y4
	FAxYU0yLra+a2Zdlqdbgxi2LTZt6oR701/Wl64haGxyX4NCNc3BmIshkrrQ/5qUg39SJVAX/NWO
	Q3WR9VDhG+Sx3txRPBZKKPQGOglovXzTTb1g=
X-Google-Smtp-Source: AGHT+IFrZEC/bJ8y5GR+bBWUGL1Y8uzCk9nreI1+8zTFR6V73HtpuZtRjg2F46/QH48la3/drolFkhmMVVRK3awVJkU=
X-Received: by 2002:a2e:b54b:0:b0:2ea:5386:c6f with SMTP id
 38308e7fff4ca-2ea950e624cmr70952381fa.16.1717481013854; Mon, 03 Jun 2024
 23:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
In-Reply-To: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Tue, 4 Jun 2024 14:03:22 +0800
Message-ID: <CAHB1Nah+5-mTDF-jiOPE1+=iECvS8MdEydEVGzSaMdsLVJ444A@mail.gmail.com>
Subject: Re: Is is reasonable to support quota in fuse?
To: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly ping...

JunChao Sun <sunjunchao2870@gmail.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=B8=80 19:36=E5=86=99=E9=81=93=EF=BC=9A
>
> Currently, FUSE in the kernel part does not support quotas. If users
> want to implement quota functionality with FUSE, they can only achieve
> this at the user level using the underlying file system features.
> However, if the underlying file system, such as btrfs, does not
> support UID/GID level quotas and only support subvolume level quota,
> users will need to find alternative methods to implement quota
> functionality.
>
> And consider another scenario: implementing a FUSE file system on top
> of an ext4 file system, but all writes to ext4 are done as a single
> user (e.g., root). In this case, ext4's UID and GID quotas are not
> applicable, and users need to find other ways to implement quotas for
> users or groups.
>
> Given these challenges, I would like to inquire about the community's
> perspective on implementing quota functionality at the FUSE kernel
> part. Is it feasible to implement quota functionality in the FUSE
> kernel module, allowing users to set quotas for FUSE just as they
> would for ext4 (e.g., using commands like quotaon /mnt/fusefs or
> quotaset /mnt/fusefs)?  Would the community consider accepting patches
> for this feature?
>
> I look forward to your insights on this matter.
>
> Thank you for your time and consideration.
>
> Best regards.

