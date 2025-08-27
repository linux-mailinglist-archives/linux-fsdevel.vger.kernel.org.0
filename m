Return-Path: <linux-fsdevel+bounces-59382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 858FCB384D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08859684E95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23198352095;
	Wed, 27 Aug 2025 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJddcTST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777978F29
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304437; cv=none; b=HWcunmbHXyyxdxxnBRhEKPNqGYiz4Q+I+h4/L2nhURNcQD4uidN0f/1aULhfLakFSvSFyvZvO11WWBYaBLWfxkMKNs2kf/K2WAF/B9uq1VOX+ftG0cCQtabTUiASKoglERf/KOxjNp3no69WbjLyEWpLJ8/aZTobHy4Tv9PkTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304437; c=relaxed/simple;
	bh=kmTbsYphP0LvvmJfhApN4A5TiThpvSFfhZ8VPYBnTgA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FvbxEUf98RYx1EDCuXoO+5LgRZBqprJia8oK4ulwbxHmJj3fH82NvEPQJKBioTdadu20P9dDsp1eePAxSIwo9vrRYqY6fJsPptO23Wbc2+aNN+gc4brsNH9VjZFpPN9aAicHv42c3AO21EVQTqgYZnE+NwMkkz+SPf3yYu6FCC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJddcTST; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445826fd9dso85855685ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756304435; x=1756909235; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kccorfHkl2Ewn+WZcPXUaSQI3Wtl1vygD8AgUJtBGJI=;
        b=fJddcTST5dnL05V4tgundTmV5jRouNoV0b+V3OT2Jan2ZUMxvTPm1fHhwV6sUZeGU9
         3f5iuIB+pZfoDy8KfLNbQ22+KUb3iCWwKtc7wmWi+yeJK9JxjGSWHyT14rXQ3R4sXjhQ
         OGz3N4xYUhmT9pduNk//aYw1sEJQJKdWnZcOQvw+xjmckWe0kMrOI+D1ZCKC552VwW4y
         vyQ99iif4rGKApLIJuN5JP8+k2U+CRFMCXgVkiNqPvgPCRnEveVV3qp17TQgVUagfEQj
         19LGINKC38Zo0mFCKgp1X+KgTWn8X7sHLcBtDxqW2v6GV8abqpAUr939Fn6dVtM0LnIC
         gp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756304435; x=1756909235;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kccorfHkl2Ewn+WZcPXUaSQI3Wtl1vygD8AgUJtBGJI=;
        b=WD50VkbPEHLvtkO/wu5aibE4HSH9ACh7Vk04SL1djuoeKZbGvEkifKtvGnnDah912e
         33u9WN2VK1Fq1wwE6bi4tJEje56P+ivZqcjWzsMBMJFAXzMRdGqu9PG+CkfBkfjxXvHz
         NkF0KoiR/VLQGC66iUKRGAjc7JsdTHiobltwiYtz5x6EdmjJACj3pA2DS+5UDj0+26nr
         6vIPWfteWoKZAVkleujpT0G4t/DtTpHVCrxvg0rxnaNqEZKaVoKazPIp/IQ6Dh8cIlaQ
         GczxwhN77ynjam7oU8RKNXxWS1ToR9qBBQgUlklBdNCNKwnzeNpeONrU5Wu50CPxlJDI
         14Og==
X-Gm-Message-State: AOJu0YwDvLCbpcpj/JiTz/zI8UkJqbyw9VFH/ZUkDpqxmET0bUUEsDMt
	cic0wCQjrc0C2CKRNnTNzlwKmrR93iFg3BL89HzHbGxpsIC3Ciq+UMmuFGXo2vmy
X-Gm-Gg: ASbGncvtm7HM6AZHoGlxrNupOJ1fzN2eGX86R0PMVi/k1tjXI+T8NaIBy0ruYHdBP2M
	CfNZp4qbz9k2110PxQM47S6eymAdWhSJqR51GZ8MkLs3cP5e0SUFSsZGYTKZflscbS6GXVkqaMm
	bRq/F9A2o846aKRuE1EHXRJzaV5XI1PMMtSW15zdOvpBma/8HYDiYmwy6ZzP1D1LgTARgAH/+RZ
	b06QDruLRPtxUYgR16SqT+X6o1SuT8D0PuPs1G3oH0VpmE6GrDHwV167OBFBKQbmdw5A6mboiZx
	JPhr7yJ8HeM6hwXa/X0KnSbFYzeninX0WqHZZu55pO+UWYO935KFro5X4NMtuHoKFnwH1R1EHRo
	KF8/R/2xXRBZMIeDO0iPOSyO6NWJnvi5kObOuS5UcgMvkHR7zN4LJVUetoKUHmKPpgXctUbbW5V
	d5Lvhb4zisLZNNzYDjyOireA==
X-Google-Smtp-Source: AGHT+IHJMfH4SxyJ46GAJCwlrafj3e/xQASe35KfDVPD3aGL4N/6f+IE6WmNHF0u3TkTMrE9E9bzoQ==
X-Received: by 2002:a17:902:c40c:b0:248:b5c1:dbb7 with SMTP id d9443c01a7336-248b5c1e790mr14079255ad.34.1756304434833;
        Wed, 27 Aug 2025 07:20:34 -0700 (PDT)
Received: from laptop (ppp-223-24-162-214.revip6.asianet.co.th. [223.24.162.214])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f6a6cb3sm2214219a91.9.2025.08.27.07.20.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:20:34 -0700 (PDT)
Date: Wed, 27 Aug 2025 21:20:26 +0700
From: Egor Shestakov <vedingrot@gmail.com>
To: linux-fsdevel@vger.kernel.org
Subject: [BUG] f2fs-tools: fsck infinite loop in options parsing
Message-ID: <aK8UKm+kAM+1AZow@laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I found a bug in the fsck.f2fs that cause infinite loop in
f2fs_parse_options().  To reproduce it you can call program with a
'-py' united options combination, but when it's separate '-p -y'
works well. Simply execute `./f2fs.fsck -py` to catch the bug.

Buggy part of a fsck/main.c code (unchanged since 2018):
>		case 'p':
>			/* preen mode has different levels:
>			 *  0: default level, the same as -a
>			 *  1: check meta
>			 *  2: same as 0, but will skip some
>			 *     check for old kernel
>			 */
>			if (optarg[0] == '-' || !is_digits(optarg) ||
>						optind == argc) {
>				MSG(0, "Info: Use default preen mode\n");
>				c.preen_mode = PREEN_MODE_0;
>				c.auto_fix = 1;
>				optind--;
>				break;
>			}

The bug occurs when a case 'p' match and after it there is not
suitable argument so a decrement optind-- happened. Since the
option '-p' united with its argument a getopt increments optind
only by one, not by two, as expected. Therefore it enters to
infinite loop.

I couldn't find good solution. Changing a preen level options
semantic is impossible because breaks many scripts, for example
in initrd.  Possible solution is use a two colons in optstring
that means optinal argument, but this is a GNU extension, so not
all standard libraries support it, in particular Musl.

-- 
Egor Shestakov
vedingrot ascii(0x40) gmail ascii(0x2E) com

