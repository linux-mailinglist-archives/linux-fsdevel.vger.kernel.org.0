Return-Path: <linux-fsdevel+bounces-7529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F815826CE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E8B1F225FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 11:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6AA1429E;
	Mon,  8 Jan 2024 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCg2/2lR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B925750;
	Mon,  8 Jan 2024 11:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3506C433C9;
	Mon,  8 Jan 2024 11:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704713646;
	bh=CLnYAtBRHdjo0Zg362aLZMLin+3s39VP07FYq7cQ8k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCg2/2lRND+/Gv8bD3MUPHzssTJXloprgf4cms+J68fH/8pwuy2nUYxeMLVdn2/Cg
	 4leuP7GdcrWUquF4nFR0hV12wkLlGHmHhefKHo5GcejB6ZDFKG8nYrzYMhe1LjL6Ge
	 7FGc7aEYuBgnt+OqYip0cLSYB8IzJOarCjMOvsKcI9ydA1irB5dND3oWVOXTRNYPhm
	 pHVKZduukyoorOGLW7qgLs3O2rjuT1Ii9W4Eszm0os4IBscjfbvBSHw5A+eiN6w/9x
	 dkxQ3Ui8QrS7XRz2hH75sGc6Y66sDm8SdrVMKiTqGwMxP0hCzfp7x3bJDtOPraair+
	 hqIVGHvVW0EqA==
Date: Mon, 8 Jan 2024 12:34:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 01/34] bdev: open block device as files
Message-ID: <20240108-haltmachen-fallpauschalen-67eb3941c1cd@brauner>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-1-6c8ee55fb6ef@kernel.org>
 <ZZuKLRpFr9pVZ2pa@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZuKLRpFr9pVZ2pa@dread.disaster.area>

On Mon, Jan 08, 2024 at 04:37:49PM +1100, Dave Chinner wrote:
> On Wed, Jan 03, 2024 at 01:54:59PM +0100, Christian Brauner wrote:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 8e0d77f9464e..b0a5e94e8c3a 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1227,8 +1227,8 @@ struct super_block {
> >  #endif
> >  	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
> >  	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
> > -	struct block_device	*s_bdev;
> > -	struct bdev_handle	*s_bdev_handle;
> > +	struct block_device	*s_bdev;	/* can go away once we use an accessor for @s_f_bdev */
> > +	struct file		*s_f_bdev;
> 
> 	struct file		*s_bdev_file;
> 
> Because then the reader knows exactly what the object type
> and what it refers to is when they read "sb->s_bdev_file" in the
> code.

Fair!

