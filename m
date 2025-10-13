Return-Path: <linux-fsdevel+bounces-63926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8957ABD1E74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66A9188B548
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3AF2EB5A3;
	Mon, 13 Oct 2025 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBDGm9z/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A42EB845;
	Mon, 13 Oct 2025 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342469; cv=none; b=RFS2MVljlKTJkh0itrNBtbjrk/T1DGWML7Tvgd1jsO+e6D8iwLg26oJJ8MESD6YqDbyEhE6nUhl1xYmo6HbBI0OQGEWZ8+QuOFe2bvgN2TqbWNLsgdMkk2craBmLdE1s2tqzO9ILC1keea6x/EU5zf1EfoNPIQASRSO8+WwIYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342469; c=relaxed/simple;
	bh=noRWn+euEOloBgxNJ8dGn+WU7na1mnGeYcuQeFZBKcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCfubCW7ZWy1PcQz4TxSulZEj0pNBFCT2JpPkpUbYfd4KG+kE+JjduOZi/g1DdQwRs/KUAtyyASKZwn2Kn3SG66xB+YANsZUMgJkPMZEdId0I+dnMSy4Ip04yuNbFHj+lKeAit8GQZrBWferFgzCemQlZ21+gzMzX4DSdMGwEy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBDGm9z/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFC6C4CEE7;
	Mon, 13 Oct 2025 08:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760342465;
	bh=noRWn+euEOloBgxNJ8dGn+WU7na1mnGeYcuQeFZBKcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pBDGm9z/dvP+Dmxvki9hejV2S2ZVULKP9OcyfWsJmAwVMW/5h3Fo/Q0rTSY2/t8de
	 MsMyqaxTxNJRsYNM2uYjQmQXuKyYHnBeLQgVj7eqUqoeQ2BZvE2kLgY0ZF1TThX559
	 KjU63ZaEvxHmiAnfvVOHOLE1j1wh1PtMXDVNbJabzybEfpwQ84O3H3kktKYxV8w0E7
	 g0ps/rPrEpS18LVK9PIjswWPewYBEj3gP4I4k6qRxRNznVUTWmodK0qXJs9/TeW6GQ
	 g2yByYTih6aMzs+AniXcqoLXFAtm/8p1Hln96sK7ehRa5VP5QdfICnIaJb7vYUs1Yj
	 gvisoLlYoia+A==
Message-ID: <74593bac-929b-4496-80e0-43d0f54d6b4c@kernel.org>
Date: Mon, 13 Oct 2025 17:01:01 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] mm,btrfs: add a filemap_fdatawrite_kick_nr helper
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
 <20251013025808.4111128-7-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013025808.4111128-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/13 11:58, Christoph Hellwig wrote:
> Abstract out the btrfs-specific behavior of kicking off I/O on a number
> of pages on an address_space into a well-defined helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

One nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


> +/*
> + * Start writeback on @nr_to_write pages from @mapping.  No one but the existing
> + * btrfs caller should be using this.  Talk to linux-mm if you think adding a
> + * new caller is a good idea.
> + */
> +int filemap_fdatawrite_kick_nr(struct address_space *mapping, long *nr_to_write)

Not a huge fan of this name. Maybe filemap_fdatawrite_nrpages() ?


-- 
Damien Le Moal
Western Digital Research

