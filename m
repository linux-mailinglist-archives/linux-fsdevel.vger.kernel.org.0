Return-Path: <linux-fsdevel+bounces-40589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091E2A2599F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 13:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926981886D17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 12:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EB9204C09;
	Mon,  3 Feb 2025 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NAjCFwx7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IwoVcn/E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qz20zXWG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w9Dk0qYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCB288B1;
	Mon,  3 Feb 2025 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586517; cv=none; b=YiOVriaTW5z0jTs1vuRt23R0vrA4PobD1QdfGgLHBmhuP2fAH3gKGaEAb01U4G8rizNUs4sxU+0FcFuyoBVS83ooMBDCBxEwp8yZJN3Fe0EQ9ki/+2ATn/dspAgWxlj4pfslHUbU2BgAsNr1uTPLZtu5segEnKQa1VtxrJ5IsBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586517; c=relaxed/simple;
	bh=V6Yamc+lCnqaifwCprEs2WCPVpEwMY6/zN8f4bDoo2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCJleXs8db9e9x1FCirGDOB5kyURx1vb7KFSMnO3ycQoLAkWxi9GPZL2f62ZlgLQU5T3wzcajZB2RKspeYCDB3iupBCDYXwZAvG866PslAb7HtcXZInRFtlETDADx5upcamo+4rinIWyhyFy9gEs6NRVxJhTGX0C45foAS+WvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NAjCFwx7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IwoVcn/E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qz20zXWG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w9Dk0qYu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CE3D21164;
	Mon,  3 Feb 2025 12:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738586509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJWjAyc38HgmMq7RG5PMlvFu0+nk7azvrMUFHWZiO7E=;
	b=NAjCFwx77MhrjumkrQSkgqr644JSzmfBTwNJz+HfFhQzApp/0kXZ7w+dyXIDXe5TqgoA3n
	Ir+14AAQ0j09IfzBwbrUgzuv5/Qg0Vc/Fr36ttXNgyAU6MxOhdeBoO9oibmK5kxUPs2x5P
	PilwBNXj+BVnKS2cX+2C31fWfNElH3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738586509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJWjAyc38HgmMq7RG5PMlvFu0+nk7azvrMUFHWZiO7E=;
	b=IwoVcn/ENnXitQ/oz5HqHn7NhLsERCl+5oGrOyOSiwk7Zc43g66hTmRUE/ADIMSD9L3pSv
	o6Zc7MM/ERGL7WBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Qz20zXWG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w9Dk0qYu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738586505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJWjAyc38HgmMq7RG5PMlvFu0+nk7azvrMUFHWZiO7E=;
	b=Qz20zXWG/jrWaw6ARmvtRiISjA3T7XBikeog7A91unNXyPHqCR/+lUQ+Wgv74cm08ZjSH8
	fFe2lTQWyj+AtDILBrIxUEHbJojee5UDowgSsKVC/7FXOwYqjNy7nER/HYzw5ZSk9Bnh/q
	gtKupnjRIAwMdlDN0Won2MwMY+vvOfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738586505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJWjAyc38HgmMq7RG5PMlvFu0+nk7azvrMUFHWZiO7E=;
	b=w9Dk0qYuqnOaeeXtGnx9wC58jQXmqaDZ37q9PG1Qk0nZzLJJMQVptS1CzAOgndg1zOCywT
	LHcIPAEppTyK2iDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A32F13795;
	Mon,  3 Feb 2025 12:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VnvJHYm5oGclIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Feb 2025 12:41:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 211EBA28E5; Mon,  3 Feb 2025 13:41:45 +0100 (CET)
Date: Mon, 3 Feb 2025 13:41:45 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults
 for files with pre content watches
Message-ID: <l5apiabdjosyy4gfuenr4oqdfio3zdiajzxoekdgtsohzpn3mj@dcmvayncbye4>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
 <20250131121703.1e4d00a7.alex.williamson@redhat.com>
 <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
 <Z512mt1hmX5Jg7iH@x1.local>
 <20250201-legehennen-klopfen-2ab140dc0422@brauner>
 <CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com>
 <CAOQ4uxjVTir-mmx05zh231BpEN1XbXpooscZyfNUYmVj32-d3w@mail.gmail.com>
 <20250202-abbauen-meerrettich-912513202ce4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250202-abbauen-meerrettich-912513202ce4@brauner>
X-Rspamd-Queue-Id: 8CE3D21164
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,redhat.com,toxicpanda.com,fb.com,vger.kernel.org,suse.cz,zeniv.linux.org.uk,kvack.org];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Sun 02-02-25 11:04:02, Christian Brauner wrote:
> On Sun, Feb 02, 2025 at 08:46:21AM +0100, Amir Goldstein wrote:
> > On Sun, Feb 2, 2025 at 1:58 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Sat, 1 Feb 2025 at 06:38, Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > Ok, but those "device fds" aren't really device fds in the sense that
> > > > they are character fds. They are regular files afaict from:
> > > >
> > > > vfio_device_open_file(struct vfio_device *device)
> > > >
> > > > (Well, it's actually worse as anon_inode_getfile() files don't have any
> > > > mode at all but that's beside the point.)?
> > > >
> > > > In any case, I think you're right that such files would (accidently?)
> > > > qualify for content watches afaict. So at least that should probably get
> > > > FMODE_NONOTIFY.
> > >
> > > Hmm. Can we just make all anon_inodes do that? I don't think you can
> > > sanely have pre-content watches on anon-inodes, since you can't really
> > > have access to them to _set_ the content watch from outside anyway..
> > >
> > > In fact, maybe do it in alloc_file_pseudo()?
> > >
> > 
> > The problem is that we cannot set FMODE_NONOTIFY -
> > we tried that once but it regressed some workloads watching
> > write on pipe fd or something.
> 
> Ok, that might be true. But I would assume that most users of
> alloc_file_pseudo() or the anonymous inode infrastructure will not care
> about fanotify events. I would not go for a separate helper. It'd be
> nice to keep the number of file allocation functions low.
> 
> I'd rather have the subsystems that want it explicitly opt-in to
> fanotify watches, i.e., remove FMODE_NONOTIFY. Because right now we have
> broken fanotify support for e.g., nsfs already. So make the subsystems
> think about whether they actually want to support it.

Agreed, that would be a saner default.

> I would disqualify all anonymous inodes and see what actually does
> break. I naively suspect that almost no one uses anonymous inodes +
> fanotify. I'd be very surprised.
> 
> I'm currently traveling (see you later btw) but from a very cursory
> reading I would naively suspect the following:
> 
> // Suspects for FMODE_NONOTIFY
> drivers/dma-buf/dma-buf.c:      file = alloc_file_pseudo(inode, dma_buf_mnt, "dmabuf",
> drivers/misc/cxl/api.c: file = alloc_file_pseudo(inode, cxl_vfs_mount, name,
> drivers/scsi/cxlflash/ocxl_hw.c:        file = alloc_file_pseudo(inode, ocxlflash_vfs_mount, name,
> fs/anon_inodes.c:       file = alloc_file_pseudo(inode, anon_inode_mnt, name,
> fs/hugetlbfs/inode.c:           file = alloc_file_pseudo(inode, mnt, name, O_RDWR,
> kernel/bpf/token.c:     file = alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME, O_RDWR, &bpf_token_fops);
> mm/secretmem.c: file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
> block/bdev.c:   bdev_file = alloc_file_pseudo_noaccount(BD_INODE(bdev),
> drivers/tty/pty.c: static int ptmx_open(struct inode *inode, struct file *filp)
> 
> // Suspects for ~FMODE_NONOTIFY
> fs/aio.c:       file = alloc_file_pseudo(inode, aio_mnt, "[aio]",

This is just a helper file for managing aio context so I don't think any
notification makes sense there (events are not well defined). So I'd say
FMODE_NONOTIFY here as well.

> fs/pipe.c:      f = alloc_file_pseudo(inode, pipe_mnt, "",
> mm/shmem.c:             res = alloc_file_pseudo(inode, mnt, name, O_RDWR,

This is actually used for stuff like IPC SEM where notification doesn't
make sense. It's also used when mmapping /dev/zero but that struct file
isn't easily accessible to userspace so overall I'd say this should be
FMODE_NONOTIFY as well.

> // Unsure:
> fs/nfs/nfs4file.c:      filep = alloc_file_pseudo(r_ino, ss_mnt, read_name, O_RDONLY,

AFAICS this struct file is for copy offload and doesn't leave the kernel.
Hence FMODE_NONOTIFY should be fine.

> net/socket.c:   file = alloc_file_pseudo(SOCK_INODE(sock), sock_mnt, dname,

In this case I think we need to be careful. It's a similar case as pipes so
probably we should use ~FMODE_NONOTIFY here from pure caution.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

