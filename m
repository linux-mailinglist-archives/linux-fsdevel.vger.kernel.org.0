Return-Path: <linux-fsdevel+bounces-47219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF33A9AB2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68563B4882
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B0822332D;
	Thu, 24 Apr 2025 10:55:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F422129E
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492149; cv=none; b=dabHlfr891pGKXGju0Mu4Q9SKzImDbxUTDAbJZLG0IlsYCnG9qPgk+y2p1gbV3ZdZVBHGNsv9M1E5bLt7lw4DNR39Sq3rgABd95oA6Btl02/H55+Uv7Q97B5f2nunw4CVBqLvP+b67t9rIssvDDJNeDho4onlDA4ok9p4xt9ugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492149; c=relaxed/simple;
	bh=uaIDVqVrpyZLs0/EY2900axDnZfArdbICyo7qVdibf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBd/Hjzrx5Z7wvJAY6p5WRyoJiYB0X4mofqOAb4Vzwr/zZuJ1EI6TmlfVBY+2ypsX2eI0zqput7/nG6E4xjcpAThaDrNkVHXIElTgqQ5Mkwt4oKa0TfnzfupnwgjtUH2zh96HLvy5AvYHzR09d+pYkFvcuQqWNJtjmmfiq4dWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2739467373; Thu, 24 Apr 2025 12:55:42 +0200 (CEST)
Date: Thu, 24 Apr 2025 12:55:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Revert "fs: move the bdex_statx call to
 vfs_getattr_nosec"
Message-ID: <20250424105541.GA3643@lst.de>
References: <20250424-patient-abgeebbt-a0a7001f040b@brauner> <20250424090444.GA27439@lst.de> <20250424-liefen-abprallen-c698e7d7eb26@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-liefen-abprallen-c698e7d7eb26@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 24, 2025 at 11:22:40AM +0200, Christian Brauner wrote:
> On Thu, Apr 24, 2025 at 11:04:44AM +0200, Christoph Hellwig wrote:
> > On Thu, Apr 24, 2025 at 10:59:44AM +0200, Christian Brauner wrote:
> > > This reverts commit 777d0961ff95b26d5887fdae69900374364976f3.
> > > 
> > > Now that we have fixed the original issue in devtmpfs we can revert this
> > > commit because the bdev_statx() call in vfs_getattr_nosec() causes
> > > issues with the lifetime logic of dm devices.
> > 
> > Umm, no.  We need this patch.  And the devtmpfs fixes the issue that
> > it caused for devtmpfs.
> 
> For loop devices only afaict.

For anything that wants to query bdev attributes.  We are about to
add the same for nvmet, and in the future also for the scsi target
and zloop if it gets merged.

Either way the above sentence is wrong - reverting it will cause a
regression.

> The bdev_statx() implementation is
> absolutely terrifying because it triggers all that block module
> autoloading stuff and quite a few kernels still have that turned on. By
> adding that to vfs_getattr_nosec() suddenly all kernel consumers are
> able to do the same thing by accident.

I send a series to fi that yesterday.

> This already crapped devtmpfs. We
> have no idea what else it will start breaking unless you audit every
> single caller.

I don't think so.  The issue really is that devtmpfs calls this from
the block device shutdown path, and md has a really weird shutdown
path.  The first is fixed by the patch you applied, and the second is
being looked into, a series was posted about half an hour ago.

Callers that aren't directly tied into block device shutdown can't
have that issue.

> If this stays in then please figure out how to skip a call into
> blkdev_get_no_open() unless it's explicitly requested.

The problem with that is the blksize that is reported unconditionally,
for the LBS stuff.  I don't have a good answer for that as it is
reported unconditionally.  But as said, the extra bdev reference is
fairly harmless outside of magic code like devtmpfs.

