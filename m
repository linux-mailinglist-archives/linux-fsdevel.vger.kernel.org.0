Return-Path: <linux-fsdevel+bounces-73641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CBFD1D272
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 09:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 204D13004EF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D5137E31F;
	Wed, 14 Jan 2026 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jd0eSMaR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622437BE77
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379857; cv=none; b=adWJppMGDMz/CsJSl9I2+7EEdxcGFzQDL5hF2TzTPKkRZ1USei1COa90yX56giYAriCtvofD8JGxV7TSpN5dfVb+N3crDNkxkNCFiKSgWrV+ElJMdJGVt8SyNl3WxLg2lWVEJepHsQ6oFRNmi7KvBAHWPfNGvx91BnWoHEIE4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379857; c=relaxed/simple;
	bh=MUWJsFB4yW8EouHM0/GRly+FbEJrtjXUmqA/Ymb25XE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kJg8Tqu4KBeD+ZES3fhKx99JNgI5wVCXpBNXwAYGvSiwgrY5MRdelUP3+JFHA7Vyr+SLKb8elWX9nlxhMCVWS9QwIuIoZYAXHA7DoiQm/N5ORsgOpowH5dG1Z9L4NIt/WxhH/+Dl+2qD+yy5Jnud6kfT8hoUM3VbhKNc9vhQ4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jd0eSMaR; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8710c9cddbso478374866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 00:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768379849; x=1768984649; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUWJsFB4yW8EouHM0/GRly+FbEJrtjXUmqA/Ymb25XE=;
        b=Jd0eSMaR7MydkWBe0yKwLUGrcY7wjwJetUkP2+yb7lxoZKAuPdzRvE/Uv8bGY0Lvli
         2LAzAZx1ek9RSvD+9iAv+1UpWrCHiu6BVZcmGBPEMszSws+rz0VJkwfrnvv3CTjl7Cqy
         1FyZgJ409fUlZr7fETLoUqi1k1kbbQCVYWnR1IcIQBzO0NtLML2cwHgwDAXFkRC//4Jo
         BRias5K8yBP19/yFrsYsy5F+3QhiwpbiX6ONs/zjTuvJ1cdSioV6wD1EZV8TbSQRBAH4
         Ne2XENgX00UDLmdPMmx4fRl0LZdXhxS8J+YRSk3UuGiUzMX9wfpPliSZZk91+m62Lui2
         FELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768379849; x=1768984649;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUWJsFB4yW8EouHM0/GRly+FbEJrtjXUmqA/Ymb25XE=;
        b=QmJYiFNZ6CsVW9MIQddUaYF0lGU7hvqwoTBADz3vZnVU+yBzH1cXwJv3zVSWpRTenu
         GOxIII+svLl5uqNY0kSpi8vE64bf//jlLt3SUJPNGEKPOmjUY9fuFoGZQXyDpH9zY+ml
         HFkqPyqvOuGgdXW/s6Z2HEe7KOTdD4nsqRoji51OiBz22F7ruNRIPpxpupvKM1cmzCN/
         yo1Aa529eRStMKgmw9//5ZYvPOhIkV3xOPMifH51OLrPBvgMnKckr7eTqiPekY9phuEu
         iuGpbP5bachtLnQ5Fmom5nn5sDW165eUp7O1nlV/x/i1BN2rAWgc/96leYQcttfXk+Bp
         3lgg==
X-Gm-Message-State: AOJu0Yy7aPCEg446FZEHqFqPanz8Mk9i8Nf/OUEDwOpGlltYNcx13XZn
	fytygGkWgc94htfPNaH7WthZF3eAzrzEz8RagNQu3QG3Qd5pUEa0Aa3rujHe34cJYZs=
X-Gm-Gg: AY/fxX6TU+D133sKYdkA2WYTRxl6fYAWqpsAZ332qlptzGxPICPuKiPZF6UZ/Ew9ewl
	2rmJniK2g7qfIwwDppqZ9UXGIzMLTShZefdcpYy7K0vpXJRmxPCUkln5UksAlbfGUJZ814v5uiu
	LI0wRR3SRDFRYxrbiNi8v+aEiF93Kbfq82SCOF9+e5vV5yRYKhyi5pWOEWNJtAmpGts4aacW7xg
	sU/4lATlFLOLdPJIAv7plW3LNG1iL7KG6KE2PD+HKgJmbu25I/WjyzM3Oz29qhpteP1ZO893xra
	pGZ9F2ma1MtwZbtwpdrOga72RkIj+o6npxrDBBm0+l2ZN0iwEyRx9CXUcCKY0CAMO/3e7BQbR2i
	oBU4ZN5+QMR5phWFTFfndC1pMuZxdKAbqPFaPnVe8kWQttlT1Oh/17A1dgREiwNpHzvHOMEC0gL
	DwIe9OT3KU+/zoyX0jztf/maaa6ChIh2oJyBo2gyKVfFDd39kOvnYn5ZrOKvWiK0TGfOuIrJNbb
	3yd/y4=
X-Received: by 2002:a17:907:9629:b0:b74:9833:306c with SMTP id a640c23a62f3a-b876127f271mr142666166b.47.1768379848724;
        Wed, 14 Jan 2026 00:37:28 -0800 (PST)
Received: from localhost (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de. [2003:ef:2f16:4900:1c62:6999:955e:52c8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27cc6bsm2456622466b.23.2026.01.14.00.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 00:37:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jan 2026 09:37:27 +0100
Message-Id: <DFO6C71QX72K.5V39YITRN86I@suse.com>
Cc: <linux-fsdevel@vger.kernel.org>
Subject: Re: [LTP] [PATCH] lack of ENAMETOOLONG testcases for pathnames
 longer than PATH_MAX
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Al Viro"
 <viro@zeniv.linux.org.uk>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260113194936.GQ3634291@ZenIV>
 <DFO6AXBPYYE4.2BD108FK6ACXE@suse.com>
In-Reply-To: <DFO6AXBPYYE4.2BD108FK6ACXE@suse.com>

I forgot to mention that guarded buffers should be introduced for
`noexist_dir` as well.

Kind regards,
--=20
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


