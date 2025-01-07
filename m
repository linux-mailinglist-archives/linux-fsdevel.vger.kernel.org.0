Return-Path: <linux-fsdevel+bounces-38545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66DA037BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 07:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398D1164B5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1591DC9AD;
	Tue,  7 Jan 2025 06:10:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722DA193077;
	Tue,  7 Jan 2025 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230218; cv=none; b=pltQOkczAaajYwLJUN4i4b+RVw0+E4hJHKMA8FZMOfjban6FxRrMkLP/wWSil57rBvlW8fUZ7D/ZDu1jexgnewhBQS3nRGsG5DuBFJL512AwM5Ck+8f/SQW8Viy6RmY9WYwpCWF8krDXLcNVqUyS0Py3qxoAAXmqAX14lP9O/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230218; c=relaxed/simple;
	bh=H4444VVScmx5T2IfgtnZV/47a+6DwCXRSEh9K+fbHAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhgicGImdXeh3MSWzHdGsWhPKo2yHLuBC0hZjDuPgyyBjFYcVjiDkZQLXCchilz9nLXgHo7IVNcsGppTtZDUTCPDYHCtean/qBkEB86j7sJhuCNCRwvr2FO080fL8QUhk1Z69dc7WwDLexk8n2uRjmGye61v6ogOB7Pk1ed7cYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBA6667373; Tue,  7 Jan 2025 07:10:12 +0100 (CET)
Date: Tue, 7 Jan 2025 07:10:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs: report the correct read/write dio alignment
 for reflinked inodes
Message-ID: <20250107061012.GA13898@lst.de>
References: <20250106151607.954940-1-hch@lst.de> <20250106151607.954940-5-hch@lst.de> <dd525ca1-68ff-4f6d-87a9-b0c67e592f83@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd525ca1-68ff-4f6d-87a9-b0c67e592f83@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 06, 2025 at 06:37:06PM +0000, John Garry wrote:
>> +	/*
>> +	 * On COW inodes we are forced to always rewrite an entire file system
>> +	 * block or RT extent.
>> +	 *
>> +	 * Because applications assume they can do sector sized direct writes
>> +	 * on XFS we fall back to buffered I/O for sub-block direct I/O in that
>> +	 * case.  Because that needs to copy the entire block into the buffer
>> +	 * cache it is highly inefficient and can easily lead to page cache
>> +	 * invalidation races.
>> +	 *
>> +	 * Tell applications to avoid this case by reporting the natively
>> +	 * supported direct I/O read alignment.
>
> Maybe I mis-read the complete comment, but did you really mean "natively 
> supported direct I/O write alignment"? You have been talking about writes 
> only, but then finally mention read alignment.

No, this is indeed intended to talk about the different (smaller) read
alignment we are now reporting.  But I guess the wording is confusing
enough that I should improve it?


