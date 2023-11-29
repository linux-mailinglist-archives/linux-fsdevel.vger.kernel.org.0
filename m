Return-Path: <linux-fsdevel+bounces-4134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEAB7FCF22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D33D1C208DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBC6101F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3ZZaNjB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376AF1104;
	Wed, 29 Nov 2023 04:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE71C433C7;
	Wed, 29 Nov 2023 04:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701232857;
	bh=8aibfFFTQeG/01SBzpF/B1KFiEUCMpRv7kkx1JWsmeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3ZZaNjBMixlBK8v4pyC1a5DVsr0u/wixKNjBeOed2V4xwQAAb7PBT/X2I/GzO41o
	 lphqd5kGIHhLIMQpfD9e/ZgUxUGlEPGbHPYLKZp7sPj78ptWYYYlukrNYbT8UPu9Bp
	 1cp6McAK+D9sK0wDJQZ1BNS2nHSicUmS95begegGN1RSNx+dz2Iy3wjGoOqHDRShHx
	 C4S1vIcKopHygYB7yuenZ+o7aLb72098dPmZUHVJmo9wEvw/uLEkc3E6A5Bws3tolm
	 iWMm2lGKCnXk4Fc/WmEnO2wut2wOMxU7ms7r5eSz6LXGCMtbVIJeuDzboIXgst5hAi
	 xwHV1vdgno4hw==
Date: Tue, 28 Nov 2023 20:40:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/13] iomap: treat inline data in iomap_writepage_map as
 an I/O error
Message-ID: <20231129044057.GH4167244@frogsfrogsfrogs>
References: <20231126124720.1249310-3-hch@lst.de>
 <87bkbfssb8.fsf@doe.com>
 <20231127063325.GB27241@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127063325.GB27241@lst.de>

On Mon, Nov 27, 2023 at 07:33:25AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 10:31:31AM +0530, Ritesh Harjani wrote:
> > The code change looks very obvious. But sorry that I have some queries
> > which I would like to clarify - 
> > 
> > The dirty page we are trying to write can always belong to the dirty
> > inode with inline data in it right? 
> 
> Yes.
> 
> > So it is then the FS responsibility to un-inline the inode in the
> > ->map_blocks call is it?
> 
> I think they way it currently works for gfs2 is that writeback from the
> page cache never goes back into the inline area.  
> 
> If we ever have a need to actually write back inline data we could
> change this code to support it, but right now I just want to make the
> assert more consistent.

Question: Do we even /want/ writeback to be initiating transactions
to log the inline data?  I suppose for ext4/jbd2 that would be the least
inefficient time to do that.

--D

