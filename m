Return-Path: <linux-fsdevel+bounces-45880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD342A7E0CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BE13A2C27
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ED71C6FFC;
	Mon,  7 Apr 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AtYPULX8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vLU6yQCo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AtYPULX8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vLU6yQCo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A211C5F05
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034976; cv=none; b=eUDS4vSs9sgSwLp1WWK0hv98DaW+fOt4GUP2MLxdX6KkfQ2B2N3ZX7b2BEaucwPN8lX0Fin46Ou/rW/4NN4oxtySug51UcmTaV00pMkNhHl0lIQqWvNPkf/qA5jhuB7ZlcNbiiz3KRWoJZlKh+kf6dTILBgm5cntThCzGY2yJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034976; c=relaxed/simple;
	bh=rtdttT+Ba/y5fu069GH7wVlB51SquNZc5B8l630p5rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGPv5QZQw+Y820+LW994fmBQ8D+F37WtTL13QQciztoDyjcmrey83tlPdLQGnj1mO/g46+BcsVPH/IMuGjVyLSYtXl9n5yo3PhNtNvsPQBgs30gLQoGKVItCR3xOUE3+zA1AVvp387bo+GbCvuY1gQnjMi7v19NVs0MB8NNIKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AtYPULX8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vLU6yQCo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AtYPULX8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vLU6yQCo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 466EF2116A;
	Mon,  7 Apr 2025 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua7uK/2kCB7MBpu7IGvUYNdQ90iZbVicggJ9dRl5UOE=;
	b=AtYPULX8JvD/QWflyAgLfj05FEiA4ZzzwoQ4kQvYU+rlBK0HYon3xTfZWQGvnWmUeZQssC
	5yYG+Y5XTvUAAN/Hi/+1McM/wuKK+wzVKZVlCXLIfiN5EJ0jlqVjtbLYTxsE7zR0zp0aK4
	24BMKI0cu6TXlAaTZ3ikczbqta+XWS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua7uK/2kCB7MBpu7IGvUYNdQ90iZbVicggJ9dRl5UOE=;
	b=vLU6yQCoWGJeEt1nSgF7Z0LPgTW4jYGfYPeKDQovXO4eYcJrfKygJH1GxpguLKYsGMzt5u
	El4Y02W6GKMxkCAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AtYPULX8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vLU6yQCo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua7uK/2kCB7MBpu7IGvUYNdQ90iZbVicggJ9dRl5UOE=;
	b=AtYPULX8JvD/QWflyAgLfj05FEiA4ZzzwoQ4kQvYU+rlBK0HYon3xTfZWQGvnWmUeZQssC
	5yYG+Y5XTvUAAN/Hi/+1McM/wuKK+wzVKZVlCXLIfiN5EJ0jlqVjtbLYTxsE7zR0zp0aK4
	24BMKI0cu6TXlAaTZ3ikczbqta+XWS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua7uK/2kCB7MBpu7IGvUYNdQ90iZbVicggJ9dRl5UOE=;
	b=vLU6yQCoWGJeEt1nSgF7Z0LPgTW4jYGfYPeKDQovXO4eYcJrfKygJH1GxpguLKYsGMzt5u
	El4Y02W6GKMxkCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C6D813691;
	Mon,  7 Apr 2025 14:09:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FBm/Dp3c82eLIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 14:09:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EFF96A08D2; Mon,  7 Apr 2025 16:09:32 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:09:32 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH 7/9] selftests/filesystems: add second test for anonymous
 inodes
Message-ID: <2bprvo3fxqzwpngpkhecllfrnbezsnriy3q5rodvyblz4hihjd@dhrc3edwxax4>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-7-53a44c20d44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-work-anon_inode-v1-7-53a44c20d44e@kernel.org>
X-Rspamd-Queue-Id: 466EF2116A
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,suse.cz,kernel.org,toxicpanda.com,syzkaller.appspotmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[5d8e79d323a13aa0b248];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Mon 07-04-25 11:54:21, Christian Brauner wrote:
> Test that anonymous inodes cannot be chmod()ed.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  tools/testing/selftests/filesystems/anon_inode_test.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
> index f2cae8f1ccae..7c4d0a225363 100644
> --- a/tools/testing/selftests/filesystems/anon_inode_test.c
> +++ b/tools/testing/selftests/filesystems/anon_inode_test.c
> @@ -22,5 +22,18 @@ TEST(anon_inode_no_chown)
>  	EXPECT_EQ(close(fd_context), 0);
>  }
>  
> +TEST(anon_inode_no_chmod)
> +{
> +	int fd_context;
> +
> +	fd_context = sys_fsopen("tmpfs", 0);
> +	ASSERT_GE(fd_context, 0);
> +
> +	ASSERT_LT(fchmod(fd_context, 0777), 0);
> +	ASSERT_EQ(errno, EOPNOTSUPP);
> +
> +	EXPECT_EQ(close(fd_context), 0);
> +}
> +
>  TEST_HARNESS_MAIN
>  
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

