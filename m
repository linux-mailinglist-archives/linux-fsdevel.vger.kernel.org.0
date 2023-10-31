Return-Path: <linux-fsdevel+bounces-1654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D6F7DD26C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDEF1C20C78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65E1DFC8;
	Tue, 31 Oct 2023 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmOCIZgu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298011DDC8
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 16:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8FCC433C7;
	Tue, 31 Oct 2023 16:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698770639;
	bh=3ihZSGpuCy0pZGpzca/totGSUjdjTTHtGxlPXQXCRCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmOCIZguruq5YCzK+179odNpzA5RUeOqu6nMPRRwspiCt/Ux7ZNeHObOyXqXd6r9F
	 Id28Rox4geUaWldKyNC1YH6amoIaNVvpaEOoVtmZlhLIwT12EMzSRXIM0N3LmeUwoz
	 LGVDG3siM/WjDIa9nZRkCB342pQmSeZjODRAZ55We94OoKB1v722Geu9h/nMglu8Rs
	 FuHs9FNM0n8vR8UT4UFk3WuSVC3kRdbs1zrAiws1y3Xnwnl02sSLXu3wWbJoT8mgSA
	 4Gm1DaS3ACPOxF2CSwH+UjePTWAcfgsZ5NN1CXKL9wL3GHm8BmpNBNVblhjQL7W2Gp
	 ZqpHMNRAzlQfw==
Date: Tue, 31 Oct 2023 09:43:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandanbabu@kernel.org>, catherine.hoang@oracle.com,
	cheng.lin130@zte.com.cn, dan.j.williams@intel.com,
	dchinner@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, osandov@fb.com, ruansy.fnst@fujitsu.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 22c2699cb068
Message-ID: <20231031164359.GA1041814@frogsfrogsfrogs>
References: <87fs1s3bk6.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231031090242.GA25889@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031090242.GA25889@lst.de>

On Tue, Oct 31, 2023 at 10:02:42AM +0100, Christoph Hellwig wrote:
> Can you also pick up:
> 
> "xfs: only remap the written blocks in xfs_reflink_end_cow_extent"
> 
> ?
> 
> Also this seems to a bit of a mix of fixes for 6.7 and big stuff that
> is too late for the merge window.

If by 'big stuff' you mean the MF_MEM_PRE_REMOVE patch, then yes, I
agree that it's too late to be changing code outside xfs.  Bumping that
to 6.8 will disappoint Shiyang, regrettably.

The patchsets for realtime units refactoring and typechecked rt-helpers
(except for the xfs_rtalloc_args thing) I'd prefer to land in 6.7 for a
few reasons.  First, the blast radii are contained to the rtalloc
subsystem of xfs.  Second, I've been testing them for nearly a year now,
I think they're ready from a QA perspective.

The third selfish reason for wanting to get the xfs realtime stuff off
my plate is that my goal for 6.8 is to try to eliminate the indirect
->iomap_begin/end calls from iomap.  It'll be helpful for me to be able
to focus exclusively on that since I'd really like your help making sure
I do the transition correctly. :)

--D

