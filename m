Return-Path: <linux-fsdevel+bounces-2068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 259497E1F0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A64B20E3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E8F18046;
	Mon,  6 Nov 2023 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI/SuAX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A347318035
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 10:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AD5C433C8;
	Mon,  6 Nov 2023 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699268367;
	bh=Zcz8isnEaoq9DvnDd7s+Wc4LLet3BGYrAiwVdwrYkDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cI/SuAX74liNBUq15FRz3SghmO1rmjBrjTvpZuzDnNrtxo1ubog3ZiMhP74IbHdBM
	 i/ArshxqqhLMmBNFaKUZ5CbFefcIyXOBXg5N6tb6ecTNqyYr7b8V5Ko5nvas9hT9Ww
	 o/GiD1nJGGTEF/7yROlVtBWI2Jblc5Gcc+0dkjeH7H+OMPUA8Gy2l0vvv+D9xgkJU8
	 ucj+IANIj6XSe/gPMXao5CYWxp4P1SnUicEUjV1uOmwgu4wqvV/52O8xB8hah31yg0
	 jfl3kDzEtnBjMM6KP3OvWixvzp6mEFqpNptpTEZ8h6xRt5XE0AfTzzEf6D0yYwWnRf
	 pKcuNGl4J6DOg==
Date: Mon, 6 Nov 2023 11:59:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231106-postfach-erhoffen-9a247559e10d@brauner>
References: <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>

> > They
> > all know that btrfs subvolumes are special. They will need to know that
> > btrfs subvolumes are special in the future even if they were vfsmounts.
> > They would likely end up with another kind of confusion because suddenly
> > vfsmounts have device numbers that aren't associated with the superblock
> > that vfsmount belongs to.
> 
> This looks like you are asking user space programs (especially legacy
> ones) to do special handling for btrfs, which I don't believe is the
> standard way.

I think spending time engaging this claim isn't worth it. This is just
easily falsifiable via a simple grep for btrfs in systemd, lxc, runc,
util-linux.

And yes, I'm definitely asking userspace to change behavior if they want
to retrieve additional information about btrfs subvolumes. We're
exposing a new api.

You get the same problem if you make subvolumes vfsmounts. Userspace
will have to adapt anyway. New APIs don't come for free and especially
not ones that suddenly pop 10 vfsmounts into your mountinfo during a
simple lookup operation.

> 
> > 
> > So nothing is really solved by vfsmounts either. The only thing that we
> > achieved is that we somehow accommodated that st_dev hack. And that I
> > consider nakable.
> 
> I think this is the problem.
> 
> If we keep the existing behavior, at least old programs won't complain
> and we're still POSIX compatible, but limited number of subvolumes
> (which can be more or less worked around, and is there for a while).
> 
> If we change the st_dev, firstly to what value? All the same for the
> same btrfs? Then a big behavior break.
> 
> It's really a compatibility problem, and it would take a long time to
> find a acceptable compromise, but never a sudden change.

This is a mischaracterization. And I'm repeating from my last mail,
st_dev wouldn't need to change. You can keep doing what you're doing
right now if you want to. We're talking about a new api to allow
differentiating subvolumes that is purely opt-in through statx().

> You can of course complain about the vision that one fs should report
> the same st_dev no matter what, but my counter argument is, for
> subvolume it's really a different tree for each one, and btrfs is
> combining the PV/VG/LV into one layer.
> 
> Thus either we go treat subvolumes as LVs, thus they would have
> different devices numbers from each other. (just like what we do for
> now, and still what I believe we should go)
> 
> Or we treat it as a VG, which should still a different device number
> from all the PVs. (A made-up device id, but shared between all
> subvolumes, and break up the existing behavior)
> 
> But never treating a btrfs as a PV, because that makes no sense.

Whatever this paragraph is supposed to tell me I don't get it.

You are reporting a single st_dev for every single btrfs mount right now
including bind mounts in mountinfo.

What you're asking is to make each subvolume a vfsmount and then showing
these vfsmounts in mountinfo and reporting made up device numbers for
that vfsmount. Which is a massive uapi change.

