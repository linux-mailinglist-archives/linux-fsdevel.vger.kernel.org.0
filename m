Return-Path: <linux-fsdevel+bounces-72013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B6CDB35D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 04:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C337A302278D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 03:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D4C235BE2;
	Wed, 24 Dec 2025 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RcRrQIH7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D22264D3
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766545477; cv=none; b=EI/H+WTSlZQEra3pT7CMn+u9ay5eQDl2Faln7AFepkKi9pYwgijTI4M/KIIA3EddLbRmCHKCixxZNZvJlXPbdPjUNcWsoyWWW9zNyr95BiIiabyZSPUBUPwTy4KJw7/2G160VbrNHTpOTV2hHVt8fr/62XRGyivsbwJFhBZ1jQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766545477; c=relaxed/simple;
	bh=iP1N+9MdmdXIxlZDis1LfF7+gfG5pgLCPpYGP/Sd5uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLj139QPa0FIgiwWi392Y+Z4Jm08AXS0tkPY2KoR8LA/C57ygEfPpTv0x2zvfzKpBtzLgDeOn/9bCiZCTvHSLZSQzfLA9X/bSA4S9q/oD2WBxc0PndKBiUoZG+newi1FFY/YNu5O8kLvbLL0/fCPJTcDH1pUxv7G12oldh9k1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RcRrQIH7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34abc7da414so4704614a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 19:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1766545475; x=1767150275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iP1N+9MdmdXIxlZDis1LfF7+gfG5pgLCPpYGP/Sd5uE=;
        b=RcRrQIH7RXWiaOcJWDh9YcbR2MSoAwrUKUMXOR57Ha5tmVdo7ZaC7K6G45dutOK8t1
         pYBolaDR8nRKCreDRgND0jsePUPemhIGMHQr3Uq6ckAJYRRmK4EQOSVrJyF7wgkVDNSS
         YelQFxIOaW2MCUp/Up5+HEASK5LN0ydnXF50iH9TeozsScCWlRvoajbeU9+nmNBUAOZ1
         zLTQ4atsLN1q2RZ5kFEsD//pTs80dEBMzzyRGeFC52WY+jZVjybbcme3FJkIV3oLQdIp
         VQJ+E5FSopeMcJM+3sHdkCP7KfVyVUAzajhW85/Q0yG1doIlVCH/1IvUI9lc0/9CBD7g
         EW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766545475; x=1767150275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP1N+9MdmdXIxlZDis1LfF7+gfG5pgLCPpYGP/Sd5uE=;
        b=FdcDA2w9i211DQC4VQOTXSRvnDPiKiVC3oN3yRpHp5+UqhatAnycyKTCvmLMH19TIt
         FJ2RF4+3t4SxZ6Y40nGiRejJ/LSGXVvhsjd3Gzvw2NVcG8id5lvUyUi2JsbPfU2KRBEl
         MiBNcbgiTJ+b8fdToiJMjgf8Ls1SZLBIdMyYD1jvR9e0/5lSV2f4AD7BenwaQ7qQDC4y
         Dz5rPH7JBKXYAs+DqtZrMM0ALws57wvDjoet1FYcf5VuBoO1/6H22GepnzWzetJTYt/A
         5ZVROz7hMtAZp9p3Csgn6zDWCkVy2fHyfHmOG7lWt3TtKvDkYemrjazJwSOac0VHLOyf
         meaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlypU0qBfTjodtthGHBBM7MTMIl7WH1iwKUv9xo8CzkmVF2eXLN1RGibMky3gDouiYGfNU7VcUUanITmss@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdXH9Lt3vQDUMx7mxhmqSmrnYWxcOWfDng5oFoXGLsfDgHtEI
	wJokkVCERNXlhL11INB5OuOh6cXj1Ew3Oh43Ywxk6TnSJMqPD/AKpmdPHSiU62YSrDuxKbfIASC
	/xWvulPNgIozdh9glV7Ylcc/YFTW17AwZgEG3lpPC6A==
X-Gm-Gg: AY/fxX6pkR99FQkrIU5DYdxKQLD1cThS1AROn3Xf2Z0+bDyaRkehd0l+lJ2spXZvM5J
	b9ZBCMZtnbkmBvh7KTno5O+FWHx/tu59Ej/XkUUt4kkDyYwpLr+0rgK4tdNyNCopbYYz/F3zvO5
	Hjk35A1X0gmXVwmSc8eNdIDzZjzc2/j9lVVhh+kVLoY5lyLzDahRfilOgty9VkiOhxsvACov+2+
	x33cQtt37XBp8zWmzba64mLeuzQmPHjGRqNZZkMoL4T/8oKPx2XnK3GOTOj4EBtjVgbkR84kPAe
	zPYj5ALByfjC
X-Google-Smtp-Source: AGHT+IGvf4GgwmgZ437ZhxoOMVTBk2q1cW6oT9Ge29q4gnaTKgeUNSmCkpqpFtXCb1xU+GacOOAZuEU1p16Vb0U67V0=
X-Received: by 2002:a17:90b:3c47:b0:34c:fe7e:84fe with SMTP id
 98e67ed59e1d1-34e921cbcdbmr13556929a91.28.1766545475229; Tue, 23 Dec 2025
 19:04:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223062113.52477-1-zhangtianci.1997@bytedance.com> <CAJnrk1aR=fPSXPuTBytnOPtE-0zuxfjMmFyug7fjsDa5T1djRA@mail.gmail.com>
In-Reply-To: <CAJnrk1aR=fPSXPuTBytnOPtE-0zuxfjMmFyug7fjsDa5T1djRA@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Wed, 24 Dec 2025 11:04:24 +0800
X-Gm-Features: AQt7F2p0DWGR90yXkiWO7lD3TMOssxauELl0T4FgB01v1oD-eyyDp-WJEUt-0hc
Message-ID: <CAP4dvsf+XGJQFk_UrGFmgTPfkbchm_izjO31M9rQN+wYU=8zMA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: add hang check in request_wait_answer()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xieyongji@bytedance.com, 
	zhujia.zj@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Hi Joanne,

Thanks your reply,

> Does setting a timeout on fuse requests suffice for what you need?
> That will detect deadlocks and abort the connection if so.
>
The timeout mechanism does not quite meet our expectations,
because the hang state of the FUSEDaemon may recover in some ways.
We only expect an alert for the hang event, after which we can manually
handle the FUSEDaemon and attempt to recover it or abort the connection.

Thanks,
Tianci

