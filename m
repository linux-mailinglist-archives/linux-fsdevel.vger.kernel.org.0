Return-Path: <linux-fsdevel+bounces-2399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3E87E5AA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 16:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30769B21058
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EBF30667;
	Wed,  8 Nov 2023 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWyBA36T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CEF30651;
	Wed,  8 Nov 2023 15:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C701C433C7;
	Wed,  8 Nov 2023 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699459040;
	bh=iYcdDrwGZIXTAONW3HA38AN1OAfVmfdONkC6/IZR0R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWyBA36Tw9XenNvu4bzYDPGIqMz/9Hv1seEMZ209CGC3nMVZ8yhEQAFN8YZNukDgC
	 Rqpix33KfrClaxXOtU3pcoJZea1p024Pse6qpqCPlkLsiDvU01dn8ctZzmwJFY/6J9
	 hrFwk+HbienAVs8jgInhD+YsvV9rI81XBmHDJMQ2Ss4Md1sbU4gcBo2LCEABPSvwjZ
	 r4Cip6ZuPyFUI9ui7NlMd4iTOaTXaFPXHbA0i2zarZbqvTJvHQMFPPUWMzmw6Bax1g
	 DxxnbA9tCFY9LAN2RJYJkbfDXLsHTGYAvh3nGDbfAOGtR0nWC0t6jJH4thCsQtPyOf
	 iA+vp8svUqi9A==
Date: Wed, 8 Nov 2023 16:57:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231108-monopol-knabe-60a4fcdc4e9a@brauner>
References: <20231106-postfach-erhoffen-9a247559e10d@brauner>
 <ZUjcgU9ItPg/foNB@infradead.org>
 <20231106-datei-filzstift-c62abf899f8f@brauner>
 <ZUkeBM1sik1daE1N@infradead.org>
 <20231107-herde-konsens-7ee4644e8139@brauner>
 <ZUs/Ja35dwo5i2e1@infradead.org>
 <20231108-labil-holzplatten-bba8180011b4@brauner>
 <ZUtC9Bw70LBFcSO+@infradead.org>
 <20231108-regimekritisch-herstellen-bdd5e3a4d60a@brauner>
 <ZUuWDv1dQ+dlSd93@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUuWDv1dQ+dlSd93@infradead.org>

On Wed, Nov 08, 2023 at 06:07:10AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 08, 2023 at 09:22:33AM +0100, Christian Brauner wrote:
> > > 	/mnt/1/foo to /mnt/2/bar will get your dev 8 for /mnt/2/bar
> > > 
> > > So the device number changes at the mount point here, bind mount or not.
> > 
> > Yes, I know. But /mnt/2/ will have the device number of the
> > superblock/filesystem it belongs to and so will /mnt/1. Creating a
> > bind-mount won't suddenly change the device number and decoupling it
> > from the superblock it is a bind-mount of.
> 
> It doesn't any more then just changing st_dev.  But at least it aligns
> to the boundary that such a change always aligned to in not just Linux
> but most (if not all?) Unix variants and thus where it is expected.

I'm not parsing that sentence fully tbh. But the point stands that this
alters how mountinfo works. bind-mounts don't deviate from the device
number of the superblock they belong to and there's no reason to tie
that st_dev change in stat() that is btrfs specific to vfsmounts. That's
not going to happen and has been rejected before.

And that is on top of all other problems with making subvolumes
automounted vfsmounts that were outlined.

