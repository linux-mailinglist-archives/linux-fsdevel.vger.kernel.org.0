Return-Path: <linux-fsdevel+bounces-22953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A744E924202
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBB41F24917
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 15:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EC61BBBCE;
	Tue,  2 Jul 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dCljCzJR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED231DFFC;
	Tue,  2 Jul 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933163; cv=none; b=Rq2t65owanOnDswCs4Mtc23lq5z/T371ks43KUHghXiUNwn9ooe/iXElS6eCjXW5K4Xblhy40GXegYpUxbfPq6UvldqrVby5m0Wwrjn4Jc4yJ32xwUNGU1S4CLhtok1GaRO0kzjVESvqa6mFLcTT3u8XBiSMCLpb3Rs3OqgBtM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933163; c=relaxed/simple;
	bh=ABYatGOHDvGjohsk6pDUWhV3e0zacUzLxB8sgh2L0Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dS03hnGJVjnp0+l26vMKQRu/W2PM/qVCp9D19ue3JZYQrhk3JP1b/ZzhL1YGX4ydCLkj5rVJn4efI/YoicjLYigOmT7NyVvbj1zRV0O5tBqSqNvrhPCrszRAou2VUyYcpUGrIOSUwGlS9K8e7G67P9uDCp6X41lz1DL8XzMkE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dCljCzJR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8aouOiHZz/CtkLH8RlphiC+CuL1fGX3TYjmQQVPOhZE=; b=dCljCzJRSfznNuYHX5KeHFLuWV
	1bGB2/E0ElcUGou1naiVTb8GjiRYIwBvBWILQ6RLqqRbBdOIErpJ+SWkBWdjlw0iN1lSHfonwrj0h
	wVdYu0AnkD5wOr6zpmOvc/VRJ7EyUE9eLSu3jJDW06TfZ4HwOGaTRkiCfriacF5Wo6FBnITHbgOe2
	cUWZdK2jsEKUktlwltOfhcgJvoqG4q8eukNIK7KWBynHYywL5TPP8gs5jg82+w2Xyc2gd4deZhrue
	H21CvG2clgGVczz798MUMmJhoWGmR3TMIxyr1HailAgCTaIgccNe/f1h4oVzV2bhQzXPmu4J40qQX
	V4LqdFhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOfBK-000000079no-1zHc;
	Tue, 02 Jul 2024 15:12:34 +0000
Date: Tue, 2 Jul 2024 08:12:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 01/10] fs: turn inode ctime fields into a single ktime_t
Message-ID: <ZoQY4jdTc5dHPGGG@infradead.org>
References: <20240701224941.GE612460@frogsfrogsfrogs>
 <3042db2f803fbc711575ec4f1c4a273912a50904.camel@kernel.org>
 <ZoOuSxRlvEQ5rOqn@infradead.org>
 <d91a29f0e600793917b73ac23175e02dafd56beb.camel@kernel.org>
 <20240702101902.qcx73xgae2sqoso7@quack3>
 <958080f6de517cf9d0a1994e3ca500f23599ca33.camel@kernel.org>
 <ZoPs0TfTEktPaCHo@infradead.org>
 <09ad82419eb78a2f81dda5dca9caae10663a2a19.camel@kernel.org>
 <ZoPvR39vGeluD5T2@infradead.org>
 <a11d84a3085c6a6920d086bf8fae1625ceff5764.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a11d84a3085c6a6920d086bf8fae1625ceff5764.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 02, 2024 at 08:21:42AM -0400, Jeff Layton wrote:
> Many of the existing callers of inode_ctime_to_ts are in void return
> functions. They're just copying data from an internal representation to
> struct inode and assume it always succeeds. For those we'll probably
> have to catch bad ctime values earlier.
> 
> So, I think I'll probably have to roll bespoke error handling in all of
> the relevant filesystems if we go this route. There are also
> differences between filesystems -- does it make sense to refuse to load
> an inode with a bogus ctime on NFS or AFS? Probably not.
> 
> Hell, it may be simpler to just ditch this patch and reimplement
> mgtimes using the nanosecond fields like the earlier versions did.

Thatdoes for sure sound simpler.  What is the big advantage of the
ktime_t?  Smaller size?


