Return-Path: <linux-fsdevel+bounces-64495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E81CBE8AB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 14:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C4A5E4F15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62C133031C;
	Fri, 17 Oct 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="QPecuiSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cmsr-t-6.hinet.net (cmsr-t-6.hinet.net [203.69.209.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDBB330319
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705569; cv=none; b=enDglK4TU/r2sNzsDXm6HlV9Z2Fo16HQ2jWxUPX3Wn6oo0/CRDM6vSjqPkv7wFnEEPpGK+EVj95wiF3AkEN+N5V4R5RC0gxV9m4BKiY+rF8lHdVG+/MG960nSk/TBXwkr2JsasMMWXN7NizSZRQBndhH6TBGX+P8lPkgFgjsuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705569; c=relaxed/simple;
	bh=fCl2YKwBrqU8en18YE7XNpHsO491aT7a333IxPQLCOw=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=PrFAYn05p76E5FyniCVu6f/7snrW7o0B726HoTmoG77yiVXqqayTk/EwUVvoYrLocLhTQVg0n6SetQBD3ZdznQGA0G+a1FqOTaELcmcGWXrXGk+isZAQRLr3lBdgvTosOxvz2SzPJc5brOZGxCtZGuM8cTayPUy655xvs4A/IWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=QPecuiSL; arc=none smtp.client-ip=203.69.209.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr4.hinet.net ([10.199.216.83])
	by cmsr-t-6.hinet.net (8.15.2/8.15.2) with ESMTPS id 59HC3kUd119021
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:03:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1760702626; bh=fCl2YKwBrqU8en18YE7XNpHsO491aT7a333IxPQLCOw=;
	h=From:To:Subject:Date;
	b=QPecuiSLc65n6yY7yJakskXuQwzvrKoA6iFqmU8cvxgpKBUkkZayjbgR4iVUn99/S
	 bN4eudzO2MIFAjXzAKg0e6/j5EA+FdAyH4I8O4dzRPPXu2ikafNnS4idWNBjv49ut5
	 4Aq0eUTgMxwlnQAEfsZi77+ixSb0RzSq51cOKNvmHgs/RfmVm2yaFjpOuXvhfNtBxl
	 jmBDTnUiu+ePwwaoLOVTBO/x5Wy/jDSq9bSaf6jPreFrGPZ0973GPpns7XTXjYU0Os
	 ZRrEwVEhBvbrRESMgTrv19O5e/6oJlabSwqIrvF/D7z8Ezt8Q0n796Q1i7l8UC9fLR
	 z9iJ146rRFvXg==
Received: from [127.0.0.1] (111-243-174-138.dynamic-ip.hinet.net [111.243.174.138])
	by cmsr4.hinet.net (8.15.2/8.15.2) with ESMTPS id 59HC27qC777566
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:03:45 +0800
From: "Purchase - PathnSitu 702" <Linux-fsdevel@ms29.hinet.net>
To: linux-fsdevel@vger.kernel.org
Reply-To: "Purchase - PathnSitu." <purchase@pathnsithu.com>
Subject: =?UTF-8?B?TmV3IE9jdG9iZXIgT3JkZXIuIDQxODk2IEZyaWRheSwgT2N0b2JlciAxNywgMjAyNSBhdCAwMjowMzo0NCBQTQ==?=
Message-ID: <5fc03d21-bcfe-040d-e363-585a610d9b9a@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Oct 2025 12:03:44 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UMR+Hzfy c=1 sm=1 tr=0 ts=68f230a2
	a=120aufl/pg89DvIrU8GlSQ==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=gC9GVpDSHrDkGow57TMA:9 a=QEXdDO2ut3YA:10

Hi Linux-fsdevel,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: October

Thanks!

Danny Peddinti

PathnSitu Trading

