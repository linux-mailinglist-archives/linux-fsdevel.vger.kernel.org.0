Return-Path: <linux-fsdevel+bounces-60495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4649CB48A15
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 12:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B0C3BA10C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 10:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCAE2192E3;
	Mon,  8 Sep 2025 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FQkotf0q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hch28aMl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FQkotf0q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hch28aMl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D312F3C32
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327041; cv=none; b=TXa0C3KfofGabWotNJMHgT/Wo5PB+l+ZUoAtQIlRrxDxDm/Y9BkAEHWmdUOIeQXzFoKdokbG27TlXN4PTrrqtgVyg2qJOulJFY5UsE1ab7IY3IoDO1tttiFgnfuhkyWwELoZC9a85imkZIfzqqaKFKrWyfUjDZ6VfrPeLCzN2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327041; c=relaxed/simple;
	bh=JFDcW3/41b2wGUypt8IwETG5QidieqWfYu7AO+SZybM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AguRtDDu0nKF8i4vkNnoO+KAqro5wwdk1GJreVxB/QzKX21Y2Rvc3sTZ1necOfX1TVOBafOWeJXdWGrCV7Z8B+X+Ui6Ml1hln1t8LvsVTUjfnrbZpj5uyKc2iHE6ya0CGmMKUuFzQ69twlOIHSO7m6pBc8nIZEV9l8NMVYliMYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FQkotf0q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hch28aMl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FQkotf0q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hch28aMl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1531C26967;
	Mon,  8 Sep 2025 10:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757327036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giMSkVu6iZuTd3F6WFLO2amgP8Tq/LcoQwzRMPGCakQ=;
	b=FQkotf0q+5rnFWpuh4xYqwF/tqXU1GLs/mwZAiUJaMff57NCXx5CChnc6QM07U4ACGlQOs
	BhVgvnbOd33cuzv2rmm7K69gSmXIC2YGfFf/kGATpgSf+fxU/go5vTrTaUMoGffs6XDA03
	XtGf2roVKmFVXpBa0agbuOAkzchlwpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757327036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giMSkVu6iZuTd3F6WFLO2amgP8Tq/LcoQwzRMPGCakQ=;
	b=Hch28aMlk22Mfe8TGvGRbrPFoDLninHAqHkGUfSH1WtOZUx1no1xOEW1k/Y9b/XbKN+wQy
	0EgRgD1PrvhL3HDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757327036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giMSkVu6iZuTd3F6WFLO2amgP8Tq/LcoQwzRMPGCakQ=;
	b=FQkotf0q+5rnFWpuh4xYqwF/tqXU1GLs/mwZAiUJaMff57NCXx5CChnc6QM07U4ACGlQOs
	BhVgvnbOd33cuzv2rmm7K69gSmXIC2YGfFf/kGATpgSf+fxU/go5vTrTaUMoGffs6XDA03
	XtGf2roVKmFVXpBa0agbuOAkzchlwpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757327036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giMSkVu6iZuTd3F6WFLO2amgP8Tq/LcoQwzRMPGCakQ=;
	b=Hch28aMlk22Mfe8TGvGRbrPFoDLninHAqHkGUfSH1WtOZUx1no1xOEW1k/Y9b/XbKN+wQy
	0EgRgD1PrvhL3HDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0534113A54;
	Mon,  8 Sep 2025 10:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 05FAAbyuvmgWewAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 10:23:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AEB67A09EB; Mon,  8 Sep 2025 12:23:55 +0200 (CEST)
Date: Mon, 8 Sep 2025 12:23:55 +0200
From: Jan Kara <jack@suse.cz>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Mark Tinguely <mark.tinguely@oracle.com>, ocfs2-devel@lists.linux.dev, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, jlbec@evilplan.org, mark@fasheh.com, brauner@kernel.org, 
	willy@infradead.org, david@fromorbit.com
Subject: Re: [External] : [PATCH] ocfs2: retire ocfs2_drop_inode() and
 I_WILL_FREE usage
Message-ID: <rvavp2omizs6e3qf6xpjpycf6norhfhnkrle4fq4632atgar5v@dghmwbctf2mm>
References: <766vdz3ecpm7hv4sp5r3uu4ezggm532ng7fdklb2nrupz6minz@qcws3ufabnjp>
 <20250904154245.644875-1-mjguzik@gmail.com>
 <f3671198-5231-41cf-b0bc-d1280992947a@oracle.com>
 <CAGudoHHT=P_UyZZpx5tBRHPE+irh1b7PxFXZAHjdHNLcEWOxAQ@mail.gmail.com>
 <8ddcaa59-0cf0-4b7c-a121-924105f7f5a6@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ddcaa59-0cf0-4b7c-a121-924105f7f5a6@linux.alibaba.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	REDIRECTOR_URL(0.00)[urldefense.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,lists.linux.dev,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,evilplan.org,fasheh.com,kernel.org,infradead.org,fromorbit.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 08-09-25 09:51:36, Joseph Qi wrote:
> On 2025/9/5 00:22, Mateusz Guzik wrote:
> > On Thu, Sep 4, 2025 at 6:15 PM Mark Tinguely <mark.tinguely@oracle.com> wrote:
> >>
> >> On 9/4/25 10:42 AM, Mateusz Guzik wrote:
> >>> This postpones the writeout to ocfs2_evict_inode(), which I'm told is
> >>> fine (tm).
> >>>
> >>> The intent is to retire the I_WILL_FREE flag.
> >>>
> >>> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> >>> ---
> >>>
> >>> ACHTUNG: only compile-time tested. Need an ocfs2 person to ack it.
> >>>
> >>> btw grep shows comments referencing ocfs2_drop_inode() which are already
> >>> stale on the stock kernel, I opted to not touch them.
> >>>
> >>> This ties into an effort to remove the I_WILL_FREE flag, unblocking
> >>> other work. If accepted would be probably best taken through vfs
> >>> branches with said work, see https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.18.inode.refcount.preliminaries__;!!ACWV5N9M2RV99hQ!OLwk8DVo7uvC-Pd6XVTiUCgP6MUDMKBMEyuV27h_yPGXOjaq078-kMdC9ILFoYQh-4WX93yb0nMfBDFFY_0$
> >>>
> >>>   fs/ocfs2/inode.c       | 23 ++---------------------
> >>>   fs/ocfs2/inode.h       |  1 -
> >>>   fs/ocfs2/ocfs2_trace.h |  2 --
> >>>   fs/ocfs2/super.c       |  2 +-
> >>>   4 files changed, 3 insertions(+), 25 deletions(-)
> >>>
> >>> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> >>> index 6c4f78f473fb..5f4a2cbc505d 100644
> >>> --- a/fs/ocfs2/inode.c
> >>> +++ b/fs/ocfs2/inode.c
> >>> @@ -1290,6 +1290,8 @@ static void ocfs2_clear_inode(struct inode *inode)
> >>>
> >>>   void ocfs2_evict_inode(struct inode *inode)
> >>>   {
> >>> +     write_inode_now(inode, 1);
> >>> +
> >>>       if (!inode->i_nlink ||
> >>>           (OCFS2_I(inode)->ip_flags & OCFS2_INODE_MAYBE_ORPHANED)) {
> >>>               ocfs2_delete_inode(inode);
> >>> @@ -1299,27 +1301,6 @@ void ocfs2_evict_inode(struct inode *inode)
> >>>       ocfs2_clear_inode(inode);
> >>>   }
> >>>
> >>> -/* Called under inode_lock, with no more references on the
> >>> - * struct inode, so it's safe here to check the flags field
> >>> - * and to manipulate i_nlink without any other locks. */
> >>> -int ocfs2_drop_inode(struct inode *inode)
> >>> -{
> >>> -     struct ocfs2_inode_info *oi = OCFS2_I(inode);
> >>> -
> >>> -     trace_ocfs2_drop_inode((unsigned long long)oi->ip_blkno,
> >>> -                             inode->i_nlink, oi->ip_flags);
> >>> -
> >>> -     assert_spin_locked(&inode->i_lock);
> >>> -     inode->i_state |= I_WILL_FREE;
> >>> -     spin_unlock(&inode->i_lock);
> >>> -     write_inode_now(inode, 1);
> >>> -     spin_lock(&inode->i_lock);
> >>> -     WARN_ON(inode->i_state & I_NEW);
> >>> -     inode->i_state &= ~I_WILL_FREE;
> >>> -
> >>> -     return 1;
> >>> -}
> >>> -
> >>>   /*
> >>>    * This is called from our getattr.
> >>>    */
> >>> diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
> >>> index accf03d4765e..07bd838e7843 100644
> >>> --- a/fs/ocfs2/inode.h
> >>> +++ b/fs/ocfs2/inode.h
> >>> @@ -116,7 +116,6 @@ static inline struct ocfs2_caching_info *INODE_CACHE(struct inode *inode)
> >>>   }
> >>>
> >>>   void ocfs2_evict_inode(struct inode *inode);
> >>> -int ocfs2_drop_inode(struct inode *inode);
> >>>
> >>>   /* Flags for ocfs2_iget() */
> >>>   #define OCFS2_FI_FLAG_SYSFILE               0x1
> >>> diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
> >>> index 54ed1495de9a..4b32fb5658ad 100644
> >>> --- a/fs/ocfs2/ocfs2_trace.h
> >>> +++ b/fs/ocfs2/ocfs2_trace.h
> >>> @@ -1569,8 +1569,6 @@ DEFINE_OCFS2_ULL_ULL_UINT_EVENT(ocfs2_delete_inode);
> >>>
> >>>   DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_clear_inode);
> >>>
> >>> -DEFINE_OCFS2_ULL_UINT_UINT_EVENT(ocfs2_drop_inode);
> >>> -
> >>>   TRACE_EVENT(ocfs2_inode_revalidate,
> >>>       TP_PROTO(void *inode, unsigned long long ino,
> >>>                unsigned int flags),
> >>> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> >>> index 53daa4482406..e4b0d25f4869 100644
> >>> --- a/fs/ocfs2/super.c
> >>> +++ b/fs/ocfs2/super.c
> >>> @@ -129,7 +129,7 @@ static const struct super_operations ocfs2_sops = {
> >>>       .statfs         = ocfs2_statfs,
> >>>       .alloc_inode    = ocfs2_alloc_inode,
> >>>       .free_inode     = ocfs2_free_inode,
> >>> -     .drop_inode     = ocfs2_drop_inode,
> >>> +     .drop_inode     = generic_delete_inode,
> >>>       .evict_inode    = ocfs2_evict_inode,
> >>>       .sync_fs        = ocfs2_sync_fs,
> >>>       .put_super      = ocfs2_put_super,
> >>
> >>
> >> I agree, fileystems should not use I_FREEING/I_WILL_FREE.
> >> Doing the sync write_inode_now() should be fine in ocfs_evict_inode().
> >>
> >> Question is ocfs_drop_inode. In commit 513e2dae9422:
> >>   ocfs2: flush inode data to disk and free inode when i_count becomes zero
> >> the return of 1 drops immediate to fix a memory caching issue.
> >> Shouldn't .drop_inode() still return 1?
> > 
> > generic_delete_inode is a stub doing just that.
> > 
> In case of "drop = 0", it may return directly without calling evict().
> This seems break the expectation of commit 513e2dae9422.

generic_delete_inode() always returns 1 so evict() will be called.
ocfs2_drop_inode() always returns 1 as well after 513e2dae9422. So I'm not
sure which case of "drop = 0" do you see...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

