Return-Path: <linux-fsdevel+bounces-38332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8DF9FFAC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 16:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9273A36D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7301B4120;
	Thu,  2 Jan 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HD+wGqXO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIhBINAW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HD+wGqXO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIhBINAW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBEBA20;
	Thu,  2 Jan 2025 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735830425; cv=none; b=V2AeKwtiQ9ry4Gegph9AzEEfdYE83VrDXnkyyHmjXPOg4byI7fNiwmhZW9oPV3A/Ha+d/9uKEGjK0C1XmxiEwsxbgOsMXpSUrjDIB69zMEerAxTXANLjfqDm+SJIlrOtP0zbAUYy4xTwyG8Wo86+4xQfEiMGPTnUY5V5omH+gwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735830425; c=relaxed/simple;
	bh=1SSq4tAPQQ/xvB3dU1qDRP1hcvNciB54nXD+bhrq7ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkkUPzv1KOz0AtHGCpSAGcqwdag8iKEfwzecoowdn/KOeD/nM6wItnCYzZR0Burbxwrfvf4kGa8WHrSZksZ3YPYNkNiPj3VkgggcggVCU4DB4MXTqxyXqodLlPXs+mUvsQK34ho1VgUha0fcGM3NWRVmGS/VHIeLH/zjB3+ZUIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HD+wGqXO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIhBINAW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HD+wGqXO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIhBINAW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CEB71F38F;
	Thu,  2 Jan 2025 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735830421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLH3ikKt+2KoKQm4QPtBKyR6HPHYGUSsry5Sh9QGFPQ=;
	b=HD+wGqXOv8Z4I9RIHGWjR99nBLUEEk40zY6wv4jGWGO/r5PcanA+BHsRGMKnmWmLJ+xr0F
	61F3MpL2Ih5NXIFBYM8Iw5lDbynbC3gBmwHWr+R0kFUhSP3SJiFMe6o8Sw6gnAj/XIyFTb
	gGgd+gs9uPATzzQV/w2Lzpia8yIJG9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735830421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLH3ikKt+2KoKQm4QPtBKyR6HPHYGUSsry5Sh9QGFPQ=;
	b=EIhBINAWFu9lxMvkgLJCUNM0TLj+YZfWYToPfwfnLwz0+4OQUBKTuvB9zh7JSpIPV4o/LN
	yOdgnZx88xKmJ4DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HD+wGqXO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EIhBINAW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735830421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLH3ikKt+2KoKQm4QPtBKyR6HPHYGUSsry5Sh9QGFPQ=;
	b=HD+wGqXOv8Z4I9RIHGWjR99nBLUEEk40zY6wv4jGWGO/r5PcanA+BHsRGMKnmWmLJ+xr0F
	61F3MpL2Ih5NXIFBYM8Iw5lDbynbC3gBmwHWr+R0kFUhSP3SJiFMe6o8Sw6gnAj/XIyFTb
	gGgd+gs9uPATzzQV/w2Lzpia8yIJG9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735830421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLH3ikKt+2KoKQm4QPtBKyR6HPHYGUSsry5Sh9QGFPQ=;
	b=EIhBINAWFu9lxMvkgLJCUNM0TLj+YZfWYToPfwfnLwz0+4OQUBKTuvB9zh7JSpIPV4o/LN
	yOdgnZx88xKmJ4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0F2213418;
	Thu,  2 Jan 2025 15:07:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7SGFOpSrdmd+HgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Jan 2025 15:07:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9FA10A0844; Thu,  2 Jan 2025 16:06:56 +0100 (CET)
Date: Thu, 2 Jan 2025 16:06:56 +0100
From: Jan Kara <jack@suse.cz>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: Errno codes from symlink() syscall
Message-ID: <u7omfwq7othzaol24tio5tmmhc5kmpjhrqoxrzwtkhus65koa6@4bccjy7zza4w>
References: <20241224160535.pi6nazpugqkhvfns@pali>
 <20241227130139.dplqu5jlli57hhhm@pali>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241227130139.dplqu5jlli57hhhm@pali>
X-Rspamd-Queue-Id: 0CEB71F38F
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 27-12-24 14:01:39, Pali Rohár wrote:
> On Tuesday 24 December 2024 17:05:35 Pali Rohár wrote:
> > TL;DR;
> > Which errno code should network fs driver returns on create symlink
> > failure to userspace application for these cases?
> > * creating new symlink is not supported by fs driver mount options
> > * creating new symlink is not supported by remote server software
> > * creating new symlink is not supported by remote server storage
> > * creating new symlink is not permitted for user due to missing
> >   privilege/capability (indicated by remote server)
> > * access to the directory was denied due to ACL/mode (on remote)
> > 
> > 
> > Hello,
> > 
> > I discussed with Steve that current error codes from symlink() syscall
> > propagated to userspace on mounted SMB share are in most cases
> > misleading for end user who is trying to create a new symlink via ln -s
> > command.
> > 
> > Linux SMB client (cifs.ko) can see different kind of errors when it is
> > trying to create a symlink on SMB server. I know at least about these
> > errors which can happen:
> > 
> > 1 For the current mount parameters, the Linux SMB client does not
> >   implement creating a new symlink yet and server supports symlinks.
> >   This applies for example for SMB1 dialect against Windows server, when
> >   Linux SMB client is already able to query existing symlinks via
> >   readlink() syscall (just not able to create new one).
> > 
> > 2 For the current mount parameters, the SMB server does not support
> >   symlink operations at all. But it can support it when using other
> >   mount parameters. This applies for example for older Samba server with
> >   SMB2+ dialect (when older version supported symlinks only over SMB1).
> > 
> > 3 The SMB server for the mounted share does not support symlink
> >   operations at all. For example server supports symlinks, but mounted
> >   share is on FAT32 on which symlinks cannot be stored.
> > 
> > 4 The user who is logged to SMB server does not have a privilege to
> >   create a new symlink at all. But server and also share supports
> >   symlinks without any problem. Just this user is less privileged,
> >   and no ACL/mode can help.
> > 
> > 5 The user does not have access right to create a new object (file,
> >   directory, symlink, etc...) in the specified directory. For example
> >   "chmod -w" can cause this.
> > 
> > Linux SMB client should have all information via different SMB error
> > codes to distinguish between all these 5 situations.
> > 
> > On Windows servers for creating a new symlink is required that user has
> > SeCreateSymbolicLinkPrivilege. This privilege is by default enabled only
> > for Administrators, so by default ordinary users cannot create symlinks
> > due to security restrictions. On the other hand, querying symlink path
> > is allowed for any user (who has access to that symlink fs object).
> > 
> > Therefore it is important for user who is calling 'ln -s' command on SMB
> > share mounted on Linux to distinguish between 4 and 5 on failure. If
> > user needs to just add "write-directory" permission (chmod +w) or asking
> > AD admin for adding SeCreateSymbolicLinkPrivilege into Group Policy.
> > 
> > 
> > I would like to open a discussion on fsdevel list, what errno codes from
> > symlink() syscall should be reported to userspace for particular
> > situations 1 - 5?
> > 
> > Situation 5 should be classic EACCES. I think this should be clear.
> > 
> > Situation 4 start to be complicated. Windows "privilege" is basically
> > same as Linux "capability", it is bound to the process and in normal
> > situation it is set by login manager. Just Linux does not have
> > equivalent capability for allowing creating new symlink. But generally
> > Linux for missing permission which is granted by capability (e.g. for
> > ioperm() via CAP_SYS_RAWIO) is in lot of cases returned errno EPERM.
> > 
> > So I thought that EPERM is a good errno candidate for situation 4, until
> > I figured out that "symlink(2)" manapage has documented that EPERM has
> > completely different meaning:
> > 
> >   EPERM  The filesystem containing linkpath does not support the
> >          creation of symbolic links.
> > 
> > And I do not understand why. I have tried to call 'ln -s' on FAT32 and
> > it really showed me: "Operation not permitted" even under root. For user
> > this error message sounds like it needs to be admin / root. It is very
> > misleading.
> > 
> > At least it looks like that EPERM cannot be used for this situation.
> > And so it is not so easy to figure out what error codes should be
> > correctly returned to userspace.
> > 
> > 
> > Pali
> 
> I was thinking more about it and the reasonable solution could be to use
> following errno codes for these situations:
> 
>  EOPNOTSUPP - server or client does not support symlink operation
>  EPERM - user does not have privilege / capability to create new symlink
>  EACCES - user does not have (ACL) permission to create new symlink

Yes, this looks sensible to me.

> But in this case it would be needed to extend symlink(2) manpage. It is
> feasible? Or the meaning of EPERM is written in the stone, it means that
> operation is not supported, and it cannot be changed?
> 
> For me it sounds a bug if EPERM means "not supported", and also "ln -s"
> tool does not understand this EPERM error as it shows human readable
> message "Operation not permitted" instead of "Operation not supported"
> (which is the correct one in this situation).

What manpage says can certainly be changed, just write to the manpage
maintainer. After all it is just documenting how the code behaves. I didn't
find anything in the standards that would forbid this behavior and we don't
even take standards too seriously ;). What matters is application behavior.
I would be a bit reluctant to change EPERM return code to EOPNOTSUPP for
all the filesystems (as much as I agree it would be more sensible error) as
I don't see a strong enough reason for risking that it might break some
application somewhere. But making Samba behave as above and documenting in
the manpage that EPERM means that particular problem for it sounds
certainly fine to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

