Return-Path: <linux-fsdevel+bounces-5705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E61C80F011
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153DE1F21580
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672475433;
	Tue, 12 Dec 2023 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8lAcSDS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F775403;
	Tue, 12 Dec 2023 15:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B635BC433C8;
	Tue, 12 Dec 2023 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702394678;
	bh=pkdBqV21b4Rfh/sUCZdEfLUL98HZquCTqxlPZhn+Osk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8lAcSDSqXLnp9J6sCXrdO5TxFpG4jjPrautjBO8odwGvYNgVxr+oFMkhVCZknFAS
	 L8MROPHcjijzWytZ5SDc989QsSGAMgWiWZIZTtHGMnG5vVoEGP6DePOT/i+UnJA3iK
	 oSOr8vuxGuJMdLR1RBjl3WmsQ1MLd8b/Qc+wFu+BQIZrGtZuAymBB1eVG23m+Zvu0X
	 h8sEtvVUXT6IWlsVcxoPIAFbLddgvj2Ew6EP2C1i+ZwzxcJ45O+p1H2J1rW2V8BCl1
	 n/oqCkLEYZeMd1mGAQloBOzKRFO1easG16/35IJtCSRqcFeyJnpnH3xcH5pOvG4HrR
	 tK2x93mz191JQ==
Date: Tue, 12 Dec 2023 16:24:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212-untiefen-leihwagen-ca303230fc4e@brauner>
References: <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <2810685.1702372247@warthog.procyon.org.uk>
 <20231212-ablauf-achtbar-ae6e5b15b057@brauner>
 <CAJfpegvL9kV+06v2W+5LbUk0eZr1ydfT1v0P-Pp_KexLNz=Lfg@mail.gmail.com>
 <20231212-sechzehn-hausgemacht-6eb61150554e@brauner>
 <CAJfpegshsEWtm-dcdUy2w9_ic0Ag7GXpA2yRWGR+LD2T37odGQ@mail.gmail.com>
 <20231212-kahlschlag-abtropfen-51dc89b9ac11@brauner>
 <CAJfpegu3uwAjMQd2jrBty0Lx-oHOczF0x6xNkyqcT4MBqyJo7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegu3uwAjMQd2jrBty0Lx-oHOczF0x6xNkyqcT4MBqyJo7Q@mail.gmail.com>

On Tue, Dec 12, 2023 at 03:06:07PM +0100, Miklos Szeredi wrote:
> On Tue, 12 Dec 2023 at 14:48, Christian Brauner <brauner@kernel.org> wrote:
> 
> > Exposing the subvolume id in statx() is still fine imho. It's a concept
> > shared between btrfs and bcachefs and it's pretty useful for interested
> > userspace that wants to make use of these apis.
> 
> Exposing subvolume ID should be okay, as long as it's not advertised
> as a way to uniquely identify an inode.   Its use should be limited to
> finding subvolume boundaries.
> 
> > > It might help to have the fh in statx, since that's easier on the
> > > userspace programmer than having to deal with two interfaces (i_ino
> > > won't go away for some time, because of backward compatibility).
> > > OTOH I also don't like the way it would need to be shoehorned into
> > > statx.
> >
> > No, it really doesn't belong into statx().
> >
> > And besides, the file handle apis name_to_handle_at() are already
> > in wider use than a lot of people think. Not just for the exportfs case
> > but also for example, cgroupfs uses file handles to provide unique
> > identifiers for cgroups that can be compared.
> 
> The issue with name_to_handle_at() is its use of the old, non-unique
> mount ID.  Yes, yes, we can get away with
> 
>  fd = openat(dfd, path, O_PATH);
>  name_to_handle_at(fd, "", ..., AT_EMPTY_PATH);
>  statx(fd, "", AT_EMPTY_PATH, STATX_MNT_ID_UNIQUE, ...);
>  close(fd);
> 
> But that's *four* syscalls instead of one...

Yeah, but putting this into statx() isn't really nice imho. Once we do
actually land the unique mount id thing it wouldn't be the worst thing
to add name_to_handle_at2().

