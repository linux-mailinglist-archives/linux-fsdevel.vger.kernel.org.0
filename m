Return-Path: <linux-fsdevel+bounces-23534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B48FB92DE85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 04:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1331F23DF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 02:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B10B288A4;
	Thu, 11 Jul 2024 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="h7Sgu9ix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3D1C294
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665379; cv=none; b=RcwYsk3FgCKYL1iISg/SQMChkJKwF67rCsEmA+AZSuN9gsimJ3OdnJe+NvugZwlgRHKHTXpZnrssJ1KpBANhdpXB3yVSTkNnO3BbHABHf+LTmnI3hKBsLVzZLym4JfcRFETPthfcKYy+qvk8Rf1aZRzFkv5ADh3zqUuXzuUTOB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665379; c=relaxed/simple;
	bh=d38yRHq18ji//IUN5ts6WA+Ph2munXiLPomY5msniS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qG31MX7EblsnFFEHRUU1zes8x/3CjrAWlqZbXqZyPFo07a30hQe8NI0lRjReb86ACKB5fTvEFLqq0OeiaqA3WwS7dEkmeqQxN0uYLiPHo/shxSreGRHRdkw/bQT5zIIMRVAbfzzQNAtHj1ZXhfLRCQ7gA2tOGIDOymT3DVLigqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=h7Sgu9ix; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46B2ZiN9025481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 22:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720665346; bh=g1tPbHJdmZnX2AtjWrEW5R3PQWck10IwSxqZ7K4T6t0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=h7Sgu9ixPhRXjD7X0B43X6VbvrEE3ZuJbHcqJCIVVVmAKUAji2iL8oSTscEj8Xyw2
	 SdA516HsA/KHmBZvaxBu8W6GiD82dLEnqCi0ayjmQTIClD8Bx4el6cuZhtyWG2f0V5
	 n67EABZ0Ad7eH1KQky/1jqdFSK+gEaemFPCz6SxIA79a6MuPM8g5DRMDW92lEdmATB
	 G6coKcFwa5pMypHAWdzMnbQc4YuKIb16T4mzyRGjVCf7MUEYzKYuOS2WaqJFUMHH/o
	 Tt/kDOuzgQ/KmvfsYWu/xcdEFGuRF+S1LdcYT/0qo8b7jEFbSOgrwUVQYaiLqyI//T
	 EgRXk7Y1kAjcw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DBE3115C193B; Wed, 10 Jul 2024 22:35:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2] jbd2: speed up jbd2_transaction_committed()
Date: Wed, 10 Jul 2024 22:35:38 -0400
Message-ID: <172066485807.400039.1155297721228619828.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240520131831.2910790-1-yi.zhang@huaweicloud.com>
References: <20240520131831.2910790-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 20 May 2024 21:18:31 +0800, Zhang Yi wrote:
> jbd2_transaction_committed() is used to check whether a transaction with
> the given tid has already committed, it holds j_state_lock in read mode
> and check the tid of current running transaction and committing
> transaction, but holding the j_state_lock is expensive.
> 
> We have already stored the sequence number of the most recently
> committed transaction in journal t->j_commit_sequence, we could do this
> check by comparing it with the given tid instead. If the given tid isn't
> smaller than j_commit_sequence, we can ensure that the given transaction
> has been committed. That way we could drop the expensive lock and
> achieve about 10% ~ 20% performance gains in concurrent DIOs on may
> virtual machine with 100G ramdisk.
> 
> [...]

Applied, thanks!

[1/1] jbd2: speed up jbd2_transaction_committed()
      commit: 7c73ddb7589fb8ddb1136b6306dfb72089c81511

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

