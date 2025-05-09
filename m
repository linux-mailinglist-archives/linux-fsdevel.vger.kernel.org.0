Return-Path: <linux-fsdevel+bounces-48653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167C8AB1BAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38113AC1F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCCF239E9E;
	Fri,  9 May 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="LPm3qxWQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA023643F
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746812359; cv=none; b=MvenipPm5flHnYbvbf/iK1Aau8hZupq1TTmrKFlz7KDKa1r74oqYOaVzRdWMeXUKwD6eX6ds8XIf2+B8CTfCvcp7vw2JEwTz/k6YBYvq/g06C4wl73QKX6wrZeg5LEYvsB2quVKtWxCI1PfRC42Lo1ZE26NC/Lp4mRMeYsxjUPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746812359; c=relaxed/simple;
	bh=LfrZCmzoSG/oOv69lKZc62lKRYOxuwevfizEFv6KoOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jiyQwJb3NLIXEhyWzhhHqLjY2av9AVK0lQsR0SGtMXlWvzxAu1ndGFYsjYMf/3gxqhGfCS0AfXLd3+XgfmymHEuOq8t1oVDkSGPfl2JEt5V4d7Cuxk93NVhcx+cxqDYnBWjW/QA8eDeuyEPXN04QwFN5QpmJhc4HCpcxYqhaKdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=LPm3qxWQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e7eff58a0so23500555ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1746812356; x=1747417156; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Awyu6yx0XWHa7ZiRVrCdZHl8L0TrAJxNWpvp17USw3Q=;
        b=LPm3qxWQ8pnjwAu6kxyJdVODFnhiWz6NZKK+DW0rUcnqvXjy+gGyKdQl6ZtOufOM7i
         TxWjUkV6AOLrEFVxqQxOsoQEcjeBwYKB5xrbUhDsaKwTEFN2JQKbDt3JNUWAx7h7Z+2l
         CBz6xpvsv5xt1c4IqGTZTjSLp961YkVsCg9qDWPwevAksMmwdsI+gm2/pwxdKuOvO4Ow
         XlROs0z/zakzqlT8WRqqZiGbDzE7djFcv+SVeumhgxyxrzFs2cYigSZCmjHVPLbXh61S
         hLbyS9dZSHdKh9NuPLDpOsgxgFGKt51+xSLqgs+0tIuS/G6ZBCAA20+9S5ghIqTX0A90
         dTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746812356; x=1747417156;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Awyu6yx0XWHa7ZiRVrCdZHl8L0TrAJxNWpvp17USw3Q=;
        b=g/bhD9dPxowmr934/5y/lxEmwjTnOA43NFYHlDJed55aFrslXhkWKXgLBsOdmTqHyA
         MJL616UyiGiGjrUmFNEBxoXBU+8eqStQ5nVyIrAXx5a+UcG4ojt9PxgmaLrs3N4tPOy4
         Bob7Ro8p+vKsxJw9iwOaOJZUXM/sWgslXnkwtqNbhH+364xtUN0PITE8Xrl7QnY38zuy
         xX0IHhqSLFcaQFCXxxVARN7R2xTB1QGBdgBRnkVklXDCoVZIrx3GouoKbL4TtFNgG7U1
         7g2ZfVHuXKH+S+VsYqzTT8ccLjHH0nwEO+9XRq3X8DswqpNeRrmV/uKeScwMVH1nzvHN
         tWmw==
X-Gm-Message-State: AOJu0YxiI7TE8Xh4GDkYNoxcVasc29q/C2XlGMjSMc7RNw+jbWkMOhgm
	ZsDmL4rm9L0zW8qA1JSrFAcvd3U6kIwX8XsKSoyIq8f2dnX7UBkPC1f1XAGK9+8T/dQfqQWLqgq
	3bfU=
X-Gm-Gg: ASbGncud/mmESMDqodTiFj4v5lo7TZqbfxELoRkD/CqAn+vHf6fJiOsnqR98COho9p0
	ShjwMslmbrjwy619wnCuMOSfA832P6995blZRsn35RRO8YLnsxLVh2tXZ9ctdFuR/hO1SIJdFWt
	Na6qVpEO0YmC2niWDvWrZiAb+QyABW1VFyHRJQcFtiLZ1ZaW1kHfTHMi7FtGmdzOaoZ24QhTrNZ
	3lOcnBaQU+Psiu+CugxxceOduZB9FkQPEA1HVpEhvvJ4efqHQUAVcmsaWzgcUqx1BNwTVFvsjkk
	MaDxsm+0uLMT4bPnu0UuXb2BX2mNTyyKBCFaSn3jDWQC3QC8rACB
X-Google-Smtp-Source: AGHT+IHGEwIyBm7xgc5W0YMlKDOYo4LdM3owzYLLhxcicqaKrdscfNIqz3QiEtNKj0ZCYv/G3JnZUA==
X-Received: by 2002:a17:902:cecb:b0:22f:a932:5374 with SMTP id d9443c01a7336-22fc918d1a7mr71694425ad.48.1746812356347;
        Fri, 09 May 2025 10:39:16 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:f242:4c31:ff5d:e2b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82a50b3sm19857515ad.240.2025.05.09.10.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:39:15 -0700 (PDT)
Message-ID: <e87e0fce1391a34ccd3f62581f8dc62d03b5c022.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: export dbg_flags in debugfs
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 09 May 2025 10:39:12 -0700
In-Reply-To: <20250507145550.425303-1-frank.li@vivo.com>
References: <20250507145550.425303-1-frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Yangtao,

On Wed, 2025-05-07 at 08:55 -0600, Yangtao Li wrote:
> hfs currently has some function tracking points,
> which are helpful for problem analysis, but rely on
> modifying the DBG_MASK macro.
>=20
> Modifying the macro requires recompiling the kernel,
> and the control of the log is more troublesome.
>=20
> Let's export this debug facility to debugfs so that
> it can be easily controlled through the node.
>=20
> node:
> 	/sys/kernel/debug/hfs/dbg_flags
>=20
> for_each_bit:
>=20
> 	DBG_BNODE_REFS=C2=A0 0x00000001
> 	DBG_BNODE_MOD=C2=A0=C2=A0 0x00000002
> 	DBG_CAT_MOD=C2=A0=C2=A0=C2=A0=C2=A0 0x00000004
> 	DBG_INODE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000008
> 	DBG_SUPER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000010
> 	DBG_EXTENT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000020
> 	DBG_BITMAP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000040
>=20

Frankly speaking, if we would like to rework the debugging framework in
HFS/HFS+, then I prefer to switch on pr_debug() and to use dynamic
debug framework of Linux kernel [1]. It will provide the more flexible
solution.

Thanks,
Slava.

[1]=C2=A0https://www.kernel.org/doc/html/v4.14/admin-guide/dynamic-debug-ho=
wto.html

