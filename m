Return-Path: <linux-fsdevel+bounces-53847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 153FDAF8204
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 22:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9676C18963B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890612BD035;
	Thu,  3 Jul 2025 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbNs34mi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C15A25A323
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575132; cv=none; b=AMlpjWL3ALwGUkgdRdCrev+nXaIbPdGH3TC5YLl1v7H2F9HB5NCUYuieWJmgGZsbsMKLhqIbTQEEl6XYLFz8B07tD1Tb5gI3R4Z7Lw4FOVQUVqjYqV7hqt89I3yhqe4cUTnPe1uBTXqTHQ7s9d081H5YfCNM6iVIKr6INwXGmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575132; c=relaxed/simple;
	bh=kSqq90Uk1Er65X8jgxcPsbeNcR74YLlXUEzvapHxQZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSxGwAWoCMlLxMB/kLnkk+up4Dqo0AZy8r4H6f/qdHReYGVFFi6u1vJDJNhN4bIMFHDRB+JHqHcWsgz70dq5hg6mAFAZSPFIHuhs5YHWMmDbjMFBRlKdgj6qCw2QSkzWETL1kfLD0Y3BaSHsUpDP1UmXM6OIFooNpN0tRIox3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbNs34mi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e447507a0so1911987b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575129; x=1752179929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtLNlXAfgk9+fIUb3rTwrk/S3ORuQPStEezt8bYHIiQ=;
        b=RbNs34miNEJgeMKCQpjdnBhromWeel1invZCi7qgzVCTPwZVMfWR7MAkZbMGQDa35I
         T8xwj1Vq/j/m+C/YoFXeOKo1ejpy1LT6z+5jwgvu06df1AIm/Z6MJgP+3Lnwpu9cqF4V
         2t8FVcDi5ZoovekciaYR2CzaHDCk79Q0fEgRe49tRKlPabLQ4jXbZ8kTQOHDeIbP2DuR
         d3HicJV8G7wKBFzN6ULso9QqPV4FK/CbUYjmjnF66bpQZ6WUxzgBX+pFPPGG7oYo5Pmr
         SJc/lKmLMjws7+bulbV5jSNobWz8oUokm417bWhqHCZmR8EFFOym2mdXj9N7iZngA1PO
         mJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575129; x=1752179929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtLNlXAfgk9+fIUb3rTwrk/S3ORuQPStEezt8bYHIiQ=;
        b=aET9FOopaNrFYtcboPCwpbt8KD4YO9LoYScZKrY4A88UtF1ZMXHLjl/4UhvTslNvPZ
         ASbK6Zh8Q/PsgpUCooB1WqkfHj97tiSNTtUHSVdWd5agqtXqjl0OuaR2+qvb8+VLyIea
         SCzdjR68LcHIxAUYTBiDIXJ4GQ964trt5WVfQzMmYk5tbx7/eltgjUDHaKSZEqz3ykU4
         Rj7+GgKQgZdUAjPfbiEV54bwxs1vKqHz3HWRHhNNQVXtd5RukLQEmLLzGw3ZpDJiFC7z
         zSbfWLcjGXt8U2T96PaSQaokhiVIRLDvj1IDCoo9pRuMyNBqS5dfXW9X2zw9LIcwDQUA
         cgIQ==
X-Gm-Message-State: AOJu0Yx0/1XyWlki7EmuTc6EGAzj9k3k06oKKpnGmrZrAmSoJqFOZz1A
	Em5rPT8vLfqj/VOprkL6GdbsIhDRTFutnmXsY6J7W7F7Ips/cdQpJ1PA6++OvgXKyjwoq1dXrUv
	kzq7NEq3hyYJneuCSNAOVmekXFkCOS+c=
X-Gm-Gg: ASbGncsGCP9rnNwSDoQM5Ia2X0nat2/LFsqebKPiT1o50jy1jIR5DDtEry76yGCcaPQ
	+A3WgGRBq0zYmfYcEIcwuFSDiZM47OPFiVyvGtZp8C16R4CHD+zphvc9Xfs9J+pJLTlrd+mrBwC
	BhDVQIp/qZyKiilKwi4dgJd1xWFm4NGvbXUqcYrqI+sp9G
X-Google-Smtp-Source: AGHT+IGUBgauXyZgKQpGx40xVUwVATdpUt/Uddtcb5IZLjWaPM4VNdwSqU+CtJs4gSW2CwtzWyZUjeW1kEI2UC18Aec=
X-Received: by 2002:a05:690c:b84:b0:70f:84c8:3105 with SMTP id
 00721157ae682-71668d73139mr365297b3.37.1751575129572; Thu, 03 Jul 2025
 13:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702212917.GK3406663@ZenIV> <b3ff59d4-c6c3-4b48-97e3-d32e98c12de7@broadcom.com>
 <CAAmqgVMmgW4PWy289P4a8N0FSZA+cHybNkKbLzFx_qBQtu8ZHA@mail.gmail.com>
In-Reply-To: <CAAmqgVMmgW4PWy289P4a8N0FSZA+cHybNkKbLzFx_qBQtu8ZHA@mail.gmail.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Thu, 3 Jul 2025 13:37:53 -0700
X-Gm-Features: Ac12FXw8Sw478luVEqRHWSXyfNkG6euSpHKIQEq8fKW923wUzLk2S2PrT59U2iQ
Message-ID: <CABPRKS8+SabBbobxxtY8ZCK7ix_VLVE1do7SpcRQhO3ctTY19Q@mail.gmail.com>
Subject: Re: [PATCH 11/11] lpfc: don't use file->f_path.dentry for comparisons
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, James Smart <james.smart@broadcom.com>, 
	Justin Tee <justin.tee@broadcom.com>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Al,

I=E2=80=99m good with the use of enum.  For the if and else if blocks, woul=
d
it be possible to help us out and convert those to switch case
statements?

For example,

switch (kind) {
case writeGuard :
    cnt =3D scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wgrd_cnt);
    break;
case writeApp:
    cnt =3D scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wapp_cnt);
    break;
=E2=80=A6
default:
    lpfc_printf_log(...);
}

Thanks,
Justin

