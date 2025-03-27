Return-Path: <linux-fsdevel+bounces-45155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55353A73A77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 18:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079723BBF50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E3535964;
	Thu, 27 Mar 2025 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DEoE79Ef";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A71fKUef";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b+hNM8sN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RzpzowgM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1B136337
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743096666; cv=none; b=kntRhFufdVSWY0n4y8wA6wYe9zQacTkPLQruZouj/11yFqEe94YiVNWPcTlDisMWXwZ61qg5ZY5HWNGf6W8ZT+60lvgh0VcqcfR8LfdReQUzEa02JLMBwglo3E/NnInZAKhWe7vJYKzAHNxixck5eWvZp716eAEXEbavSLkGiF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743096666; c=relaxed/simple;
	bh=WFNXLBqrd8SqbWISD+N67nMBzPJ5+3QJoyjdpUINQzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U78PZ46dSZUF8UHZS92BUh6Useas7aHBtFbWKQZ6L7WHDerdM8orkNiLhQAa7Gp1VXWnGDzHKipdiOBQMRlPkpP3p5JIEYr/iMh6cXlLyTo0FF5T/WDi7opVswBUWILal0C8+ZesSk/RIG47qbFFliIZdpu5kVydwi8meuDsPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DEoE79Ef; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A71fKUef; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b+hNM8sN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RzpzowgM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D1BA51F388;
	Thu, 27 Mar 2025 17:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743096661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SixOHwgv/UImNXb3CxlvsLfYJAuDBFBTemaXYBqNT5g=;
	b=DEoE79EfZOFHXunv9o6ps39sUGn37y3yKlTEXQXrCu7YYlqqSjnJfEWOVarxbIXykC8zTg
	GNZxtJMZa7eaPMZBW5X6+IqF5TD4dIwItIkR6fDAqECl7YaEzcpKdaR+yOVUoqF9GzE+wF
	J7OLincSc0/XmqUxORbttvA9+fJnwO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743096661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SixOHwgv/UImNXb3CxlvsLfYJAuDBFBTemaXYBqNT5g=;
	b=A71fKUefUM2VjvMlvFxNl1ORbSaf81pu2QzubVAVN8PlQm0pbxISlokd4wrmiZHGBma1Dl
	Wz6HXXyITuH+KUDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=b+hNM8sN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RzpzowgM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743096660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SixOHwgv/UImNXb3CxlvsLfYJAuDBFBTemaXYBqNT5g=;
	b=b+hNM8sN4KTN/MswSBmbIYhmHDk1eEhkCto4eahu/QOyzfOcTEAmOnRpC/AaluEzUm1h2V
	Mv++4O40CglyBg3K9NPyXaLmTLM5Ap33ttl2eX9uvGCI9TGOJLeYY0oH9xqRPbbROBif3N
	FsT1ud+4TIGPo/79Grzch7YaBVZTJzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743096660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SixOHwgv/UImNXb3CxlvsLfYJAuDBFBTemaXYBqNT5g=;
	b=RzpzowgMm6UCBRfqdNVJJzrYwgmVPMVTW/XeX2Ql+tGvkjOf/vYPT98AYim3mH+RmaK+nZ
	R3aeqs7hCzIaHBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE7551376E;
	Thu, 27 Mar 2025 17:31:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h0h7LlSL5WdUHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Mar 2025 17:31:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37912A082A; Thu, 27 Mar 2025 18:30:56 +0100 (CET)
Date: Thu, 27 Mar 2025 18:30:56 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Jan Kara <jack@suse.cz>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <faaagghgdeliafoxhdxeyrgzdmx7oao2apqc73y7h3v33ok7jn@6x5xmfczakm3>
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
 <Z9xG2l8lm7ha3Pf2@infradead.org>
 <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
 <Z9z32X7k_eVLrYjR@infradead.org>
 <576418420308d2511a4c155cc57cf0b1420c273b.camel@HansenPartnership.com>
 <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
 <vnb6flqo3hhijz4kb3yio5rxzaugvaxharocvtf4j4s5o5xynm@nbccfx5xqvnk>
 <9f5bea0af3e32de0e338481d6438676d99f40be7.camel@HansenPartnership.com>
 <jlnc33bmqefx3273msuzq3yyei7la2ttwzqyyavohzm2k66sl6@gtqq6jpueipz>
 <3b5d42a0-933a-457b-aca9-3eaf7c7f947f@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b5d42a0-933a-457b-aca9-3eaf7c7f947f@sandeen.net>
X-Rspamd-Queue-Id: D1BA51F388
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 27-03-25 09:55:21, Eric Sandeen wrote:
> On 3/24/25 2:28 PM, Jan Kara wrote:
> > On Mon 24-03-25 10:34:56, James Bottomley wrote:
> >> On Mon, 2025-03-24 at 12:38 +0100, Jan Kara wrote:
> >>> On Fri 21-03-25 13:00:24, James Bottomley via Lsf-pc wrote:
> >>>> On Fri, 2025-03-21 at 08:34 -0400, James Bottomley wrote:
> >>>> [...]
> >>>>> Let me digest all that and see if we have more hope this time
> >>>>> around.
> >>>>
> >>>> OK, I think I've gone over it all.  The biggest problem with
> >>>> resurrecting the patch was bugs in ext3, which isn't a problem now.
> >>>> Most of the suspend system has been rearchitected to separate
> >>>> suspending user space processes from kernel ones.  The sync it
> >>>> currently does occurs before even user processes are frozen.  I
> >>>> think
> >>>> (as most of the original proposals did) that we just do freeze all
> >>>> supers (using the reverse list) after user processes are frozen but
> >>>> just before kernel threads are (this shouldn't perturb the image
> >>>> allocation in hibernate, which was another source of bugs in xfs).
> >>>
> >>> So as far as my memory serves the fundamental problem with this
> >>> approach was FUSE - once userspace is frozen, you cannot write to
> >>> FUSE filesystems so filesystem freezing of FUSE would block if
> >>> userspace is already suspended. You may even have a setup like:
> >>>
> >>> bdev <- fs <- FUSE filesystem <- loopback file <- loop device <-
> >>> another fs
> >>>
> >>> So you really have to be careful to freeze this stack without causing
> >>> deadlocks.
> >>
> >> Ah, so that explains why the sys_sync() sits in suspend resume *before*
> >> freezing userspace ... that always appeared odd to me.
> >>
> >>>  So you need to be freezing userspace after filesystems are
> >>> frozen but then you have to deal with the fact that parts of your
> >>> userspace will be blocked in the kernel (trying to do some write)
> >>> waiting for the filesystem to thaw. But it might be tractable these
> >>> days since I have a vague recollection that system suspend is now
> >>> able to gracefully handle even tasks in uninterruptible sleep.
> >>
> >> There is another thing I thought about: we don't actually have to
> >> freeze across the sleep.  It might be possible simply to invoke
> >> freeze/thaw where sys_sync() is now done to get a better on stable
> >> storage image?  That should have fewer deadlock issues.
> > 
> > Well, there's not going to be a huge difference between doing sync(2) and
> > doing freeze+thaw for each filesystem. After you thaw the filesystem
> > drivers usually mark that the fs is in inconsistent state and that triggers
> > journal replay / fsck on next mount.
> 
> For XFS, IIRC we only do that (mark the log dirty) so that we will process
> orphan inodes if we crash while frozen, which today happens only during log
> replay. I tried to remove that behavior long ago but didn't get very far.
> (Since then maybe we have grown other reasons to mark dirty, not sure.)
> 
> https://lore.kernel.org/linux-xfs/83696ce6-4054-0e77-b4b8-e82a1a9fbbc3@redhat.com/
> 
> Does ext4 mark it dirty too? I actually thought it left a clean journal when
> freezing.

The journal is completely checkpointed (thus emptied) while freezing but
thawing marks the superblock as requiring replay again and also background
filesystem threads (like lazy init, periodic superblock stats update, etc.)
can start creating transactions in the journal.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

