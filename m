Return-Path: <linux-fsdevel+bounces-45881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3719DA7E0CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CFF18982CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E11C7000;
	Mon,  7 Apr 2025 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WL2F+UgW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4LwzJs/v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WL2F+UgW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4LwzJs/v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1E286355
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034988; cv=none; b=HdCuMAkFWQ5Z3PmH3Qo/m4eh1uZRwyw4KEOAbvQH0s+HuXxQPd/dyUfV82kS3r7vm0yKXH1hiVsRAhZD/fgRZd9o+ugsFslo8W6t0tpmmKp8qcWkyeHa90ky/8o11IyVkgarpgLvBMqh3ntlPwvn6BsOkzCBypx16UdTltVanZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034988; c=relaxed/simple;
	bh=flVqbyN6Lwi7lw1+vOYOmqRPht/v8r22pXXcuNl2+9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cmk33fG6FMwoXZ5L3C+8QCcyVSzbprjzDbGGQ/MJNaK64PKRqj7BFBqnPipVX88hYLoETtRiiuIZTE02qfDQqZlakHoUfaL0C0KYPrOVLT4V6ftty24Xolt2SNlAVdFWqeIfTTIq+Iml8SxUr2/71WtKI2OHIR2pF8+oKEpfzDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WL2F+UgW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4LwzJs/v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WL2F+UgW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4LwzJs/v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1C8B2116A;
	Mon,  7 Apr 2025 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JeB58gYvlw3kdiL2WidLgtgr2GjSpLGz3yrzvbq2R3I=;
	b=WL2F+UgWzlylTrorcVwReW4Vydi/4wYgOBIFGYlzljVteVfLFVCYF6BQscpFgGTPbrRQMD
	qJrmTSnHYuzYYd0FLKVVkFfV8tBXEbjPKFVlo8PJ0tX9hnIWRH6v5yFqOGM9geAo0lsRGb
	cFGkOablRXgn+eN39dKkQVl5grz8f+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JeB58gYvlw3kdiL2WidLgtgr2GjSpLGz3yrzvbq2R3I=;
	b=4LwzJs/vojYrRjuQudryJGybz2X+HPwklPPafAoXwhCidK6COWefxmwfve4Z6GnuFMMtTM
	Do7viM08pfxUCrAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JeB58gYvlw3kdiL2WidLgtgr2GjSpLGz3yrzvbq2R3I=;
	b=WL2F+UgWzlylTrorcVwReW4Vydi/4wYgOBIFGYlzljVteVfLFVCYF6BQscpFgGTPbrRQMD
	qJrmTSnHYuzYYd0FLKVVkFfV8tBXEbjPKFVlo8PJ0tX9hnIWRH6v5yFqOGM9geAo0lsRGb
	cFGkOablRXgn+eN39dKkQVl5grz8f+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JeB58gYvlw3kdiL2WidLgtgr2GjSpLGz3yrzvbq2R3I=;
	b=4LwzJs/vojYrRjuQudryJGybz2X+HPwklPPafAoXwhCidK6COWefxmwfve4Z6GnuFMMtTM
	Do7viM08pfxUCrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B843813691;
	Mon,  7 Apr 2025 14:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IbT6LKbc82elIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 14:09:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 723FCA08D2; Mon,  7 Apr 2025 16:09:42 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:09:42 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH 8/9] selftests/filesystems: add third test for anonymous
 inodes
Message-ID: <trqhpbnuh62bqxyyzlxwjfq2ooigtrl5t5isad2ra7oyuhdonw@jkfhzc3rkrmf>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-8-53a44c20d44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-work-anon_inode-v1-8-53a44c20d44e@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[5d8e79d323a13aa0b248];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,suse.cz,kernel.org,toxicpanda.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 07-04-25 11:54:22, Christian Brauner wrote:
> Test that anonymous inodes cannot be exec()ed.
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
> index 7c4d0a225363..486496252ddd 100644
> --- a/tools/testing/selftests/filesystems/anon_inode_test.c
> +++ b/tools/testing/selftests/filesystems/anon_inode_test.c
> @@ -35,5 +35,18 @@ TEST(anon_inode_no_chmod)
>  	EXPECT_EQ(close(fd_context), 0);
>  }
>  
> +TEST(anon_inode_no_exec)
> +{
> +	int fd_context;
> +
> +	fd_context = sys_fsopen("tmpfs", 0);
> +	ASSERT_GE(fd_context, 0);
> +
> +	ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
> +	ASSERT_EQ(errno, EACCES);
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

