Return-Path: <linux-fsdevel+bounces-45882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94626A7E0C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83328163E0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9DD1C7010;
	Mon,  7 Apr 2025 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LaM16Nkp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nOj0bI8v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Dx18pqy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4nG8RvrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DFB86355
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034995; cv=none; b=bLc1TjpHyp+caGcRMsQrREdepfckd//1bGi6t7ljBNoL/VOEGD0mXcpLe3ekuCMCskTibDTw7zzCExaMYfTBer5VCHYnPvlhLHYnnj4/5YCZGLVwoMeDzW2CvH44KSVcPlijlqbGZoKhSbBkVdLG5iZHxSMD1UurYkwkNL0lvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034995; c=relaxed/simple;
	bh=XvbYoxVnXcO8WDd63zR3ID9GFTgpB8Laoj7X/u9MtnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1mkC4cjfsbOVIFp/ICg7ws5ntTFM2KPlldmB1p5I1qmvTqlhXyHkgvSKD3qFAOClFe/fl6Z5sjqfH2/k2cynqjntN7WL56DzgKQhl+GwtnHHmkxw0nyNy42b9GkFjL58OvGb2g5kLV5AFvTZmMhh9v60aMHt56RmgkER7eFEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LaM16Nkp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nOj0bI8v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Dx18pqy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4nG8RvrD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29A4F2116A;
	Mon,  7 Apr 2025 14:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rW1x0AR5QDBE5SdgqIqfK8y9Xj/p6HryldTCeU1V5Io=;
	b=LaM16Nkpjv1Zakp3D0Mi6eGKHsYsayq/ZBCRUG3OKa+I9chYD7Qh/fes+WYvFrGc9m45C6
	f7xUW17lFuI53+eRLtcaHavTLHIkn28cAl8n86Xc29CTgsDgvx+t9ky/h3/Ci4b77uGlC3
	Q0/iwVQBcTXEfhpKN9x4Xfc8Maw5OcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rW1x0AR5QDBE5SdgqIqfK8y9Xj/p6HryldTCeU1V5Io=;
	b=nOj0bI8v6VK0AgrJpJe8JD3f8ZqYJFMa44ScAVwkUGbLEEgk7Gg/i1Utq5aAfZvgJFosJx
	ejhL+9b/NtWR8uCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0Dx18pqy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4nG8RvrD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rW1x0AR5QDBE5SdgqIqfK8y9Xj/p6HryldTCeU1V5Io=;
	b=0Dx18pqyC/f+vX4WtHc+1Gf5p4WJA6z58u1n7iNdXSESrHWkWjeZs8XvJCByVzu2Cmk3Zw
	coME4kq8HwgPOTVBv+oyyjOOBjYF1QU6/42onA86KoV0QR2SPqqOK6hJQU/yN0P4lRhI80
	i1+/HDI/rXKNGgKUtsw+prbEhIveAfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rW1x0AR5QDBE5SdgqIqfK8y9Xj/p6HryldTCeU1V5Io=;
	b=4nG8RvrD6SF3wEqwy5iN5voRw0hcapd9neZsafRvt9ZnsOdr5BBztw1mFrnm+517KTzdnx
	R8UUmtmZjLol5wDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F64613691;
	Mon,  7 Apr 2025 14:09:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QramB6zc82euIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 14:09:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8191A08D2; Mon,  7 Apr 2025 16:09:47 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:09:47 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH 9/9] selftests/filesystems: add fourth test for anonymous
 inodes
Message-ID: <3najiosayjpivtescspjccnhnvaxmmehsmyo2v7iikliltrvhy@i74t4xetzv5y>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-9-53a44c20d44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-work-anon_inode-v1-9-53a44c20d44e@kernel.org>
X-Rspamd-Queue-Id: 29A4F2116A
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,suse.cz,kernel.org,toxicpanda.com,syzkaller.appspotmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[5d8e79d323a13aa0b248];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 07-04-25 11:54:23, Christian Brauner wrote:
> Test that anonymous inodes cannot be open()ed.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  tools/testing/selftests/filesystems/anon_inode_test.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
> index 486496252ddd..e8e0ef1460d2 100644
> --- a/tools/testing/selftests/filesystems/anon_inode_test.c
> +++ b/tools/testing/selftests/filesystems/anon_inode_test.c
> @@ -48,5 +48,22 @@ TEST(anon_inode_no_exec)
>  	EXPECT_EQ(close(fd_context), 0);
>  }
>  
> +TEST(anon_inode_no_open)
> +{
> +	int fd_context;
> +
> +	fd_context = sys_fsopen("tmpfs", 0);
> +	ASSERT_GE(fd_context, 0);
> +
> +	ASSERT_GE(dup2(fd_context, 500), 0);
> +	ASSERT_EQ(close(fd_context), 0);
> +	fd_context = 500;
> +
> +	ASSERT_LT(open("/proc/self/fd/500", 0), 0);
> +	ASSERT_EQ(errno, ENXIO);
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

