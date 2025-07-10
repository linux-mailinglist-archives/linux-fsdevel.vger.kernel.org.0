Return-Path: <linux-fsdevel+bounces-54495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6A5B002EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7F84A56E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE792D9795;
	Thu, 10 Jul 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eD+Hvn7Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mJOuKh4P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AE8gmRXK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2iNx+RTI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1BF2C1599
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153013; cv=none; b=TFsIQY5uOWPj5O9WaVp7Ygtv4S1Y/25k2XT6D3JLUUahz4rNP1QriDCSreHSEuhe2/3RxEfPitQd/ijyL4OhgtnQc1i9NlYnQMrVpwNCoMayTQufe795z8socNFjgHoDi3LLtK1DVjX0QsqkzWB2K4AO9nIUKvFEXD9HDcWibpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153013; c=relaxed/simple;
	bh=6wzNeHKe2BwweMlq895MbtGooUY62kwoBduxkWK5Nos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7ZlFmtOFRWA8K/mIO0JqINtMYVWskWAqzmJUmoF4APwAgnJHAalxuV5uaXdMJG5StFvbefvsEfP+hiL6rwVidiKGn14fOX8x0T4Vbzf/IckzphWd/R+CssdrqElr3QVvBMtOH+G9TmlHCBorhL3LxVSm6Tkqb5+4Lz2TrBqFPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eD+Hvn7Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mJOuKh4P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AE8gmRXK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2iNx+RTI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C424121175;
	Thu, 10 Jul 2025 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752153009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyJYnzTWJud5qEGhrZj76b5jt76YQEEA8Xla8XnWYCI=;
	b=eD+Hvn7ZLTFWMgSHZCTGec0Q2nrnVMxsDS60BVl3tkuQTfzJX6NKCouIsq0gvJDK5qTDZm
	hzfec7UPwkOq03Rut0QrPDclglmvIM1JlhtM+PxiclYYwxAnSAPEvXEWYUJdRbQtjYpCYQ
	8VUrnp1QnIyaTXxt0OXdlTD8PNxA2uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752153009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyJYnzTWJud5qEGhrZj76b5jt76YQEEA8Xla8XnWYCI=;
	b=mJOuKh4P+rH23nX5Slq2qnqcl4aZaxTkud0cBp7E7uk23R/O5aN339AWOIzgj4zkFjKs2B
	4txzG5FZizrEKTAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AE8gmRXK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2iNx+RTI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752153008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyJYnzTWJud5qEGhrZj76b5jt76YQEEA8Xla8XnWYCI=;
	b=AE8gmRXK97XQg+ako5dNJ/Am6nwNeQMZiPTHlyWjH6cESCeSKiwH9t1kre4nAFCpWAP8S4
	X23Nw3M+4bpMfjDKqHk1AczAhxCwLZuqoN5T3BnMmOR7hvNlofMWFvsVTkFNTlJxST/7BT
	vCIRTWq9DcbaVWNDvbLNERrcO2tWf9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752153008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyJYnzTWJud5qEGhrZj76b5jt76YQEEA8Xla8XnWYCI=;
	b=2iNx+RTILnuNSLzwrBa6OKoCkNZ1ZxkYVIT/m5OgKQDqKVYd6EnQ0dRySRNKTdE2+gYWyd
	/d5t9pC4FFZl+wBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6119136CB;
	Thu, 10 Jul 2025 13:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id esQeLLC7b2jGGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Jul 2025 13:10:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5A12EA098F; Thu, 10 Jul 2025 15:10:04 +0200 (CEST)
Date: Thu, 10 Jul 2025 15:10:04 +0200
From: Jan Kara <jack@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <kgolzhhd47x3iqkdrwyzh65ng4mm6cauxdjgiao2otztncyc3f@rskadwaph2l5>
References: <343vlonfhw76mnbjnysejihoxsjyp2kzwvedhjjjml4ccaygbq@72m67s3e2ped>
 <y2rpp6u6pksjrzgxsn5rtcsl2vspffkcbtu6tfzgo7thn7g23p@7quhaixfx5yh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y2rpp6u6pksjrzgxsn5rtcsl2vspffkcbtu6tfzgo7thn7g23p@7quhaixfx5yh>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,fromorbit.com,kernel.org,gmx.com,suse.com,vger.kernel.org,zeniv.linux.org.uk,lists.sourceforge.net,lists.linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C424121175
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Wed 09-07-25 13:49:12, Kent Overstreet wrote:
> On Wed, Jul 09, 2025 at 07:23:07PM +0200, Jan Kara wrote:
> > > It also avoids the problem of ->mark_dead events being generated
> > > from a context that holds filesystem/vfs locks and then deadlocking
> > > waiting for those locks to be released.
> > > 
> > > IOWs, a multi-device filesystem should really be implementing
> > > ->mark_dead itself, and should not be depending on being able to
> > > lock the superblock to take an active reference to it.
> > > 
> > > It should be pretty clear that these are not issues that the generic
> > > filesystem ->mark_dead implementation should be trying to
> > > handle.....
> > 
> > Well, IMO every fs implementation needs to do the bdev -> sb transition and
> > make sb somehow stable. It may be that grabbing s_umount and active sb
> > reference is not what everybody wants but AFAIU btrfs as the second
> > multi-device filesystem would be fine with that and for bcachefs this
> > doesn't work only because they have special superblock instantiation
> > behavior on mount for independent reasons (i.e., not because active ref
> > + s_umount would be problematic for them) if I understand Kent right.
> > So I'm still not fully convinced each multi-device filesystem should be
> > shipping their special method to get from device to stable sb reference.
> 
> Honestly, the sync_filesystem() call seems bogus.
> 
> If the block device is truly dead, what's it going to accomplish?

Notice that fs_bdev_mark_dead() calls sync_filesystem() only in case
'surprise' argument is false - meaning this is actually a notification
*before* the device is going away. I.e., graceful device hot unplug when
you can access the device to clean up as much as possible.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

