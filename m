Return-Path: <linux-fsdevel+bounces-70202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1EC9378A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 04:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 496E034A32D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 03:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE030223323;
	Sat, 29 Nov 2025 03:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="f2/hI8DR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918B11A23B6
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764388357; cv=none; b=Tf/CeNBu+nGiX3HdA7SDtl2hp6m5kK+VIc4cUqPaYU6wNH/Bv3XAahabXcj+JF5i9k4lt2y9udbE2/RTXGsigvorU+ij6Pydnzs72Z2n1sGGIFtNd9ZXXfafZFUx/R6eF8Ri+zCU7ybOA3aJoFdmnP3JyScAtYleA+nO1rzY2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764388357; c=relaxed/simple;
	bh=GgxZY+zGjHqMIJL9xK0fwb/wL9caL1WVLmEJSeIIQGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSkum09K5AdSU7jiDRMM1XWB4UjQeRtK2BzFefylOL12tXouB4OFC4zwWN4EvevyUT3REP0of0a31g6GLirMnzIGRmieBB2Rg6LVByVIGqmTnr6WT40V6rJZXIZB6kkGCtDchFnHpTmmHFu95y092HRZM5EZEOKejJEVjMbCDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=f2/hI8DR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([12.187.214.164])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AT3q06j017072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 22:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764388324; bh=qkdEq0YlotXHeAiLMDJxrdCiBWvZyfhbAXNUmcPs01w=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=f2/hI8DRtT7gAXi/RxaRbbeopRpo2fVLXLp677KFRhUpXBHcH1OhbTWj5V1izJkqH
	 6uICBn36VF/gRx8UlaY1/HF/N6P6zKpQUfQMav3+ai501lKXhGvonBEul3xFO456hr
	 cYVRxE4IIGbnhyuJ2tzK+O5zPGsLUMwRz1M+T3bref7kkcE0fPFe49LZiW3Q2SH7OA
	 r8I8QjMfNPA5VzjGMMnlYhCIobOYQPR/GfS+f3arxYFQg2UejQcCwRiDfGQi8F/Wr/
	 7lh/MDTPhgiDewSKLP4DTS9u7uC26tj5k5rPXZzLR2f3cMCL/YR7m2TlIVMiAnd/Ds
	 MkptGFbsUXXpw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7397A4D578F0; Fri, 28 Nov 2025 21:52:00 -0600 (CST)
Date: Fri, 28 Nov 2025 21:52:00 -0600
From: "Theodore Tso" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH v2 00/13] ext4: replace ext4_es_insert_extent() when
 caching on-disk extents
Message-ID: <20251129035200.GA64725@macsyma.local>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251128164959.GC4102@macsyma-3.local>
 <58148859-dad6-4a1a-82ef-2a6099e2464d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58148859-dad6-4a1a-82ef-2a6099e2464d@huaweicloud.com>

On Sat, Nov 29, 2025 at 09:32:25AM +0800, Zhang Yi wrote:
> 
> The ext4.git tree[1] shows that only the first three patches from this
> v2 version have been merged, possibly because the fourth patch conflicted
> with ErKun's patch[2].

Yeah, oops.  Sorry about that.  I think I had checked some other
branch via a git reset --hard, and forgot that I had accidentally
aborted the git am after the patch conflict.

I've rearranged the dev brach so that those first three patches are
not at the tip of the dev branch.  So if you want to grab the dev
branch, and then rebase your new series on top of commit 91ef18b567da,
you can do that.

* 1e366d088866 - (HEAD -> dev, ext4/dev) ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1 (10 minutes ago)
* 6afae3414127 - ext4: subdivide EXT4_EXT_DATA_VALID1 (10 minutes ago)
* a4e2cc74a11b - ext4: cleanup zeroout in ext4_split_extent_at() (10 minutes ago)
* 91ef18b567da - ext4: mark inodes without acls in __ext4_iget() (10 minutes ago)

Note that the merge window opens on this coming Sunday, but a good
number of these patches are bug fixes (and not in the sense of adding
a new feature :-), so I'd prefer to land them this cycle if possible.

> I've written a new version locally, adding two fix
> patches for the three merged patches, and then rebase the subsequent
> patches and modify them directly. I can send them out after texting.
> Is this okay?

Why don't you modify your series so it applies on top of 91ef18b567da,
so we don't hace to have the fixup patches, and I may just simply push
everything up to 91ef18b567da to Linus, and we can then just apply the
next version of your series on top of that commit, and I'll push it to
Linus right after -rc1.

Does that seem workable to you?

							- Ted

