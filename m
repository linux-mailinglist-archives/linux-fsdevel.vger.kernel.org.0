Return-Path: <linux-fsdevel+bounces-11384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33DD8535B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1309E1F21BDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371335F846;
	Tue, 13 Feb 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NrQsyi7e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oTK1LIk8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NrQsyi7e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oTK1LIk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04FE65F;
	Tue, 13 Feb 2024 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840561; cv=none; b=a8cOy6d/0JGeU0y/xJaUF8zCYAHbBNHWPFoCIJi+hLwKAoTywrEgUzL44zKelZLSRbSXLgr+MTMEcHaPFlxtgy1YQ9q5qrF5F3MFiZDwHBcdKIIvVeWw9aBcwuQcuWMxLdEB/aBl0LNk34b7TNVryNWDQjMClXbLQmds2dtpX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840561; c=relaxed/simple;
	bh=S/GRXv9DFjc7yF8QJeC4bdwYNBcaL3z76O2ybsYr6ZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=StYU+ZIkfce1fNWXIpFqzXBOv7usutD3d0+JY+NTBy2kI5b3ByXvcj3ePQPRknnmISLsn2vti94ScEjRj+mPF3yCft9M5/arnaMPCEjlAREJI2pCaKzbVbQMOaofh/WZ0/1HZ3y40au83KSEfwAwrrvwgLh5Ar3I03BFqfV8Jp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NrQsyi7e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oTK1LIk8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NrQsyi7e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oTK1LIk8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0BCF221C42;
	Tue, 13 Feb 2024 16:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707840558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zubravQy7jVbUoW/ZL/MweR2V9SuJRaNpDAgWH+si7c=;
	b=NrQsyi7eL0Z8MNW3teN7s7NjS59N9Cv5z81m8t+3jwF++XZK/cJAMx9lQsQ8eXjKHKtPhE
	WLIYfwWxxH6j/MgaeVK0xr43Gin/lx7FIAo9zUXS2+cIdLf8nDBSAS5i5Oawrzei5zA7wC
	Z3ajU2KtGeGno1pzikYmBgnvjgaYeSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707840558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zubravQy7jVbUoW/ZL/MweR2V9SuJRaNpDAgWH+si7c=;
	b=oTK1LIk883C4Bl1hG5vCRjrkMxD6cI6iRlY7IzZeyJHztiGOfgHWgulmR8O0JFT/0/m6BM
	NoIt2VnzNXQ+tJCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707840558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zubravQy7jVbUoW/ZL/MweR2V9SuJRaNpDAgWH+si7c=;
	b=NrQsyi7eL0Z8MNW3teN7s7NjS59N9Cv5z81m8t+3jwF++XZK/cJAMx9lQsQ8eXjKHKtPhE
	WLIYfwWxxH6j/MgaeVK0xr43Gin/lx7FIAo9zUXS2+cIdLf8nDBSAS5i5Oawrzei5zA7wC
	Z3ajU2KtGeGno1pzikYmBgnvjgaYeSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707840558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zubravQy7jVbUoW/ZL/MweR2V9SuJRaNpDAgWH+si7c=;
	b=oTK1LIk883C4Bl1hG5vCRjrkMxD6cI6iRlY7IzZeyJHztiGOfgHWgulmR8O0JFT/0/m6BM
	NoIt2VnzNXQ+tJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC40D1370C;
	Tue, 13 Feb 2024 16:09:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ArjcJy2Uy2VkSwAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 13 Feb 2024 16:09:17 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  jaegeuk@kernel.org,
  chao@kernel.org,  viro@zeniv.linux.org.uk,  brauner@kernel.org,
  linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net,
  jack@suse.cz,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel@collabora.com,  Gabriel Krisman
 Bertazi <krisman@collabora.com>,  Eric Biggers <ebiggers@google.com>
Subject: Re: [RESEND PATCH v9 1/3] libfs: Introduce case-insensitive string
 comparison helper
In-Reply-To: <1b7d51df-4995-4a4a-8ec4-f1ea4975e44c@collabora.com> (Eugen
	Hristev's message of "Tue, 13 Feb 2024 06:44:16 +0200")
Organization: SUSE
References: <20240208064334.268216-1-eugen.hristev@collabora.com>
	<20240208064334.268216-2-eugen.hristev@collabora.com>
	<87ttmivm1i.fsf@mailhost.krisman.be>
	<ff492e0f-3760-430e-968a-8b2adab13f3f@collabora.com>
	<87plx5u2do.fsf@mailhost.krisman.be>
	<1b7d51df-4995-4a4a-8ec4-f1ea4975e44c@collabora.com>
Date: Tue, 13 Feb 2024 11:09:16 -0500
Message-ID: <875xyse47n.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NrQsyi7e;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oTK1LIk8
X-Spamd-Result: default: False [-1.66 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.35)[90.50%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0BCF221C42
X-Spam-Level: 
X-Spam-Score: -1.66
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> On 2/9/24 16:40, Gabriel Krisman Bertazi wrote:
>> Eugen Hristev <eugen.hristev@collabora.com> writes:
> With the changes you suggested, I get these errors now :
>
> [  107.409410] EXT4-fs error (device sda1): ext4_lookup:1816: inode #521217: comm
> ls: 'CUC' linked to parent dir
> ls: cannot access '/media/CI_dir/CUC': Structure needs cleaning
> total 8
> drwxr-xr-x 2 root root 4096 Feb 12 11:51 .
> drwxr-xr-x 4 root root 4096 Feb 12 11:47 ..
> -????????? ? ?    ?       ?            ? CUC
>
> Do you have any idea about what is wrong ?

Hm, there's a bug somewhere. The lookup got broken and ls got an error.
Did you debug it a bit?  can you share the code and a reproducer?

From a quick look at the example I suggested, utf8_strncasecmp* return 0
on match, but ext4_match should return true when matched. So remember to
negate the output:

...
res = !utf8_strncasecmp(um, name, &dirent);
...

-- 
Gabriel Krisman Bertazi

