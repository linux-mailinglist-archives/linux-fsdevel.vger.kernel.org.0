Return-Path: <linux-fsdevel+bounces-36535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97FF9E5778
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 14:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C949A1883BF9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2983A218E8B;
	Thu,  5 Dec 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diU6eNPh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350C0218AA7
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406085; cv=none; b=sz9h56Vl1rvR60QQOagSYvNq+V4K76r0RxFfbP0eUuh3qStlYa0tslQdY5qIkrsAgNmBNxvI3iRrWaAhz23DB54OuXolNyVoKLJ2uwStH3u8/Md+DPv5svJU15FCBez8BY/BjALHlTHI80dvnYPzhCDT/k7cB2ivXaNv1LLEFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406085; c=relaxed/simple;
	bh=MT4iop78WS7kXQHV1lnkSBtdTDxzy6q5KPmoYCa5UK0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwpQrCP3ocCA/60KP+DyzqsfFL17veCeGJt5PvNC5i29xjzAeE+MaxULiaqnwuK6vioTFjrqj+uSiBR37ktiAG6qkpsqGrRmSjij6dhL5Cp5u5HXOQKeDp6jAlOYttD5wPjYSOZB5l6W1W4yH8LMlCnvcKnhUGLbtUAZFmrGebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diU6eNPh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724f42c1c38so804960b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 05:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733406083; x=1734010883; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stPP7YaX8NczBe94EUNJGGQYrsTGF2tS1ZZnY2i0wbc=;
        b=diU6eNPhM/Y5kSxAN4dPL4FYjF51fH/plBVeJhdvWxj7BtjuaCGmUl76NHKY+NqkAQ
         CUYJ1iyBED7RJjzffjrl7T5L71vAMthJxmo8Do8I+B6gTdFnIjTy6Yb7SF3qDBj/tOqJ
         v2NVKWP5Iyhh2NnryjDqG5glVqqrBXhtScfQ/F7/07knxTpezBC6jO5LE67VuOn27Mpd
         tWHiIsZDOPl2SPtbUWoKm2o92GVtb8NUBCWuCesqK0DW1nKqwQiNGC+oP58bj+E75siG
         VDL+sKvTGI5hRgB5or/s+3Mfg9TRxE+z8uTPWkjV+qkEkK6UtTI9YQCQ1Bg2vxCRA9Qy
         plUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733406083; x=1734010883;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stPP7YaX8NczBe94EUNJGGQYrsTGF2tS1ZZnY2i0wbc=;
        b=KPkklcJa9FKeRtzHGkZgLMs+Rj5gRNTjG6HGwrKWDWdfcrNS/YqCyutnWTymF8hcYz
         ucN9JjHVMCUsKC6k2kmj4LxDv0Bjqjon0Y53uiriDr0DEgxQu73DNttoNtR0VxQgc3EZ
         a17WMAHeM/hjdcmy1QmWB+6LXsqJM/7sMfqKno5d7BZrwaVgcav/MJ4AMvUS0C0hpfzs
         rm6OjTpoUdekf61lWcJGH4/moGKBp7VUXMs6YglMbWipH0WXNkkMvIxEaT0W97YskL+w
         qyGv5QTfEIsez+0EVweJhthRrkXNfg7oQyV9Om5iiOy1yOOR867rnbq30o71fbScDN7c
         WS0w==
X-Forwarded-Encrypted: i=1; AJvYcCVf6+ZdFlZE2NYO+97sVJJ7IYf/F4jGOFcmgNKkf1TMXyO+sC6DaDZCpFrx9ajFH639kv8jnl8JLFyUnLPR@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwwLnq02tOQzl44UPUPsDqVvmSPAApBQg6d/vVwcPLT6iHjrG
	Wr4OZOYddEcSkGg3lst234JTOuV2Qy1zgwu9h8TVGWWv8uizv9T2
X-Gm-Gg: ASbGncsPEDsRD3M+a1Uqzw+IBjI9eyWQf+9pIRUjCSiPASNPLNk3ua9XS8/8X1bRFnX
	1zFjCsEvR6weUiWmVFXpOFx80TKcVG7B99WU5hylQTzrDCYH9VIowU2BKuYvjfjMRgsCAJR4xlO
	XUvulnY1UpqkposCQWWEL6eHH667ysgrZGU6PTOaLShN5oq5dUJdJAc3aDReY0Gt8ziCmG3jptn
	gKgzv085DhJJtAf+Z6XgNP5iJ2l//PJ6kt3c4hXGqmsLKD591+yq+q9iJv4lzgdsVx1EyjjY9pa
	4i+w/Y9CGp5H0DbC3y4/ffCbfF0g23aX9AAz
X-Google-Smtp-Source: AGHT+IHqy2fB0PSEtlgLnY5uV9xawlm78HfsnB+wjTo6kKRSaGcYU2YxGWLqYyJoarSz/w0en8Z3NQ==
X-Received: by 2002:a05:6a00:218b:b0:720:75c2:7a92 with SMTP id d2e1a72fcca58-7257fb740b0mr12587584b3a.15.1733406083228;
        Thu, 05 Dec 2024 05:41:23 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a17e8bsm1229477b3a.88.2024.12.05.05.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:41:22 -0800 (PST)
Date: Thu, 05 Dec 2024 22:41:18 +0900
Message-ID: <m28qsuw8ld.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	ebiederm@xmission.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <5b5b50909f7c23f09500d7ecc8b57b46c33ab7b0.camel@sipsolutions.net>
References: <cover.1733199769.git.thehajime@gmail.com>
	<215895272109f7b0a4a00625e86b57f39fa13af8.1733199769.git.thehajime@gmail.com>
	<5b5b50909f7c23f09500d7ecc8b57b46c33ab7b0.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


On Thu, 05 Dec 2024 01:20:51 +0900,
Johannes Berg wrote:
> 
> On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
> > 
> >  arch/um/include/asm/Kbuild           |  1 +
> > 
> >  arch/x86/um/asm/module.h             | 24 ------------------------
> > 
> 
> These changes could be a separate cleanup?

agree.  will do it.

-- Hajime


