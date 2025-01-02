Return-Path: <linux-fsdevel+bounces-38331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38269FFA85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CB67A1AD1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562F1B392C;
	Thu,  2 Jan 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HKF1C4pL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+aInUHKR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HKF1C4pL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+aInUHKR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE83191489;
	Thu,  2 Jan 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735828674; cv=none; b=ji3etfAIyOEXq51MoaqRjbW03S70id54uSwAzxRlzEy347Ecj5jvzIDkYmOCdzDJwPC6h/pfHJ4gmuDoPdZSVh8LCk3Wt7zVv2Fcvf2AKeTsHEX/ds26nFSfusOZ7m1OiJuHSimoDHKF7iXRigyB14dbU0HLEZp6RWGep8+uKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735828674; c=relaxed/simple;
	bh=vrslAyZJSMAnwx/bx+27ILdnXVg60Y7Pwc3rMG3j8k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpgopJRFl+NRaxsyjKiHlMXfAs6K+Q42khnjorEuyBx4cp2dX0tburz3gNu9cmefnZLOoOF84piSrCZUdCcdzahdIVPYITcXV71IryQqDKNUXY4FcHZXJ2GHu48iVDWYiCFJP0EPFrlANnhwc84nEOpuZB8zZgxJ+IDbb+2HOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HKF1C4pL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+aInUHKR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HKF1C4pL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+aInUHKR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21F27211B4;
	Thu,  2 Jan 2025 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735828671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jALyLmH5Wjf7WNRQOooZcqWz5mWM/83st2sEg1mZ7xQ=;
	b=HKF1C4pLR7NZC8O9vdvl3eedjOBwNjCaOB1X/JXp9yv63e9AjQQShOMwq1KER+dd9I/Ge5
	4WdBE5dxBNI4h4mPDcNR7b8m7NMUVEcI3LPEsSVupwsr4Msi6xAcqIw+MEMuOdF6nZw2zI
	CucscKHuEx1RK6p8gVIoYeNdKqWRVTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735828671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jALyLmH5Wjf7WNRQOooZcqWz5mWM/83st2sEg1mZ7xQ=;
	b=+aInUHKRiwJwFyYF1Jjt/kFE0oZdVcgut9m7bhP/1iNiXVspMLQfxmzm/Qy7sfvKtQuwGh
	QZVfE8XZV6cccgBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735828671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jALyLmH5Wjf7WNRQOooZcqWz5mWM/83st2sEg1mZ7xQ=;
	b=HKF1C4pLR7NZC8O9vdvl3eedjOBwNjCaOB1X/JXp9yv63e9AjQQShOMwq1KER+dd9I/Ge5
	4WdBE5dxBNI4h4mPDcNR7b8m7NMUVEcI3LPEsSVupwsr4Msi6xAcqIw+MEMuOdF6nZw2zI
	CucscKHuEx1RK6p8gVIoYeNdKqWRVTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735828671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jALyLmH5Wjf7WNRQOooZcqWz5mWM/83st2sEg1mZ7xQ=;
	b=+aInUHKRiwJwFyYF1Jjt/kFE0oZdVcgut9m7bhP/1iNiXVspMLQfxmzm/Qy7sfvKtQuwGh
	QZVfE8XZV6cccgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 170D513418;
	Thu,  2 Jan 2025 14:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qw2aBb+kdmd7FwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Jan 2025 14:37:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 48112A0887; Thu,  2 Jan 2025 15:37:50 +0100 (CET)
Date: Thu, 2 Jan 2025 15:37:50 +0100
From: Jan Kara <jack@suse.cz>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
References: <20241227121508.nofy6bho66pc5ry5@pali>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241227121508.nofy6bho66pc5ry5@pali>
X-Spam-Score: -3.80
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hello!

On Fri 27-12-24 13:15:08, Pali Rohár wrote:
> Few months ago I discussed with Steve that Linux SMB client has some
> problems during removal of directory which has read-only attribute set.
> 
> I was looking what exactly the read-only windows attribute means, how it
> is interpreted by Linux and in my opinion it is wrongly used in Linux at
> all.
> 
> Windows filesystems NTFS and ReFS, and also exported over SMB supports
> two ways how to present some file or directory as read-only. First
> option is by setting ACL permissions (for particular or all users) to
> GENERIC_READ-only. Second option is by setting the read-only attribute.
> Second option is available also for (ex)FAT filesystems (first option via
> ACL is not possible on (ex)FAT as it does not have ACLs).
> 
> First option (ACL) is basically same as clearing all "w" bits in mode
> and ACL (if present) on Linux. It enforces security permission behavior.
> Note that if the parent directory grants for user delete child
> permission then the file can be deleted. This behavior is same for Linux
> and Windows (on Windows there is separate ACL for delete child, on Linux
> it is part of directory's write permission).
> 
> Second option (Windows read-only attribute) means that the file/dir
> cannot be opened in write mode, its metadata attribute cannot be changed
> and the file/dir cannot be deleted at all. But anybody who has
> WRITE_ATTRIBUTES ACL permission can clear this attribute and do whatever
> wants.

I guess someone with more experience how to fuse together Windows & Linux
permission semantics should chime in here but here are my thoughts.

> Linux filesystems has similar thing to Windows read-only attribute
> (FILE_ATTRIBUTE_READONLY). It is "immutable" bit (FS_IMMUTABLE_FL),
> which can be set by the "chattr" tool. Seems that the only difference
> between Windows read-only and Linux immutable is that on Linux only
> process with CAP_LINUX_IMMUTABLE can set or clear this bit. On Windows
> it can be anybody who has write ACL.
> 
> Now I'm thinking, how should be Windows read-only bit interpreted by
> Linux filesystems drivers (FAT, exFAT, NTFS, SMB)? I see few options:
> 
> 0) Simply ignored. Disadvantage is that over network fs, user would not
>    be able to do modify or delete such file, even as root.
> 
> 1) Smartly ignored. Meaning that for local fs, it is ignored and for
>    network fs it has to be cleared before any write/modify/delete
>    operation.
> 
> 2) Translated to Linux mode/ACL. So the user has some ability to see it
>    or change it via chmod. Disadvantage is that it mix ACL/mode.

So this option looks sensible to me. We clear all write permissions in
file's mode / ACL. For reading that is fully compatible, for mode
modifications it gets a bit messy (probably I'd suggest to just clear
FILE_ATTRIBUTE_READONLY on modification) but kind of close.

> 3) Translated to Linux FS_IMMUTABLE_FL. So the user can use lsattr /
>    chattr to see or change it. Disadvantage is that this bit can be
>    changed only by root or by CAP_LINUX_IMMUTABLE process.
> 
> 4) Exported via some new xattr. User can see or change it. But for
>    example recursive removal via rm -rf would be failing as rm would not
>    know about this special new xattr.
> 
> In any case, in my opinion, all Linux fs drivers for these filesystems
> (FAT, exFAT, NTFS, SMB, are there some others?) should handle this
> windows read-only bit in the same way.
> 
> What do you think, what should be the best option?
> 
> I have another idea. What about introducing a new FS_IMMUTABLE_USER_FL
> bit which have same behavior as FS_IMMUTABLE_FL, just it would be
> possible to set it for any user who has granted "write" permission?

Uh, in unix, write permission is for accessing file data. Modifying access
permissions etc. is always limited to inode owner (or user with special
capabilities). So this would be very confusing in Unix permission model.

> Instead of requiring CAP_LINUX_IMMUTABLE. I see a nice usecase that even
> ordinary user could be able to mark file as protected against removal or
> modification (for example some backup data).

So I don't see us introducing another immutable bit in VFS. Special
"protected file" bit modifiable by whoever can modify file permissions is
not really different from clearing write permission bits in mode. So that
doesn't seem as a terribly useful feature to me. That being said nothing
really stops individual filesystems from introducing their own inode flags,
get / set them via ioctl and implement whatever permission checking needed
with them. After all this is how the flags like IMMUTABLE or APPEND started
and only later on when they propagated into many filesystems we've lifted
them into VFS.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

