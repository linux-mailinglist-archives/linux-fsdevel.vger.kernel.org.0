Return-Path: <linux-fsdevel+bounces-74621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBtZC4RQcGlvXQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:05:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA23950C6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CE2050AE53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 12:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE8248F5A;
	Tue, 20 Jan 2026 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XgULO+TV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="32uO7/JB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qmqwOG4P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EWn5vhsH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0852C33FE18
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910621; cv=none; b=bz/X6Ie9Ma46e8hcEjQQBV3frvX77zDq5zb6+EmMgOp2vk4I2G3TpCHyEcFB0ZklgwBD3TOeGDHHqpUest9ihatTqqdI8LmjZDsBMmINGOx7+aLC7daeqE9d/f+NUK6Qd+txyQEdiKnhFsdURRYNxcYneGlgnvdQgdPtHQ6RYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910621; c=relaxed/simple;
	bh=RVcjQ69rx0Mb5x1IZLW8qGpLV83c+W6l2DHFYbMhuSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBs17y9eBmQ5PEPiqqT8j8j+IxgbXdOTvRdRwVXo9Qu18hYy5CfE2Z2RuXah2s5efV19+YTfCouxF2KX4AroYacSY89KR95bDPpPmBOwQgHVZbVeBGVToLLCrff5jwIzk59USFKH5M1y2QaXXc9uZbyijIHR6NaVUf2w4DmfKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XgULO+TV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=32uO7/JB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qmqwOG4P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EWn5vhsH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1D875BCCB;
	Tue, 20 Jan 2026 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768910618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZ/8i0focUq4iGcgtu9GLvrxQMD8MnR6tRpAdxV8E68=;
	b=XgULO+TVxZTrzbtcxbGyUyelLwMdRDOgxNLoG4vRjhAZhJk+i4VbDW0Ec5LBTPlurIqYYG
	BHa5Vm0+Rtmy7lS1Nzn+0ZA3PlEG//ctPHHpbd8IJqGFUxXeOCjdRbITrptU+qrq0NGuGs
	ZtQEDwlzZeWbZq6q5TNkP543J/Inyd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768910618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZ/8i0focUq4iGcgtu9GLvrxQMD8MnR6tRpAdxV8E68=;
	b=32uO7/JB4P+lh4LvSa0+dVsvqfxKeQRT4hRFU43LAP1b8RqPL8u/4HDCyOdP3548g296Su
	ot4FvwNm/yREcJBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768910616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZ/8i0focUq4iGcgtu9GLvrxQMD8MnR6tRpAdxV8E68=;
	b=qmqwOG4PpuBJsGCzvya63JidR9dfq4NS71dRcKRtXsBNdYsDRvu+pgkxAKDR8FRMnYMGYr
	wbuSDET89TtmCCHssI6YWFGWzziwcS/gVBjPHmRQXc+oOrd17t4OtZWmLDRfCTyWjLBLlu
	B4VqgYc+G0ZCRtGs8VhsvISrWuvhmXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768910616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZ/8i0focUq4iGcgtu9GLvrxQMD8MnR6tRpAdxV8E68=;
	b=EWn5vhsHkU60tdDmUqHhmgWdYuUkw4iF+mG2BXk3wJJ4CfR2Yio5MnQxWJ+FEiWauOLi7/
	z4vHCwVIqXJeJrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D26463EA63;
	Tue, 20 Jan 2026 12:03:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tp1OMxhvb2mdTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 20 Jan 2026 12:03:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 966FEA09DA; Tue, 20 Jan 2026 13:03:36 +0100 (CET)
Date: Tue, 20 Jan 2026 13:03:36 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fsnotify: Use connector hash for destroying inode
 marks
Message-ID: <56pt2kjxhxhki2vwed4pme4dwefq3uz3pqktb25zekcs2in6nk@mmlns7qnmhxf>
References: <20260119161505.26187-1-jack@suse.cz>
 <20260119171400.12006-5-jack@suse.cz>
 <CAOQ4uxje6rMQGNHKYjjO9_Bw3nZuOTyephS=wcOBJSv+Kh27yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxje6rMQGNHKYjjO9_Bw3nZuOTyephS=wcOBJSv+Kh27yQ@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74621-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CA23950C6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 20-01-26 12:43:26, Amir Goldstein wrote:
> On Mon, Jan 19, 2026 at 6:14 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Instead of iterating all inodes belonging to a superblock to find inode
> > marks and remove them on umount, iterate all inode connectors for the
> > superblock. This may be substantially faster since there are generally
> > much less inodes with fsnotify marks than all inodes. It also removes
> > one use of sb->s_inodes list which we strive to ultimately remove.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/notify/fsnotify.c | 74 +++++++++++++++-----------------------------
> >  1 file changed, 25 insertions(+), 49 deletions(-)
> >
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 706484fb3bf3..16a4a537d8c3 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -34,62 +34,38 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
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
> > -       struct inode *inode, *iput_inode = NULL;
> > -
> > -       spin_lock(&sb->s_inode_list_lock);
> > -       list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> > -               /*
> > -                * We cannot __iget() an inode in state I_FREEING,
> > -                * I_WILL_FREE, or I_NEW which is fine because by that point
> > -                * the inode cannot have any associated watches.
> > -                */
> > -               spin_lock(&inode->i_lock);
> > -               if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
> > -                       spin_unlock(&inode->i_lock);
> > -                       continue;
> > -               }
> > -
> > -               /*
> > -                * If i_count is zero, the inode cannot have any watches and
> > -                * doing an __iget/iput with SB_ACTIVE clear would actually
> > -                * evict all inodes with zero i_count from icache which is
> > -                * unnecessarily violent and may in fact be illegal to do.
> > -                * However, we should have been called /after/ evict_inodes
> > -                * removed all zero refcount inodes, in any case.  Test to
> > -                * be sure.
> > -                */
> > -               if (!icount_read(inode)) {
> > -                       spin_unlock(&inode->i_lock);
> > -                       continue;
> > -               }
> > +       int idx;
> > +       struct fsnotify_mark_connector *conn;
> > +       struct inode *inode;
> >
> > +       /*
> > +        * We hold srcu over the iteration so that returned connectors stay
> > +        * allocated until we can grab them in fsnotify_destroy_conn_marks()
> 
> fsnotify_destroy_marks()
> 
> > +        */
> > +       idx = srcu_read_lock(&fsnotify_mark_srcu);
> > +       spin_lock(&sbinfo->list_lock);
> > +       while (!list_empty(&sbinfo->inode_conn_list)) {
> > +               conn = fsnotify_inode_connector_from_list(
> > +                                               sbinfo->inode_conn_list.next);
> > +               /* All connectors on the list are still attached to an inode */
> > +               inode = conn->obj;
> >                 __iget(inode);
> > -               spin_unlock(&inode->i_lock);
> > -               spin_unlock(&sb->s_inode_list_lock);
> > -
> > -               iput(iput_inode);
> > -
> > -               /* for each watch, send FS_UNMOUNT and then remove it */
> > +               spin_unlock(&sbinfo->list_lock);
> >                 fsnotify_inode(inode, FS_UNMOUNT);
> > -
> > -               fsnotify_inode_delete(inode);
> > -
> > -               iput_inode = inode;
> > -
> > +               fsnotify_destroy_marks(&inode->i_fsnotify_marks);
> > +               iput(inode);
> >                 cond_resched();
> > -               spin_lock(&sb->s_inode_list_lock);
> > +               spin_lock(&sbinfo->list_lock);
> 
> The list could be long.
> Do we maybe want to avoid holding srcu read for the entire list walk?
> 
> Anyway, with or without, feel free to add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks for review! Actually now that I think about it sbinfo->list_lock is
enough to protect lifetime of the connector so we don't need srcu at all
here. I'll remove it for the next revision.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

