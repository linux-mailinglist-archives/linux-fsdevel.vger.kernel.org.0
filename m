Return-Path: <linux-fsdevel+bounces-1679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B4F7DD926
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 00:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A45B20FF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 23:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576B527468;
	Tue, 31 Oct 2023 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWVsN5tO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10AC12E4A
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F876C433C7;
	Tue, 31 Oct 2023 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698793971;
	bh=HUHN15gYL1zUQAZ/9kbQyYuReBV1adG4NcrFQI5O1EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UWVsN5tO54rx3f5rm/2Q31gDwhbSjKfQC6V5qBLtEVr4Rwpj7I7yMkvepTMR/lTtT
	 VZqTAW/Ni44oDy4DxIjDO6jVJnB3XhJ1iXh/jS/mwEM6mkBwXfzeYhmhhzk0O3GH1C
	 FpD5ET6CpsJs564xQRPuK4enmdSn0K5L9FR73kX/HjPNJDmk0zU7wpeb5rhu5lYajK
	 tqce7Z3t64Zk3H+3LHPpkEK22xLM57Jc8HFHfmu9721nBL0Xsq/svRRP9VsvB3XdNt
	 WDyDN0dl8KXCOPtrduLbhpDz2EwAI3OEgEsUZRP0GYvAfodXBg89A0KEIH+Eygdi1J
	 T4yRHuxrW0+lQ==
Date: Tue, 31 Oct 2023 16:12:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <20231031231250.GA1205221@frogsfrogsfrogs>
References: <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
 <ZTjMRRqmlJ+fTys2@dread.disaster.area>
 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area>
 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area>
 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
 <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>

On Tue, Oct 31, 2023 at 09:03:57AM +0200, Amir Goldstein wrote:
> On Tue, Oct 31, 2023 at 3:42 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> [...]
> > .... and what is annoying is that that the new i_version just a
> > glorified ctime change counter. What we should be fixing is ctime -
> > integrating this change counting into ctime would allow us to make
> > i_version go away entirely. i.e. We don't need a persistent ctime
> > change counter if the ctime has sufficient resolution or persistent
> > encoding that it does not need an external persistent change
> > counter.
> >
> > That was reasoning behind the multi-grain timestamps. While the mgts
> > implementation was flawed, the reasoning behind it certainly isn't.
> > We should be trying to get rid of i_version by integrating it into
> > ctime updates, not arguing how atime vs i_version should work.
> >
> > > So I don't think the issue here is "i_version" per se. I think in a
> > > vacuum, the best option of i_version is pretty obvious.  But if you
> > > want i_version to track di_changecount, *then* you end up with that
> > > situation where the persistence of atime matters, and i_version needs
> > > to update whenever a (persistent) atime update happens.
> >
> > Yet I don't want i_version to track di_changecount.
> >
> > I want to *stop supporting i_version altogether* in XFS.
> >
> > I want i_version as filesystem internal metadata to die completely.
> >
> > I don't want to change the on disk format to add a new i_version
> > field because we'll be straight back in this same siutation when the
> > next i_version bug is found and semantics get changed yet again.
> >
> > Hence if we can encode the necessary change attributes into ctime,
> > we can drop VFS i_version support altogether.  Then the "atime bumps
> > i_version" problem also goes away because then we *don't use
> > i_version*.
> >
> > But if we can't get the VFS to do this with ctime, at least we have
> > the abstractions available to us (i.e. timestamp granularity and
> > statx change cookie) to allow XFS to implement this sort of
> > ctime-with-integrated-change-counter internally to the filesystem
> > and be able to drop i_version support....
> >
> 
> I don't know if it was mentioned before in one of the many threads,
> but there is another benefit of ctime-with-integrated-change-counter
> approach - it is the ability to extend the solution with some adaptations
> also to mtime.
> 
> The "change cookie" is used to know if inode metadata cache should
> be invalidated and mtime is often used to know if data cache should
> be invalidated, or if data comparison could be skipped (e.g. rsync).
> 
> The difference is that mtime can be set by user, so using lower nsec
> bits for modification counter would require to truncate the user set
> time granularity to 100ns - that is probably acceptable, but only as
> an opt-in behavior.
> 
> The special value 0 for mtime-change-counter could be reserved for
> mtime that was set by the user or for upgrade of existing inode,
> where 0 counter means that mtime cannot be trusted as an accurate
> data modification-cookie.

What about write faults on an mmap region?  The first ro->rw transition
results in an mtime update, but not again until the page gets cleaned.

> This feature is going to be useful for the vfs HSM implementation [1]
> that I am working on and it actually rhymes with the XFS DMAPI
> patches that were never fully merged upstream.

Kudos, I cannot figure out a non-pejorative word that rhymes with
"**API". ;)

--D

> Speaking on behalf of my employer, we would love to see the data
> modification-cookie feature implemented, whether in vfs or in xfs.
> 
> *IF* the result on this thread is that the chosen solution is
> ctime-with-change-counter in XFS
> *AND* if there is agreement among XFS developers to extend it with
> an opt-in mkfs/mount option to 100ns-mtime-with-change-counter in XFS
> *THEN* I think I will be able to allocate resources to drive this xfs work.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API
> 

