Return-Path: <linux-fsdevel+bounces-22886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010FC91E401
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 17:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9638287E27
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A30516D313;
	Mon,  1 Jul 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eYVMLLHU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3P9wJM2V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eYVMLLHU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3P9wJM2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B165453AC;
	Mon,  1 Jul 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847486; cv=none; b=aPDcPuwbqc9mNK2WgXe+j4OgmI16cwBWHagxs2J/YpBY9NvH4AdmW9SiJhF5OEYe39B3ESyVB32mL895i+rWSVe7oNXbZtkJmtB1yeQWuiIV8FlyxE+QFXS2A+bqTQVJFtZlJdFygAS+C9q6B4RK6x1XtaWRZvzmiT4x7re+Ctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847486; c=relaxed/simple;
	bh=A4X/8zuLwhQlbEDJM8qv3feEW02PFnloz6FKlPPEy+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCkkY3DbvJ618Z0IYas3yR1B5FG2P5i0N9eglcScrLdzp1/KWG/+RrPai5CESdhlbq6Lhkpv/9JarKCNBKJCz0VQ0goFWeUv27s+f7ZuGc2j+liwen2mL8Yb+M+/2KIBFwmfxGUhxsRrwWCW41txpBKGMkObLlYwn6wlNCIQvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eYVMLLHU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3P9wJM2V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eYVMLLHU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3P9wJM2V; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3EC6219B9;
	Mon,  1 Jul 2024 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719847482;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cj7Ce9Ym/sfb2sDvLTmuCL9ctsqC7G9CNBaQC/7mpWM=;
	b=eYVMLLHUiywmTNc4rCPjIViO/DXO6iAHpwDw3qE1A+yHT4hB7jZHK1vNq4S3Qya2hj8Nzx
	nnM1jC+Thkp777m+eNkDMsAptyMFvtINhgXBUlkLuEiIXUCDqLLCtepT1ZBwH4WW+6Hltb
	BzJbls++BS91/poXGjWflmBHtxstYC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719847482;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cj7Ce9Ym/sfb2sDvLTmuCL9ctsqC7G9CNBaQC/7mpWM=;
	b=3P9wJM2V7xu/1owrLE9QMz9guXL/Sm7CRWt/qRwbHWrdRhAzDyrohNPLfez4VmKwn2ohzV
	q4G6XkTbAnBbldCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719847482;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cj7Ce9Ym/sfb2sDvLTmuCL9ctsqC7G9CNBaQC/7mpWM=;
	b=eYVMLLHUiywmTNc4rCPjIViO/DXO6iAHpwDw3qE1A+yHT4hB7jZHK1vNq4S3Qya2hj8Nzx
	nnM1jC+Thkp777m+eNkDMsAptyMFvtINhgXBUlkLuEiIXUCDqLLCtepT1ZBwH4WW+6Hltb
	BzJbls++BS91/poXGjWflmBHtxstYC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719847482;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cj7Ce9Ym/sfb2sDvLTmuCL9ctsqC7G9CNBaQC/7mpWM=;
	b=3P9wJM2V7xu/1owrLE9QMz9guXL/Sm7CRWt/qRwbHWrdRhAzDyrohNPLfez4VmKwn2ohzV
	q4G6XkTbAnBbldCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A55613800;
	Mon,  1 Jul 2024 15:24:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9mq8GTrKgmZuAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 01 Jul 2024 15:24:42 +0000
Date: Mon, 1 Jul 2024 17:24:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 09/11] btrfs: convert to multigrain timestamps
Message-ID: <20240701152437.GE21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
 <20240701-mgtime-v2-9-19d412a940d9@kernel.org>
 <20240701134936.GB504479@perftesting>
 <ec952d79bbe19d80a7aff495e9784c60a1a1e668.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec952d79bbe19d80a7aff495e9784c60a1a1e668.camel@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[26];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[to_ip_from(RLkafno779cm49o166uw1xdisb)];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Mon, Jul 01, 2024 at 09:57:43AM -0400, Jeff Layton wrote:
> On Mon, 2024-07-01 at 09:49 -0400, Josef Bacik wrote:
> > On Mon, Jul 01, 2024 at 06:26:45AM -0400, Jeff Layton wrote:
> > > Enable multigrain timestamps, which should ensure that there is an
> > > apparent change to the timestamp whenever it has been written after
> > > being actively observed via getattr.
> > > 
> > > Beyond enabling the FS_MGTIME flag, this patch eliminates
> > > update_time_for_write, which goes to great pains to avoid in-memory
> > > stores. Just have it overwrite the timestamps unconditionally.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/btrfs/file.c  | 25 ++++---------------------
> > >  fs/btrfs/super.c |  3 ++-
> > >  2 files changed, 6 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > > index d90138683a0a..409628c0c3cc 100644
> > > --- a/fs/btrfs/file.c
> > > +++ b/fs/btrfs/file.c
> > > @@ -1120,26 +1120,6 @@ void btrfs_check_nocow_unlock(struct
> > > btrfs_inode *inode)
> > >  	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
> > >  }
> > >  
> > > -static void update_time_for_write(struct inode *inode)
> > > -{
> > > -	struct timespec64 now, ts;
> > > -
> > > -	if (IS_NOCMTIME(inode))
> > > -		return;
> > > -
> > > -	now = current_time(inode);
> > > -	ts = inode_get_mtime(inode);
> > > -	if (!timespec64_equal(&ts, &now))
> > > -		inode_set_mtime_to_ts(inode, now);
> > > -
> > > -	ts = inode_get_ctime(inode);
> > > -	if (!timespec64_equal(&ts, &now))
> > > -		inode_set_ctime_to_ts(inode, now);
> > > -
> > > -	if (IS_I_VERSION(inode))
> > > -		inode_inc_iversion(inode);
> > > -}
> > > -
> > >  static int btrfs_write_check(struct kiocb *iocb, struct iov_iter
> > > *from,
> > >  			     size_t count)
> > >  {
> > > @@ -1171,7 +1151,10 @@ static int btrfs_write_check(struct kiocb
> > > *iocb, struct iov_iter *from,
> > >  	 * need to start yet another transaction to update the
> > > inode as we will
> > >  	 * update the inode when we finish writing whatever data
> > > we write.
> > >  	 */
> > > -	update_time_for_write(inode);
> > > +	if (!IS_NOCMTIME(inode)) {
> > > +		inode_set_mtime_to_ts(inode,
> > > inode_set_ctime_current(inode));
> > > +		inode_inc_iversion(inode);
> > 
> > You've dropped the
> > 
> > if (IS_I_VERSION(inode))
> > 
> > check here, and it doesn't appear to be in inode_inc_iversion.  Is
> > there a
> > reason for this?  Thanks,
> > 
> 
> AFAICT, btrfs always sets SB_I_VERSION. Are there any cases where it
> isn't? If so, then I can put this check back. I'll make a note about it
> in the changelog if not.

Yes it's always set and I don't see anything in the generic code that
would unset it so it's safe to drop the IS_I_VERSION check.

The check was originally added in November 2012 by 6c760c072403f4
("Btrfs: do not call file_update_time in aio_write") and then moved a
few times. Enabling the super block flags was added in May 2012 by
0c4d2d95d06e92 ("Btrfs: use i_version instead of our own sequence") so
the check was not necessary from the beginning.

