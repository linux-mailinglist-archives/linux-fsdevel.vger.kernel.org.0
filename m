Return-Path: <linux-fsdevel+bounces-1636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4987DCCD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 13:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6727C2817EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF81DA50;
	Tue, 31 Oct 2023 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="stIqHE18";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ezvTsNdn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32371DA2A
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 12:22:05 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0925D98;
	Tue, 31 Oct 2023 05:22:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FB961F38C;
	Tue, 31 Oct 2023 12:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698754921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LxFJRcgKBrTkwCYk/XtrM2vfD36eMy9uV2KLQkafOhY=;
	b=stIqHE18hi2qK54I3U59vf2hwUprwpecHKfDAQl0BfZhfY9q7vOh7VQOvfyRIjXKcuCKic
	KzxtNU5bDMp3XfdhMrN/PHoUj5JOtUvbLJw1Z1SqneYw14oLKXB5dXYyn7z9vA2N6wH7ST
	4OCFQZPjOT/CJctCbnuDY/fSgPBEEfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698754921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LxFJRcgKBrTkwCYk/XtrM2vfD36eMy9uV2KLQkafOhY=;
	b=ezvTsNdnRqRV9+SjqugsQVNOwztieZlM3AEVPM4DYQWa5mL9YeU3DWOSCLoXuxS8MGnhK2
	d4woXKVGLv2zv/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BBDD1391B;
	Tue, 31 Oct 2023 12:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id dhoQImnxQGV9SgAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 31 Oct 2023 12:22:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A429A06E5; Tue, 31 Oct 2023 13:22:01 +0100 (CET)
Date: Tue, 31 Oct 2023 13:22:01 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
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
Message-ID: <20231031122201.kmxzttzfbearu6iu@quack3>
References: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area>
 <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
 <ZTjMRRqmlJ+fTys2@dread.disaster.area>
 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area>
 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area>
 <d5965ba7ed012433a9914ba38a6046f2ddb015ac.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5965ba7ed012433a9914ba38a6046f2ddb015ac.camel@kernel.org>

On Tue 31-10-23 07:04:53, Jeff Layton wrote:
> On Tue, 2023-10-31 at 09:37 +1100, Dave Chinner wrote:
> > I have suggested mechanisms for using masked off bits of timestamps
> > to encode sub-timestamp granularity change counts and keep them
> > invisible to userspace and then not using i_version at all for XFS.
> > This avoids all the problems that the multi-grain timestamp
> > infrastructure exposed due to variable granularity of user visible
> > timestamps and ordering across inodes with different granularity.
> > This is potentially a general solution, too.
> 
> I don't really understand this at all, but trying to do anything with
> fine-grained timestamps will just run into a lot of the same problems we
> hit with the multigrain work. If you still see this as a path forward,
> maybe you can describe it more detail?

Dave explained a bit more details here [1] like:

Another options is for XFS to play it's own internal tricks with
[cm]time granularity and turn off i_version. e.g. limit external
timestamp visibility to 1us and use the remaining dozen bits of the
ns field to hold a change counter for updates within a single coarse
timer tick. This guarantees the timestamp changes within a coarse
tick for the purposes of change detection, but we don't expose those
bits to applications so applications that compare timestamps across
inodes won't get things back to front like was happening with the
multi-grain timestamps....
-

So as far as I understand Dave wants to effectively persist counter in low
bits of ctime and expose ctime+counter as its change cookie. I guess that
could work and what makes the complexity manageable compared to full
multigrain timestamps is the fact that we have one filesystem, one on-disk
format etc. The only slight trouble could be that if we previously handed
out something in low bits of ctime for XFS, we need to keep handing the
same thing out until the inode changes (i.e., no rounding until the moment
inode changes) as the old timestamp could be stored somewhere externally
and compared.

								Honza

[1] https://lore.kernel.org/all/ZTjMRRqmlJ+fTys2@dread.disaster.area/


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

