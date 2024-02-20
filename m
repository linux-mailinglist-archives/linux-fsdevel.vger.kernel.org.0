Return-Path: <linux-fsdevel+bounces-12157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D4585BF3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 16:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51298282337
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092A274274;
	Tue, 20 Feb 2024 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1MHaQJL8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KvYwjIm3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1MHaQJL8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KvYwjIm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962B67E91;
	Tue, 20 Feb 2024 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441189; cv=none; b=QDT2xJgRECCIp3P0Cf1eOVDMGwKV98+ZczTw9sush0Ne5/oGy8ngDEwANy42OADlNnhaz2XvjrQxiTLAc4Y7Ag/C9k5s0gaFecVeDvFSnAAdZaNjg/08rl6ja7v88AocgjvERQYklh6KUSz7ZZav6qm9DAN0TBLkXgKy0V6wp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441189; c=relaxed/simple;
	bh=+6dpGBqTRme9HOoPA5CvCblwTs/y4BuSqvP6fWdqjs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mpx13h8f2j9sH0PUjpnPY38TQTTDuvilrMK83fEc6epMJMgTNQ22fQJ8c1bmsV5xwWzERTlcgs3KHmZlRDP/9fX4lrngXaDRo+DgvsCxfaaBg5oqNh9SSjLNCA/Q4e/GE++eFgS0u4hnPiBMNLOFAGizGEPG2LZ7SrwxZ146Hl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1MHaQJL8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KvYwjIm3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1MHaQJL8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KvYwjIm3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C43111F898;
	Tue, 20 Feb 2024 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708441185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mvro3zekXoZ0IqphOQMb6DozUfJPZwilwfAcT3oRVog=;
	b=1MHaQJL8i7D8jEJnULlFdqwVhl0mVJmTxyTAfnOT33B3Ex2QuFyhxl/cqxfxLO5aYih85i
	7nflvsvX6whA4y8pu7ig/SCRzXkTON+G+OEOHDN11Za0LtUBpvU0LQ742MdGbVvgtkqrnr
	3eOSj79u8cjfnuTj/hh5AQSc4GhghBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708441185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mvro3zekXoZ0IqphOQMb6DozUfJPZwilwfAcT3oRVog=;
	b=KvYwjIm34gjCXKk+/Khnf2ICGcGzqO8Mmy5RtPzBxH3pdVakyzgegMS4uu4Gjt7GLDZfY3
	7/2yo2ZijfeAGtBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708441185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mvro3zekXoZ0IqphOQMb6DozUfJPZwilwfAcT3oRVog=;
	b=1MHaQJL8i7D8jEJnULlFdqwVhl0mVJmTxyTAfnOT33B3Ex2QuFyhxl/cqxfxLO5aYih85i
	7nflvsvX6whA4y8pu7ig/SCRzXkTON+G+OEOHDN11Za0LtUBpvU0LQ742MdGbVvgtkqrnr
	3eOSj79u8cjfnuTj/hh5AQSc4GhghBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708441185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mvro3zekXoZ0IqphOQMb6DozUfJPZwilwfAcT3oRVog=;
	b=KvYwjIm34gjCXKk+/Khnf2ICGcGzqO8Mmy5RtPzBxH3pdVakyzgegMS4uu4Gjt7GLDZfY3
	7/2yo2ZijfeAGtBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FD76139D0;
	Tue, 20 Feb 2024 14:59:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pBv1GGG+1GU4PwAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 20 Feb 2024 14:59:45 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,  Gabriel
 Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v10 3/8] libfs: Introduce case-insensitive string
 comparison helper
In-Reply-To: <fb32fc72-5434-4852-b7e9-f63fc03a8248@collabora.com> (Eugen
	Hristev's message of "Tue, 20 Feb 2024 09:36:40 +0200")
Organization: SUSE
References: <20240215042654.359210-1-eugen.hristev@collabora.com>
	<20240215042654.359210-4-eugen.hristev@collabora.com>
	<87zfw0bd6y.fsf@mailhost.krisman.be>
	<50d2afaa-fd7e-4772-ac84-24e8994bfba8@collabora.com>
	<87msrwbj18.fsf@mailhost.krisman.be>
	<fb32fc72-5434-4852-b7e9-f63fc03a8248@collabora.com>
Date: Tue, 20 Feb 2024 09:59:44 -0500
Message-ID: <871q97b2qn.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.90 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.80)[84.80%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.90

Eugen Hristev <eugen.hristev@collabora.com> writes:

> Okay, I am changing it.
>
> By the way, is this supposed to work like this on case-insensitive directories ?
>
> user@debian-rockchip-rock5b-rk3588:~$ ls -la /media/CI_dir/*cuc
> ls: cannot access '/media/CI_dir/*cuc': No such file or directory
> user@debian-rockchip-rock5b-rk3588:~$ ls -la /media/CI_dir/*CUC
> -rw-r--r-- 1 root root 0 Feb 12 17:47 /media/CI_dir/CUC
> user@debian-rockchip-rock5b-rk3588:~$ ls -la /media/CI_dir/cuc
> -rw-r--r-- 1 root root 0 Feb 12 17:47 /media/CI_dir/cuc
> user@debian-rockchip-rock5b-rk3588:~$
>
>
> basically wildcards don't work.

Yes, at least from a kernel point of view.  Your shell does wildcards in
userspace, probably by doing getdents and then comparing with possible
matches.  Since the shell itself is not case-insensitive aware, its
comparison is case-sensitive, and you get these apparent weird
semantics.

Not ideal from a user point of view.  But not a kernel bug.  If it
pushes people away from using case-insensitive directories in their
day-to-day work and leave it to only be used by Windows compatibility
layers, maybe that's a win? :)

-- 
Gabriel Krisman Bertazi

