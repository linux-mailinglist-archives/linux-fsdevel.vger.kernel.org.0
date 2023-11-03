Return-Path: <linux-fsdevel+bounces-1898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0D7DFF44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 07:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC5F1C21012
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 06:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615F1C0F;
	Fri,  3 Nov 2023 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVkwcQSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF477E
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 06:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224E4C433C8;
	Fri,  3 Nov 2023 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698994605;
	bh=gXZtlJJO0m0VCRUln3Vut2rUuEGepVckJih3S/2TJZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVkwcQSOi67LzNjQ82OqhP+JfqEXAC3bFpVVeiukbIiusGHCmURpgA9R/PtNT0vEr
	 i3XXOwipCL+WQNk3NWSeU5Cjg6due2ukrbDWMFpkap/bRYGwfbWUPZ/4WqjdkRo0Nl
	 uYEDo8vJ7/budZ49hsOWV3ywzBeJQ11WP+W1WSciIeFdWyWTjQ2wohVaFyf32d0lfG
	 3T5Bef6svqPJf0AaBZRxydgW6Ks38GHVvKN+3R90kBgYRmRTp3GlM2CpGdlNCuPARh
	 6FO40l9XfUlsOxP1FqKmQ4H6+TZ+1sUS6MnlrPG/ES1TuINnrscZf3lxf5gDvCTK6F
	 WdB7e7KgQeoOg==
Date: Fri, 3 Nov 2023 07:56:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Christoph Hellwig <hch@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231103-wichen-shrimps-1ddd9565d6a6@brauner>
References: <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-ankurbeln-eingearbeitet-cbeb018bfedc@brauner>
 <20231102123446.GA3305034@perftesting>
 <20231102170745.GF11264@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102170745.GF11264@suse.cz>

On Thu, Nov 02, 2023 at 06:07:45PM +0100, David Sterba wrote:
> On Thu, Nov 02, 2023 at 08:34:46AM -0400, Josef Bacik wrote:
> > On Thu, Nov 02, 2023 at 10:48:35AM +0100, Christian Brauner wrote:
> > > > We'll be converted to the new mount API tho, so I suppose that's something.
> > > > Thanks,
> > > 
> > > Just in case you forgot about it. I did send a patch to convert btrfs to
> > > the new mount api in June:
> > > 
> > > https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org
> > > 
> > 
> > Yeah Daan told me about this after I had done the bulk of the work.  I
> > shamelessly stole the dup idea, I had been doing something uglier.
> > 
> > > Can I ask you to please please copy just two things from that series:
> > > 
> > > (1) Please get rid of the second filesystems type.
> > > (2) Please fix the silent remount behavior when mounting a subvolume.
> > >
> > 
> > Yeah I've gotten rid of the second file system type, the remount thing is odd,
> > I'm going to see if I can get away with not bringing that over.  I *think* it's
> > because the standard distro way of doing things is to do
> > 
> > mount -o ro,subvol=/my/root/vol /
> > mount -o rw,subvol=/my/home/vol /home
> > <boot some more>
> > mount -o remount,rw /
> > 
> > but I haven't messed with it yet to see if it breaks.  That's on the list to
> > investigate today.  Thanks,
> 
> It's a use case for distros, 0723a0473fb4 ("btrfs: allow mounting btrfs
> subvolumes with different ro/rw options"), the functionality should
> be preserved else it's a regression.

My series explicitly made sure that it _isn't_ broken. Which is pretty
obvious from the description I put in there where that example is
explained at length.

It just handles it _cleanly_ through the new mount api while retaining
the behavior through the old mount api. The details - as Josef noted -
I've explained extensively.

