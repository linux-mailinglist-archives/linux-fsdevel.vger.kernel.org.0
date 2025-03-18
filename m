Return-Path: <linux-fsdevel+bounces-44298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC3EA66ED8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736931887B65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DDF204C28;
	Tue, 18 Mar 2025 08:46:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEE31DC185;
	Tue, 18 Mar 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287607; cv=none; b=cKPJ8BVFS7XL8BHns2hpmzLhjzGD1FbZHic1boDaWsuS+HnPvB7cL8mfhi1sQucq5jTJVemV8BGO50YcQbWMpRSQbbx/hfVDw4+az03BZwP1Hy9yV/ZB5ztfgK71i3UyjlfGlrPx6LXiYyQC5Z6fbIHTPUq+ZZt83Riv5knbID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287607; c=relaxed/simple;
	bh=tiEyPa0R/xYSe87L2z5ehN7hDR+DAb14vNRTJeTg21U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCw/bos+6SUgYKpnb/dCkzjZfjlhqmLsJCTXP3Z8WSKOjGZ5qjh3H7c+94uD73IwFZfFOPIVSO3b6O4+dIBJ1YjU2bPas8P+5J5xFN8KVkxoul/S3Pw89QZ+x/7sHACOLEHkN9k4258XEO5Gosg07S4HOlB9+dxDvvkth3+uNcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4384F68AFE; Tue, 18 Mar 2025 09:46:41 +0100 (CET)
Date: Tue, 18 Mar 2025 09:46:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	cem@kernel.org, dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 11/13] xfs: add xfs_file_dio_write_atomic()
Message-ID: <20250318084641.GC19274@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-12-john.g.garry@oracle.com> <20250317064109.GA27621@lst.de> <7d9585df-9a1c-42f7-99ca-084dd47ea3ae@oracle.com> <20250318054345.GE14470@lst.de> <08992e02-9ff4-416e-bd6c-e3e016356200@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08992e02-9ff4-416e-bd6c-e3e016356200@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 08:42:36AM +0000, John Garry wrote:
>> I see that this is what's done in the current series now.  But that feels
>> very wrong.  Why do you want to deprive the user of this nice and useful
>> code if they don't have the right hardware? 
>
> I don't think it's fair to say that we deprive the user - so far we just 
> don't and nobody has asked for atomics without HW support.

You're still keeping this nice functionality from the users..

>
>> Why do we limit us to the
>> hardware supported size when we support more in software? 
>
> As I see, HW offload gives fast and predictable performance.
>
> The COW method is just a (slow) fallback is when HW offload is not possible.
>
> If we want to allow the user to avail of atomics greater than the mounted 
> bdev, then we should have a method to tell the user of the optimised 
> threshold. They could read the bdev atomic limits and infer this, but that 
> is not a good user experience.

Yes, there should be an interface to expose that.  But even without
the hardware acceleration a guaranteed untorn write is a really nice
feature to have.


