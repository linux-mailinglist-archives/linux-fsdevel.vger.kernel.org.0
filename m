Return-Path: <linux-fsdevel+bounces-22738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB0591B781
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85321F22028
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 07:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320213E03F;
	Fri, 28 Jun 2024 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/fL2U42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316F125AC;
	Fri, 28 Jun 2024 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558227; cv=none; b=XQMcQ7vZ66Blh7rZouLtEnEkHvNolZkZhKS4vA1tTUrduTEOkiPb6nbbUzgEcI4YEDuxmO8S3O5xdwhWAc2m24TmVElrO1mbEIoRQNcLfGmV9kbqqon/tHchx7MrpiJ+2UbFWoKvAGFl/cmXY9zSuehBqFzrl+XJH0o4d4WLFnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558227; c=relaxed/simple;
	bh=3X1MYFbfPFItTW0/VokXn+z9ucFH3r/YhPWshyQeayU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kkJV3C0ptIsqX4M2cn83FZS0HjETlmoXsOs8cIQBlHXScZJhWFNhrF4nc7dUwRNYoZYnCn/epkKbUL8tC0Uqa7tarP05531FUAGCMWbT87pJi+B19oXQ2PlKFvoqPwuNqzFIDDSGtF1AaJG7FHw99UiW/Bnk4GqorWhHgQC9rXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/fL2U42; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c2d25b5432so188608a91.2;
        Fri, 28 Jun 2024 00:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719558226; x=1720163026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1CHoIZeJtIf2ePFFJ0KGCQoC4Wx5b33LDat/8F3E4k=;
        b=L/fL2U42y1jkeWWXG/8anDqagD5uJj9AnfoxniDeOYXEJz4HI1LbvEY95rOUjGg0Dq
         megGUW5uxXrXyQWaAldDYCtkVdv5uNA0uAcsCVQ7Zzsgq5lIAcSwQ8+FlfxJ2hf6fIVo
         GopmdsLSBMDfnmgU0n5t/zCKKoJetL/wHAu6kyI9pA4q54sKAk5SZKU6W9aQtPMP78Hd
         kyBfC7KuT2gfath+sysE5Rtl0thcz39m2vNRfPj/Ry6IP45Tktl64TPfER+kyshExzpm
         z5xroKO8ldJslsqy9UahwTe4+xkceYsNHCIKw96nLh2ZG4XPfCeMqlGs9Ge83OJNsuPt
         4mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719558226; x=1720163026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1CHoIZeJtIf2ePFFJ0KGCQoC4Wx5b33LDat/8F3E4k=;
        b=QCBH4eI3Ut6ltuT7POlTKHtNCAs5PTlLIsZZTRu0ohICcR2Qb4e/JrdW0wUi4DOMim
         aIfMrWnbCTqihf4wzyOyki7SOqpmipdn6saQ+2R8XIpKRAwgKXWIq8ZMVGDEPtCyb8OO
         dnlz9nlCbSLhCLqwDHe78cWx7hCLuJMq2xYgrMdk602QPMS7HqZsmHJapovgdJg0wfyU
         Soaw1x/9EePqSL2wO4OJWB52ZAhMhPuzGR7sqfsxBjWIARgZEWudfaRE2hQRT0/5ZpD5
         AFNt6Jl5SRaJqGtLIzutvV25MoI3YQBLPuTr+lD4yEthvy9g0D8mfmn+Kzaa2j6rJAIY
         +/+A==
X-Forwarded-Encrypted: i=1; AJvYcCWhaCt1tDBxdUbkX/v0wvI42D/QNfU9LEmgdbM258K3nuyoyc2zcngFE1Mihc3JsFbUSIwJdjkouBBpG5cr4OprclWyAtH0QZ1OVqzkv+lWrOTrICzAjq53Q9BMXfrPWkw5T2jwym0T42rr877vJIeop9GWh9Ehs8NzbuiWbhH1bmWPXcTwqys69BF29A==
X-Gm-Message-State: AOJu0YxTfeRNyv1M3T20WH3tCS/0mnarltZ06MjSrUmpGbRYJRacUwzW
	4Y0ZkftEdsFQkPCNkCu65JeVdFjra5WOsZMOCRJmdA3hnInUcoc2
X-Google-Smtp-Source: AGHT+IGS9AdHpDDTB41Zy++wNdbA3CWe3YJ/2/uzP2NiiLr/yfetlDWt1/cRzRQyTWMuYfhslv336g==
X-Received: by 2002:a17:90a:9e6:b0:2c8:7fa:993c with SMTP id 98e67ed59e1d1-2c861409604mr13020964a91.18.1719558225856;
        Fri, 28 Jun 2024 00:03:45 -0700 (PDT)
Received: from dev0.. ([122.176.81.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3eb774sm889779a91.53.2024.06.28.00.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 00:03:45 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: akpm@linux-foundation.org
Cc: jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] selftests/proc: fix unused result warning during test compilation
Date: Fri, 28 Jun 2024 07:03:38 +0000
Message-Id: <20240628070338.65008-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625110526.d443fe6d3feb51a50aebf849@linux-foundation.org>
References: <20240625110526.d443fe6d3feb51a50aebf849@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Jun 2024 11:05:26 -0700, Andrew Morton wrote:
> Thanks.  There's a patch queued which simply deletes this code.
>
> https://lkml.kernel.org/r/20240603124220.33778-1-amer.shanawany@gmail.com

Thank you for sharing the queued patch Andrew.
There has been no update/revert on it, may I know what would be the next step here?
After reading the patch above, I believe my change is "more" right. Is that correct?

Thanks and Regards
- Abhinav

