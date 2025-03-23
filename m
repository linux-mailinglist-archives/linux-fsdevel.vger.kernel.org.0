Return-Path: <linux-fsdevel+bounces-44819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F9DA6CE0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 07:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7043B0041
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 06:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B904B20125F;
	Sun, 23 Mar 2025 06:38:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4904501A;
	Sun, 23 Mar 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742711938; cv=none; b=qrb253BtkxN/BSf45wrxxmbx9VDKLYfmiPFQnR8hDiX2D537MPSZJNz3XSM4NyQP0e0SHsR73rxIRGto/oaaLJ0PQ/caPke8zZ492FdWQN3rfriSauKUhS3nmewx398EtwCAqE5QIBNHj/IBKxyjDP/zqDZSYigyHrozoZIwY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742711938; c=relaxed/simple;
	bh=vGqGzpNx83/KKM+ov0KTUadpeo/g/SEh0kk2aUbk9I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHuEV80wVWm4fKquAdPdkG8FC9fnFor+i0Z/qJdmqeSqVvlpUlWysQY1B5mbtijRNuPjDRW5bMvsPHv3oBo4SPhy30sDyL8rqkzQLB85jyKfQpG8wPTJ0I7bwBbLIAfxSaJl4YjMds2mZENvxSNtBhMpAMaaX1af7sNgcyDWHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8FCDD67373; Sun, 23 Mar 2025 07:38:51 +0100 (CET)
Date: Sun, 23 Mar 2025 07:38:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] iomap: rework IOMAP atomic flags
Message-ID: <20250323063850.GA30703@lst.de>
References: <20250320120250.4087011-1-john.g.garry@oracle.com> <20250320120250.4087011-4-john.g.garry@oracle.com> <87cye8sv9f.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cye8sv9f.fsf@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Mar 23, 2025 at 01:17:08AM +0530, Ritesh Harjani wrote:

[full quote deleted, can you please properly trim your replies?]

> So, I guess we can shift IOMAP_F_SIZE_CHANGED and IOMAP_F_STALE by
> 1 bit. So it will all look like.. 

Let's create some more space to avoid this for the next round, e.g.
count the core set flags from 31 down, and limit IOMAP_F_PRIVATE to a
single flag, which is how it is used.


