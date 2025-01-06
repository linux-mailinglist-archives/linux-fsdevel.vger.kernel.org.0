Return-Path: <linux-fsdevel+bounces-38461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B97A02F04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8728163A46
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BB51DF27D;
	Mon,  6 Jan 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHpYgHb2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DC1DE8AB;
	Mon,  6 Jan 2025 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184694; cv=none; b=n7S+GWiSuF19BHEupEZQqQ6DRG8mwlBiHWMZAhNzrE0r49qv/eIXx11ooARdMiE5YcDH5DZIi09qdduh/buW13xVXMRl8uSRXWZN3XWoH3bM0IbBDBV/4GLUJeUPMTMoylfn5GhGgCZxOxPNYOPwSvoS6t7jMc3fi4nXr2WBQMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184694; c=relaxed/simple;
	bh=ccxKpThYwftMaNS5q2OIMIsDzP9bXnLAp2NVg6GoyWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3x6I7EgdHF4k5MkgSuFuAHLIn281ug9qaQlqB+jncbwfzn2I0BmsqNcz5LNMbo8+qlQx7MgNxY7NQ3/s2GaqLjaR357nDR35E5+I5XyI8FWBBjwA73pzahjTL2+TIxTrNgguhRl4KFqdK5FCTfkl8HqlAT4PHr/c1Lx4uhL1Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHpYgHb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C303AC4CED2;
	Mon,  6 Jan 2025 17:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736184693;
	bh=ccxKpThYwftMaNS5q2OIMIsDzP9bXnLAp2NVg6GoyWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHpYgHb2PDqsq6mCMcw8u0WT8RybObwjopiG3NTN4nKuXHT8jL9UqLwH2HWFEVzvA
	 Bpub1uzrmUCRUrWbiyAp8gB775WTOW9hzSFt5DxyCHrdxgIDuKzyNer68dBw4EsCR8
	 /lM+e1rkZlzhcDGvos3JLRY0yWbZmqUegDf1/L3VDF8HElSMhE6EDbC6jt3Mf1N2MN
	 DTt7sRVQWTTLGSZPlTNJuachN0RQ60Lf52cbVb9LU2rpax9lrvnbCV3j1TphU5ROk+
	 jyWUyINucDgzepmaw4u+mG3hNRZZB+KuyDRiUZE0Ojr/Rom/HZ40jJzJbFc239nUEf
	 R6WTpo2Tww1uA==
Date: Mon, 6 Jan 2025 09:31:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Zhang Yi <yi.zhang@huaweicloud.com>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, adilger.kernel@dilger.ca,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com, Sai Chaitanya Mitta <mittachaitu@gmail.com>,
	linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fs: introduce FALLOC_FL_FORCE_ZERO to fallocate
Message-ID: <20250106173133.GB6174@frogsfrogsfrogs>
References: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
 <20241228014522.2395187-2-yi.zhang@huaweicloud.com>
 <Z3u-OCX86j-q7JXo@infradead.org>
 <20250106161732.GG1284777@mit.edu>
 <Z3wEhXakqrW4i3UC@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3wEhXakqrW4i3UC@infradead.org>

On Mon, Jan 06, 2025 at 08:27:49AM -0800, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 11:17:32AM -0500, Theodore Ts'o wrote:
> > Yes.  And we might decide that it should be done using some kind of
> > ioctl, such as BLKDISCARD, as opposed to a new fallocate operation,
> > since it really isn't a filesystem metadata operation, just as
> > BLKDISARD isn't.  The other side of the argument is that ioctls are
> > ugly, and maybe all new such operations should be plumbed through via
> > fallocate as opposed to adding a new ioctl.  I don't have strong
> > feelings on this, although I *do* belive that whatever interface we
> > use, whether it be fallocate or ioctl, it should be supported by block
> > devices and files in a file system, to make life easier for those
> > databases that want to support running on a raw block device (for
> > full-page advertisements on the back cover of the Businessweek
> > magazine) or on files (which is how 99.9% of all real-world users
> > actually run enterprise databases.  :-)
> 
> If you want the operation to work for files it needs to be routed
> through the file system as otherwise you can't make it actually
> work coherently.  While you could add a new ioctl that works on a
> file fallocate seems like a much better interface.  Supporting it
> on a block device is trivial, as it can mostly (or even entirely
> depending on the exact definition of the interface) reuse the existing
> zero range / punch hole code.

I think we should wire it up as a new FALLOC_FL_WRITE_ZEROES mode,
document very vigorously that it exists to facilitate pure overwrites
(specifically that it returns EOPNOTSUPP for always-cow files), and not
add more ioctls.

(That said, doesn't BLKZEROOUT already do this for bdevs?)

--D

