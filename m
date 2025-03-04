Return-Path: <linux-fsdevel+bounces-43159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9E6A4EC73
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8281918843BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B1A207E1A;
	Tue,  4 Mar 2025 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgqesJTy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4C2045BC;
	Tue,  4 Mar 2025 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114126; cv=none; b=j6Di23abqLL5azepjwOc+LJocrr2ZgFHP/JceMy4AjTDahAxTdSn6zmKNr4n+ThSaHHPP2Xl8jMJAaPU0gGSpGIcxdCYJI1oQck2BeaV6A7qB4s99dGslR9DNs0JxgMWoBEoqsH+YRCvQMINIpOMqsX5rPf3Iu6WKYiS1tNCkUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114126; c=relaxed/simple;
	bh=NpKfzr/oUBsQgUVJ29zrkPoatW+jzNjZkTw+UvFff8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTNGYcl4lW6QYmJrx30n2iX5i1q9X7y0ih6in6Yuqxxz/xwcRH/EbmqXMkvKoRJGJzkeaFCqUIFi6TXMiQd3OiMNJqNY8ZFxdUmP4GZdZsn1BvtvHY1q2smOSYB/QGZZPmtWJ7k+WJfrulVeH58fiM6bSBYEbSukrrztqdM/Oxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgqesJTy; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e50d491f69so4640796a12.1;
        Tue, 04 Mar 2025 10:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741114123; x=1741718923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MrypCo6V7mDN1yvGSKa3ZiKGOTIawZz8DrFPoNJTQE=;
        b=MgqesJTymab556ltKm/CqIAvEz3vi+qXj4MamnlIsxI4SZR9/jjKibmGzBU5UTR8Vt
         dyYW85uBbqoadUKhG4WZqjKHRLeNefgE3aiejiCUzsZlGMwgFbTct9URYUTE7K1Dnmzs
         bScmrTfKypuK7ybNOt/jtUTJ3N4p1aAlW9bzS7UfF1X/EW9uGVrVeoUifV0QPCcrKSWM
         Qg0n6xZO+oBPdsn5pNiPkqgALkmKenDQ0+FGiXelz8PoBJ1BQdavoieuIjdXPTLxGLBk
         PlemQ8kR6SvxigpV+GX358LNqTwtBILG7vfFnCbta6cLwJ7qghpRxTqkYiT8P9CO3fVB
         ijbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741114123; x=1741718923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MrypCo6V7mDN1yvGSKa3ZiKGOTIawZz8DrFPoNJTQE=;
        b=j6BnGv4Q5FOtPckLQ7fE2TF23LMJ4rjClkusbav+dptSa9LF+3eaw10KHtn1vqLZ3F
         N0Yn+logLWzRXALjjZyLT31mibkSrHqFTA6+Xq0R5NEkKeyluIiV3TcmL7sDIyASTHdp
         /JnN+HpHIyZN7l918/JgfT/O2KdkkmsPdSXsFgxMKSnybwZ277FdlnAxr536wMlSTOf3
         2jlDkRCZ77lJL3aa4rc/kE0P6Ju0QXNI0+wp3ScAbTPWBGlPDbuIvMyvbQnPZoTnyM05
         YhGw1K66/E4W/IYoM86096KqZ+QUfStgjV/9fI6GF285xODUx8ZjGKrQCVCydj6p3RwY
         HMEA==
X-Forwarded-Encrypted: i=1; AJvYcCVbxZdk8cqde+jOGz5Of1HqM0KdHDhYrVwGtwvZwu5Dc4kD0JBhj1Srd9J2f44WSWWrjxeWg3kVd0BdETdm@vger.kernel.org, AJvYcCWYGSW04Sxb81Z5bfRD4UEXE/EJ1A0rgQI3WctYjMso+a2mu8T04o2DMvvksn2MKwAgVrJ1n5ArI39/4PDM@vger.kernel.org
X-Gm-Message-State: AOJu0YyawDa6uFHNsaVmUmySFFPhj3mMmDtaZMRysVghAmvXCBZ/VyvJ
	nsUStYmfIKQ/62GoS+YxxnfmCS3K3fZNv8BEXw3qS5ixnCW/h64FcVNi4vwL0GuQtxFNzZ/9tWb
	rnYCe0JzWN6mhQa8DRedwWt6I4/w=
X-Gm-Gg: ASbGncu8i2z37XLG3CkSs2uS52tBtpe02syv7PwxwQSG2xBWiVGWIx1tKPhiWqJ2X/K
	rIzzERUkS4zflTqMb4ofTByyuThNtkLbklfayogqR6Y7fM/7H9+rjNkqZLTSDKu3TW+6mkouQEU
	Au95G3h2sIzmN6YK8mC8pLoR5m
X-Google-Smtp-Source: AGHT+IHCazDJJo/7iQIA45l595GF8+VhKHWgcWqMTz+wapHtrZ5mfXVHw2QdpH37Cov+fyOXnQcBRr8tYrJ0j+9dZNI=
X-Received: by 2002:a05:6402:3547:b0:5e4:cfb0:f66b with SMTP id
 4fb4d7f45d1cf-5e59f35248amr167731a12.7.1741114122758; Tue, 04 Mar 2025
 10:48:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304183506.498724-1-mjguzik@gmail.com> <20250304183506.498724-2-mjguzik@gmail.com>
In-Reply-To: <20250304183506.498724-2-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 4 Mar 2025 19:48:30 +0100
X-Gm-Features: AQ5f1JqL3wd9FXFX4qmZyopa_wTmc40z_qCDzfhmGbuS95bJdGI7okUIdP1XsFs
Message-ID: <CAGudoHHjGZ4xTQ4mGhFX5RV+fq7=Ywo86b7Qf42+ssVeHhMOtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] file: add fput and file_ref_put routines optimized
 for use when closing a fd
To: brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 7:35=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:

> +void fput_close_sync(struct file *file)
> +{
> +       if (unlikely(file_ref_put_close(&file->f_ref)))
> +               __fput(file);
> +}

this of course should be: *likely*

--=20
Mateusz Guzik <mjguzik gmail.com>

