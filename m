Return-Path: <linux-fsdevel+bounces-20645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9828D65B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 17:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91935282B5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358EE770FF;
	Fri, 31 May 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UF+2dzDh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902AB33080;
	Fri, 31 May 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169363; cv=none; b=JVeSrP5J03IoYApssbR4pyJCPiOs7sSkjRkscc9eqkciBcsY/QZ/0OZEbxCrzDIVcLI1FH1YIxgJC7pwS1fEFWxWrPZX2DZltROw84ZpDy78JtbtTnDxHEz6KUDCIMdWu6zBxPUge5vyLKiCVWSCJr6FaH5R7o/hJlPOk56+f/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169363; c=relaxed/simple;
	bh=vGdGcvG/usBANOA8rI6HjNUXFa+3GSenghMlRYfsdgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOmr+leAS3krXSHLhQryUSfbPQUejdVtVj4u4rf9wq1oaOAJyLn6PxeOdVcgfwdkEeplbBe6+bf996DpC+TqBrzKUJdfeyEdohr0XdalcfW4xe0vDxTXnye2fHH7XqJey8Is+PQJaEvFqM39BkF1UQNKuQrUP04Nm4jdLuOanPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UF+2dzDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122DFC116B1;
	Fri, 31 May 2024 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717169363;
	bh=vGdGcvG/usBANOA8rI6HjNUXFa+3GSenghMlRYfsdgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UF+2dzDh6UpZmUspof8Y3Y11pjEkOJ4u4k3fnlpwD6csQFbUlRc+YOwzDBNfgjQ0Y
	 6y6UArHPAvnIA+M8dgy8aB4CBagR2BPX9DLzaP0cG/KuYMztdP+qIv5RQ/q3nzGyVt
	 l5s1afe35RsHc6Mq7c9F2kqWJs23LDOQNT1y/FNxXgWcdpipHTxVWBjfsA0b3iueuF
	 /WHKa8NytnhvEHZDmFgPxMa6azgFXgLT7DgNDpvIppfmCorcFwSkPVjtUDuhe4y1K1
	 8oKOV2eU+WtmkkMx1hy/gZ1DY+sYyerAhamQf0sGVWzRKWGOUWnZEWghbiccyg8MlV
	 stx36vE4Oz9vw==
Date: Fri, 31 May 2024 08:29:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 7/8] xfs: reserve blocks for truncating realtime
 inode
Message-ID: <20240531152922.GN52987@frogsfrogsfrogs>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-8-yi.zhang@huaweicloud.com>
 <ZlnFvWsvfrR1HBZW@infradead.org>
 <20240531141000.GH52987@frogsfrogsfrogs>
 <Zlna8S76sbj-6ItP@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zlna8S76sbj-6ItP@infradead.org>

On Fri, May 31, 2024 at 07:13:05AM -0700, Christoph Hellwig wrote:
> On Fri, May 31, 2024 at 07:10:00AM -0700, Darrick J. Wong wrote:
> > On Fri, May 31, 2024 at 05:42:37AM -0700, Christoph Hellwig wrote:
> > > > -	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> > > > +	resblks = XFS_IS_REALTIME_INODE(ip) ? XFS_DIOSTRAT_SPACE_RES(mp, 0) : 0;
> > > 
> > > This probably wants a comment explaining that we need the block
> > > reservation for bmap btree block allocations / splits that can happen
> > > because we can split a written extent into one written and one
> > > unwritten, while for the data fork we'll always just shorten or
> > > remove extents.
> > 
> > "for the data fork"? <confused>
> > 
> > This always runs on the data fork.  Did you mean "for files with alloc
> > unit > 1 fsblock"?
> 
> Sorry, it was meant to say for the data device.  My whole journey
> to check if this could get called for the attr fork twisted my mind.

I really hope not -- all writes to the attr fork have known sizes at
syscall time, and appending doesn't even make sense.

> But you have a good point that even for the rt device we only need
> the reservation for an rtextsize > 1.

<nod>

--D

