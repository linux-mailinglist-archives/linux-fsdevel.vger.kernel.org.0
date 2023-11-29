Return-Path: <linux-fsdevel+bounces-4136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE867FCF25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED4F1C208C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F04101E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMS44/70"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA844383;
	Wed, 29 Nov 2023 04:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99898C433C8;
	Wed, 29 Nov 2023 04:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701233107;
	bh=P5KIJy6Y2exHU2sBw2hHySo9caDBn/4evFW6fcZ6tGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMS44/70Q76V/4GnG7szqOBDRutwRr+x1Ai8KlCniR7dhdx37t+gkbYlBXseJlswY
	 a2BTjVyCF6I0tJuQ5JyrlWaYqj/9ntu60vQcuoVxr+agRr+HcOTkkvOzHv5yLYP2si
	 kL1l/ac0B4UF8Qjqg8LruDTWVyp0N4EhEiJK1cKcxpsv+REvEB8ekvEvmUVm++gLbv
	 XdegjB1VsqTC4T8pt/zfR/pVDKnjiTY6l49lJBe2VVKWTIHPFX0f6Zd4HVLoAA+mtk
	 RrvuHuPVTRuATv+zXdHdzTDshOSXVu4wNbz5JViySd+E2g0iTySnc6zvjOVV6ZVEK3
	 tC2mv9eEeCjpw==
Date: Tue, 28 Nov 2023 20:45:06 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/13] iomap: drop the obsolete PF_MEMALLOC check in
 iomap_do_writepage
Message-ID: <20231129044506.GJ4167244@frogsfrogsfrogs>
References: <20231126124720.1249310-5-hch@lst.de>
 <875y1nsnsj.fsf@doe.com>
 <20231127064107.GA27540@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127064107.GA27540@lst.de>

On Mon, Nov 27, 2023 at 07:41:07AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 12:09:08PM +0530, Ritesh Harjani wrote:
> > Nice cleanup. As you explained, iomap_do_writepage() never gets called
> > from memory reclaim context. So it is unused code which can be removed. 
> > 
> > However, there was an instance when this WARN was hit by wrong
> > usage of PF_MEMALLOC flag [1], which was caught due to WARN_ON_ONCE.
> > 
> > [1]: https://lore.kernel.org/linux-xfs/20200309185714.42850-1-ebiggers@kernel.org/
> > 
> > Maybe we can just have a WARN_ON_ONCE() and update the comments?
> > We anyway don't require "goto redirty" anymore since we will never
> > actually get called from reclaim context.
> 
> Well, xfs/iomap never really cared about the flag, just that it didn't
> get called from direct reclaim or kswapd.  If we think such a WARN_ON
> is still useful, the only caller of it in do_writepages might be a better
> place.

I think that's a good idea, given the enormous complexity of modern day
XFS and the sometimes rough quality of others.  :P

--D

