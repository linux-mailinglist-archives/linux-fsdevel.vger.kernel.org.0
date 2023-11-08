Return-Path: <linux-fsdevel+bounces-2400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C17E5AEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 17:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236BA281164
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C2A30FAE;
	Wed,  8 Nov 2023 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4QMT3S+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A633064B;
	Wed,  8 Nov 2023 16:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6343C433C9;
	Wed,  8 Nov 2023 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699460198;
	bh=BhmN/ZS2H2B72q3/zNWEkj2AC2tw83Unk8813dgUMU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4QMT3S+v03YP8UlJK1rpRQ801YbSXiihsNTfbBIMgfL+PR7sqxspH5xWbhlpF2Q1
	 OgQkxDaZ03JESvKRb0oUWnGlcgVnjx0qXtx8p7I/55z3/8EWLxFDQxPTbx6nQZFRq6
	 N5P5D4kDh3lGuSxl5QqIdv8R5VXoqnue6s8R+qJ3QFxSKYdiMODdIqgcQrueDdZvu6
	 Am1LeApkMpP3qDAC3e8qvNYB8NT5/Elq0srp8I7DtRM9Ue1tmLTm3nFxLeQa1SRFdO
	 XEYA8vwi4EaDU9PPGhqLdULag//ejO7ZPprTEM4ee8wS2fBCJtjam90ul//fVPKP4L
	 qm0ZKiwTf/BZA==
Date: Wed, 8 Nov 2023 17:16:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231108-atemwege-polterabend-694ca7612cf8@brauner>
References: <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
 <20231107-leiden-drinnen-913c37d86f37@brauner>
 <ZUs+MkCMkTPs4EtQ@infradead.org>
 <20231108-zertreten-disqualifikation-bd170f2e8afb@brauner>
 <ZUuWSVgRT3k/hanT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUuWSVgRT3k/hanT@infradead.org>

On Wed, Nov 08, 2023 at 06:08:09AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 08, 2023 at 09:27:44AM +0100, Christian Brauner wrote:
> > > What is that flag going to buy us?
> > 
> > The initial list that Josef provided in
> > https://lore.kernel.org/linux-btrfs/20231025210654.GA2892534@perftesting
> > asks to give users a way to figure out whether a file is located on a
> > subvolume. Which I think is reasonable and there's a good chunk of
> > software out there that could really benefit from this. Now all of the
> > additional info that is requested doesn't need to live in statx(). But
> > that flag can serve as an indicator for userspace that they are on a
> > subvolume and that they can go to btrfs specific ioctls if they want to
> > figure out more details.
> 
> Well, if we want to legitimize the historic btrfs behavior the way to
> find out is if st_dev changes without that being a mount point, so
> an extra flag would be redundant.

The device number may also change on overlayfs per directory in certain
circumstances so it doesn't work in the general case.

Plus that requires a lot of gymnastics in the general case as you need
to statx() the file, call statfs() to figure out that it is a btrfs
filesystem, retrieve the device number of the superblock/filesystem and
compare that with the device number returned from stat(). And that's the
btrfs specific case. For bcachefs this doesn't work because it doesn't
seem to change st_dev.

