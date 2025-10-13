Return-Path: <linux-fsdevel+bounces-63924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCDDBD1DE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 09:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2D1189898B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015762EAB80;
	Mon, 13 Oct 2025 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPPmQkpy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A62D9EF9;
	Mon, 13 Oct 2025 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341693; cv=none; b=sZjxzBEvzBCT9GHisnXWBD1joLWhHwHHuwoSjKxZX/zXkps/UAzu6Ot3tFbtVT1fMa++y4BHpfk783+XePP4dkfWYV1Xh1lrqFJ+rmSltSG53TZqH0ajCBYKdxfyv264kEBGElg+F//C0Epz/PvWGzDaz1skG+FOjrZ0rYJ+Kr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341693; c=relaxed/simple;
	bh=W5wcCFPexeGvn/sWSNJLJR9WixkS/7o9Gp49Ix6jPvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxtP6bt58X9L83B869wzYdn+XEHimlfDw4+f0HmymLgS87nwZutSLT0zgsdce/lYZkEI4JlfiPXHzlqXFC6OirHmcS2b8yx3XbF1mmFxCtBWtG1IYxSMbsBLA7CvG6bXwyInr06qw1YqfU6HttldyQsWRep7cBviq9OH5l1CEhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPPmQkpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BB5C4CEE7;
	Mon, 13 Oct 2025 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760341691;
	bh=W5wcCFPexeGvn/sWSNJLJR9WixkS/7o9Gp49Ix6jPvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UPPmQkpyyYVS6SOITQIR/LEENy+jW+pKmV5ySk18gTKCucgkHN0dqQ7TKnMY+LaK6
	 EDi+sx9kCjZEUtwvd5w55ZndyNVIxgknDRmJrideQfFKgHVz4+9SsJr0m8x+PocrDm
	 xqQgWiOSWszxzHuvV5mYNWImqt0WlPe9/zd17OvqMXFiSSVNPF4hbTxbQtxUfaNPu6
	 Pt7OyMr8bHcfKmIpXX77KjuumNNIKfuiJY2Wy47C96vfDrxy5xH/bW0v/XnYk89arN
	 QPKWQwGZtw0c/lR0fFdRJuAU1uZSFpxzo20ZIF/pwbY9proseoAtFujC1htoxYXum+
	 4zIFMnJ01t21A==
Message-ID: <e7521bcc-ee24-479b-8384-a0d6e1de43b0@kernel.org>
Date: Mon, 13 Oct 2025 16:48:06 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] btrfs: use the local tmp_inode variable in
 start_delalloc_inodes
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
 <20251013025808.4111128-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013025808.4111128-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/13 11:57, Christoph Hellwig wrote:
> start_delalloc_inodes has a struct inode * pointer available in the
> main loop, use it instead of re-calculating it from the btrfs inode.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

