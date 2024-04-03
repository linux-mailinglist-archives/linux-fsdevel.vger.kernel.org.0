Return-Path: <linux-fsdevel+bounces-16015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07205896D95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 13:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66FD2935BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649F14199C;
	Wed,  3 Apr 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rm/vG5mK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W6zFCVQ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE1A139588;
	Wed,  3 Apr 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142201; cv=none; b=KdmwNVp0w372cZqsnYwRlZS4ubqCAHSG/VC+RWFNVw199JN+50SDbPochQqwWkzwglvc78EaF8nzZHcvDkdl5WlW+yyFU4nmAdamW1pfeGExCxinK6Ij2q6J/5xSVC0O0viU5U5sEg1ggNBC3ouqIIufiB7+wiC6wRxWfwqGr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142201; c=relaxed/simple;
	bh=uMKHnDXTEm+EOZrtndTxFv/QNJgNWVRCusPPKwTHd64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOOgX68OfiWrOQrgTfufgKh83QW7DMqcA0PWst45Uyx93Oaw65TqEoQ8YRSXnUtSP+teXoL+48TbXeyT20FZzYlV7K8mm5oO4s1KJeQYBlTfqRMsvviOoXva03Oc+ZASlxo9oT7aqI43eW9mOwVhmHuisM7B3pzPCth9KvF8jsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rm/vG5mK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W6zFCVQ0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC81035270;
	Wed,  3 Apr 2024 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712142196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pcQEkiDoZSJwCrXrqPil+MhwkFDK8GbPO7YjAbOieLo=;
	b=rm/vG5mKI5motS3wQle0dgofSHgXQain5VpuEGueEfffm/xtxpALt17FuuFyyMRw1NQPBs
	84tWRZmmB1D/N4ikPyWKQTBhSmvdizwz58GYEjAyl4Y+3tPjGZvjAj9W5QWacOUUVC/GOD
	nrIJkqvL0yYoHBsOeR4Wzgtz/sT/8rE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712142196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pcQEkiDoZSJwCrXrqPil+MhwkFDK8GbPO7YjAbOieLo=;
	b=W6zFCVQ0QbqGZG82yh1ffhmB4224NDIE5PVvCEN6M6Q9+8oz1SnJEVwvqSIqcSEdVON0lp
	1KVpt2Cy/S3nDlDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AC29013357;
	Wed,  3 Apr 2024 11:03:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EiH8KXQ3DWaIGgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 03 Apr 2024 11:03:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6839EA0814; Wed,  3 Apr 2024 13:03:16 +0200 (CEST)
Date: Wed, 3 Apr 2024 13:03:16 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	syzbot <syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com>,
	Edward Adam Davis <eadavis@qq.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, amir73il@gmail.com,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [linux-next:master] [fs]  1b43c46297: kernel_BUG_at_mm/usercopy.c
Message-ID: <20240403110316.qtmypq2rtpueloga@quack3>
References: <202404031550.f3de0571-lkp@intel.com>
 <000000000000f075b9061520cbbe@google.com>
 <tencent_A7845DD769577306D813742365E976E3A205@qq.com>
 <20240403-mundgerecht-klopapier-e921ceb787ca@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403-mundgerecht-klopapier-e921ceb787ca@brauner>
X-Rspamd-Queue-Id: BC81035270
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.975];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[4139435cb1b34cf759c2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,syzkaller.appspotmail.com,qq.com,kernel.org,lists.linux.dev,kvack.org,suse.cz,vger.kernel.org,gmail.com,oracle.com,googlegroups.com,zeniv.linux.org.uk];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 03-04-24 10:46:19, Christian Brauner wrote:
> On Wed, Apr 03, 2024 at 02:54:14PM +0800, Edward Adam Davis wrote:
> > [Syzbot reported]
> > BUG: KASAN: slab-out-of-bounds in instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
> > BUG: KASAN: slab-out-of-bounds in _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
> > Write of size 48 at addr ffff88802b8cbc88 by task syz-executor333/5090
> > 
> > CPU: 0 PID: 5090 Comm: syz-executor333 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> >  print_address_description mm/kasan/report.c:377 [inline]
> >  print_report+0x169/0x550 mm/kasan/report.c:488
> >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> >  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
> >  instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
> >  _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
> >  copy_from_user include/linux/uaccess.h:183 [inline]
> >  handle_to_path fs/fhandle.c:203 [inline]
> >  do_handle_open+0x204/0x660 fs/fhandle.c:226
> >  do_syscall_64+0xfb/0x240
> >  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> > [Fix] 
> > When copying data to f_handle, the length of the copied data should not include
> > the length of "struct file_handle".
> > 
> > Reported-by: syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  fs/fhandle.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index 53ed54711cd2..8a7f86c2139a 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -202,7 +202,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
> >  	*handle = f_handle;
> >  	if (copy_from_user(&handle->f_handle,
> >  			   &ufh->f_handle,
> > -			   struct_size(ufh, f_handle, f_handle.handle_bytes))) {
> > +			   f_handle.handle_bytes)) {
> 
> Groan, of course. What a silly mistake. Thanks for the fix.
> I'll fold this into:
> Fixes: 1b43c4629756 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
> because this hasn't hit mainline yet and it doesn't make sense to keep
> that bug around.
> 
> Sorry, that'll mean we drop your patch but I'll give you credit in the
> commit log of the original patch.

Indeed, I should have caught this during review. Sorry for that and thanks
for fixing this up quickly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

