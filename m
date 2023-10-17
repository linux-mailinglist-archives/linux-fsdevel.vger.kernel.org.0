Return-Path: <linux-fsdevel+bounces-504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0937CB7B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 02:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08412B20FC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 00:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9E17CE;
	Tue, 17 Oct 2023 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUUuzPit"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D97A10EB
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 00:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1663C433C7;
	Tue, 17 Oct 2023 00:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697504267;
	bh=JV3a9WavpKRxzuKlWmqQJg+YqvaB3sDwZIIEHKP8u0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUUuzPit1KoxCtDPpasaR7GJ1ViDLCByCip7UH8Qe/tim4SLVGcz09pYkUWe0bHGk
	 TD4f2G9LympQs5T5ZYbV3MrpuqAkzkg0VGYKO2LqKqKZFjirbcUJL/mNhCNgh5ovIj
	 ylVntVcMw63UfOMo9wLSGg9S5jmYjkf6+x4Celobo94t+VneVjrfCjjdrG/UY8y6aV
	 JZdwBTVvMSiFXYHsjQ6YmpT3SMyXM90XRfcLqJXK/wQavkUsqeuLX9iXc/qGODnDuF
	 wJ7Wptu6UXM9nhoClw7IiIIQuvE6IVEZS3fSoWwRkr5n2dMJyBWdn+5wTIAgfPM05R
	 ZeWj+VSzwEdXw==
Date: Mon, 16 Oct 2023 17:57:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: cheng.lin130@zte.com.cn
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	david@fromorbit.com, hch@infradead.org, jiang.yong5@zte.com.cn,
	wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [RFC PATCH] fs: introduce check for drop/inc_nlink
Message-ID: <20231017005747.GB11424@frogsfrogsfrogs>
References: <20231013-tyrannisieren-umfassen-0047ab6279aa@brauner>
 <202310131740571821517@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310131740571821517@zte.com.cn>

On Fri, Oct 13, 2023 at 05:40:57PM +0800, cheng.lin130@zte.com.cn wrote:
> > On Fri, Oct 13, 2023 at 03:27:30PM +0800, cheng.lin130@zte.com.cn wrote:
> > > From: Cheng Lin <cheng.lin130@zte.com.cn>
> > >
> > > Avoid inode nlink overflow or underflow.
> > >
> > > Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > > ---
> > I'm very confused. There's no explanation why that's needed. As it
> > stands it's not possible to provide a useful review.
> > I'm not saying it's wrong. I just don't understand why and even if this
> > should please show up in the commit message.
> In an xfs issue, there was an nlink underflow of a directory inode. There
> is a key information in the kernel messages, that is the WARN_ON from
> drop_nlink(). However, VFS did not prevent the underflow. I'm not sure
> if this behavior is inadvertent or specifically designed. As an abnormal
> situation, perhaps prohibiting nlink overflow or underflow is a better way
> to handle it.
> Request for your comment.

I was trying to steer you towards modifying vfs_rmdir and vfs_unlink to
check that i_nlink of the files involved aren't somehow already zero
and returning -EFSCORRUPTED if they are.  Not messing around with
drop_nlink.

--D

