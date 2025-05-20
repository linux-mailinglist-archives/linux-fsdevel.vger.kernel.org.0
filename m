Return-Path: <linux-fsdevel+bounces-49522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EE2ABDD85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817143AF21D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D7224EF90;
	Tue, 20 May 2025 14:41:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46224EF6F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752059; cv=none; b=mg0Y5PvCGZc31WfHxDcMHYuIIK/vjVGn0VjthJg3ZNhTjjvHY6oT/jifRVTlAWN8LeviHewXkKa2RqmyFeY9S5e4ftkdxohZ80+bmaqDJt/2zd2/nuSrwpxxI+eBMPcJJlYN/gEfS0arXIc1Bh2hAwXX2IQkTfhJDwpCQbDbVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752059; c=relaxed/simple;
	bh=IILUo4g9XxkHNqcNVbJg4ope2u1OZE0eGEtTJRxZDjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXG25GcIugPxOLc7VgIJyBCCMBk99hZpgV3DPfqhZCXumSXvD/kJMaifE+f82Rw/TwB7iLnGJItI90EfRXNacCKOKHWppMiLRm1cH9eqQgwYRyFrjD/TdsN4ewFaUZCNF52E9kszBpQzRhfP/+1giv2MAreSQ53HV4Ee5HAhDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KEeR8D013170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:40:27 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id CE19C2E00E9; Tue, 20 May 2025 10:40:24 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        wanghaichi0403@gmail.com, yi.zhang@huawei.com, libaokun1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 1/4] ext4: fix out of bounds punch offset
Date: Tue, 20 May 2025 10:40:20 -0400
Message-ID: <174775151765.432196.17776440436332077240.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250506012009.3896990-1-yi.zhang@huaweicloud.com>
References: <20250506012009.3896990-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 06 May 2025 09:20:06 +0800, Zhang Yi wrote:
> Punching a hole with a start offset that exceeds max_end is not
> permitted and will result in a negative length in the
> truncate_inode_partial_folio() function while truncating the page cache,
> potentially leading to undesirable consequences.
> 
> A simple reproducer:
> 
> [...]

Applied, thanks!

[1/4] ext4: fix out of bounds punch offset
      commit: b5e58bcd79625423487fa3ecba8e8411b5396327
[2/4] ext4: fix incorrect punch max_end
      commit: 29ec9bed2395061350249ae356fb300dd82a78e7
[3/4] ext4: factor out ext4_get_maxbytes()
      commit: dbe27f06fa38b9bfc598f8864ae1c5d5831d9992
[4/4] ext4: ensure i_size is smaller than maxbytes
      commit: 1a77a028a392fab66dd637cdfac3f888450d00af

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

