Return-Path: <linux-fsdevel+bounces-20068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC1E8CD89B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 18:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5C1B22C99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00CF1CFB2;
	Thu, 23 May 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tmZcCNsv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a6Ukreth";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tmZcCNsv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a6Ukreth"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED451862A;
	Thu, 23 May 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482598; cv=none; b=bRICAJduxlzxVJPc1WsKB3ugZqMnDMiwpLqRYgdEhOm75Ce4vLLT291Y16aG2Z1PRg/f5ovEWUMDIkfVBAR2b1V+8Y8Yd5CKEXgh1qx1S3WXxKcFxQ8nazoFCSmd0gTgJySBiZNCls0rbYcdu+nUBj3iEejGdiMbHL5TtmJT0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482598; c=relaxed/simple;
	bh=c4dpRkSmY/SjGnXNwhJHg4tJmXiikYsmAFdcCQTWv7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K13/DJa3KqyV0Mqt9F5FQBir7Q802IUqCZVT/t7rVVl75dCi8Qve37kLbmG7mkEx/21hbta4SSpZATadKvva1P93P3kDvgqu4oBxFmo0N//zdqAG8GN5Wqsgz6aQgycWwor9M0sWL82nayPtaxcdkTG5sHbx03tYMJ31zJL9P0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tmZcCNsv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a6Ukreth; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tmZcCNsv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a6Ukreth; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AB8A21BCE;
	Thu, 23 May 2024 16:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716482594;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uR/6eKdUfSRhoDdDdj5PWbeAQdfTjoONJNC6g2gQC8U=;
	b=tmZcCNsvfhPxmATnkZnvBJ0+gUFi5J9oZolh6AF13s8Bo/HP3NOPE6UJlfon7oCMzM4TN1
	pD4MQf6Ms6oJgka3zRPRW+SE5m9jmGgFTP9ETi6Tkrfx6AfySVw5pJLgI9xGiYzg5UTUh6
	quvBn6Qbxls9wWwL0OYw7dGiq0cB18A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716482594;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uR/6eKdUfSRhoDdDdj5PWbeAQdfTjoONJNC6g2gQC8U=;
	b=a6UkrethGFauGlsdBebvs3Q1nwyqK4ZGl5550ZOeB8NVHGlNgIKMKsJ96mG7FVSfaOTtqp
	R7BwCG29CZ3UqUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716482594;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uR/6eKdUfSRhoDdDdj5PWbeAQdfTjoONJNC6g2gQC8U=;
	b=tmZcCNsvfhPxmATnkZnvBJ0+gUFi5J9oZolh6AF13s8Bo/HP3NOPE6UJlfon7oCMzM4TN1
	pD4MQf6Ms6oJgka3zRPRW+SE5m9jmGgFTP9ETi6Tkrfx6AfySVw5pJLgI9xGiYzg5UTUh6
	quvBn6Qbxls9wWwL0OYw7dGiq0cB18A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716482594;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uR/6eKdUfSRhoDdDdj5PWbeAQdfTjoONJNC6g2gQC8U=;
	b=a6UkrethGFauGlsdBebvs3Q1nwyqK4ZGl5550ZOeB8NVHGlNgIKMKsJ96mG7FVSfaOTtqp
	R7BwCG29CZ3UqUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E8E313A6B;
	Thu, 23 May 2024 16:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mub4BiJyT2b6IAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 23 May 2024 16:43:14 +0000
Date: Thu, 23 May 2024 18:43:12 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+85e58cdf5b3136471d4b@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com,
	jack@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
	mszeredi@redhat.com, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [btrfs?] [overlayfs?] possible deadlock in
 ovl_copy_up_flags
Message-ID: <20240523164312.GD17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000f6865106191c3e58@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f6865106191c3e58@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [0.05 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.45)[91.32%];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=fba88766130220e8];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[85e58cdf5b3136471d4b];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,fb.com,suse.com,suse.cz,toxicpanda.com,vger.kernel.org,szeredi.hu,redhat.com,googlegroups.com,zeniv.linux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: 0.05
X-Spam-Flag: NO

On Thu, May 23, 2024 at 03:09:26AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c75962170e49 Add linux-next specific files for 20240517
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1438a5cc980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fba88766130220e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=85e58cdf5b3136471d4b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115f3e58980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f4c97c980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/21696f8048a3/disk-c7596217.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b8c71f928633/vmlinux-c7596217.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/350bfc6c0a6a/bzImage-c7596217.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/7f6a8434331c/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 9a87907de3597a339cc129229d1a20bc7365ea5f
> Author: Miklos Szeredi <mszeredi@redhat.com>
> Date:   Thu May 2 18:35:57 2024 +0000
> 
>     ovl: implement tmpfile

In the C reproducer it's btrfs + overlayfs, this more looks like a bug in
overlayfs handling the tmpfile and sb_*_write accross layers. Btrfs
functions are not on the stack.

#syz set subsystems: overlayfs

