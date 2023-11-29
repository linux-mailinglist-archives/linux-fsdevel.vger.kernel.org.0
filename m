Return-Path: <linux-fsdevel+bounces-4141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E80F7FCF31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCD71F20FD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2BD11198
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYfF7htl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF91104;
	Wed, 29 Nov 2023 04:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FB8C433C7;
	Wed, 29 Nov 2023 04:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701233638;
	bh=BfdSYc9LefJj+IX95v1/a2smE+G3XPnGpIoPmeKzwUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYfF7htldylXViay0JlYLhhHHHko0DYhvRPTycILZqO+cRK1bpBQPGR1+Bv6zRJiM
	 JvyuIBYgtR8JiPIes726HM+3FLUmk5Z7/8WcDuyEnagwK73LguQpuklgpEGX69Fxr7
	 75mO1Du6Yn4D1CBr1kBIFim5Cp4KBXyWeZAyTxpeQmJZtBRA3w7KW/dR1dZS0cKxCH
	 vmh1kQMHQfuCryomleGOfYaJt5n/JKjlhMygM6i/bH/Els7p37Bs08/nsrMw5gzZH8
	 x/No9AdCbkgeCuHrxRa+XoTfFFruG2oVQaX6acBV7SpyPO/Cztg56eceCr17hnrNMU
	 aBTt+0ZHlG1Og==
Date: Tue, 28 Nov 2023 20:53:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/13] iomap: move the iomap_sector sector calculation
 out of iomap_add_to_ioend
Message-ID: <20231129045357.GN4167244@frogsfrogsfrogs>
References: <20231126124720.1249310-9-hch@lst.de>
 <87plzvr05y.fsf@doe.com>
 <20231127135402.GA23928@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127135402.GA23928@lst.de>

On Mon, Nov 27, 2023 at 02:54:02PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 03:24:49PM +0530, Ritesh Harjani wrote:
> > >  static bool
> > > -iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
> > > -		sector_t sector)
> > > +iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset)

Can you change @offset to @pos while you're changing the function
signature?

> > Not sure which style you would like to keep in fs/iomap/.
> > Should the function name be in the same line as "static bool" or in the next line?
> > For previous function you made the function name definition in the same
> > line. Or is the naming style irrelevant for fs/iomap/?
> 
> The XFS style that iomap start out with has the separate line, and I
> actually kinda like it.  But I think willy convinced us a while ago to
> move the common line which is the normal kernel style, and most new code
> seems to use this.  And yes, I should probably be consistent and I
> should change it here as well.

I prefer xfs style, but I've been told privately to knock it off outside
xfs.  So.  Fugly kernel style with too much manual whitespace
maintenance it is. :/

--D

