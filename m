Return-Path: <linux-fsdevel+bounces-18966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0B48BF147
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 01:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C7BB21AF6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 23:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1177E107;
	Tue,  7 May 2024 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KQp8BrbH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFFA12D76F
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123077; cv=none; b=crN9Hbj9PW0Uoc/CDJrx7g5PFwwMJ/MCMS52iZ8YcOD6WTTFjy6ukfVzk0KtjDdSkKV2EXro2rccnZ11t3THVsLHRKn5A2BFyT/KFdJihg083HRJE3i1Nv6bsEOFkCWhZzYrG8b4OOw/teuasjmk/Lde+t+5B/8aUMZaJKNQzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123077; c=relaxed/simple;
	bh=4ki02SrhUgGoO2NBs7aSIdob5gBkMpbDm48dELXE9rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6nY/0YT1qq96adBZC7nCk0MltWdu4cZDeDDQgTsHU+V67irTa6Oif/24w9237h6Ib1PYL/9u6v7bwablNkSL7N/GoiqsLv7Lm1oCMECwGJLfTOSs+ME3jCKoCYvwMRGbnOUFEbqwDVf2KWepOjeGvkbi9QH5xBYPH5H5CMvN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KQp8BrbH; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 447N42VB026194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 19:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715123044; bh=E4LG6htVk322z4ErkwjEczI86vSYy/AQbKJj4Rf6hVA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=KQp8BrbHEqmHhBTAKaEnbeQr8cwLSTiCebA+l4lvrlKAIwZjiGvMZ1GbljpADqKTy
	 Z/HuFehWcx8N5P0ne/NVNavkMv68l+JJT5m4S/6vVQJpYCaihDDZ7if7GUnXbYrwVS
	 jPeXZs5F78UIaAxyoOBNGaLk0Qq4Djl85dW/uuAhQUuPxVYgyZpoIFq1jTNt5RlQ1V
	 Xfbp3oGXjHt++6IBCAPl1vBopOSL4Sz04OTgQ+TMRou4bSi6zZKrsnnp+xZ+h7bhsW
	 7tJPj5S+rP570/KQ2sD6w/Mz0BlsQla18Rb40hvSdS9/D7OW2pSPSw1cZfJMjJqg0f
	 YQ0uDA8Gi4bcw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 141C215C02BC; Tue, 07 May 2024 19:04:00 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: remove the redundant folio_wait_stable()
Date: Tue,  7 May 2024 19:03:54 -0400
Message-ID: <171512302199.3602678.2811036632858501777.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240419023005.2719050-1-yi.zhang@huaweicloud.com>
References: <20240419023005.2719050-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 19 Apr 2024 10:30:05 +0800, Zhang Yi wrote:
> __filemap_get_folio() with FGP_WRITEBEGIN parameter has already wait
> for stable folio, so remove the redundant folio_wait_stable() in
> ext4_da_write_begin(), it was left over from the commit cc883236b792
> ("ext4: drop unnecessary journal handle in delalloc write") that
> removed the retry getting page logic.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: remove the redundant folio_wait_stable()
      commit: df0b5afc62f3368d657a8fe4a8d393ac481474c2

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

