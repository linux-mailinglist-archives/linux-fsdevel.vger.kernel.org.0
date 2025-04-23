Return-Path: <linux-fsdevel+bounces-47055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1BAA98264
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C8318962C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6123F26B0A5;
	Wed, 23 Apr 2025 08:11:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFAA1F470E;
	Wed, 23 Apr 2025 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395869; cv=none; b=XkiGPr/z3y29FyiXOewWdlnox9dPyxlcJ1TO1YizOCSpHB83REGHFZilxqoRNEgySU0ZeGu6ZqRT+f6m+G9n/mpy1b87REG/kOiWZ1NbttRCNp2WpBFilXUafbIoOKjtzUcCnrJUuucZXF0u7R1emltvMEK0Vzp1txt/FnK0b9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395869; c=relaxed/simple;
	bh=AcZL+tgJx6ZeqYbFnXapzYJ9r1oRCnCzprxsrk7VnzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5yAdF1cAVAJAfgLV8AnZI4foZXjSOOlgR5QZb4ZfMgNxuDHNX6fbBjwujefEn5sMV7iesh0XAIKqLC0i1MjakX2zSKpO1BcV9IlbNKmpLgng8wC1v5OHpbVfs7m9WtXWb3/SJeDfq6CHqBfFLg8E+p5bo/JqvZpoeVQWJRIdck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B376468AFE; Wed, 23 Apr 2025 10:10:55 +0200 (CEST)
Date: Wed, 23 Apr 2025 10:10:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 05/15] xfs: ignore HW which cannot atomic write a
 single block
Message-ID: <20250423081055.GA28307@lst.de>
References: <20250422122739.2230121-1-john.g.garry@oracle.com> <20250422122739.2230121-6-john.g.garry@oracle.com> <20250423003823.GW25675@frogsfrogsfrogs> <f467a921-e7dd-4f5b-ac9f-c6e8c043143c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f467a921-e7dd-4f5b-ac9f-c6e8c043143c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 23, 2025 at 08:15:43AM +0100, John Garry wrote:
> Ideally we could have not set them in the first place, but need to know the 
> blocksize when xfs_alloc_buftarg() is called, but it is not yet set for 
> mp/sb. Is there any neat way to know the blocksize when xfs_alloc_buftarg() 
> is called?

The buftarg is needed to read the superblock, which is used to determine
the block size, so no.

But maybe we should just delay setting the atomic values until later so
that it can be done in a single pass?  E.g. into xfs_setsize_buftarg
which then should probably be rename to something like
xfs_buftarg_setup.


