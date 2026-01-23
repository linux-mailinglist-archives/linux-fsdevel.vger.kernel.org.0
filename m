Return-Path: <linux-fsdevel+bounces-75281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB9oL4lqc2l/vgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:33:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A7A75DA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2521303012B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5581FF5F9;
	Fri, 23 Jan 2026 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TBgAvgpP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9jWl8LQf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MDR/T2LQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jghxDPS7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015871EFF80
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171474; cv=none; b=oNPpfZ1v1f72pRUP3u9HdBHMR5loyf7piVh9+pUH5+ztsWzAsDvOCEKe4BWiTFC3L6HLXcDqkRhdTcMPH9dpQbKHWbgCW5lFEKsfsWzW7sD4HEUvdb4FMk0wMUiKFjG/+TOhEGgLpCP8VfzlOrsgDb3eTJADKd8m6q/9TX55+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171474; c=relaxed/simple;
	bh=Qoqnckuq3ozKuuLA5EnzyAzzAESMPuuHyyJ/WU6x6E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/W5aKushRLxIL9yqGYJGQd+7aaFsfq3r+z95jNKYoXWgsUOWzQYbs72BVCXMGN/O+/RC2+yvHMFsh6SBet1pJa0GoVWaPEcQ0SUssrHLXAJgHYTVihePeDDknQLXpLkSH/FmISWJ/tVXrebSibTOoU5Sd0yGTQg/ykY3JU1Qbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TBgAvgpP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9jWl8LQf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MDR/T2LQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jghxDPS7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B34A337E5;
	Fri, 23 Jan 2026 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769171471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JlbAXrnE+seymJEMN79XRxW0vDx1UCM8fcKMj00MAg=;
	b=TBgAvgpPcGW0IxQzUPSOn25UnIhx78PDbv9bUe8Pum1m5qrJsRGUYGZ50NwHy8VVyUQ201
	yAjsnjbwP+nD/yjcje9k0iK8BlzOwxmKxRohwXZmYbk7OlbsTI16AKpmKDNdxr4RiPgSmN
	9y3p0cStFfSkcgo7hoj7SWdZKL45kkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769171471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JlbAXrnE+seymJEMN79XRxW0vDx1UCM8fcKMj00MAg=;
	b=9jWl8LQfgAvTk0Nh2mFlKwTAg/fvpYAxeP3Taxj14TR5fsCrAGoCuktMRgkX9hjDWUSNEk
	b0g3gFZJdjgGwsDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769171470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JlbAXrnE+seymJEMN79XRxW0vDx1UCM8fcKMj00MAg=;
	b=MDR/T2LQMDn8euBVj5VxRD2AiO84R5TJosV0HWMsPhZKkDvGVt2ETOL+g9VnOEfBSbF8Cp
	dAUjsaStCFnlOtNDuWp6x3wnGpzAi1xhHXT/237PaVEqAUcg/vwlNE/abTmm+aeQB9sdzQ
	I0rP5T0i8K6xbBKHcTjW0Q0m8YrWrHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769171470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JlbAXrnE+seymJEMN79XRxW0vDx1UCM8fcKMj00MAg=;
	b=jghxDPS7c0npYiNvpNt0/MyNHpOUktJfQJPP9pQ4qhwGuiGxaoGET5zm3LorzsYZSxWZZn
	+aYRoyDa3t9th3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7834C136AA;
	Fri, 23 Jan 2026 12:31:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EaxRHQ5qc2nEMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 23 Jan 2026 12:31:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3F40AA0A1B; Fri, 23 Jan 2026 13:31:10 +0100 (CET)
Date: Fri, 23 Jan 2026 13:31:10 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 2/3] fsnotify: Use connector hash for destroying inode
 marks
Message-ID: <m5a3dyhvpnjhyjmxae2o2sd2azhynbrupmhzsy2fbgomhdcyow@imnv6ytjaxfi>
References: <20260120131830.21836-1-jack@suse.cz>
 <20260120132313.30198-5-jack@suse.cz>
 <20260123-mengenlehre-wildhasen-46e47a6e7558@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-mengenlehre-wildhasen-46e47a6e7558@brauner>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75281-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.969];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E6A7A75DA9
X-Rspamd-Action: no action

On Fri 23-01-26 12:22:31, Christian Brauner wrote:
> On Tue, Jan 20, 2026 at 02:23:10PM +0100, Jan Kara wrote:
> > Instead of iterating all inodes belonging to a superblock to find inode
> > marks and remove them on umount, iterate all inode connectors for the
> > superblock. This may be substantially faster since there are generally
> > much less inodes with fsnotify marks than all inodes. It also removes
> > one use of sb->s_inodes list which we strive to ultimately remove.
> > 
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/notify/fsnotify.c | 71 +++++++++++++-------------------------------
> >  1 file changed, 20 insertions(+), 51 deletions(-)
> > 
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 706484fb3bf3..a0cf0a6ffe1d 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -34,62 +34,31 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
> >  }
> >  
> >  /**
> > - * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
> > - * @sb: superblock being unmounted.
> > + * fsnotify_unmount_inodes - an sb is unmounting. Handle any watched inodes.
> > + * @sbinfo: fsnotify info for superblock being unmounted.
> >   *
> > - * Called during unmount with no locks held, so needs to be safe against
> > - * concurrent modifiers. We temporarily drop sb->s_inode_list_lock and CAN block.
> > + * Walk all inode connectors for the superblock and free all associated marks.
> >   */
> > -static void fsnotify_unmount_inodes(struct super_block *sb)
> > +static void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo)
> >  {
> > -	struct inode *inode, *iput_inode = NULL;
> > -
> > -	spin_lock(&sb->s_inode_list_lock);
> > -	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> > -		/*
> > -		 * We cannot __iget() an inode in state I_FREEING,
> > -		 * I_WILL_FREE, or I_NEW which is fine because by that point
> > -		 * the inode cannot have any associated watches.
> > -		 */
> > -		spin_lock(&inode->i_lock);
> > -		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
> > -			spin_unlock(&inode->i_lock);
> > -			continue;
> > -		}
> > -
> > -		/*
> > -		 * If i_count is zero, the inode cannot have any watches and
> > -		 * doing an __iget/iput with SB_ACTIVE clear would actually
> > -		 * evict all inodes with zero i_count from icache which is
> > -		 * unnecessarily violent and may in fact be illegal to do.
> > -		 * However, we should have been called /after/ evict_inodes
> > -		 * removed all zero refcount inodes, in any case.  Test to
> > -		 * be sure.
> > -		 */
> > -		if (!icount_read(inode)) {
> > -			spin_unlock(&inode->i_lock);
> > -			continue;
> > -		}
> > -
> > -		__iget(inode);
> > -		spin_unlock(&inode->i_lock);
> > -		spin_unlock(&sb->s_inode_list_lock);
> > -
> > -		iput(iput_inode);
> > -
> > -		/* for each watch, send FS_UNMOUNT and then remove it */
> > +	struct fsnotify_mark_connector *conn;
> > +	struct inode *inode;
> > +
> > +	spin_lock(&sbinfo->list_lock);
> 
> I think you could even make this lockless by using an rcu list.
> But probably not needed. I assume that sbinfo->list_lock will not be
> heavily contended when the filesystem is shut down.

Yes, generally list_lock is acquired only when adding/removing inode
notification marks which is infrequent. Thanks for review!
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

