Return-Path: <linux-fsdevel+bounces-76584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL54M1bvhWlvIQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 14:40:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BEDFE4AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 14:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA0A4300F116
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 13:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91BA367F56;
	Fri,  6 Feb 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3mhNFDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2783AEF4E
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385211; cv=none; b=Mvg5KR2Wy/wHIQGhoOV0tDCsgYVMuongJIEUwnFkWoLExjyn8H82FcY9cfAD4m/MhMukyGot+gIsGbSyIP0mo7PPQOPNbU58OdA6Lh51NVrmtPAeeCAJ41reHHDe7wOVG6Dq8l6jjT1bqrd9HLS48b8e1x9c5LSiML5OaKjuEh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385211; c=relaxed/simple;
	bh=2HFNmOufWCwJLMLsyff7exDJnW6+hr07aH3JcpMxurA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBVG2BlsDcl+59lgMiVbRo+a662WAPQNuQlIlOqWpjlq5AlUXFO/6GzqbT4zYlvaTEFwffGPHcFOkxB2kd2x3VIwBQq2HjMIRdjgCyrm+sBotSxpu9VuVDOJdprM3XNjGIkn/VABYI0pxcmNL/rWDl8MBM7gcPfDjW/fRvrzN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3mhNFDD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so7850645e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770385209; x=1770990009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acgu0QGpSbBYxjDws4fcOntfiUC/MgIGMChLZMpVBu8=;
        b=l3mhNFDD0q3Zl9iLvpin3TuudxzHwthHPuRSPLq2JNzU62ynlOOHYcMl1clylZ/a1k
         bgnTtHjj3ebTBLO8WGw5qbDgLvpx7p7YgX79Hx0ElCaxB5O9zWxRzRGrtLyIKZ+TDQPc
         A1NXrbq+6PUVIN7lXnd6H2jakAXUXC4aYLdSvq2Lxi0jUeLRAGSTO+ylw1Dz1/TWlaOt
         Lqq7xMb7dFbUTk372DcLEp5m9AHe6xfyOQgzzmSSaTf4p3lDnjbx3zYSOA3ahL8zEkXz
         ESz25bGU3a2N+uQUQNVb9qy24OQ/+p++hI92TW1z0V7iOrkaEpNHeswEYKoNy8+LmRx1
         9/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385209; x=1770990009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acgu0QGpSbBYxjDws4fcOntfiUC/MgIGMChLZMpVBu8=;
        b=nbpWiURhNsomlFkCTuWqSZ5G/0Ryd/a0e0UX53dmPOpxJZV3y3pvuUCR2mdGJ6Eghr
         xjZf14Z7GRmzYUeeUzA6JBqzzlT1hTWBcmPPGZgUUujwlY4zr/VlnobC9v9Llg+fYJaY
         AbNhdNP1RXOPOp/qWYzJCDpjGB93gmSoJRvQ5Gv92IE9tf/+OyV2nXMvrS/RfDkAXIMb
         LkC1UlGnU5wc/aZTILmfCd2z1C9OPBDHcvWVSuTt2AE6jZcrFY5fpJaqlubkzjDr5iv7
         gAyDZB1v4mVgnxSP6LFKYCFaxcqv6tr4wC4W1LdqkbEUN8moR/8OdVI8gaFcl8PsQSkV
         TrXw==
X-Forwarded-Encrypted: i=1; AJvYcCXkGBMAfc0degAhq2DNqMphyIZ0sdt+Q2XantyV2AGGfL+f1otmKwar+/FlUMlKeHFPP017OBIdjgFOyh6A@vger.kernel.org
X-Gm-Message-State: AOJu0Yze2crdq5oBJg5zYoGOsp4CzWWHs66QcORCWal9laFfuEkuJEep
	mM4+e8O8Jo31vvYRjsMjE2oqmwAeULCpsAUOBmDki9MpmVShSjvQ8EuQ
X-Gm-Gg: AZuq6aL82tasYg1mATLe6LL27WDpUqsINZcuYnUiKWqmiz8cNA5ZoAcWEhVsQBqOfaH
	RtrUw0iYNq3z3x2mWAcnDEYs0CK5E23wtXxll9nkNhegcwzIh89WXJ1IkGvbX3V4g7FToH3vEZR
	UTDvpvBOBGBmpraWT23QuMqU0dJKj3ICP31KHqM7oclg4ZYm9xnFU4QuP8vBOmRHsO2qBkMV1c7
	hm2k5mVQf37B5ttpx7NY74QeAJ6CNx+a2vyoMuiv1+kXxGkPagnvQwmQf2QeNA9cUJcFvESiw88
	DNQ2Jp4mCjQI/IJVL9UFocoI+PSGwNfvM6kq3eXbY0+odG4Xwl8fHFpnrUSqRPc3N0Mu/sGnVFQ
	+FDIIqtVpoFZMCGBCg9r3orDbgVrnUEvDQIMecQwRZjG4nrrkPFG2iyQ3c+CeL8YZN7I5KcSW4W
	9CmP6HLcY=
X-Received: by 2002:a05:600c:528b:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-483201e25b5mr37192225e9.10.1770385209264;
        Fri, 06 Feb 2026 05:40:09 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48317d345c2sm171484865e9.6.2026.02.06.05.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 05:40:08 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: joannelkoong@gmail.com
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	bschubert@ddn.com,
	csander@purestorage.com,
	io-uring@vger.kernel.org,
	krisman@suse.de,
	linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu,
	hch@infradead.org,
	xiaobing.li@samsung.com
Subject: Re: [PATCH v4 03/25] io_uring/kbuf: add support for kernel-managed buffer rings
Date: Fri,  6 Feb 2026 16:39:50 +0300
Message-ID: <20260206133950.3133771-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-4-joannelkoong@gmail.com>
References: <20260116233044.1532965-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,ddn.com,purestorage.com,vger.kernel.org,suse.de,szeredi.hu,infradead.org,samsung.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76584-lists,linux-fsdevel=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98BEDFE4AD
X-Rspamd-Action: no action

Joanne Koong <joannelkoong@gmail.com>:
> Add support for kernel-managed buffer rings (kmbuf rings)

Is it true that these kbufs solve same problem splice originally meant for?
I. e. is it true that kbuf is modern uring-based replacement for splice?

Linus said in 2006 in https://lore.kernel.org/all/Pine.LNX.4.64.0603300853190.27203@g5.osdl.org/ :

> The pipe is just the standard in-kernel buffer between two arbitrary 
> points. Think of it as a scatter-gather list with a wait-queue. That's 
> what a pipe _is_. Trying to get rid of the pipe totally misses the 
> whole point of splice().

So, kbuf is modern version of exactly this?

-- 
Askar Safin

