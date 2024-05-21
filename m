Return-Path: <linux-fsdevel+bounces-19914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B2E8CB1ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0806D1F2205E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187011CAB7;
	Tue, 21 May 2024 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PLMoOsOg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mdwFRJUx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PLMoOsOg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mdwFRJUx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B841CD18;
	Tue, 21 May 2024 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307693; cv=none; b=QMYcBx2Bl1669WxyqWEO7qywf4rTelOSuihwaPke0yuy/Azzrf7PmntVt5w1r5ku6IaF+acr9jIe4L0ogl3w8LXuLJX5CMuffoShsNCy7wMcIA7coyTdCEw2+Igg4gr24UR1KJAEoJhQI+fLiqAqOh7iZMMvbPksB56NSx8aLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307693; c=relaxed/simple;
	bh=6bqGy2CjjGhQDMc9pe+ND6gbmyigDIcKTONSi9fupOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCJzgYJm/DMjhrC5Kxkq+UbRPYDF4Xx7BStP03NtVX3UqqAgy8OzGGUs+7gV7XvKsXZDSScP7DGUUwYEbMflXtQcMdJxgiAk3/YZEq3CdOKxd6Uu8Zlk+Qrfc9/Y+eV+Rd++QqwGWl1PO4zqwkRWT6OW+itVr4PoCIfj7f9xJCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PLMoOsOg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mdwFRJUx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PLMoOsOg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mdwFRJUx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F205D5C2AC;
	Tue, 21 May 2024 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716307690;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5Xi7SG0eDHbsUbeYXeWTmPtIVDxeHZNI7gEWb0uohE=;
	b=PLMoOsOgYA5RqmbcoHl7fA3Z0pxox+pvJoU0QFNPQ+SZt0HDWSyNl3uW3R4n1wfcKqGugF
	XlzFFxQJuUuoV+7r+z44vBkUOB5HLlcAQMQvadVUFImM2mLYtTWeID6HDpqqehZ0vF8y7t
	6W1/VavFg+yVj0l+31E5Ud1EuI3e/mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716307690;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5Xi7SG0eDHbsUbeYXeWTmPtIVDxeHZNI7gEWb0uohE=;
	b=mdwFRJUxpitl/3BwH6hshBOw0sKimAVhn9iNi7E4PiaOHqAYLhQD8nP3jCyS3fXmDvPaCB
	ZC4hKj/16acJiQBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716307690;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5Xi7SG0eDHbsUbeYXeWTmPtIVDxeHZNI7gEWb0uohE=;
	b=PLMoOsOgYA5RqmbcoHl7fA3Z0pxox+pvJoU0QFNPQ+SZt0HDWSyNl3uW3R4n1wfcKqGugF
	XlzFFxQJuUuoV+7r+z44vBkUOB5HLlcAQMQvadVUFImM2mLYtTWeID6HDpqqehZ0vF8y7t
	6W1/VavFg+yVj0l+31E5Ud1EuI3e/mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716307690;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5Xi7SG0eDHbsUbeYXeWTmPtIVDxeHZNI7gEWb0uohE=;
	b=mdwFRJUxpitl/3BwH6hshBOw0sKimAVhn9iNi7E4PiaOHqAYLhQD8nP3jCyS3fXmDvPaCB
	ZC4hKj/16acJiQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDDAB13A1E;
	Tue, 21 May 2024 16:08:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YjIQMunGTGZEdgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 May 2024 16:08:09 +0000
Date: Tue, 21 May 2024 18:08:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH] fs: switch timespec64 fields in inode to discrete
 integers
Message-ID: <20240521160808.GR17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240517-amtime-v1-1-7b804ca4be8f@kernel.org>
 <Zkg7OCSYJ7rzv6_D@casper.infradead.org>
 <34fccefda12dce92706bc40c25626846616de264.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34fccefda12dce92706bc40c25626846616de264.camel@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,zeniv.linux.org.uk,suse.cz,linux-foundation.org,vger.kernel.org,gmail.com,redhat.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]

On Sat, May 18, 2024 at 06:48:30AM -0400, Jeff Layton wrote:
> On Sat, 2024-05-18 at 06:23 +0100, Matthew Wilcox wrote:
> > On Fri, May 17, 2024 at 08:08:40PM -0400, Jeff Layton wrote:
> > > For reference (according to pahole):
> > > 
> > >     Before:	/* size: 624, cachelines: 10, members: 53 */
> > >     After: 	/* size: 616, cachelines: 10, members: 56 */
> > 
> > Smaller is always better, but for a meaningful improvement, we'd want
> > to see more.  On my laptop running a Debian 6.6.15 kernel, I see:
> > 
> > inode_cache        11398  11475    640   25    4 : tunables    0    0    0 : slabdata    459    459      0
> > 
> > so there's 25 inodes per 4 pages.  Going down to 632 is still 25 per 4
> > pages.  At 628 bytes, we get 26 per 4 pages.  Ar 604 bytes, we're at 27.
> > And at 584 bytes, we get 28.
> > 
> > Of course, struct inode gets embedded in a lot of filesystem inodes.
> > xfs_inode         142562 142720   1024   32    8 : tunables    0    0    0 : slabdata   4460   4460      0
> > ext4_inode_cache      81     81   1184   27    8 : tunables    0    0    0 : slabdata      3      3      0
> > sock_inode_cache    2123   2223    832   39    8 : tunables    0    0    0 : slabdata     57     57      0
> > 
> > So any of them might cross a magic boundary where we suddenly get more
> > objects per slab.
> > 
> > Not trying to diss the work you've done here, just pointing out the
> > limits for anyone who's trying to do something similar.  Or maybe
> > inspire someone to do more reductions ;-)
> 
> Way to bust my bubble, Willy. ;-)
> 
> On a more serious note, I may be able to squeeze out another 4 bytes by
> moving __i_ctime to a single 8 byte word. It's never settable from
> userland, so we probably don't need the full range of times that a
> timespec64 gives us there. Shrinking that may also make the multigrain
> time rework simpler.
> 
> David Howells was also looking at removing the i_private field as well.
> Since these structs are usually embedded in a larger structure, it's
> not clear that we need that field. If we can make that work, it'll mean
> another 8 bytes goes away on 64-bit arches.
> 
> IOW, I think there may be some other opportunities for shrinkage in the
> future.

Incremental shrinking works well, we've managed to get btrfs_inode under
1024 bytes recently but it took several releases, removing, reordering
or otherwise optimizing the size. It's easier to focus on what's left
there than to take notes and assume all the other struct members that
could be optimized eventually.

