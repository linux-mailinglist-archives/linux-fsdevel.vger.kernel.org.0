Return-Path: <linux-fsdevel+bounces-38660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E804DA05FD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 16:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233A4188994A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 15:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71501FDE2C;
	Wed,  8 Jan 2025 15:18:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EDE1FDE14;
	Wed,  8 Jan 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349516; cv=none; b=ldkGccFRx6WGQTsJyvTOXv4Y5rTfsZnHP88uTDhC5JSBp0SzbeUeYvs+E9sz0pq3dlEsKVet/FcVVwUrWIbVdy+c65H6JaojOpQEAHDvZ42XXW3Lcs/WWr6PFngFWWRBJ8Ca8qdxXNBNC2hqEBsbV3beja5lD2ooMKtL4W8uR3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349516; c=relaxed/simple;
	bh=OujOAdLOQ7kXdL5URXNzCkXJteiHpdwooom5ajLUb9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWp63xdmQIugRIpNbAYl6cR2FMrAe7JbbCXJszXIgHEMb7oAqaQMxqqmO7c00+uy1ICbyKVJTNyXzECT/iYf/IWT60WF75M0ccUt07rIVOGRU+InxexNtRk0LTKyEg1RXjEho2XAv+GuV1du8JxEwiiyxqAaHQQQ7V1XDqt8+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7CC3A68BFE; Wed,  8 Jan 2025 16:18:28 +0100 (CET)
Date: Wed, 8 Jan 2025 16:18:27 +0100
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
Subject: Re: [PATCH 4/5] xfs: report the correct read/write dio alignment
 for reflinked inodes
Message-ID: <20250108151827.GA24499@lst.de>
References: <20250108085549.1296733-1-hch@lst.de> <20250108085549.1296733-5-hch@lst.de> <571d96ad-d9fe-4c76-8f05-1e487244b388@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571d96ad-d9fe-4c76-8f05-1e487244b388@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 08, 2025 at 10:13:02AM +0000, John Garry wrote:
> On 08/01/2025 08:55, Christoph Hellwig wrote:
>> @@ -580,9 +580,24 @@ xfs_report_dioalign(
>>   	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>>   	struct block_device	*bdev = target->bt_bdev;
>>   -	stat->result_mask |= STATX_DIOALIGN;
>> +	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
>
> BTW, it would be a crappy userspace which can't handle fields which it did 
> not ask for, e.g. asked for STATX_DIOALIGN, but got  STATX_DIOALIGN and 
> STATX_DIO_READ_ALIGN

Well, the space is marked for extension.  I don't think there ever
was a requirement only fields asked for are reported, but if that
feels safer I could switch to that.

