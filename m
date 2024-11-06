Return-Path: <linux-fsdevel+bounces-33739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E7E9BE4FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 11:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37124281E63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2266D1DE4E4;
	Wed,  6 Nov 2024 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJR+EJ1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473571DE3C2;
	Wed,  6 Nov 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890684; cv=none; b=dAzZSY9Te1VIkPuCjFYvpRxx3wlgKzk67f+Jwlip+o/pihjMDTyiwHHmSFQD+qtv70ltZAiOQpClIcjMZkHuTAGCDlsrJRUFcoEfj1t6kPXSnMrkFVGNk59lPqoy1YZpTtmOFgGJ1r1BV9drcxR5ii6YZwY+4/I9qoFxazOMugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890684; c=relaxed/simple;
	bh=DU+cqVwhIllNWlfaxAghOm+01hCv7n/5l2mWWPIECfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgbDBHbVaE6JKiEHECH12nXUv20b3rVhFcNBzuOGWsCuVfnO+krfavXH6sxv1vw9hSUTuM7wTEs6njmz3bdRuUd3+Xmk2fGtyTwXJY8z39psBc7wN1T1m3/g1FESjeAup6qgLiwSlrrwOLKh4x55r7dmu4Iiyqmdd6FfZ+mN0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJR+EJ1g; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so5363877a12.0;
        Wed, 06 Nov 2024 02:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730890682; x=1731495482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTsF9ael3y6Shw0lLZctrR5o30Pguzo63nQZaMsrVCg=;
        b=CJR+EJ1gF1bj5wtiu2dZwSXTYimoOP61VWa3xGRQPBDUdBtCmhz7LEfyrumP9lpFHx
         bOTrkJYDIfy0gopAXlBK8dj5h3FSmyoz2bGfdSCeopx6z0HLno/t1/gQ94xLC+YNOTQ2
         2lvbnpeW4RTPQV5DlmEXWv/wkiQAIrnt9Yw39giMvO6cdKarieRp3X5+2hIvyj/fglWQ
         iFwWHRRQaeknS86O9Sd5lNZEW9+yNMkR7yl5fsT2cqZetaFQoaebR5mWf994st2hOIIm
         G4TJcvxk+LIF/+iMIX35zWN7VmRu4tVMY7u+r9So2bFJL+3hxVGReQVC5N/0zKO8fef1
         jSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730890682; x=1731495482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTsF9ael3y6Shw0lLZctrR5o30Pguzo63nQZaMsrVCg=;
        b=VBfcWXtym8M+/WI28SA72tlyRcEVT1BdXb6c6KL16fnO9Lbury/gNGpGd3ylgWSSeX
         A8LYeUz+mhEZbibYebMC+IluBpyLI7s0l4cacX550v2fZiMi6TSAuFz0nmqQ/eK58JQ8
         lTEN8ECiIUk0HCpsUE77vJOGUhGEJ2WX264AGp5FDIP0+64JVhH2C0crs6vxVK/f/HFw
         z7GSqHlqdM26X/C/MUvZbaRurPJDc/oOIiCo2OFTxjvrqU19czYuToPjf4Q4/XjGhgKf
         uOk17FewevtPI4KVxddu7dfDcfp+uydsXbMX7bm7qrqBxo/PAlYOxKFtFCjokiqOcZXX
         3b0w==
X-Forwarded-Encrypted: i=1; AJvYcCUWQ7GTegK/2SyjBv6iRXF5hwLzdLAn+eMEgHRpMhjo0Hsv0D9P/ff5nlaoM7bqPdbdyxMEi4ji+LRKPaRi@vger.kernel.org, AJvYcCW5AbISP4KjDAWMn1rlXdJzOk6HAOgC9LJRXaO52jD7/avZUPT7ytMmcztq0NwweLZD23KVi+3s+MppCQNK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MVhElNnrAAF6HgMP2O52QU9wzEgyM0FCtJQxpJRCwhiXS4Cq
	EQ8De8UDSfYGQYG8kZ+sr7IBv08dl3VOTQ+pbW3eeXmeMzYfZyJs
X-Google-Smtp-Source: AGHT+IHEmktzAFbYTQwCm7tERYMACaS6FCHs5NoqJD4/moDeQkOBhuhL3R3KVJdENpcjZf1Pv/V78g==
X-Received: by 2002:a17:90b:3b85:b0:2e2:edf9:b8b8 with SMTP id 98e67ed59e1d1-2e94c53a1fbmr25114426a91.35.1730890682483;
        Wed, 06 Nov 2024 02:58:02 -0800 (PST)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e99a62d6acsm1190237a91.53.2024.11.06.02.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:58:01 -0800 (PST)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: jack@suse.cz
Cc: bcrl@kvack.org,
	brauner@kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pvmohammedanees2003@gmail.com,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH] fs: aio: Transition from Linked List to Hash Table for Active Request Management in AIO
Date: Wed,  6 Nov 2024 16:27:00 +0530
Message-ID: <20241106105700.10735-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031120423.5rq6uykywklkptkv@quack3>
References: <20241031120423.5rq6uykywklkptkv@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Well, I'd say that calling io_cancel() isn't really frequent operation. Or
> are you aware of any workload that would be regularly doing that? Hence
> optimizing performance for such operation isn't going to bring much benefit
> to real users. On the other hand the additional complexity of handling
> hashtable for requests in flight (although it isn't big on its own) is
> going to impact everybody using AIO. Hence I agree with Matthew that
> changes like you propose are not a clear win when looking at the bigger
> picture and need good justification.

Makes sense to me, the added complexity may not be worth the 
marginal performance gain. Thanks for helping me with this!



