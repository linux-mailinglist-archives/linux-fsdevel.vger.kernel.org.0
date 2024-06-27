Return-Path: <linux-fsdevel+bounces-22593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01ED919DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 05:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46137282EC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052B8134AC;
	Thu, 27 Jun 2024 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOsfPmpb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370198814
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457543; cv=none; b=d3kTGTcnVA5jSTyTgDtGNceaEGj3N4PtdlSeD4WmuFFNz8PWMyILSp8wyjICY5/y82+lvKT3+PKrVKW1oOFc2j15JNvIDvcOlGQCVAQuGhUPwgz5y37Le8e7AxZ7s70LA7JrJKz1BKjGZnxTYZzdtYrqMQrtQd2iU0ZyEPHEMSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457543; c=relaxed/simple;
	bh=Iwek6Zy3VOc3y0z76X/47a6QK2JbzXjLJErDzpUUmnk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=R4uKgKkVgnITIegPQ2Fx4sK2VeKkyoAxrMJFiy6BOzOd1kkF46QqrUz0Xlfi7/XJgkscbR64jWrHCKyTWlHRgvNz4hiOAYDdhyW8M9Pn4akYQYygEoJqexvCQeGnJIRAPA+/K7Tx+EUzBadw8QvMawGKka0oG3ZKz36meuXfOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOsfPmpb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70670fb3860so3744867b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 20:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719457541; x=1720062341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:subject:references:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iwek6Zy3VOc3y0z76X/47a6QK2JbzXjLJErDzpUUmnk=;
        b=UOsfPmpbf6XI5nRp6ucet64YBhw1vlfTMuctq/aa1ENLk2zXfu9rFtxzBTURUh1NVQ
         Hl/KHKGtl6aHZJB6bJj62Mq8TwVagqG2gUYjbywK/zqK+r0ETUu8qLN4K4NLRR2Fvq83
         MiAH/Ki54ahWMqyZEoApCsCja3A7zjT9dvouFFI1SrmEtE9tGMI2rs9aHivjBYb/Oe3C
         LSDfkpHj8qrFsStrOyhw9KHwsD9aCRvtZFYzO14UYJJc+BkyP0ibEiu5qMH3uaXxBTdR
         DiY02Os2D8kHdsGijk6/vsyj8wZNsirqPtOGEBv0Fy5x0v9APkqfnOf3BEigSmUlR/Fo
         8RYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719457541; x=1720062341;
        h=content-transfer-encoding:in-reply-to:from:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Iwek6Zy3VOc3y0z76X/47a6QK2JbzXjLJErDzpUUmnk=;
        b=oS92q7S1fzknVxOrj5jPVCzarX/WYSN3WDSyJv3uOO0HT59UBT8HdIX9CDpwlC5pOl
         X9xQHN4Y3X5PdyOdK0bCw4nisISDnUPAFCAQTOzexvD+VijbqPXS0O52NpNxbP4ZV2Ra
         Q25x1yKbKUYECrwdBHvrcwf6oibil9Fw++ERaNwaZYo5/jD58KGswleRpXlyaOwBtzTC
         Et78e/oO9WGpom/mn3L7PJT7n4DacnD+F6DfhwNt7OfY7uyFWr3BXt10QMEx5iI/nmFz
         YxuKWxGHme0B3jAxCF9CJ7mmtRUCcRrps/UpIrOgi3izSm9jfV2lAyvnvR/1sbP/Ai0e
         i4Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVD513J/FprkDNMNF7FV6L+fEyUsXNaVaMr70OWnlNmYASKe7yWn2pImfaJvPCjuHBWsd3LmpNQ6YqWJGnBO4Hf9KJ0mZX7St9+i10lEg==
X-Gm-Message-State: AOJu0Yw21iLxw8k+sQWFielvvXIbt3x0y6yeL2C2B1IvWSb3pQ5kJHJS
	0Uipwj3lno0sGhNSCCBmDBs2luVv1IaUDfpLt00aMhJpt/1CFK6Z
X-Google-Smtp-Source: AGHT+IG3jTedu0UYQYg7JnGtWfrdE+3TXpkIwmb1JhGdPYgjuPDXGGxMc7YWqbedWSM8glmmmNV0Mg==
X-Received: by 2002:a05:6a20:751a:b0:1be:2e29:92ae with SMTP id adf61e73a8af0-1be2e299403mr3090403637.2.1719457540890;
        Wed, 26 Jun 2024 20:05:40 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac9793c3sm2142985ad.146.2024.06.26.20.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 20:05:40 -0700 (PDT)
Message-ID: <513c13ea-3568-441c-972c-c5427d076cb9@gmail.com>
Date: Thu, 27 Jun 2024 11:04:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jack@suse.cz
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, vernhao@tencent.com,
 zigiwang@tencent.com, bruzzhang@tencent.com
References: <20240625100859.15507-1-jack@suse.cz>
Subject: Re: [PATCH 0/10] mm: Fix various readahead quirks
From: Zhang Peng <zhangpengpeng0808@gmail.com>
In-Reply-To: <20240625100859.15507-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I test this batch of patch with fio, it indeed has a huge sppedup
in sequential read when block size is 4KiB. The result as follow,
for async read, iodepth is set to 128, and other settings
are self-evident.

casename                upstream   withFix speedup
----------------        --------   -------- -------
randread-4k-sync        48991      47773 -2.4862%
seqread-4k-sync         1162758    1422955 22.3776%
seqread-1024k-sync      1460208    1452522 -0.5264%
randread-4k-libaio      47467      47309 -0.3329%
randread-4k-posixaio    49190      49512 0.6546%
seqread-4k-libaio       1085932    1234635 13.6936%
seqread-1024k-libaio    1423341    1402214 -1.4843%
seqread-4k-posixaio     1165084    1369613 17.5549%
seqread-1024k-posixaio  1435422    1408808 -1.8541%

