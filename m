Return-Path: <linux-fsdevel+bounces-1358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90F07D95CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 12:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2544D1C21032
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D25A179B3;
	Fri, 27 Oct 2023 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LoprrsKm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1TiP4l4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8078171DC
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 10:58:16 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ECD1B6;
	Fri, 27 Oct 2023 03:58:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B05721FEF2;
	Fri, 27 Oct 2023 10:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698404293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHt33JITK+CruVu/Kq7gOvJiMSgnxMBp3xqwVrdgGPg=;
	b=LoprrsKmbQ0kuH7OEfyfF+SzxIJy5BVcK2aCJ4kDq7KzWLj3If0CsHtmMWErHSxGvWRgxK
	DsniCnUOjbcqG4jJrEX+3wVDWRy5V9L5/5iemBBuX/7BHKP2JaHisyhIqkbyO5iEA39IGj
	Y2mFJjxrPf/Q4z1lLasJDwOYLwUZ2KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698404293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHt33JITK+CruVu/Kq7gOvJiMSgnxMBp3xqwVrdgGPg=;
	b=1TiP4l4t+cpR6iPapZS0AzU3KDjbfia40Z002DIYgNpZSR9g2JMCoZRAQpiTnQi6dK4fzH
	xS8H7gMNkOEN7BDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 937291358C;
	Fri, 27 Oct 2023 10:58:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mQb5I8WXO2WODAAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 27 Oct 2023 10:58:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 080E2A05BC; Fri, 27 Oct 2023 12:58:13 +0200 (CEST)
Date: Fri, 27 Oct 2023 12:58:12 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231027105812.obhj2h6vllrwpmtc@quack3>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025170445.qks7etxtwivyqz22@quack3>
 <ZTtOOs4zZ1P/eDZn@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTtOOs4zZ1P/eDZn@infradead.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.87
X-Spamd-Result: default: False [-5.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.27)[96.59%];
	 FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,fb.com,toxicpanda.com,suse.com,vger.kernel.org]

On Thu 26-10-23 22:44:26, Christoph Hellwig wrote:
> On Wed, Oct 25, 2023 at 07:04:45PM +0200, Jan Kara wrote:
> > Well, this is the discussion how btrfs should be presenting its subvolumes
> > to VFS / userspace, isn't it?
> 
> Yes.  Which we've pressured to resolve forever, but it's been ignored.
> 
> > I never dived into that too closely but as
> > far as I remember it was discussed to death without finding an acceptable
> > (to all parties) solution? I guess having a different fsid per subvolume
> > makes sense (and we can't change that given it is like that forever even if
> > we wanted). Having different subvolumes share one superblock is more
> > disputable but there were reasons for that as well. So I'm not sure how you
> > imagine to resolve this...
> 
> We need to solve this out kernel wide, and right now the kernel doesn't
> support different dev_t / fsids inside a single file syste at all.
> SuSE hacks around that badly for limited user interfaces with the
> horrible get_inode_dev method they've added, but this has been rejected
> upstream for good reason.  What this series does is to add another
> limited version of this through the backdoor.

OK, I see. I agree adding ->get_fsid is just piling on top of the problems
so I can see why you don't like it. Band aids are double-edged sword ;)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

