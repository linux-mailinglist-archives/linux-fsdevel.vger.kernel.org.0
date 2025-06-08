Return-Path: <linux-fsdevel+bounces-50938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447DBAD13FA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABE67A4A3A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 19:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A0E1DB95E;
	Sun,  8 Jun 2025 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaKV2Ht9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C11519A6;
	Sun,  8 Jun 2025 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749410289; cv=none; b=NSJtKMVyPnKFboukARkFEt0sYBusZBNgTXcwo+JXtB1SPS1p4yzdoUNc9zpqK8L0vJnZjKONHpMdTCE/OEGrbYJoEqkDuWNTXCfsh9zJZLaWYEIsYx3TxV1LMZP7HpGHGeO4dd6QD53P6YQaIYI9ujd1ylDeKfKskPXzR9J6Rqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749410289; c=relaxed/simple;
	bh=qUg2VsVI0el6SMVzmcxYMK0aVnmPj/zSG1AWmqx0hOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1Rurl4wF2CblSBFCq05HfG9Rci4XrMoWKWS6ETJoQKhP2sroECDiVKt289iQkKx2tSL2L2g4BdU3/8f/BAoMPkvTSzS8Tbb1kljfoSCEI7kQ/Y/uXNj9FM/DLk+LIDFmS4/P9HFSFfBWqre9uSMMD3KUI2HckaJltDrnWnwWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaKV2Ht9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so6956149a12.2;
        Sun, 08 Jun 2025 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749410286; x=1750015086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hhXYl2dG0PKKdPVeGCKQDcQbh05SiksJbS4B+foHh4g=;
        b=XaKV2Ht9wgdKGHM4d5kpGDf70lta4J5kbflKGMTdcodoWbGq97JBQjzMsMBLzQhPrP
         dJ6HFdH3trEriHdpHRhFgGTHjJ8YrOhi0Wec/HzRBDyda4y70nXUEJIwRW+YQJmWRTln
         ai2X3KQ+VGQtj+sqCJh/v4eKbuvS9GcTha3qM1pAOLN2lQ0G3+jtC4We7DjVpmUV49i+
         3wLZ+sSC1glBm0JCbpBBv9xrEoUIvovxVvcHI15Uu3EFCGiglw/uoeSQd9qn1KHTEsuv
         +R3oqo4G7QdGxESuAs00WF3YPTgGzaoF8GvcP2nuohvhxmOtBY9CWOxQsG/ammXyV4ez
         qW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749410286; x=1750015086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhXYl2dG0PKKdPVeGCKQDcQbh05SiksJbS4B+foHh4g=;
        b=cZ0CAJM6mor7b4n7n4gNfSOpuR8SKvD7K815T7S+wwgrMrw8o+pa8Xp7oYCDB0Ml8P
         7JYsc5SD2lMJgpqC30XV1O0PQFjBjTdilDMhpqJh1xvPDC3gO+iAeP1HrVfS0QergqD5
         f5I033CW8v23rm0HqURWMs9+0zUbXmEaagbWTQbLmR+ZQNaBx2kkshhNQSs8jFpuxk4i
         CneE+PD9hKOY459QlYCfTpCI7/Qa00sHm8kBi8B/81ZN/O7vmGWk3oprGSRl+57dQHz1
         EnmLG9RTHSM3uUr5fSqBCySTjpGIePuJbQNO6XAFUpka7dJGvEG9DHcEeDcb+5I/MRv3
         UUpw==
X-Forwarded-Encrypted: i=1; AJvYcCVemQvJwvZKbpuCVGRErIINAF6OojLs8geCMSz1JvBxHiqEFqpSUyZNklQocl/auQUBIkd9griZ1Mo4bbet@vger.kernel.org, AJvYcCXaVbfmzBNgbG6xdThEwqBiivyYnJ7gXX8aYqsdivWdgZWjLZSTvtnsFcL0jNFKkIuzi4JnFvYJZ/fA@vger.kernel.org
X-Gm-Message-State: AOJu0Yycqv/TdtyrMn1mPWPh2Dnnh+wMy6iCsGtxoMs9z/6rzBPgPl05
	Y1G+dRS92IY7WtYhxJNcETB1ENh/QHbUC72lSt/km09IgadBV669jMW+8JVuYXitGxGEhR/qEgY
	LIgC9MwC70aiq5uj9fK+stayVvtmPfA==
X-Gm-Gg: ASbGncvN07ZlyRlAiMDGt3k+o/BEMYxyeJuaC+as8ziN/UV+7E6QgV/unCPtJPaEQdj
	s8N0TVrOrZ56EF35pwkA8g4F2VTSBdOF4l6pwMRRDEr+V8mBG2S1gi2tmHqnj+Qh22uBY8lQRls
	E3unsI2NsPFH54CGFeWcwXuPUaoGReB3RLQyiD6XhuiLz1onto3iqKT2XLNUc3iB56LBRWOeoKS
	rYszArEiCTL
X-Google-Smtp-Source: AGHT+IGWEv+0BwAfLP6VLFwo8aJTu+GRQOdNlXUslKkZ+pyZg1As4gPUilJUGwbMIVoDLMBYK57YFWSCNiEqTpz+x7c=
X-Received: by 2002:a17:907:6d28:b0:add:f4ac:171f with SMTP id
 a640c23a62f3a-ade1a9e20c0mr1000941766b.5.1749410286046; Sun, 08 Jun 2025
 12:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com> <20250606233803.1421259-2-joannelkoong@gmail.com>
In-Reply-To: <20250606233803.1421259-2-joannelkoong@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 9 Jun 2025 00:47:28 +0530
X-Gm-Features: AX0GCFvJmRMiGyfipihL_0ezt7UvmKCSmDo7Mv70fMUgXDTTx5VWYRVPpLh4hpI
Message-ID: <CACzX3AvY7qPU5ptbrVoJtAnqznmun_om382wJEvi-asM3xaG7g@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] iomap: move buffered io bio logic into separate file
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"

> +
> +int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio, size_t poff,
> +                             size_t plen, const struct iomap *iomap) {

Nit: { should go in the next line.

