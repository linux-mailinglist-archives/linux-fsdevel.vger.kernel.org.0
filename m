Return-Path: <linux-fsdevel+bounces-11514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BAA854364
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 08:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3A7B2628E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 07:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B42125A6;
	Wed, 14 Feb 2024 07:26:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADA0111B5;
	Wed, 14 Feb 2024 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895583; cv=none; b=FS+9VmPhUWs7gCmnH2qYD0xpxMMfobVgu9+VyjSCVgkW7Z5BQGw5cA+BHCbi70zvrFPplF/EO11ajnfRx/UiRJ+g37JLzmrwYwhyw57ZyXd88BtWZsuwWfspU8zl7AoNMl1L9DtELgXHvNUmw4Mns8MZxjnoIOZT3uf7vrJu+gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895583; c=relaxed/simple;
	bh=juFBNMubKn9gMBWcEFowWNCBKZXHfuauU6CXERbbJHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2s4VZ57vLD1VvTuk7DNMNfO6ap1bur2+lZeaVv7Hp26aT0iC48v3QiFym8GQ5l3qzIW5ZHmRZKav13RvhDdH+WnRvmElqjZ9c7mS3PgclahMB2QSA1emADCOM6HvmhLgYnv2hExCGAvRhNepfNWb43a0LDy8U/rqWXi/dVx1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54133227A87; Wed, 14 Feb 2024 08:26:10 +0100 (CET)
Date: Wed, 14 Feb 2024 08:26:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v3 07/15] block: Limit atomic write IO size according
 to atomic_write_max_sectors
Message-ID: <20240214072610.GA9881@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-8-john.g.garry@oracle.com> <20240213062620.GD23128@lst.de> <749e8de5-8bbb-4fb5-a0c0-82937a9dfa38@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749e8de5-8bbb-4fb5-a0c0-82937a9dfa38@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 13, 2024 at 08:15:08AM +0000, John Garry wrote:
> I'm note sure if that would be better in the fops.c patch (or not added)

We'll need the partition check.  If you want to get fancy you could
also add the atomic boundary offset thing there as a partitions would
make devices with that "feature" useful again, although I'd prefer to
only deal with that if the need actually arises.

The right place is in the core infrastructure, the bdev patch is just
a user of the block infrastructure.  bdev really are just another
file system and a consumer of the block layer APIs.

