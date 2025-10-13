Return-Path: <linux-fsdevel+bounces-63922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C8BD1DAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 09:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DB53A5338
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CD22EA47F;
	Mon, 13 Oct 2025 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ5eg06e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5B61FFE;
	Mon, 13 Oct 2025 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341352; cv=none; b=kMutbCAHWZQlFT20ZRm5VK3nIOcbR1//Tk1TweESAv4UO4Oq7QXqqYPM3sYspEUxtbwy7buIJJSiyw5OnSkCSYIsgt4ENzylFKo+Ro+7z6PQ6BCByvci6lurJW9N7KM9+vpmKTDbXJy03GrjTgT7uYQFjjIVlLsCJq34Xcyn/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341352; c=relaxed/simple;
	bh=98uNYnRqcVdtyKijP43iNr9FBYNN1buUB0s6rxs7Jnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pr9QgvZZoyP2FzVf1BljS8bsEFs7oPi9BFjlTSoXswF6e7Y31ICIIFS2DJwCdGkUJzfncFfbk7WD1Le04mHMFam5VfYHOqYnRD+eWxy4hKB33nLFzFkXQKJp5g6B27ZOyUuybm12sud5SZLbFO+4ynaD7/Cls18cOYvivbgejpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ5eg06e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B319CC4CEE7;
	Mon, 13 Oct 2025 07:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760341352;
	bh=98uNYnRqcVdtyKijP43iNr9FBYNN1buUB0s6rxs7Jnc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SZ5eg06eGhWCDln8zwWXVDi++rSzVsHgAzWQJp6ZN6j1s72t724fV2Jbt/DoD4/7a
	 lzXCYqRFefu97LfS0v6l7l6RNbjUdksNgGIFVCwXCqmnBLTCzAuPu2jsND1qCnheSU
	 5WvUZoBYTtf+4hn9pSm37g9eScUL/M8svS4SRwjVFz0odn/HOFPYo+EQ9uTGkE0A3Y
	 t8lC4ps3+kZ+rjKfDGchS64/XB0CnIm4l5cAXgqyDnOGPQV/PEg8HibmPCecq80TYA
	 jShbsfAa3bAHekN7SMuo/X0dgr/3gIkq2mzIt9VcRrdCC14ERZA4Q1iuF9y9GfIYsH
	 oUreoxYxkdAVg==
Message-ID: <8efa955a-21c4-42b9-a734-a06a46fd51c7@kernel.org>
Date: Mon, 13 Oct 2025 16:42:27 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] 9p: don't opencode filemap_fdatawrite_range in
 v9fs_mmap_vm_close
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
 <20251013025808.4111128-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013025808.4111128-3-hch@lst.de>
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

