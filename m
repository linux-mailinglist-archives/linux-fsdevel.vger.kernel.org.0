Return-Path: <linux-fsdevel+bounces-19542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080C8C6AC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 18:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B68E1F238F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F4F23776;
	Wed, 15 May 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LOHfFBOK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Had3bBPe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LOHfFBOK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Had3bBPe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AF1392;
	Wed, 15 May 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791010; cv=none; b=e4Mkv/2bgFSHGMVaQJZkVcernd+JE+Qk802wUezroXRDF+XEACazl4GXxTKZdoEekyinl/re6bb/WmVY2CStWP347rJv07eWWYopP74MZ8Te7EI1NUBsVigblSZSDUm6iCPttfOjHS/ALU+jxbnlGZGQyU3WIqQ4JFqs9jxUu/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791010; c=relaxed/simple;
	bh=5cYTWTUqYGK9Lsmtgex2ufr1zilkF/fgbuIddliU2eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pB/8wCyo3BXdKPkkOrGT5XmxUUe9ydZ/vzfkg95wJ/q5724RNeRu950HvpsZM6WydcbTRhIh9qr+xc+sY7vnF79hXV1GwzTHdjbc2k4yxw/F420mriU8NU1H2Q6jdlRnBlNLovgUx+ZxDsY6Zd0rrKaHmvBJ4TATPRbbi4qzFHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LOHfFBOK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Had3bBPe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LOHfFBOK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Had3bBPe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D06333D5F;
	Wed, 15 May 2024 16:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715791007;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8i1qPfQ62wrcBf778d7lmhXzaAaIOC8pN8skQz1Y0NI=;
	b=LOHfFBOKWrsRaYqT8+TT0cBmr77VY7wrW8IqkCyFNH3j6sqhuFE3DZsBwTF/Ggi2k7ABAP
	+C5RtiT77YduzRCJPTVbYfqcaajCTRSvKR651OOSKp3JDuG93csf4bqAURLPJtLAopTbIC
	yPo1GgLWUa8w98jEigA3fS+ii+8FvV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715791007;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8i1qPfQ62wrcBf778d7lmhXzaAaIOC8pN8skQz1Y0NI=;
	b=Had3bBPeqHgjP38nE6OY8jdPc5wF4L8kmzpQ9FZZk6Q68Y8iFV7GrgZP590jlZ2ToOA7q0
	7IwjYdB5FHfeTbAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715791007;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8i1qPfQ62wrcBf778d7lmhXzaAaIOC8pN8skQz1Y0NI=;
	b=LOHfFBOKWrsRaYqT8+TT0cBmr77VY7wrW8IqkCyFNH3j6sqhuFE3DZsBwTF/Ggi2k7ABAP
	+C5RtiT77YduzRCJPTVbYfqcaajCTRSvKR651OOSKp3JDuG93csf4bqAURLPJtLAopTbIC
	yPo1GgLWUa8w98jEigA3fS+ii+8FvV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715791007;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8i1qPfQ62wrcBf778d7lmhXzaAaIOC8pN8skQz1Y0NI=;
	b=Had3bBPeqHgjP38nE6OY8jdPc5wF4L8kmzpQ9FZZk6Q68Y8iFV7GrgZP590jlZ2ToOA7q0
	7IwjYdB5FHfeTbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E714A1372E;
	Wed, 15 May 2024 16:36:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u7suOJ7kRGZdIgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 May 2024 16:36:46 +0000
Date: Wed, 15 May 2024 18:36:45 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io
Message-ID: <20240515163645.GR4449@suse.cz>
Reply-To: dsterba@suse.cz
References: <000000000000169326060971d07a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000169326060971d07a@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: 0.53
X-Spam-Level: 
X-Spamd-Result: default: False [0.53 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=c3aadb4391bbacce];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.97)[86.80%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[06006fc4a90bff8e8f17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]

On Sun, Nov 05, 2023 at 05:31:27PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8bc9e6515183 Merge tag 'devicetree-for-6.7' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10e087a0e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c3aadb4391bbacce
> dashboard link: https://syzkaller.appspot.com/bug?extid=06006fc4a90bff8e8f17
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6c9b9f6781b1/disk-8bc9e651.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/44acae63a945/vmlinux-8bc9e651.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f0058df8ab69/bzImage-8bc9e651.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com

#syz fix: btrfs: don't drop extent_map for free space inode on write error

We were not aware that syzbot also hit the problem, we got report from
our CI so the auto close tags was missing.

