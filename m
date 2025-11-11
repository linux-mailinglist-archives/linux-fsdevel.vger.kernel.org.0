Return-Path: <linux-fsdevel+bounces-67977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D6AC4F5F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5A83A49FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 18:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D234324715;
	Tue, 11 Nov 2025 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9ZMv5X7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D620FA81
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884350; cv=none; b=DTlUucYYt3Ruznj+rg7LnuZ88SuMLDYCKT1cTbahMvKFyPSQeair9RkYK4H/5lTZ7+vTMUW/iZ3ajvy9eJEsixirEmEGb5ugaOJHp0BcFOZhMyV32PEjEjMIg9+1e9SfvjJ6xgeCh6ovwuEO3GRJk4qw/aJTYHFKD07SDj2+WQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884350; c=relaxed/simple;
	bh=JyhPSHeCITxYJKF3xJYvx8dwXO9foqb6Q0bZKLDId3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t493N+QxEyzs44G3wPCAgzC7+ZOeBFr4v8ETquVCFaZ3H+Sw63n1B9u+CMG+4N0Fiju7aE2ObIwUH6J3TiVcBv/2k5SPyo9nM+tG/1j0Ih6nvFnX9yd6k65wclPmCYYFp5OWniiVMZ1K5/MtzIYUCDh5DP8XOS5wiY6jtvlG4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9ZMv5X7; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4edb7c8232aso138971cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 10:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762884345; x=1763489145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggyAFVSETsKtCaOfB2zJdNojnQ7EG6f4LaOVMtcEG48=;
        b=K9ZMv5X7mqNPI4DTAuCsIzHEUA7fmmx8ljVvrEuCWrR9KnV+PgmFPHwQQS99p6QzcQ
         sMOwp80fETL/G8obtrLQoYGKgrYZNHRw3ONRYNyY4KMa0s93KDAOqMnIfNwxwEaNVNsI
         9wBRbQW7aBlD9CZDXLkx4Opdegqkyr4nUPAWEpUOINJiNgmdQTLBTom/yp2DBbuVaOnJ
         hhKyIO/hiqawLoXFgk6GzB49UKVtlzc3gJc5It8L56Egj/133qaJbu5QNr0Ri+ouvEAb
         Y56zeONPZbPuYEapywRvQs5s2e58dWMUIpbtDsbUyQRM0rPa1Id0zmpSp+3H0lWzRWcS
         W91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762884345; x=1763489145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ggyAFVSETsKtCaOfB2zJdNojnQ7EG6f4LaOVMtcEG48=;
        b=XSOd02Jj0ljuiC4rhXtKq3Jf3uLyXwIm7Q3Qs0EQRIn62VSx+hBByuvYR+GygV0Zp/
         H4kpT2UkfTimAPMxfH1p4KCBGw9RXbcPudzHNrRsgjeB4WrYRGMdxzaouAy/q+YFuIRy
         S4/DGUatkFO1oCMHI7WV+O9HiQKlYa5xMQ0fcUqrYzAkrTjUuFPQHfAKSaMtAQq1wkTn
         AQx4scqKRyQKRj++43r6aTmFPJwi9dGQKuRq73Aj671UglQaJPkU/RPIgC7JJW3roN1j
         l1hm9fQG7SntqiTe4EOPeFLN9HgZGn1ECgCRWoAdBxUphQqJ+3zWaoEsM1R9JdjrD0/d
         rEyA==
X-Forwarded-Encrypted: i=1; AJvYcCVF5/O31sYV5DDD2wJ6IzQMJ0AIZy8xSTLlApAC4xMxYBIAaFIvPa7wIa5tethOCrgQIbEIe4TUXKhVPgKx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09ZTROF9JjXMZ7Upz73LYQai14YbWmtWie1BaJGJ1ZwwIlvHy
	iBdljTw46qEArWHxoAIChJtUWkcACpL6ZTobilWtK3FM3km5s15GHEpQRsTbvtgL9OY+zza90lT
	DwA2GnlRI/ulYUAnmDNpEWla7Rvy1Jtk=
X-Gm-Gg: ASbGncs3i+EVCTMuLq2IqtT7DZFl5tCMMdad+VwUJSykj/CIaAPKPdV62paBDiDJUyX
	pspwajsVewGwRG456eiO4CUvjCkQ5TWuNUVuojWFbwXvW1J1mkRp/I6mtZ72gpRWzTdeuQu9+Dv
	YCq+cdU117FYk3krsuLPPMqJ+xlKVtAs97PzBsF15B6GhI1nssTzwfDobxahHn09Lx7+pM82gux
	HmQc40CyPO/2YcrEwobGyMfaKmj+hKUJcaXX4JmT3YkxduC3lNJc4+dEZuROsYuPmadQ884otFs
	1TBUVLGaNcHrpys=
X-Google-Smtp-Source: AGHT+IFLk6zPBPWHh3ylHbttrdYGIZigGpIvRkYs3QOqlPNcOD0+z7M63J00uF5c4nG31br60oMPmv7619qNWODbjSU=
X-Received: by 2002:ac8:7dd6:0:b0:4ec:f030:fe46 with SMTP id
 d75a77b69052e-4eddbe14c37mr964911cf.83.1762884345338; Tue, 11 Nov 2025
 10:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104205119.1600045-1-joannelkoong@gmail.com> <20251111-unkontrollierbar-zugelangt-1dbd13f5d305@brauner>
In-Reply-To: <20251111-unkontrollierbar-zugelangt-1dbd13f5d305@brauner>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 11 Nov 2025 10:05:34 -0800
X-Gm-Features: AWmQ_bko5c62RXeOKX7DdIAB3q1fQyJxcUxj9CduCnGxpO0tdnnJ2rcxtqofTsQ
Message-ID: <CAJnrk1a3+gAU7OCXCAsZPx26nOfDYtKNFC9rpDiDTdU_zD1riA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] iomap: buffered io changes
To: Christian Brauner <brauner@kernel.org>
Cc: hch@infradead.org, djwong@kernel.org, bfoster@redhat.com, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:09=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Nov 04, 2025 at 12:51:11PM -0800, Joanne Koong wrote:
> >
> > v2: https://lore.kernel.org/linux-fsdevel/20251021164353.3854086-1-joan=
nelkoong@gmail.com/
> > v2 -> v3:
> > * Fix race when writing back all bytes of a folio (patch 3)
> > * Rename from bytes_pending to bytes_submitted (patch 3)
> > * Add more comments about logic (patch 3)
> > * Change bytes_submitted from unsigned to size_t (patch 3) (Matthew)
> >
> > v1: https://lore.kernel.org/linux-fsdevel/20251009225611.3744728-1-joan=
nelkoong@gmail.com/
> > v1 -> v2:
> > * Incorporate Christoph's feedback (drop non-block-aligned writes patch=
, fix
> >   bitmap scanning function comments, use more concise variable name, et=
c)
> > * For loff_t patch, fix up .writeback_range() callback for zonefs, gfs2=
, and
> >   block
>
> Joanne, I think we're ready to take this upstream. Could you do me a
> favor and rebase this on top of vfs-6.19.iomap and resend?

Absolutely, I will rebase and resend this today.

Thanks,
Joanne

