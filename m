Return-Path: <linux-fsdevel+bounces-13635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BD087239F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 17:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791CE1C236C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D2C12B168;
	Tue,  5 Mar 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fsDjqMKw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3CF12A17D
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654688; cv=none; b=NvQUF3fPBeaaGvbTwIm9bUnNseH6ZqmsWT857UnO9+D02SGaTiWDLw7RPIbbo/e0mck4w4eiijkFBoPos391fU/Fws+coNMQaTxqI8Da9d5KFDtgEimD7EzrOV9psnsJnV5v1Na3gBMS4+7PzQ9PApJUbsNdWSWo9dwmu9ghZUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654688; c=relaxed/simple;
	bh=q0H2NcD59dhHTfKo451ZTlcHqhnaVKga21S64KdL2as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ga5nAZOh1jT9rmC2fwupuIC3PoNdV9UTagvv0a7qrLYGa9JCWtLO0530qhDQCJkfmwc5TuMsf1uj6PqYTx2sGHua1ZN4lnPsgaKnJPdHZHUGMMFfBxy0wxqrLIP3NGuTNmRqdUl9q7ENgOJyzSM6LRDkhq/FF9eWSicm8r0y3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fsDjqMKw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso447769466b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 08:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709654683; x=1710259483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0H2NcD59dhHTfKo451ZTlcHqhnaVKga21S64KdL2as=;
        b=fsDjqMKwWJOFnPCn0DCnKFaEXpI7vkz3ut9smwncEpR/tO3vbOQimuSlebJM2I54O0
         q89FiTfVOvqty18mCYkPThQef1eW/YFx+oxoNQAjRGr5pKfOna+UXWNtf78ZNxkgNwWo
         +K8JsnhaI3QiDSN932uo3EDNNJDp9nOlQIPtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654683; x=1710259483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0H2NcD59dhHTfKo451ZTlcHqhnaVKga21S64KdL2as=;
        b=buXRf2LWBD4I/xw92Q6P3cqolqiduhnsAV7Q952wHsz9ZcH1y7KRLZHGnOf0tdpxL3
         B+bNRMKiqLJRCn9JD/kDr/MuT2c0EUuqxcbyn6RDXFGEk0rBDRSYppv3i3Q5Zl4L1Woa
         Ss4Gll/wEKPMq7Y8W143J4dcaN478Toa/aqDuAwQ6uJ6cuMo1D76oc1dQvBH6uUb7pMx
         KAXISTS6ZzTButvrbr+M2SGxD3TP/vu6WY1ijV90lIbvxmkv5lfzs+fLOdMxU47LeYwo
         dg6kbodNLvbcIb2fa3j1PdQtcjdSniV1CPN+UIJWu0C1hmkHQluLuo/QYA/dq/fIhDr6
         grKQ==
X-Gm-Message-State: AOJu0YyZLgJP8e31m6Q7BXNCjPu7KrRasWcE4yrXLh4EvFxrAxp2h3Hw
	Gjzqu7buQn0Y5tz99O1Juh8sElZVva5cUfgpaQrnVPAS3BCejH9bLSjIrPOk4BEHgBFCH/a4FzM
	eUHLFhXBjxbT8IUUb8cwPBTOwkacfmzFuvlb+5w06v5cZDSKJ
X-Google-Smtp-Source: AGHT+IFMZIwMXMwn9b1NuGmsElo9IYaOZRWc5K/okKG3s2qc3CABtigMHxo2c25ZIM++4Um6Tc+NwcUVMUZHUl0pEDU=
X-Received: by 2002:a17:906:ff53:b0:a43:f9ff:2571 with SMTP id
 zo19-20020a170906ff5300b00a43f9ff2571mr8629999ejb.45.1709654683091; Tue, 05
 Mar 2024 08:04:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028065912.6084-1-zhoujifeng@kylinos.com.cn> <20231107081350.14472-1-zhoujifeng@kylinos.com.cn>
In-Reply-To: <20231107081350.14472-1-zhoujifeng@kylinos.com.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 17:04:30 +0100
Message-ID: <CAJfpegtK_52EO51FANkp4=3-BcrLo0eP94=7es5AvjS4R1vvjA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Track process write operations in both direct
 and writethrough modes
To: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Nov 2023 at 09:14, Zhou Jifeng <zhoujifeng@kylinos.com.cn> wrote:
>
> Due to the fact that fuse does not count the write IO of processes in the
> direct and writethrough write modes, user processes cannot track
> write_bytes through the =E2=80=9C/proc/[pid]/io=E2=80=9D path. For exampl=
e, the system
> tool iotop cannot count the write operations of the corresponding process=
.
>
> Signed-off-by: Zhou Jifeng <zhoujifeng@kylinos.com.cn>

Applied, thanks.

Miklos

