Return-Path: <linux-fsdevel+bounces-18050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA29B8B504D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 06:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38006B22576
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 04:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2331ED26D;
	Mon, 29 Apr 2024 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4k5UAY5J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F02C9E;
	Mon, 29 Apr 2024 04:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365622; cv=none; b=bksWjzpHKu4+V07desNAj4PGtBLvSimNX5Gta4rOWo8QF/JNwkL8PnyNmp2iNBAGCR1Yvexsiz1ktAiqsroqHGkIekyDzlbAU9w1ERc4Ujgi3OB3ISz9AciIO4yQ5FJliHk0y706BvVArkJ0lD9rzNJ+UllOpjbXziwfycQ/yDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365622; c=relaxed/simple;
	bh=Y3Yw4fqjgMfx5qt0BxUNSBzAYTKoCa7xwgWrGN8ZRHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTJhwaqb0yyeoWlAL49NXEIUpGnvhN5+0i81kTeDAb2WCFB999WPc/5jLmAkBzDXiJYdSX3wj7TLQAxl+zC1uZXV28g+X4W+1tjDOl9rfWfkZFm84mcdTNAvCNLl7rlV1NrFkLfMZfEV7xWGyseJbM3WQkLi+vdpmr9nc1ZGVAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4k5UAY5J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DElu1HvIyaA3nI0Xb23ShaONautF5mIMDWu29gQbPi0=; b=4k5UAY5Jzfz3S+tN7NCALEjg13
	kBc/lnwuF6G8ZTTptTdmF0PHldWt27CDW3mj1G/7qWSSvUHHrba3FeuAiP1Hz0wTfAZxN3Wn7O2yb
	yLITyU49tjUy8FxagDp/ojJq0Wyq8LZJ3DGahdEhjAbluGiJho4DF608NnpDCm9QIWWgqkU+Eq8g0
	Cam+0HbFK1ITEEFrEeksp5aBf3P3we3dzAmYUEpoWptTSUBSgh/McHQrL9mMrKYN5yb5bCNzaWTgA
	/JtfeT0anK4y8aaZs3DtPWFUv5+c5CGfA8XlG8PDNaPvDg4+rINkI/eDhtxvTGdFGZCVk2S1RMIbZ
	lkU6G9ow==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1IoO-00000001R8T-0LHY;
	Mon, 29 Apr 2024 04:40:20 +0000
Date: Sun, 28 Apr 2024 21:40:20 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, p.raghav@samsung.com, da.gomez@samsung.com,
	hare@suse.de, john.g.garry@oracle.com, ziy@nvidia.com,
	linux-xfs@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC] fstests: add fsstress + writeback + debugfs folio split
 test
Message-ID: <Zi8ktG914Oc5_bl1@bombadil.infradead.org>
References: <20240424224649.1494092-1-mcgrof@kernel.org>
 <20240425053150.tx7pdosbfv5adat6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425053150.tx7pdosbfv5adat6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Apr 25, 2024 at 01:31:50PM +0800, Zorro Lang wrote:
> On Wed, Apr 24, 2024 at 03:46:48PM -0700, Luis Chamberlain wrote:
> > This is dangerous at the moment as its using
> > a debugfs API which requires two out of tree fixes [0] [1] which will
> > be posted shortly.
> I can't find "boot_params" in /sys/kernel/debug/. So we might need to
> fix this helper, and then call it in debugfs related test cases.
> 
> I'll send another patch to talk about that fix. For this case, it needs
> _require_debugfs and $DEBUGFS_MNT.

Sure I'll wait until you send patches to fix this.

> > +_begin_fstest long_rw stress soak smoketest dangerous_fuzzers
> 
> Just double check, is it a dangerous_fuzzers test, and not good to be in auto group?

Yes for the explanation quoted above from the commit log, today the
existing code requires fixes which I just posted. The sscanf bug is also
hard to reproduce but I manged to reproduce it so this simple fix is
still being discussed. So for now only those in the know of what they
are doing should run this test.

> > +blocksize=$(_get_file_block_size $SCRATCH_MNT)
> > +export XFS_DIO_MIN=$((blocksize * 2))
> 
> Oh, I even forgot we have this parameter in fsstress.c :)

Yes, but its not well documented for good reason too, its only for DIO.

> > +test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
> > +
> > +# Our general goal here is to race with ops which can stress folio addition,
> > +# removal, edits, and writeback.
> > +
> > +# zero frequencies for write ops to minimize writeback
> > +fsstress_args+=(-R)
> 
> But you set "fsstress_args=(-w -d $SCRATCH_MNT/test -n $nr_ops -p $nr_cpus)" above,
> so you zeros frequencies of non-write operations (-w) and then zeros frequencies of
> write operations (-R). Do you want to use "-z" directly, to zeros frequencies of
> all operations ?

You know, it took a whileto figure out the right values here but I've
done more experimentation and we can just go with the defaults, what we
also needed is to add compaction so to help reproduce the real crash I
was trying to aim for. Now its cooked up.

For now I'll just post a v2 RFC and leave the cleanup stuff you've
requested for a v3. Right now this is just useful for folks who want
to help debug truncation + writeback + compaction races we are
uncovering with min order.

  Luis

