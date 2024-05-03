Return-Path: <linux-fsdevel+bounces-18644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7A08BAE84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 16:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3DC282150
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 14:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BCA154BF4;
	Fri,  3 May 2024 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ppJJr1aD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K2Swz6qM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ppJJr1aD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K2Swz6qM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20215444E;
	Fri,  3 May 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745361; cv=none; b=C6k3kgkHffScnHuxuSmrJEeA0zCNUtdKTU6kMObwEp5HNJyJ44fZgbXX6idv1AaafzceIXedKqsxfmY6rRCIrAM3I4qIQ6riwC5Lf9yZxMtPWT+DNo1RyuffxgqOkOMmvWcIiQxcWJVPoHZWMqohAuTtSg1bnrVhZspXVoU+1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745361; c=relaxed/simple;
	bh=yzxhMm+OX7Dr7aYseilNZKDnyQLup8KnYfLAkzglVJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6X+NFiT9TIx/kGdOHtuZyasgi+QXseA02eYGP1TH2Pyh+h4vZ5d1GZbkz3aqXIS74sgZcveCSdMcgzUIoJr/rCRthQTKRhCTtFlvKS6iSLZIYiLekdtJuBRjLHDxFAJXWWe3CnEUKw3h6WpBBBfbepdvkIB3Alr7sM1gAZndDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ppJJr1aD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K2Swz6qM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ppJJr1aD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K2Swz6qM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BDD42058F;
	Fri,  3 May 2024 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714745357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCLk7Ggx6SE086KTSnCfd61jjTZpX1jQg+IBaAc2Btk=;
	b=ppJJr1aDg5zyCfKxoPAv0SSHKf7byu4Soibv3aPPxehvtyCLU24K0tOeMK1fpq/qqj95vs
	7Huq/PJ28xC/3xVLnII9qSxTJ1RcdraPH7+4ontuw+BPYdhfT8CimDx96Mri7um/wZdp2y
	0ps8IuDnWu9frNbdqy3w1oYfR7Bn77M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714745357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCLk7Ggx6SE086KTSnCfd61jjTZpX1jQg+IBaAc2Btk=;
	b=K2Swz6qMrqILGKqgotraJ8/X4aWP6k8SUn/TJbAciKo7Ft3XSdSAGar/ZP8Se5nTgEpc3A
	yp9v4Br4dsQpGnDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714745357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCLk7Ggx6SE086KTSnCfd61jjTZpX1jQg+IBaAc2Btk=;
	b=ppJJr1aDg5zyCfKxoPAv0SSHKf7byu4Soibv3aPPxehvtyCLU24K0tOeMK1fpq/qqj95vs
	7Huq/PJ28xC/3xVLnII9qSxTJ1RcdraPH7+4ontuw+BPYdhfT8CimDx96Mri7um/wZdp2y
	0ps8IuDnWu9frNbdqy3w1oYfR7Bn77M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714745357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCLk7Ggx6SE086KTSnCfd61jjTZpX1jQg+IBaAc2Btk=;
	b=K2Swz6qMrqILGKqgotraJ8/X4aWP6k8SUn/TJbAciKo7Ft3XSdSAGar/ZP8Se5nTgEpc3A
	yp9v4Br4dsQpGnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78D1A13991;
	Fri,  3 May 2024 14:09:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wl16HQ3wNGYyEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 May 2024 14:09:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C2A5DA0A12; Fri,  3 May 2024 16:09:16 +0200 (CEST)
Date: Fri, 3 May 2024 16:09:16 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu,
	syzbot <syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com>,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
	ritesh.list@gmail.com, syzkaller-bugs@googlegroups.com,
	trix@redhat.com, yangerkun <yangerkun@huawei.com>
Subject: Re: [syzbot] [ext4?] WARNING in mb_cache_destroy
Message-ID: <20240503140916.zd33jcev7c6fy254@quack3>
References: <00000000000072c6ba06174b30b7@google.com>
 <0000000000003bf5be061751ae70@google.com>
 <20240502103341.t53u6ya7ujbzkkxo@quack3>
 <dca44ba5-5c33-05ef-d9de-21a84f9d7eaa@huawei.com>
 <20240503102328.cstcauc5qakmk2bg@quack3>
 <9209062c-fa94-33f3-fd89-834a3314c7ed@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9209062c-fa94-33f3-fd89-834a3314c7ed@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dd43bd0f7474512edc47];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,mit.edu,syzkaller.appspotmail.com,dilger.ca,vger.kernel.org,lists.linux.dev,kernel.org,google.com,gmail.com,googlegroups.com,redhat.com,huawei.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Fri 03-05-24 19:38:21, Baokun Li wrote:
> On 2024/5/3 18:23, Jan Kara wrote:
> > Hi!
> > 
> > On Fri 03-05-24 17:51:07, Baokun Li wrote:
> > > On 2024/5/2 18:33, Jan Kara wrote:
> > > > On Tue 30-04-24 08:04:03, syzbot wrote:
> > > > > syzbot has bisected this issue to:
> > > > > 
> > > > > commit 67d7d8ad99beccd9fe92d585b87f1760dc9018e3
> > > > > Author: Baokun Li <libaokun1@huawei.com>
> > > > > Date:   Thu Jun 16 02:13:56 2022 +0000
> > > > > 
> > > > >       ext4: fix use-after-free in ext4_xattr_set_entry
> > > > So I'm not sure the bisect is correct since the change is looking harmless.
> > > Yes, the root cause of the problem has nothing to do with this patch,
> > > and please see the detailed analysis below.
> > > > But it is sufficiently related that there indeed may be some relationship.
> > > > Anyway, the kernel log has:
> > > > 
> > > > [   44.932900][ T1063] EXT4-fs warning (device loop0): ext4_evict_inode:297: xattr delete (err -12)
> > > > [   44.943316][ T1063] EXT4-fs (loop0): unmounting filesystem.
> > > > [   44.949531][ T1063] ------------[ cut here ]------------
> > > > [   44.955050][ T1063] WARNING: CPU: 0 PID: 1063 at fs/mbcache.c:409 mb_cache_destroy+0xda/0x110
> > > > 
> > > > So ext4_xattr_delete_inode() called when removing inode has failed with
> > > > ENOMEM and later mb_cache_destroy() was eventually complaining about having
> > > > mbcache entry with increased refcount. So likely some error cleanup path is
> > > > forgetting to drop mbcache entry reference somewhere but at this point I
> > > > cannot find where. We'll likely need to play with the reproducer to debug
> > > > that. Baokun, any chance for looking into this?
> > > > 
> > > > 								Honza
> > > As you guessed, when -ENOMEM is returned in ext4_sb_bread(),
> > > the reference count of ce is not properly released, as follows.
> > > 
> > > ext4_create
> > >   __ext4_new_inode
> > >    security_inode_init_security
> > >     ext4_initxattrs
> > >      ext4_xattr_set_handle
> > >       ext4_xattr_block_find
> > >       ext4_xattr_block_set
> > >        ext4_xattr_block_cache_find
> > >          ce = mb_cache_entry_find_first
> > >              __entry_find
> > >              atomic_inc_not_zero(&entry->e_refcnt)
> > >          bh = ext4_sb_bread(inode->i_sb, ce->e_value, REQ_PRIO);
> > >          if (PTR_ERR(bh) == -ENOMEM)
> > >              return NULL;
> > > 
> > > Before merging into commit 67d7d8ad99be("ext4: fix use-after-free
> > > in ext4_xattr_set_entry"), it will not return early in
> > > ext4_xattr_ibody_find(),
> > > so it tries to find it in iboy, fails the check in xattr_check_inode() and
> > > returns without executing ext4_xattr_block_find(). Thus it will bisect
> > > the patch, but actually has nothing to do with it.
> > > 
> > > ext4_xattr_ibody_get
> > >   xattr_check_inode
> > >    __xattr_check_inode
> > >     check_xattrs
> > >      if (end - (void *)header < sizeof(*header) + sizeof(u32))
> > >        "in-inode xattr block too small"
> > > 
> > > Here's the patch in testing, I'll send it out officially after it is tested.
> > > (PS:  I'm not sure if propagating the ext4_xattr_block_cache_find() errors
> > > would be better.)
> > Great! Thanks for debugging this! Some comments to your fix below:
> > 
> > > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > > index b67a176bfcf9..5c9e751915fd 100644
> > > --- a/fs/ext4/xattr.c
> > > +++ b/fs/ext4/xattr.c
> > > @@ -3113,11 +3113,10 @@ ext4_xattr_block_cache_find(struct inode *inode,
> > > 
> > >           bh = ext4_sb_bread(inode->i_sb, ce->e_value, REQ_PRIO);
> > >           if (IS_ERR(bh)) {
> > > -            if (PTR_ERR(bh) == -ENOMEM)
> > > -                return NULL;
> > > +            if (PTR_ERR(bh) != -ENOMEM)
> > > +                EXT4_ERROR_INODE(inode, "block %lu read error",
> > > +                         (unsigned long)ce->e_value);
> > >               bh = NULL;
> > > -            EXT4_ERROR_INODE(inode, "block %lu read error",
> > > -                     (unsigned long)ce->e_value);
> > >           } else if (ext4_xattr_cmp(header, BHDR(bh)) == 0) {
> > >               *pce = ce;
> > >               return bh;
> > So if we get the ENOMEM error, continuing the iteration seems to be
> > pointless as we'll likely get it for the following entries as well. I think
> > the original behavior of aborting the iteration in case of ENOMEM is
> > actually better. We just have to do mb_cache_entry_put(ea_block_cache, ce)
> > before returning...
> > 
> > 								Honza
> Returning NULL here would normally attempt to allocate a new
> xattr_block in ext4_xattr_block_set(), and when ext4_sb_bread() fails,
> allocating the new block and inserting it would most likely fail as well,
> so my initial thought was to propagate the error from ext4_sb_bread()
> to also make ext4_xattr_block_set() fail when ext4_sb_bread() fails.

Yes, this would be probably even better solution.

> But I noticed that before Ted added the special handling for -ENOMEM,
> EXT4_ERROR_INODE was called to set the ERROR_FS flag no matter
> what error ext4_sb_bread() returned, and after we can distinguish
> between -EIO and -ENOMEM, we don't have to set the ERROR_FS flag
> in the case of -ENOMEM. So there's this conservative fix now.
> 
> In short, in my personal opinion, for -EIO and -ENOMEM, they should
> be the same except whether or not the ERROR_FS flag is set.
> Otherwise, I think adding mb_cache_entry_put() directly is the easiest
> and most straightforward fix.  Honza, do you have any other thoughts?

Yeah. I'd go for adding mb_cache_entry_put() now as a quick fix and then
work on propagating the error from ext4_xattr_block_cache_find() as a
cleaner solution...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

