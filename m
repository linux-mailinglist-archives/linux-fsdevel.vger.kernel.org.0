Return-Path: <linux-fsdevel+bounces-67126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D32FC35DEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 14:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9DB3A6613
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91BB2DF6E6;
	Wed,  5 Nov 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MJwBx/ek";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K4xLPfqU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MJwBx/ek";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K4xLPfqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB730F801
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349829; cv=none; b=Lj0+HEoVc7V6XQKbgLpPil744CoMDNdPZFlRREoquPTbp2+bAVxSDqS5HpoWObd8uNBiqvhetQXJJaWkgZz2kS7ghZSPnmLEkbLQoN1iqDPC8GrAaQw2eksuHq+Uwcua+FkfO9YVTQFMkpanZkJKNyXUJVNxab1VHckS7NxK/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349829; c=relaxed/simple;
	bh=qx5uF7npMcRFYsWodp/mM3VYK3VLwcEGT5qaUyc0nfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSBEafuzce/hWIJVYbWxUFnORN2A37JnwhTZhXayhCfeLu0fXLaAWb0v+IjW6v6ZEHINVMkRAYKLFJTY1C3CiwC6eudNSy9bI7k/Tlff2Le/EgZOATtsxMA5hMxU7u8O1xzRXeaon7635dixR0OOXMgQUJCoO2u8dMPEc1/r02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MJwBx/ek; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K4xLPfqU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MJwBx/ek; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K4xLPfqU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F5341F394;
	Wed,  5 Nov 2025 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762349826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvbP9g5QyiQyGGML2yhORH082sXupYiHfPq3UnRkBgk=;
	b=MJwBx/ekzCSAZIuWCO45HheFRmxY9mV84XjpxnIjUpbkD0wIUykmszc++TUqZYF6JlAil8
	1w8QvWf5Wf9XnQgKQmomXpbZDiiGFkz+QxfvLiKc4ciVIa1RCGiBNO+rBdQ0dgitmBKxxl
	BE/Q1U/dRNrrixM/F7NJ/iYjy2frsDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762349826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvbP9g5QyiQyGGML2yhORH082sXupYiHfPq3UnRkBgk=;
	b=K4xLPfqUP78I1Y+ZJjaaOU/wWsY6qJn1JZdzX5sPz10TwdmXC7TESxMxEXCbt9zIsLh7Ri
	jX01A8XAdzpeU9Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="MJwBx/ek";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K4xLPfqU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762349826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvbP9g5QyiQyGGML2yhORH082sXupYiHfPq3UnRkBgk=;
	b=MJwBx/ekzCSAZIuWCO45HheFRmxY9mV84XjpxnIjUpbkD0wIUykmszc++TUqZYF6JlAil8
	1w8QvWf5Wf9XnQgKQmomXpbZDiiGFkz+QxfvLiKc4ciVIa1RCGiBNO+rBdQ0dgitmBKxxl
	BE/Q1U/dRNrrixM/F7NJ/iYjy2frsDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762349826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvbP9g5QyiQyGGML2yhORH082sXupYiHfPq3UnRkBgk=;
	b=K4xLPfqUP78I1Y+ZJjaaOU/wWsY6qJn1JZdzX5sPz10TwdmXC7TESxMxEXCbt9zIsLh7Ri
	jX01A8XAdzpeU9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00207132DD;
	Wed,  5 Nov 2025 13:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DbsCAAJTC2l5GAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 13:37:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9111CA28C0; Wed,  5 Nov 2025 14:37:05 +0100 (CET)
Date: Wed, 5 Nov 2025 14:37:05 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: generic_permission() optimization
Message-ID: <kn44smk4dgaj5rqmtcfr7ruecixzrik6omur2l2opitn7lbvfm@rm4y24fcfzbz>
References: <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
 <20250412215257.GF13132@mit.edu>
 <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
 <20250412235535.GH13132@mit.edu>
 <CAGudoHEJZ32rDUt4+n2-L-RU=bpGgkYMroxtdMF6MQjKRsW24w@mail.gmail.com>
 <20250413124054.GA1116327@mit.edu>
 <CAGudoHFciRp7qJtaHSOhLAxpCfT1NEf0+MN0iprnOYORYgXKbw@mail.gmail.com>
 <CAGudoHHrUkcGvhE3kwc9+kgdia_NREEeTj=_UBtiHCpUGEYwZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHrUkcGvhE3kwc9+kgdia_NREEeTj=_UBtiHCpUGEYwZg@mail.gmail.com>
X-Rspamd-Queue-Id: 0F5341F394
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 05-11-25 12:51:16, Mateusz Guzik wrote:
> On Wed, Nov 5, 2025 at 12:50 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Sun, Apr 13, 2025 at 2:40 PM Theodore Ts'o <tytso@mit.edu> wrote:
> > >
> > > On Sun, Apr 13, 2025 at 11:41:47AM +0200, Mateusz Guzik wrote:
> > > > This is the rootfs of the thing, so I tried it out with merely
> > > > printing it. I got 70 entries at boot time. I don't think figuring out
> > > > what this is specifically is warranted (it is on debian though).
> > >
> > > Well, can you run:
> > >
> > > debugfs -R "stat <INO>" /dev/ROOT_DEV
> > >
> > > on say, two or three of the inodes (replace INO with a number, and
> > > ROOT_DEV with the root file system device) and send me the result?
> > > That would be really helpful in understanding what might be going on.
> > >
> > > > So... I think this is good enough to commit? I had no part in writing
> > > > the patch and I'm not an ext4 person, so I'm not submitting it myself.
> > > >
> > > > Ted, you seem fine with the patch, so perhaps you could do the needful(tm)?
> > >
> > > Sure, I'll put together a more formal patch and do full QA run and
> > > checking of the code paths, as a supposed a fairly superficial review
> > > and hack.
> > >
> >
> > It looks like this well through the cracks.
> >
> > To recount, here is the patch (by Linus, not me):
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index f386de8c12f6..3e0ba7c4723a 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -5109,6 +5109,11 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
> > >                 goto bad_inode;
> > >         brelse(iloc.bh);
> > >
> > > +       if (test_opt(sb, DEBUG) &&
> > > +           (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
> > > +            ei->i_file_acl))
> > > +               ext4_msg(sb, KERN_DEBUG, "has xattr ino %lu", inode->i_ino);
> > > +
> > >         unlock_new_inode(inode);
> > >         return inode;
> >
> 
> sigh, copy-pasto, the patch is:
>   --- a/fs/ext4/inode.c
>   +++ b/fs/ext4/inode.c
>   @@ -5011,6 +5011,11 @@ struct inode *__ext4_iget(...
>         }
> 
>         brelse(iloc.bh);
>   +
>   +     /* Initialize the "no ACL's" state for the simple cases */
>   +     if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
>   +             cache_no_acl(inode);
>   +
>         unlock_new_inode(inode);
>         return inode;

This looks fine. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

