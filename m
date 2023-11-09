Return-Path: <linux-fsdevel+bounces-2595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 754F27E6F47
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A638A1C20B11
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB5822324;
	Thu,  9 Nov 2023 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3+xz+5u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1013AE3
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 16:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D44C433C9;
	Thu,  9 Nov 2023 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699547936;
	bh=bkdMTVjQse1cJXkwlSeNrJqtIRuV61o2Whlzq2oeE+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3+xz+5ul0Jj/Lh+TRvXzZR8fl7Joi2xybHVBz4kCxHVi+cadXR+dkOb9l0F8oHPg
	 1CWv/fBoCE8eEcggDkvQkvkQ/BzLIdU+WpSu58xtqMcqsOPMwwALpuqvioF2XW9+m5
	 xwXyEqSKGC6JRQQx1ha+OqR0KH6qXJ2vMbkWwquYCfdHbS3F7PAvbg8dekjKVQ5qzQ
	 xtsLzcSZvEBw3k7+uYsjhSueqDHAcryd+pu9rDLJY6OiUglInF0uiXRu1oyFFeCTnT
	 84t1/97BMtaGROE8TDNHdE3p/3LYjjaRUVYaOnl7IYlx2TZOqF+6ppVHAulv594EG2
	 z6QR36lGul8dw==
Date: Thu, 9 Nov 2023 08:38:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>, catherine.hoang@oracle.com,
	cheng.lin130@zte.com.cn, dchinner@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	osandov@fb.com
Subject: Re: [GIT PULL] xfs: new code for 6.7
Message-ID: <20231109163856.GG1205143@frogsfrogsfrogs>
References: <87fs1g1rac.fsf@debian-BULLSEYE-live-builder-AMD64>
 <CAHk-=wj3oM3d-Hw2vvxys3KCZ9De+gBN7Gxr2jf96OTisL9udw@mail.gmail.com>
 <20231108225200.GY1205143@frogsfrogsfrogs>
 <20231109045150.GB28458@lst.de>
 <20231109073945.GE1205143@frogsfrogsfrogs>
 <20231109144614.GA31340@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109144614.GA31340@lst.de>

On Thu, Nov 09, 2023 at 03:46:14PM +0100, Christoph Hellwig wrote:
> On Wed, Nov 08, 2023 at 11:39:45PM -0800, Darrick J. Wong wrote:
> > Dave and I started looking at this too, and came up with: For rtgroups
> > filesystems, what if rtpick simply rotored the rtgroups?  And what if we
> > didn't bother persisting the rotor value, which would make this casting
> > nightmare go away in the long run.  It's not like we persist the agi
> > rotors.
> 
> Yep.  We should still fix the cast and replace it with a proper union
> or other means for pre-RTG file systems given that they will be around
> for while.

<nod> Linus' fixup stuffs the seq value in tv_sec.  That's not great
since the inode writeout code then truncates the upper 32 bits, but
that's what the kernel has been doing for 5+ years now.

Dave suggested that we might restore the pre-4.6 behavior by explicitly
encoding what we used to do:

	inode->i_atime.tv_sec = seq & 0xFFFFFFFF;
	inode->i_atime.tv_nsec = seq >> 32;

(There's a helper in 6.7 for this, apparently.)

But then I pointed out that the entire rtpick sequence counter thing
merely provides a *starting point* for rtbitmap searches.  So it's not
like garbled values result in metadata inconsistency.  IOWs, it's
apparently benign.

IOWs, how much does anyone care about improving on Linus' fixup?

--D

