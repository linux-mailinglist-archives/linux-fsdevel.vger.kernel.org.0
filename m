Return-Path: <linux-fsdevel+bounces-43811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14564A5DFFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26413AAFA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80124501D;
	Wed, 12 Mar 2025 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g8m2uElF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="53s7N2b/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g8m2uElF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="53s7N2b/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00F139579
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792557; cv=none; b=inQ3jszU6BPbXFOTm+qeaBcS8ktBR5O9b2QLOTncD7G+XmuLiaC9tLxi+soANSevd7ik775VFmrTapwdB6JvujoHhl25JO5g0B4zEUDC3umVdEvBG4FxO2sU3bjzFcggNO+TsCWDEP6qSWkD346xQa6wybp+DiqCrIC2YqBvKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792557; c=relaxed/simple;
	bh=eiG7UH2tjEp1TaXxPsHu024Q7X5m0ZvFvgeV/U/EtBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7mBmqmaG3N0zYJxXgx7vzA6+43KJAoYaCoq3pH7ofH0XuRxmC5eeTwbF09MHaQch1BaRlJuuIFG43QceTv+imQ5QLMcWXpcrs+JfrruC+j96bDgVkAw2bG2LF46FIeIAdfNeflFiLAgiUN34Fxx8LceF3NQQ6yA6S4MT/xVgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g8m2uElF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=53s7N2b/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g8m2uElF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=53s7N2b/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9C8EF1F453;
	Wed, 12 Mar 2025 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741792553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcJn3CE+IaYGNWzumrq1+igK1DLyDjC0HD1poZgvqBI=;
	b=g8m2uElFrh5rkv2LALwDVdaIlvw7H4g66aDKXq9Sm5KYmLgnmdVOXPX13xu7yxflE3Fpjz
	TNZBI3mxYBhUpZswH9SFKtuOeeSB5tbxNm68l9SzHDLkMN+7x2Wl/7Xs0YqyYBASpGO1lL
	I8GE8tQUBZL+Vbn9gmKtC+XhEpnO1r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741792553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcJn3CE+IaYGNWzumrq1+igK1DLyDjC0HD1poZgvqBI=;
	b=53s7N2b/Z8KrXTi5rZ9ek/5nYdTKo8QHTC1J6ysl1Tv277sdsvhXElYVjvZ/f1OggRFEoO
	sUNHoITKQJ4XecAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741792553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcJn3CE+IaYGNWzumrq1+igK1DLyDjC0HD1poZgvqBI=;
	b=g8m2uElFrh5rkv2LALwDVdaIlvw7H4g66aDKXq9Sm5KYmLgnmdVOXPX13xu7yxflE3Fpjz
	TNZBI3mxYBhUpZswH9SFKtuOeeSB5tbxNm68l9SzHDLkMN+7x2Wl/7Xs0YqyYBASpGO1lL
	I8GE8tQUBZL+Vbn9gmKtC+XhEpnO1r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741792553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcJn3CE+IaYGNWzumrq1+igK1DLyDjC0HD1poZgvqBI=;
	b=53s7N2b/Z8KrXTi5rZ9ek/5nYdTKo8QHTC1J6ysl1Tv277sdsvhXElYVjvZ/f1OggRFEoO
	sUNHoITKQJ4XecAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 947A5132CB;
	Wed, 12 Mar 2025 15:15:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JtM6JCml0WeqCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Mar 2025 15:15:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C416A0908; Wed, 12 Mar 2025 16:15:53 +0100 (CET)
Date: Wed, 12 Mar 2025 16:15:53 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Fabian Frederick <fabf@skynet.be>, Jan Kara <jack@suse.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] udf: merge bh free
Message-ID: <7lfufsfaumw6tpr2ewjwnxyan2t2wcj3ibvl5kvtkllfhj22nf@f3sgvbtxl7f3>
References: <cb514af7-bbe0-435b-934f-dd1d7a16d2cd@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb514af7-bbe0-435b-934f-dd1d7a16d2cd@stanley.mountain>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hello Dan!

On Tue 11-03-25 15:35:20, Dan Carpenter wrote:
> Commit 02d4ca49fa22 ("udf: merge bh free") from Jan 6, 2017
> (linux-next), leads to the following Smatch static checker warning:

Thanks for the report! I think you've misidentified the commit introducing
the problem. The problem comes from a much more recent b405c1e58b73 ("udf:
refactor udf_next_aext() to handle error") which started to set 'ret' on
that path. But that's just a minor issue.

> 	fs/udf/namei.c:442 udf_mkdir()
> 	warn: passing positive error code '(-117),(-28),(-22),(-12),(-5),(-1),1' to 'ERR_PTR'
> 
> fs/udf/namei.c
>     422 static struct dentry *udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>     423                                 struct dentry *dentry, umode_t mode)
>     424 {
>     425         struct inode *inode;
>     426         struct udf_fileident_iter iter;
>     427         int err;
>     428         struct udf_inode_info *dinfo = UDF_I(dir);
>     429         struct udf_inode_info *iinfo;
>     430 
>     431         inode = udf_new_inode(dir, S_IFDIR | mode);
>     432         if (IS_ERR(inode))
>     433                 return ERR_CAST(inode);
>     434 
>     435         iinfo = UDF_I(inode);
>     436         inode->i_op = &udf_dir_inode_operations;
>     437         inode->i_fop = &udf_dir_operations;
>     438         err = udf_fiiter_add_entry(inode, NULL, &iter);
>     439         if (err) {
>     440                 clear_nlink(inode);
>     441                 discard_new_inode(inode);
> --> 442                 return ERR_PTR(err);
> 
> Returning ERR_PTR(1) will lead to an Oops in the caller.

Yeah, not good.

> The issue is this code from inode_getblk():
> 
> fs/udf/inode.c
>    787          /*
>    788           * Move prev_epos and cur_epos into indirect extent if we are at
>    789           * the pointer to it
>    790           */
>    791          ret = udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
>    792          if (ret < 0)
>    793                  goto out_free;
>    794          ret = udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
>                 ^^^^^^^^^^^^^^^^^^^
> ret is set here.  It can be a negative error code, zero for EOF or one
> on success.
> 
>    795          if (ret < 0)
>    796                  goto out_free;
>    797  
>    798          /* if the extent is allocated and recorded, return the block
>    799             if the extent is not a multiple of the blocksize, round up */
>    800  
>    801          if (!isBeyondEOF && etype == (EXT_RECORDED_ALLOCATED >> 30)) {
>    802                  if (elen & (inode->i_sb->s_blocksize - 1)) {
>    803                          elen = EXT_RECORDED_ALLOCATED |
>    804                                  ((elen + inode->i_sb->s_blocksize - 1) &
>    805                                   ~(inode->i_sb->s_blocksize - 1));
>    806                          iinfo->i_lenExtents =
>    807                                  ALIGN(iinfo->i_lenExtents,
>    808                                        inode->i_sb->s_blocksize);
>    809                          udf_write_aext(inode, &cur_epos, &eloc, elen, 1);
>    810                  }
>    811                  map->oflags = UDF_BLK_MAPPED;
>    812                  map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc, offset);
>    813                  goto out_free;
> 
> Smatch is concerned that the ret = 1 from this goto out_free gets
> propagated back to the caller.

Indeed. We should have set ret = 0 here to comply with the calling
convention of inode_getblk() which is 0 on success < 0 on error. I'll send
a fix.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

