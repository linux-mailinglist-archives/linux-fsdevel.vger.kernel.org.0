Return-Path: <linux-fsdevel+bounces-23972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F59370B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 00:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006FB1F21607
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 22:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99D80C07;
	Thu, 18 Jul 2024 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tHOogS6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B78146595;
	Thu, 18 Jul 2024 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342124; cv=none; b=OFAkIAhknMjqNwYuokShe/i+QFuB5wgLwVR5muBJKcLb/h9uHkXQ6JEgfAL3Xy/YbuLrQvZLNDYz5Hy0le9QLDSmP3/wvYtMn0r2cY/achA5IXEeyYh8H/cduxOiQxSJQZlscrbvaKOL3EoMTGE1Btn+zdn1OZbjZVMvYrbVJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342124; c=relaxed/simple;
	bh=Q77l9sJemK2FS1NwrQtLXO+wErvSKs6sLOGw2QWCUeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPdutMlpVFDpNRGzH8XGBxOGdsSUHBBhTYp+w9RAIrLDzxwVU0z9O4/+VN6nPbBpz6wREBluI3iMc9bGCgrzy9Evqdm3WIvDdeMw//6bibPw9Omx8lnaNlAAAGrTK89S6aGyFcedrnhYayulQXhsV5NAPXSjzH2SnzYvMgpfMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tHOogS6Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8EeDOIWMZon6WTAwsmmAoyg2vi80dO8qZGMtoPq7F+E=; b=tHOogS6Zot9g8mA5X2wa8ho1xh
	cJtBfw9ihmKKR3nG/4Xa9I6ZZcKWIn6vjwPb+Fk4C2EClJ+YSGtx3uKdftj/ZsnAet+hOuoSlMsz0
	+eRS9XgQN7JHQE/NjJe0cpXBmdWI6c8JqmMdmpXRxnw/uaCi2lJb8f4fxxGKqjGgYfJ+GQud4+vM+
	bT7XMoZo0TvCyCnhlLWO/aEGwOYhaKsADSFF67gcuGe64n/GloNtpILvGUPsmDotbR8I30TOBCQz8
	1sTAe/2Igmfud9BCj4g3O3IuehyG+2LMCbZBDIy+W1BKkQs+ETGHZilUSno2ZuQNEYtY8fsiG0VC0
	9IBpaohg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUZiZ-00000002OEF-411Q;
	Thu, 18 Jul 2024 22:35:19 +0000
Date: Thu, 18 Jul 2024 23:35:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/2] ext4: Remove array of buffer_heads from
 mext_page_mkuptodate()
Message-ID: <ZpmYp-ci47MZ6c9T@casper.infradead.org>
References: <20240516181651.2879778-1-willy@infradead.org>
 <20240516181651.2879778-2-willy@infradead.org>
 <20240627202022.GC419129@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627202022.GC419129@mit.edu>

On Thu, Jun 27, 2024 at 04:20:22PM -0400, Theodore Ts'o wrote:
> This patch is causing ext4/020 (which tests the EXT4_IOC_MOVE_EXT
> ioctl used by e4defrag).  This can be easily reproduced via:
> "kvm-xfstests -c ext4/4k ext4/020".  From
> /results/ext4/results-4k/ext4/020.out.bad:
> 
>    QA output created by 020
>    wrote 1048576/1048576 bytes at offset 0
>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>    wrote 1023/1023 bytes at offset 0
>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>    md5sum: WARNING: 1 computed checksum did NOT match
>    SCRATCH_MNT/020.orig: FAILED
> 
> I'm going to drop both this patch and the preceeding patch in this
> series ("ext4: reduce stack usage in ext4_mpage_readpages()") pending
> further investigation.

Thanks.  I couldn't get kvm-xfstests to work, but I was able to run
ext4/020 using Kent's testsuite.  I found two bugs and fixed them.
I split this second patch into three patches for v2.

