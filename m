Return-Path: <linux-fsdevel+bounces-12214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE57685D18A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 08:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127BC1C237F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 07:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B43B781;
	Wed, 21 Feb 2024 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTBjJF/n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406E3AC14;
	Wed, 21 Feb 2024 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500996; cv=none; b=jdgJgITpkznnAvdaQTa1dbHYofrz8M+3hOhmvh7HOunF+ihUEJZTzFk0OLlWyuAna6iJbCD4nOyR1X59dcD2et8tvsBZ6pR0rmvEKaxQ1nEIGJPECR/AyTq4j3IyD25+PgN1ZC2zqCSxxAkv0VPgGT9bp8Juh/fUKajodQVfJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500996; c=relaxed/simple;
	bh=FS2/Uhxfmp4pi9UmAvFLOif4dLZEwtBfvdCM/gWN54A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIWJjgyZBEYxsTl5kxbZ43qWvDPyUt3+aG4YRFyFHIzhZtuligGzCpLZ2EuEsMjRJtSz+KbYcszQEak12ZLcgj0sO0C+tErkht0hbKpfjZmhCaUiRcb3QECQtiR8Zz1z0MFGdp6/glsHB6fvUChawwKX0krZAShrJKQzfgq/V2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTBjJF/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6298C433C7;
	Wed, 21 Feb 2024 07:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708500995;
	bh=FS2/Uhxfmp4pi9UmAvFLOif4dLZEwtBfvdCM/gWN54A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTBjJF/ntzTFe0x0dDIBen7ED7fhL/vOXq4P4GxyMPl4AER26GX3frz4dWYxOkgBB
	 w4BTWtvNR+6JIWcSqMA3cua1Z1lmUawssAvGLI/rpltBvGAcynUiTXg8mwPcREQH6g
	 OhQmRdfTD32dpHIQksNE79kSuLGKXmmJSZc7lhZsCqjNwuztRCf39fKm5W3GP5XoMX
	 IBIdVs9adJaOyrU3Dlx7D0e1Ocrx3Mk93wjSHQfXD9ueU6R/OtJj1Zkcfr8Fi/w97v
	 SgWArjjdvKUwnDVBg5qYaXug7ufpbAacocdzkZ1ALV+IVFge2k0G4bNWlLMXBD3LWr
	 spnD9ylL7aTfA==
Date: Wed, 21 Feb 2024 08:36:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC 1/2] fs & block: remove bdev->bd_inode
Message-ID: <20240221-geruhsam-mehrfach-d6e16f03924a@brauner>
References: <20240129-vfs-bdev-file-bd_inode-v1-0-42eb9eea96cf@kernel.org>
 <20240129-vfs-bdev-file-bd_inode-v1-1-42eb9eea96cf@kernel.org>
 <8d4156dd-a65e-5baf-a297-b5c36f8c929f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d4156dd-a65e-5baf-a297-b5c36f8c929f@huaweicloud.com>

On Tue, Feb 20, 2024 at 07:57:12PM +0800, Yu Kuai wrote:
> Hi, Christian
> 
> 在 2024/01/29 18:56, Christian Brauner 写道:
> > The only user that doesn't rely on files is the block layer itself in
> > block/fops.c where we only have access to the block device. As the bdev
> > filesystem doesn't open block devices as files obviously.
> > 
> > This introduces a union into struct buffer_head and struct iomap. The
> > union encompasses both struct block_device and struct file. In both
> > cases a flag is used to differentiate whether a block device or a proper
> > file was stashed. Simple accessors bh_bdev() and iomap_bdev() are used
> > to return the block device in the really low-level functions where it's
> > needed. These are overall just a few callsites.
> 
> I just realize that your implementation for iomap and buffer_head is
> better, if you don't mind. I'll split related changes into a seperate
> patch, and send out together.

Sure!

