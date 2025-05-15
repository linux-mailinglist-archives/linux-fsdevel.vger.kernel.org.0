Return-Path: <linux-fsdevel+bounces-49177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8249AB8F99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829EF17EFDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DB125C6F1;
	Thu, 15 May 2025 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS82bhYY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B241C71;
	Thu, 15 May 2025 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335743; cv=none; b=UNuG2UpC2X8Xf7BDF56D97pot8RNk+TWwSPKUYJT19glmZGNWAsyIZIPY1b5argElrmlXu2pRpx0Trg/9XBAp+uM5YXlOzpv1zW3ddkoXS107vIVJK4uMwq9kkxSC/vThwpZ6/Wfmk+soB7HwUiAa+Ni+Fdy5GgWbl8UBgagaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335743; c=relaxed/simple;
	bh=mt20YoXHrSpyzVe+/WttlN02jBfQDfMyUYU16qi5huc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ki/94yAUj1rCNUP7CCpMMvuof1FerGfvfpSglR14q4UPbU9+ZY9AeYRyiyUq7J1yp3vJDnaKj2SUOGCm3LP8ULZ2mHc3nTv1zPOSLxFejefZs7AC4CsD0Mc/xcbRYeAxfIEmS+AXR6XXk9pAyMT79FT2m+KaEnKwVLrT14v0CWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS82bhYY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4767e969b94so20950181cf.2;
        Thu, 15 May 2025 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747335741; x=1747940541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt20YoXHrSpyzVe+/WttlN02jBfQDfMyUYU16qi5huc=;
        b=IS82bhYYsKaa0L4bClFfB1cMTX/QX0UuzdTcg1Y4qHB4FDBR/QDe16ork+N9AVk1wY
         gBtbyqn4w5jtFDRr7lq1uyj25p9zvUzuFEI/sNl39HusQtt1Dm2zWy7bu/Qds5dlECRX
         HKpgLygkSHW6F2hNtP13W2PwrMLC4OgBwYrDCeoF/N1mB7jnBMB1T4FIEllN9Z9SG4dc
         yJCPjsF9iQcfMwTw4noOZaodV23k5iFYigYSUL2siOuIgux9uqnOq3b6roXcJCq0jF6N
         JkvnDY3Uqv54rGV4RTHF+Fu8VHvG2XLOPOYKt+9Yy+I/eP6wOn6rGFeIDXZLgUBmm87f
         4zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747335741; x=1747940541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mt20YoXHrSpyzVe+/WttlN02jBfQDfMyUYU16qi5huc=;
        b=Oh4HRmu8GBXFgOCLsIu+AKbiKRhKQzqhhwZYbI5EPGe9uIgqO5XLmBUHw32fdA0eoK
         ScpB7YIPPKsrjqJ9eqF6MBskycUyDS/OEJZnerggZd4skn369tTxwqMAuoKGeHTp1s5A
         YVxyGaTNwWwzgPPKH5G3g9AK08fRXeGebYJDxYzCVmNR4hGoVi3AF5rkObAfPJpIWzUk
         KgcZcgkuiTVf2tXEEuYWACr1ezVsCH+NWcWyv2N4eRzy0H89LHbHhz6OvXBgbtQ/Hg6M
         jFr4SgpfAtoD2Lw2lcy1ZMOpBmjuUIuAP/qrQqfNR+SJdOBE467eFDiPtbNdx66/N55s
         SBDg==
X-Forwarded-Encrypted: i=1; AJvYcCUGw5rXBYUPT+8XUVulqrPzCyknyAHAh0zSj3vpaO1ZwBSYRC2WfdEviE2aMB9prlq858YMPaaxg4vyklZY@vger.kernel.org, AJvYcCVS2Zq0GA7PggKy3TjQIrfNFQIpHDW8Thl6B+8r9rU6NH0gwGL6up6MmLXyKuLr587DcOK7xKHwCC4gMqWC@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcfvvv9i5IAhRtwVwM51HBnKwjD9gfyRrdMzPJQZtCNbEYqCl
	6HbUINHCdvdeudk//vdHEUvsoohIj9l7o8Iu95sj7Iwo9jAyMzQJWjFq9QVvCUPmizmkt0LQNwF
	BhzE2uWtdxbKQQ0CmNTVMrXwYyKMlHyYOrQ==
X-Gm-Gg: ASbGncuUOCwNiG1QRwk6ryZfO10jPElZ9UXuQZxWH3Hpj9lDKRQJ9rmiPE6o4OL6DCa
	+KnUsjwlXPzTUyBgjj1tw5qZiMTJ7XEy6tflmcQtwFTPs1Srsxky2Sf6dU8UfaMFZnJuI0GvDtL
	rrJOTDwccfVx1YpeZ3eR18jqaPZKG9Nejk
X-Google-Smtp-Source: AGHT+IHYuQVFv6AtXcpCuJoy0ls9a9Lrch07XWwNSnrqJDp2xs4zkGpBPJUvKkA2UphVrjYzCNxqEstiz0YDt1DCJNQ=
X-Received: by 2002:a05:622a:1e12:b0:48b:5789:34ac with SMTP id
 d75a77b69052e-494ae36bfeamr10038531cf.3.1747335740799; Thu, 15 May 2025
 12:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <CAOQ4uxjDwk6NA_UKiJuXfyY=2G33rruu3jr70pthFpBBbSgp1A@mail.gmail.com>
 <CAJfpegvEYUgEbpATpQx8NqVR33Mv-VK96C+gbTag1CEUeBqvnA@mail.gmail.com>
 <CAJnrk1ZxpOBENHk3Q1dJVY78RSdE+PtFR8UpYukT0dLJv3scHw@mail.gmail.com>
 <CAJfpegunxRn3EG3ZoQYteyZ3B6ny_DG1U65=VX25tohQuHCpVQ@mail.gmail.com>
 <CAJnrk1ZH3hwgtgOq7a=J-vxop5fCm5K_ZEek0W3kX9N1xf4HAA@mail.gmail.com> <CAC1kPDMATpB4GiaX+-sBZ058igt1QuXf_V4NAt0tC=-3aG__TQ@mail.gmail.com>
In-Reply-To: <CAC1kPDMATpB4GiaX+-sBZ058igt1QuXf_V4NAt0tC=-3aG__TQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 15 May 2025 12:02:10 -0700
X-Gm-Features: AX0GCFs9Rp713kGIskQfAI1EIw_Vx_IoQpDsS_EXcH_R4aIaNz-91BMC2I69Plg
Message-ID: <CAJnrk1a00+TyWRGSMr1sOdy02KKL=AmmhRc2UZCiQ5s66Ga5zA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] fuse: Expose more information of fuse backing
 files to userspace
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 8:17=E2=80=AFPM Chen Linxuan <chenlinxuan@uniontech=
.com> wrote:
>
> On Thu, May 15, 2025 at 7:04=E2=80=AFAM Joanne Koong <joannelkoong@gmail.=
com> wrote:
>
> > But I guess one advantage of doing it in sysfs is that it'll work for
> > unprivileged servers whereas I think with /var/run/, there needs
> > to be elevated permissions to write to anything in that directory path.
>
> I suggest something like $XDG_RUNTIME_DIR/libfuse for unprivileged server=
s.
> It usually is something like /var/run/user/1000/libfuse.

Cool, I think this works then.

Thanks,
Joanne
>
> Thanks,
> Chen Linxuan

