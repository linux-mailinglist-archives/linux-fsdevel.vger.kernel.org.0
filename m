Return-Path: <linux-fsdevel+bounces-33810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A269BF47C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 18:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028F31F23847
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0520721E;
	Wed,  6 Nov 2024 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V5KURQh1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k0hojoQ2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V5KURQh1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k0hojoQ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C8204932;
	Wed,  6 Nov 2024 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915071; cv=none; b=FTteZHw+ZTN05jp7THj/qV/ISh9ROagmXPCcEJ38jYv6q/2CmB/bvM5OkDNVxhGg24QN+0Rxr8RIQuLkW6zoqcyW4X1gj4q0ov6xOmJoBVx4OufuhLXLjHJgGPf5k2uW7L0o1dec57gRkch5WOvv10H179oiuixrA/5X/Jyd7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915071; c=relaxed/simple;
	bh=P9Im8Mja/NroOhr10JZTucnsIuTZZ4Un9St924nVyQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4yuZxoYtHOW/jh+dEzYoYHP8MAple5X6w6tle1KTrRfcf5fHZclF8h7lZw8M+jgaAI3MmEJvAgd5RKPi8cfQ5MPelHq3z3QP5bKrvlJ7McCxkXMJisMCunA6BvFODuJxxFgM5x3UtYc0+7eJIJoSa0zuBnhX3uqayOk2dNmhL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V5KURQh1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k0hojoQ2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V5KURQh1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k0hojoQ2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFC121F846;
	Wed,  6 Nov 2024 17:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730915067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VFl2eelebdXx2dClx4rsISOiUVqPiYqhxkteQkA/0s=;
	b=V5KURQh1NcCO48njiAdO5jUzgWp0K//VtpJs+i8QxLB/YF1x2+fJFkWvXqSqJMr8TmtEmO
	rlE34R5WBsmy/WiRVllH2XFBSpzAcheI8WGZfF9wwprzcAFkM7WKUT2p4M1H6Sxs+ge7Wp
	AEcPX2sJqZTEFT97/T5YI+CCabz11fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730915067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VFl2eelebdXx2dClx4rsISOiUVqPiYqhxkteQkA/0s=;
	b=k0hojoQ2a3lu3qTqKlfOv67RJ5Nmd1F4GfW9G6SHNyFeNcOXwRxZeCZFjbNJPwlbx2WlHW
	LaXbPe6Jy9xx03Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730915067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VFl2eelebdXx2dClx4rsISOiUVqPiYqhxkteQkA/0s=;
	b=V5KURQh1NcCO48njiAdO5jUzgWp0K//VtpJs+i8QxLB/YF1x2+fJFkWvXqSqJMr8TmtEmO
	rlE34R5WBsmy/WiRVllH2XFBSpzAcheI8WGZfF9wwprzcAFkM7WKUT2p4M1H6Sxs+ge7Wp
	AEcPX2sJqZTEFT97/T5YI+CCabz11fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730915067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VFl2eelebdXx2dClx4rsISOiUVqPiYqhxkteQkA/0s=;
	b=k0hojoQ2a3lu3qTqKlfOv67RJ5Nmd1F4GfW9G6SHNyFeNcOXwRxZeCZFjbNJPwlbx2WlHW
	LaXbPe6Jy9xx03Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3849137C4;
	Wed,  6 Nov 2024 17:44:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LfHSL/uqK2fneAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 06 Nov 2024 17:44:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59A80A0AFB; Wed,  6 Nov 2024 18:44:23 +0100 (CET)
Date: Wed, 6 Nov 2024 18:44:23 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Ma, Yu" <yu.ma@intel.com>, Christian Brauner <brauner@kernel.org>,
	jack@suse.cz, mjguzik@gmail.com, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v5 0/3] fs/file.c: optimize the critical section of
 file_lock in
Message-ID: <20241106174423.kdgv6eonsmwci5oj@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240722-geliebt-feiern-9b2ab7126d85@brauner>
 <20240801191304.GR5334@ZenIV>
 <20240802-bewachsen-einpacken-343b843869f9@brauner>
 <20240802142248.GV5334@ZenIV>
 <20240805-gesaugt-crashtest-705884058a28@brauner>
 <5210f83c-d2d9-4df6-b3eb-3311da128dae@intel.com>
 <20240812024044.GF13701@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812024044.GF13701@ZenIV>
X-Spam-Score: -3.80
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,suse.cz,gmail.com,google.com,vger.kernel.org,linux.intel.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 12-08-24 03:40:44, Al Viro wrote:
> On Mon, Aug 12, 2024 at 09:31:17AM +0800, Ma, Yu wrote:
> > 
> > On 8/5/2024 2:56 PM, Christian Brauner wrote:
> > > On Fri, Aug 02, 2024 at 03:22:48PM GMT, Al Viro wrote:
> > > > On Fri, Aug 02, 2024 at 01:04:44PM +0200, Christian Brauner wrote:
> > > > > > Hmm...   Something fishy's going on - those are not reachable by any branches.
> > > > > Hm, they probably got dropped when rebasing to v6.11-rc1 and I did have
> > > > > to play around with --onto.
> > > > > 
> > > > > > I'm putting together (in viro/vfs.git) a branch for that area (#work.fdtable)
> > > > > > and I'm going to apply those 3 unless anyone objects.
> > > > > Fine since they aren't in that branch. Otherwise I generally prefer to
> > > > > just merge a common branch.
> > > > If it's going to be rebased anyway, I don't see much difference from cherry-pick,
> > > > TBH...
> > > Yeah, but I generally don't rebase after -rc1 anymore unles there's
> > > really annoying conflicts.
> > 
> > Thanks Christian and Al for your time and efforts. I'm not familiar with the
> > merging process, may i know about when these patches could be seen in master
> 
> It's in work.fdtable in my tree, will post that series tonight and add to #for-next

Al, it seems you didn't push the patches to Linus during the last merge
window. Do you plan to push them during the coming one?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

