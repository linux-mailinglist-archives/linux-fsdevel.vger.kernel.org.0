Return-Path: <linux-fsdevel+bounces-44504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80687A69F4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 06:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE66189DD87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 05:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC401E47B0;
	Thu, 20 Mar 2025 05:29:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418EB3D994;
	Thu, 20 Mar 2025 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448578; cv=none; b=pUJXggRFbhJrvKyaDeVYApeg0M6kfEiXJsf50JiEuz+vD90z9Sxed2LXHpjmpXZzCJiyX9gjbOAKRH/6Bq9UA8NUhIupLMjy7pxHBiCsmN8cJ/5N9EJeNkNbpKBBZDJ6oWm3rC9akT8ru/KrTlCX6U9cvjgV7nL0NrqLkp94/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448578; c=relaxed/simple;
	bh=bDfQSsLmLnxeqEW9bKVw08xONqJ1TOJd2A9qPkd57ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDDw3F9/ZQZguEyEg+ldJa1uKMdwhZjLXuEHgsj/tikcdOY1YLfsyTb3GDyphKQXBYbQ/U/McxUOpTZd2j+WKFZxQwqKFSccHBj7zPCFY1m9Ym7od4YJQM2vW6iipFhdsMiLj/qlvrc1CGP4Qa3219gfFYIJJTB+mV9kc04kYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13F0068AA6; Thu, 20 Mar 2025 06:29:30 +0100 (CET)
Date: Thu, 20 Mar 2025 06:29:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	cem@kernel.org, dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
Message-ID: <20250320052929.GA12560@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-11-john.g.garry@oracle.com> <Z9fOoE3LxcLNcddh@infradead.org> <eb7a6175-5637-4ea6-a08c-14776aa67d8b@oracle.com> <20250318053906.GD14470@lst.de> <eff45548-df5a-469b-a4ee-6d09845c86e2@oracle.com> <20250318083203.GA18902@lst.de> <de3f6e25-851a-4ed7-9511-397270785794@oracle.com> <20250319073045.GA25373@lst.de> <ef315f4e-d7e9-48ee-b975-e0a014d10ba2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef315f4e-d7e9-48ee-b975-e0a014d10ba2@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 19, 2025 at 10:24:55AM +0000, John Garry wrote:
> it seems to work ok, cheers

Better test it very well, this was really just intended as a sketch..

>> +	count_fsb = end_fsb - offset_fsb;
>> +	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
>> +			xfs_get_cowextsz_hint(ip));
>> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>> +
>> +	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write,
>> +			XFS_DIOSTRAT_SPACE_RES(mp, resaligned), 0, false, &tp);
>>   	if (error)
>>   		return error;
>>   -	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
>> -			&nimaps, 0);
>> -	if (error)
>> -		goto out_unlock;
>> +	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
>> +		cmap.br_startoff = end_fsb;
>
> Do we really need this logic?
>
> offset_fsb does not change, and logically cmap.br_startoff == end_fsb 
> already, right?

Afte unlocking and relocking the ilock the extent layout could have
changed.


