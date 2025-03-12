Return-Path: <linux-fsdevel+bounces-43812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B828A5E069
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4887ABAC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 15:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FC42505C6;
	Wed, 12 Mar 2025 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c+/DuXte";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wrf7+fRi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c+/DuXte";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wrf7+fRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0482512C5
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793587; cv=none; b=I2RccE+E/1W59Nh7zCzwGpTGQmUG/cEC4Y/di8YGPUVHWLrp5KLH/RVORBNWJTKjq8LkRsPQhqGmzxAWZfuiiHlvcEymp35W2OOrOBEEIW0nEuLMEsbSxYphf1wnLnQfHHWeKgMQMOhQEwur33+9/h4rTzyKk9zNlnGq9uz1vkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793587; c=relaxed/simple;
	bh=z2hs4CfgX9OfKD1WnBlTX6824d9OyYlX2OL06nlA0AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+Hk2GN8mzXE8vb7xkngcCDGc1HA1qwCmKeNg7JvynzuudbyNnJGOtMoV9xpdQv5oblgvX91IgaL1qLVgue2uoa7vJKAwsU2r6cNZj+IfBdn0DCMXWgJ7dcAFKUo4ypNLumYv2PKsC8cXhjGLZbqvQ7kZBvq5gUoA5a7s3R+COs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c+/DuXte; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wrf7+fRi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c+/DuXte; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wrf7+fRi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E506211CF;
	Wed, 12 Mar 2025 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741793584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HloKuTltoU70unHlUzSjk95UWlnJ5shMlX4ZT7p+20g=;
	b=c+/DuXteZz+Tc00Cw4lCy06Vuj/zKTxTZq4jb6AfFA4bDGS4ogjkeK1CBaGYVXvgyNe308
	4vMjRj/3fB6CtNYpEJjjttWrJA/NYET07piElDNkinFUZB+d6ny75yvdYVRWiZnDtYdlbT
	KdHy3F4tt3ouCcKGm3s056vj8kQ6UwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741793584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HloKuTltoU70unHlUzSjk95UWlnJ5shMlX4ZT7p+20g=;
	b=Wrf7+fRiueV31n1Rs3jnq7XzxRVLcMzgqTRDiAHEZmTnD7PRDRw9Q3SS4zma6Kh2h3d6A2
	IcFWn3lFE7lz3mCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741793584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HloKuTltoU70unHlUzSjk95UWlnJ5shMlX4ZT7p+20g=;
	b=c+/DuXteZz+Tc00Cw4lCy06Vuj/zKTxTZq4jb6AfFA4bDGS4ogjkeK1CBaGYVXvgyNe308
	4vMjRj/3fB6CtNYpEJjjttWrJA/NYET07piElDNkinFUZB+d6ny75yvdYVRWiZnDtYdlbT
	KdHy3F4tt3ouCcKGm3s056vj8kQ6UwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741793584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HloKuTltoU70unHlUzSjk95UWlnJ5shMlX4ZT7p+20g=;
	b=Wrf7+fRiueV31n1Rs3jnq7XzxRVLcMzgqTRDiAHEZmTnD7PRDRw9Q3SS4zma6Kh2h3d6A2
	IcFWn3lFE7lz3mCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26AD6132CB;
	Wed, 12 Mar 2025 15:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fTdvCTCp0WdQDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Mar 2025 15:33:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D333DA0908; Wed, 12 Mar 2025 16:32:55 +0100 (CET)
Date: Wed, 12 Mar 2025 16:32:55 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Fabian Frederick <fabf@skynet.be>, Jan Kara <jack@suse.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] udf: merge bh free
Message-ID: <qt7dvq6f27jeka2je5474naztkiicmcw4czcn6mspyswotdr5z@2hxnydxvs6zo>
References: <cb514af7-bbe0-435b-934f-dd1d7a16d2cd@stanley.mountain>
 <7lfufsfaumw6tpr2ewjwnxyan2t2wcj3ibvl5kvtkllfhj22nf@f3sgvbtxl7f3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7lfufsfaumw6tpr2ewjwnxyan2t2wcj3ibvl5kvtkllfhj22nf@f3sgvbtxl7f3>
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

On Wed 12-03-25 16:15:53, Jan Kara wrote:
> Hello Dan!
> 
> On Tue 11-03-25 15:35:20, Dan Carpenter wrote:
> > Commit 02d4ca49fa22 ("udf: merge bh free") from Jan 6, 2017
> > (linux-next), leads to the following Smatch static checker warning:
> 
> Thanks for the report! I think you've misidentified the commit introducing
> the problem. The problem comes from a much more recent b405c1e58b73 ("udf:
> refactor udf_next_aext() to handle error") which started to set 'ret' on
> that path. But that's just a minor issue.
> 
> > 	fs/udf/namei.c:442 udf_mkdir()
> > 	warn: passing positive error code '(-117),(-28),(-22),(-12),(-5),(-1),1' to 'ERR_PTR'
> > 
> > fs/udf/namei.c
> >     422 static struct dentry *udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> >     423                                 struct dentry *dentry, umode_t mode)
> >     424 {
> >     425         struct inode *inode;
> >     426         struct udf_fileident_iter iter;
> >     427         int err;
> >     428         struct udf_inode_info *dinfo = UDF_I(dir);
> >     429         struct udf_inode_info *iinfo;
> >     430 
> >     431         inode = udf_new_inode(dir, S_IFDIR | mode);
> >     432         if (IS_ERR(inode))
> >     433                 return ERR_CAST(inode);
> >     434 
> >     435         iinfo = UDF_I(inode);
> >     436         inode->i_op = &udf_dir_inode_operations;
> >     437         inode->i_fop = &udf_dir_operations;
> >     438         err = udf_fiiter_add_entry(inode, NULL, &iter);
> >     439         if (err) {
> >     440                 clear_nlink(inode);
> >     441                 discard_new_inode(inode);
> > --> 442                 return ERR_PTR(err);
> > 
> > Returning ERR_PTR(1) will lead to an Oops in the caller.
> 
> Yeah, not good.

BTW, I've realized this is not really possible to hit in practice because
udf_fiiter_add_entry() calls udf_bread() (and thus inode_getblk()) for
known unallocated block and thus the path in inode_getblk() with the wrong
return value will not be executed in this case. Still this is rather
dangerous bug and better have it fixed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

