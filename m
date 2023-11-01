Return-Path: <linux-fsdevel+bounces-1715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225557DDF39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 11:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D83BB210D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 10:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C6F101DE;
	Wed,  1 Nov 2023 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cIDBQeCe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mvEEW889"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEBD29AB
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 10:16:55 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C15C102;
	Wed,  1 Nov 2023 03:16:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80D4E21A62;
	Wed,  1 Nov 2023 10:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698833809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFpkczKLmbO7DBmC+KuusmYf1M81/8uEj5OEO9u0an8=;
	b=cIDBQeCeT6F/rRtPtuWsaxhbXCw/Oy8Nd3TyqIdVXqkKWHuejYiCFHWbJG36hEldNK/gE3
	PmAIxp18ujdwD778pBZ/fbbmaGxjbOGZeg065cemuCDzPnGNMI05uyPZkJArv7AoMBGwNW
	DccVThknuJ0/4feaYznjvdWoDckhhmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698833809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFpkczKLmbO7DBmC+KuusmYf1M81/8uEj5OEO9u0an8=;
	b=mvEEW889xoYvMMVwNIK0/VQCeU1UNx7tGnXGVlAFU0jWGpNvK1Hq0sOak6HpTutwkrFEmF
	VSu8elpoFbhhjyDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E0F51348D;
	Wed,  1 Nov 2023 10:16:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +FrRGpElQmX8GwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 01 Nov 2023 10:16:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EF5D5A06E3; Wed,  1 Nov 2023 11:16:48 +0100 (CET)
Date: Wed, 1 Nov 2023 11:16:48 +0100
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
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
Message-ID: <20231101101648.zjloqo5su6bbxzff@quack3>
References: <ZTjMRRqmlJ+fTys2@dread.disaster.area>
 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area>
 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area>
 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
 <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
 <ZUF4NTxQXpkJADxf@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUF4NTxQXpkJADxf@dread.disaster.area>

On Wed 01-11-23 08:57:09, Dave Chinner wrote:
> 5. When-ever the inode is persisted, the timestamp is copied to the
> on-disk structure and the current change counter is folded in.
> 
> 	This means the on-disk structure always contains the latest
> 	change attribute that has been persisted, just like we
> 	currently do with i_version now.
> 
> 6. When-ever we read the inode off disk, we split the change counter
> from the timestamp and update the appropriate internal structures
> with this information.
> 
> 	This ensures that the VFS and userspace never see the change
> 	counter implementation in the inode timestamps.

OK, but is this compatible with the current XFS behavior? AFAICS currently
XFS sets sb->s_time_gran to 1 so timestamps currently stored on disk will
have some mostly random garbage in low bits of the ctime. Now if you look
at such inode with a kernel using this new scheme, stat(2) will report
ctime with low bits zeroed-out so if the ctime fetched in the old kernel was
stored in some external database and compared to the newly fetched ctime, it
will appear that ctime has gone backwards... Maybe we don't care but it is
a user visible change that can potentially confuse something.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

