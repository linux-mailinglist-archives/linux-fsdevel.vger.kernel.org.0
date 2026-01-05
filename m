Return-Path: <linux-fsdevel+bounces-72390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C4CF3BD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 14:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04BB2301D300
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F404343D72;
	Mon,  5 Jan 2026 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ngagv0uq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0434320C
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617135; cv=none; b=cSOM6FOxVJ1g/I2BMazYpkmUqg2kDmdSW82s9fpl/a5eeQ6xWp/EPsDTnAbXV0sNum5OWKx1MwZkxqSmbD8Tc2ry8wP7F6iwUKM73m05fqNxCkMmilN7pqU2n2b1veez0JusUMncxH2Ll6EVatUDr7k/far2goajy+z9bTQQ4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617135; c=relaxed/simple;
	bh=Du4vwB69/PMr3V7cOX/8dQPikLdDUw9VqpUv9GBIsYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5gZAOg6hlbmw/cAjIrTBTRU1bFAYyJiUFyep9aC7dJX9qzRcrNN2661Rl5sFg5YWrG4JEgji2DRqm9u1dE2bL+eZmHK5FaV3Ad+1vr38FA0C9bUnNQ8VXBenimRG18AMarORThUVYgcVIsdzrFTCNvHX4rcRECSgigA5Ge+sO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ngagv0uq; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ee1a3ef624so80046691cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 04:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1767617132; x=1768221932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du4vwB69/PMr3V7cOX/8dQPikLdDUw9VqpUv9GBIsYY=;
        b=ngagv0uqfZ9jZI0j7wBau3w7v80S7B1f3HpdReTGZTYR9hAhNO4cEyMR3deuAW+b3E
         e4AvwGRdDtjBtkZzdmzHEHRaXtlWMayUzuF2f+xCAV6tl+0OzRAMeQ72xpiQfXtOci1P
         RcvjbuXSEY+hGiqs0Rq8PtAZcKoOqtzsp7fXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767617132; x=1768221932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Du4vwB69/PMr3V7cOX/8dQPikLdDUw9VqpUv9GBIsYY=;
        b=eSd1FJpACw4OUa+3jPfVi/fYHOELnQkOVG50xSP+sUerjyewViWsQLVZNgp9OHB//N
         fJYZrzB7imvzVJbCH8Ixy4S8XIcMLZrIxsxSmkVkH6WP36YwXVewO+H2jQ7Gc7/Lv8pA
         NhsQwirXroBZHrRpqQg1uQF6P/iZx7bGqGIpDqz+PPYoTLS9qsOm96JLH7jNEnN/wJGu
         lSuil2SJgydr+YJ9LS0IOmJdTkLvOFjx3pqx0phbMgn08IU8c+eusu9LsEM5HNIVyiXi
         dWHTP9lpxdGRHn//ShCkhNJMCIIpvEbogCWYcF/7/t765ku20o0WIEfxuGjqt0VZr5b7
         xj5g==
X-Gm-Message-State: AOJu0Yy4fxYerYMyGoh5Da1muC5jmbfhomfk76fxR3lXjtZNmuWSK6U1
	rtxRzi0Fd04Kh68uyNZadnKXzGeYok2pVaRPeVK5Y/xW2FoMRhD2/7ZdLIcJ6F+MK8XTDPK7J8i
	gcp8C4HYw8Cz+hLPE9aKGGOTO21RrPR71MiNMfL+cpA==
X-Gm-Gg: AY/fxX6iYuQ2tYsNSNKe9IPcVlb0Ukep1ljmVcIjEuPneNCEVam8GrzO3kBBH022CLM
	y3l+qasQjqtPsFm8f6JB9xxBouZfQFQTMaVpeyo/rY6Pxbi5CarUZFOmdvVG9yOndm+73VhxDLJ
	YYL+uiT3E1ZA/SkzU/usNwEvhx4KWSJdvrCmcoxxDhbjaqhcSBKchkntQMubvex2bdxdREgTIOL
	6E6gL8fxGtWRqH6IVzo63qUMeQ0p1KY9YlWkWpOsgxf1w6Uzn1Du5ZkZoPvILIwI74CJQ==
X-Google-Smtp-Source: AGHT+IGJKRsbB38kkWGuMkpSTDC5QfqosGqAB1upXip5pxy0cS3rzQrMSjNWdGRlhKc4EbKpJYmnOESQ+aT1hoiTbj8=
X-Received: by 2002:ac8:5650:0:b0:4ee:4a3a:bd08 with SMTP id
 d75a77b69052e-4f4cb62b370mr457517201cf.80.1767617132170; Mon, 05 Jan 2026
 04:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
In-Reply-To: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 5 Jan 2026 13:45:21 +0100
X-Gm-Features: AQt7F2qNvfXKlGuCsusymCw6AD2btyYtlN1eqffJchbCX4VkKGYbFIZcZr0lj5E
Message-ID: <CAJfpegtMXJd_k2j6kgNXNnRRJMPcX=o+yx9C3d_wkK8dtNQT2Q@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Dec 2025 at 13:11, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Using libc types and headers from the UAPI headers is problematic as it
> introduces a dependency on a full C toolchain.

Can you please elaborate?

Is there a real use case that is being fixed by this?

Or is this some theoretical thing?

Thanks,
Miklos

