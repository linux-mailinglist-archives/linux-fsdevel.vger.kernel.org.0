Return-Path: <linux-fsdevel+bounces-63923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31CBD1DB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 09:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E7C18987F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B932EA48B;
	Mon, 13 Oct 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnWR5DL6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B102E0412;
	Mon, 13 Oct 2025 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341408; cv=none; b=eBtzWuO506SerkAZvZ2aZtg9k/B93skCyRaF9M2X2RxO3PWWrSEERQo9QbKIT4TmigaHJbmHKaB2hMfQc9rHFCJxsB1Syf1AUdLmvGrRvVdZj2v8hMr9L6CIkr+QUgVn2qImffdqtmoHUTjzm0e5Nai1zbYm4zjg1VwTyh35oD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341408; c=relaxed/simple;
	bh=pLU1IwgvICYpZ3g2TCq3YLekM3iXUDoDXJJmtP+sz6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnt3092lFZDPlLANvrifB+OlP93xzqZgty2Y83XQLBKicXZxN2iU1Q+vQ+c0eMXJcuCZ7q9xe0Sa577znON92HPGLZWa/PNMo0O+7MUulvx1uIJUrdeMHpirJgb3gZa0XM9j1VECOs0+sGg8ze4xPj3sNnffXTUGuBbbCj42eYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnWR5DL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EA0C4CEE7;
	Mon, 13 Oct 2025 07:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760341407;
	bh=pLU1IwgvICYpZ3g2TCq3YLekM3iXUDoDXJJmtP+sz6A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lnWR5DL6O1Ugwhb5lInDx7NsVnbuDNuDrNW1Qj3ABN/pQSdJlhF74Fm09Z3LeViRL
	 bE2zqG/e2w6dngZxYVFNJ/Q65clf+Hj8cZCyGC9elWh2sCrl/ssUDaqCcq/BnD22lG
	 5mscBQ6e6g6SgtiCsQkUqwOmjpRsjjA6bhuSVHlPWaGLahKdGSXhn8sQHQ6tCt72XF
	 Rk4AQ7XlVAvM3T4VF5GRomIr8nMHBfOdFFlk+shVbgSkMhmSHIzSoJlP+5yFt1UtH0
	 L4pKE/dxRF+YHRiKKH3Ri+AL6eYTysDFQCA7AbcfnAcPEZnlKNw7XpiM65yn9w2Kko
	 WZ3KtavIeGATg==
Message-ID: <90d26781-97c6-48ac-9f4f-4cd14567e657@kernel.org>
Date: Mon, 13 Oct 2025 16:43:23 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] ocfs2: don't opencode filemap_fdatawrite_range in
 ocfs2_journal_submit_inode_data_buffers
To: Christoph Hellwig <hch@lst.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, v9fs@lists.linux.dev,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013025808.4111128-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/13 11:57, Christoph Hellwig wrote:
> Use filemap_fdatawrite_range instead of opencoding the logic using
> filemap_fdatawrite_wbc.  There is a slight change in the conversion
> as nr_to_write is now set to LONG_MAX instead of double the number
> of the pages in the range.  LONG_MAX is the usual nr_to_write for
> WB_SYNC_ALL writeback, and the value expected by lower layers here.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

