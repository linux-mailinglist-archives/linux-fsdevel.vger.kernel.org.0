Return-Path: <linux-fsdevel+bounces-13023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BB686A3F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 00:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068B81F246B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4641256761;
	Tue, 27 Feb 2024 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KK8acMoU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2cN0mEgy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KK8acMoU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2cN0mEgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C2D56442;
	Tue, 27 Feb 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709077741; cv=none; b=lI9uUmOcK9IseT0qo7dbmi5jG1/eOl+BhPgCMMJjWLJORzz+tPlI1AnmNzstTXjr2hXB4ycD3NEXg5Z8BrCOym5MINcbHX2KDNe6HvBpmOr35u9Op4/kIDDDm3TAfSm6Odj9jpFNmKOwwsJve6uQ1vhTa89t25mPwcm3Ef8WE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709077741; c=relaxed/simple;
	bh=Y+/rFevpzvhdvuWiKxENTvkTi0r9cvuGobLI8jzXRS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YVFpKwh9v+TQ+p1VCTP/FzE5kfA0KM5Us/PPEbRuyMmDhOAqcqkFiYjERrbG/8XyxVrJQN/o0RpeLmc9tB9gEuQ/418KDbhcxL0FH/WXEjoHwHsLaChCqvqK7Yblj+QLu8OXXEFrFKqBru25DodRmVqr/c0bH0PJQqRJ0OC/PeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KK8acMoU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2cN0mEgy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KK8acMoU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2cN0mEgy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 10AB72280F;
	Tue, 27 Feb 2024 23:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709077738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M15oWz8K/quZkZ3iAaKhipWnksYJwmCDDGkA7L4LZ0E=;
	b=KK8acMoUR0AjvMtcekxBOz3P1kONZ68wdHPOpT25umpGKSP/8GQU+w7zr45xgr5Aa2Jrqs
	ZibILliWKdwCWqzrtN8Wjgd4BFFCi4qE6i3sQdXY5O2qmHFfAEJ2AWatTKNY+4sjkP4YYI
	tvBE63uXD2AOc+kAksuf1/s8f16bvlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709077738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M15oWz8K/quZkZ3iAaKhipWnksYJwmCDDGkA7L4LZ0E=;
	b=2cN0mEgyIxHnuVoRqLmvobEJxkpbPFxvJ5MoFqUajy4zDFLuRS94mXa4yKKdoYr6a34nNn
	KgckqqnWIC1WBKAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709077738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M15oWz8K/quZkZ3iAaKhipWnksYJwmCDDGkA7L4LZ0E=;
	b=KK8acMoUR0AjvMtcekxBOz3P1kONZ68wdHPOpT25umpGKSP/8GQU+w7zr45xgr5Aa2Jrqs
	ZibILliWKdwCWqzrtN8Wjgd4BFFCi4qE6i3sQdXY5O2qmHFfAEJ2AWatTKNY+4sjkP4YYI
	tvBE63uXD2AOc+kAksuf1/s8f16bvlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709077738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M15oWz8K/quZkZ3iAaKhipWnksYJwmCDDGkA7L4LZ0E=;
	b=2cN0mEgyIxHnuVoRqLmvobEJxkpbPFxvJ5MoFqUajy4zDFLuRS94mXa4yKKdoYr6a34nNn
	KgckqqnWIC1WBKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE61113ABA;
	Tue, 27 Feb 2024 23:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xBoaKOl03mVJOQAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 27 Feb 2024 23:48:57 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Eric Biggers <ebiggers@kernel.org>, tytso@mit.edu,
  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz
Subject: Re: [PATCH v12 0/8] Cache insensitive cleanup for ext4/f2fs
In-Reply-To: <20240220085235.71132-1-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Tue, 20 Feb 2024 10:52:27 +0200")
Organization: SUSE
References: <20240220085235.71132-1-eugen.hristev@collabora.com>
Date: Tue, 27 Feb 2024 18:48:56 -0500
Message-ID: <87r0gx4gev.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> Hello,
>
> I am trying to respin the series here :
> https://www.spinics.net/lists/linux-ext4/msg85081.html

This has a reviewed-by tag from Eric, but since its been years and we've
been going through more changes now, I'd ask you to drop the r-b until
Eric has had a chance to review it and give a new tag.

Thanks,

> I resent some of the v9 patches and got some reviews from Gabriel,
> I did changes as requested and here is v12.
>
> Changes in v12:
> - revert to v10 comparison with propagating the error code from utf comparison
>
> Changes in v11:
> - revert to the original v9 implementation for the comparison helper.
>
> Changes in v10:
> - reworked a bit the comparison helper to improve performance by
> first performing the exact lookup.
>
>
> * Original commit letter
>
> The case-insensitive implementations in f2fs and ext4 have quite a bit
> of duplicated code.  This series simplifies the ext4 version, with the
> goal of extracting ext4_ci_compare into a helper library that can be
> used by both filesystems.  It also reduces the clutter from many
> codeguards for CONFIG_UNICODE; as requested by Linus, they are part of
> the codeflow now.
>
> While there, I noticed we can leverage the utf8 functions to detect
> encoded names that are corrupted in the filesystem. Therefore, it also
> adds an ext4 error on that scenario, to mark the filesystem as
> corrupted.
>
> This series survived passes of xfstests -g quick.
>
>
> Gabriel Krisman Bertazi (8):
>   ext4: Simplify the handling of cached insensitive names
>   f2fs: Simplify the handling of cached insensitive names
>   libfs: Introduce case-insensitive string comparison helper
>   ext4: Reuse generic_ci_match for ci comparisons
>   f2fs: Reuse generic_ci_match for ci comparisons
>   ext4: Log error when lookup of encoded dentry fails
>   ext4: Move CONFIG_UNICODE defguards into the code flow
>   f2fs: Move CONFIG_UNICODE defguards into the code flow
>
>  fs/ext4/crypto.c   |  19 ++-----
>  fs/ext4/ext4.h     |  35 +++++++-----
>  fs/ext4/namei.c    | 129 ++++++++++++++++-----------------------------
>  fs/ext4/super.c    |   4 +-
>  fs/f2fs/dir.c      | 105 +++++++++++-------------------------
>  fs/f2fs/f2fs.h     |  17 +++++-
>  fs/f2fs/namei.c    |  10 ++--
>  fs/f2fs/recovery.c |   5 +-
>  fs/f2fs/super.c    |   8 +--
>  fs/libfs.c         |  85 +++++++++++++++++++++++++++++
>  include/linux/fs.h |   4 ++
>  11 files changed, 216 insertions(+), 205 deletions(-)

-- 
Gabriel Krisman Bertazi

