Return-Path: <linux-fsdevel+bounces-19551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D5F8C6B56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 19:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599C81F2390A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7024D9E2;
	Wed, 15 May 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K0eVMjs/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2IiCYPHD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K0eVMjs/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2IiCYPHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272C47F69;
	Wed, 15 May 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793309; cv=none; b=c59kX0F9sRqZgadJp6eSk6RyOL0vss056FiXUjK7QxUDE5F1WVDfie51fsiDJGWNzEGc0AwlwADMXGzZ2XdeTNCjVubcImVbzoHZfQdxGjP40GjrUMpfk4dr9DThV9OR91keYPrLWLTgOn0/DNPji8gZxGGq5RaHGb4ibvOcWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793309; c=relaxed/simple;
	bh=p/MSJ7E3D8J/h+ziDbndYVP90C09UgrDpaGa6w/oFcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdv2X+V7GMQp6Xd0vyzD4k+on3RlGpyVdNJz8TpaJntN09/EbF415eMNbOlI828X1YleCz65TyUON/jv1bgEXofLJlB+jYiKQPwZHJBeviVbC/CjjOXsgrUBAkhDkVAum+P8FjmYpiTp53yIEIWdm+5k3rbMXUSR/xqhw82IimM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K0eVMjs/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2IiCYPHD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K0eVMjs/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2IiCYPHD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 825BC20986;
	Wed, 15 May 2024 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715793305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdo6u8NmBIZC/iZG3MEh7x2L2hP8V7/hk4kCETY+KHg=;
	b=K0eVMjs/dx4cQV9iCs3oLesmlKRvb8dK2CcO8hYSPoPFDG32jd/iFWN1okMzFvZty29QFX
	k57MzuKGcAXLTImJcUwGlIraSKCP+j8G01gnAxeKbApZJ058E0BxFTPYuYNkOKzqWH200v
	i3y3Q0X/bjf+63YXXwJpjUX7KpSwen8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715793305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdo6u8NmBIZC/iZG3MEh7x2L2hP8V7/hk4kCETY+KHg=;
	b=2IiCYPHDXrVEhvpPjlIok6A2/vCZwbdkN9v68oiq6GbqwIDLU9vjX8hZ6dKZjpwqD+nN+Z
	hMGt9VPFsTQNPFBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715793305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdo6u8NmBIZC/iZG3MEh7x2L2hP8V7/hk4kCETY+KHg=;
	b=K0eVMjs/dx4cQV9iCs3oLesmlKRvb8dK2CcO8hYSPoPFDG32jd/iFWN1okMzFvZty29QFX
	k57MzuKGcAXLTImJcUwGlIraSKCP+j8G01gnAxeKbApZJ058E0BxFTPYuYNkOKzqWH200v
	i3y3Q0X/bjf+63YXXwJpjUX7KpSwen8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715793305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdo6u8NmBIZC/iZG3MEh7x2L2hP8V7/hk4kCETY+KHg=;
	b=2IiCYPHDXrVEhvpPjlIok6A2/vCZwbdkN9v68oiq6GbqwIDLU9vjX8hZ6dKZjpwqD+nN+Z
	hMGt9VPFsTQNPFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54527136A8;
	Wed, 15 May 2024 17:15:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YbKEFJntRGZHcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 15 May 2024 17:15:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D156CA08B5; Wed, 15 May 2024 19:15:03 +0200 (CEST)
Date: Wed, 15 May 2024 19:15:03 +0200
From: Jan Kara <jack@suse.cz>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] fsnotify: clear PARENT_WATCHED flags lazily
Message-ID: <20240515171503.loxpdv3xumgbc44w@quack3>
References: <20240510221901.520546-1-stephen.s.brennan@oracle.com>
 <CAOQ4uxjKdkXLi6w2az9a3dnEkX1-w771ZUz1Lr2ToFFUGvf8Ng@mail.gmail.com>
 <87bk59gsxv.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bk59gsxv.fsf@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 13-05-24 17:04:12, Stephen Brennan wrote:
> Amir Goldstein <amir73il@gmail.com> writes:
> 
> > On Fri, May 10, 2024 at 6:21 PM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> >>
> >> Hi Amir, Jan, et al,
> >
> > Hi Stephen,
> >
> >>
> >> It's been a while since I worked with you on the patch series[1] that aimed to
> >> make __fsnotify_update_child_dentry_flags() a sleepable function. That work got
> >> to a point that it was close to ready, but there were some locking issues which
> >> Jan found, and the kernel test robot reported, and I didn't find myself able to
> >> tackle them in the amount of time I had.
> >>
> >> But looking back on that series, I think I threw out the baby with the
> >> bathwater. While I may not have resolved the locking issues associated with the
> >> larger change, there was one patch which Amir shared, that probably resolves
> >> more than 90% of the issues that people may see. I'm sending that here, since it
> >> still applies to the latest master branch, and I think it's a very good idea.
> >>
> >> To refresh you, the underlying issue I was trying to resolve was when
> >> directories have many dentries (frequently, a ton of negative dentries), the
> >> __fsnotify_update_child_dentry_flags() operation can take a while, and it
> >> happens under spinlock.
> >>
> >> Case #1 - if the directory has tens of millions of dentries, then you could get
> >> a soft lockup from a single call to this function. I have seen some cases where
> >> a single directory had this many dentries, but it's pretty rare.
> >>
> >> Case #2 - suppose you have a system with many CPUs and a busy directory. Suppose
> >> the directory watch is removed. The caller will begin executing
> >> __fsnotify_update_child_dentry_flags() to clear the PARENT_WATCHED flag, but in
> >> parallel, many other CPUs could wind up in __fsnotify_parent() and decide that
> >> they, too, must call __fsnotify_update_child_dentry_flags() to clear the flags.
> >> These CPUs will all spin waiting their turn, at which point they'll re-do the
> >> long (and likely, useless) call. Even if the original call only took a second or
> >> two, if you have a dozen or so CPUs that end up in that call, some CPUs will
> >> spin a long time.
> >>
> >> Amir's patch to clear PARENT_WATCHED flags lazily resolves that easily. In
> >> __fsnotify_parent(), if callers notice that the parent is no longer watching,
> >> they merely update the flags for the current dentry (not all the other
> >> children). The __fsnotify_recalc_mask() function further avoids excess calls by
> >> only updating children if the parent started watching. This easily handles case
> >> #2 above. Perhaps case #1 could still cause issues, for the cases of truly huge
> >> dentry counts, but we shouldn't let "perfect" get in the way of "good enough" :)
> >>
> >
> > The story sounds good :)
> > Only thing I am worried about is: was case #2 tested to prove that
> > the patch really imploves in practice and not only in theory?
> >
> > I am not asking that you write a test for this or even a reproducer
> > just evidence that you collected from a case where improvement is observed
> > and measurable.
> 
> I had not done so when you sent this, but I should have done it
> beforehand. In any case, now I have. I got my hands on a 384-CPU machine
> and extended my negative dentry creation tool so that it can run a
> workload in which it constantly runs "open()" followed by "close()" on
> 1000 files in the same directory, per thread (so a total of 384,000
> files, a large but not unreasonable amount of dentries).
> 
> Then I simply run "inotifywait /path/to/dir" a few times. Without the
> patch, softlockups are easy to reproduce. With the patch, I haven't been
> able to get a single soft lockup.

Thanks for the patch and for testing! I've added your patch to my tree (not
for this merge window though) with a cosmetic tweak that instead of
fsnotify_update_child_dentry_flags() we just have
fsnotify_clear_child_dentry_flag() and fsnotify_set_children_dentry_flags()
functions to make naming somewhat clearer.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

