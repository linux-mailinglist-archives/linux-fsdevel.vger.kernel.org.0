Return-Path: <linux-fsdevel+bounces-63921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F5DBD1D95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 09:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C2D3B0DA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0132EA480;
	Mon, 13 Oct 2025 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/DFd5ZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D261FFE;
	Mon, 13 Oct 2025 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341283; cv=none; b=LE+fB7jlAvSqlX5RQUrIWtGzDWHuriWMoM5BGjA1S9k5fWW0XTFTt7YQVq3QbhgEHcWbjLR3cLjI5I6Cl4HWikjIQ/H+IAyI9B5YaOy/MrfzIfbGtktIRCP3bdpnfdCDOewZQmIZvyYJmxQkdcygYK+LZcYaOnxhyCLN6AyFlYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341283; c=relaxed/simple;
	bh=9BuTDzaR1my5eKzXxHUiTDJrNndjS3jKSzq9fhN1ZZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnJJlJX2XJ02i1sOE+rVZUO7DQ6BiqABJkeylf4on3EOCzIer/k4T7GcGGdFNpt/rtZtWgy7QbPb/7/DMiw92lx50CGZ+eibggJWtMOvb5tnhLD0u58exjwbwUJFjftq97bOi/NNgG0Igxv6u4dsMVwFIAiI3f639JLN/yCuZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/DFd5ZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445E3C4CEE7;
	Mon, 13 Oct 2025 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760341282;
	bh=9BuTDzaR1my5eKzXxHUiTDJrNndjS3jKSzq9fhN1ZZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F/DFd5ZYNP3J4xWwD4ImXWRAWOwNap/62bMhdThDYgc3/2IeAz5fOWHNeFTbdUa6W
	 JQMJl06Yc7WAUEse9bKwJr7KQXApDxR2fsQ/ZbQftiID6tJFy6Jnu2iQ2etXhYY/1y
	 fVXIyAHi8tj3743VeMDXBjLUUrv18KxGfykZwRfAP7rdEtulKKUOga9wIU4T24i89s
	 5cCRR1LLRSGWJkqeQgu66Dho0nOsRvXxAhZp39wGJg4Kw1XaJwc4WPhP67KOX4l0Nu
	 JYHMFDzA+2JaD+TLc2aws0RwskQ1TJFy11dVJWXXcBlGHq7DxG1Bl9to7qt0KVOyIG
	 RWBwZk7se8h2A==
Message-ID: <a1759d1c-08dc-46e3-96b2-9ae2d8258b22@kernel.org>
Date: Mon, 13 Oct 2025 16:41:17 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm: don't opencode filemap_fdatawrite_range in
 filemap_invalidate_inode
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
 <20251013025808.4111128-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013025808.4111128-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/13 11:57, Christoph Hellwig wrote:
> Use filemap_fdatawrite_range instead of opencoding the logic using
> filemap_fdatawrite_wbc.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

