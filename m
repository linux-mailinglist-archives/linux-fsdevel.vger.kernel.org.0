Return-Path: <linux-fsdevel+bounces-46459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E719A89B7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 13:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3D0189E161
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CDC28BABD;
	Tue, 15 Apr 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uI1xDssi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MtaJyPc5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OIOY4hfw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7VatcsVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D627FD6E
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715335; cv=none; b=UThAHwEuD2gtyEAksx/Gw4wd+bEYZyNYAjiJ0SzYOjzFhzdZzTrYbXl2fK/bpOOFgwIDUBFb8EX5N3lEk9at+dbn0QAynaqhxfvNgsTQWtDsidhiSfgN0SOJyV3aVCl/JF1xK0vKrtpttlx5ZPrvfeaJL0Smeghm6ZBcBshzVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715335; c=relaxed/simple;
	bh=bwEfUzuopWre1ZySt0NNb2cBAIv614nzpCPXlndK/2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XO1A4MwARxri3WpdkgtmXnBItqAnqa5lFbEGAeas9VdL6BT0iu/FT511S/uPzkyVfM7LNCuvEeL7BOtoP+LQVi2RhhphwDkyhVpaKlGxRhvKURCu9LAcfEgBRYPo8IzVyObESYKhdedNKCgVdWj8yDECCZBvynKY2TtMjmirz5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uI1xDssi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MtaJyPc5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OIOY4hfw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7VatcsVk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B22EE21134;
	Tue, 15 Apr 2025 11:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744715332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BoJpHota7+8QJvowdrK3ydyh8Nvcw7MRfbekl5i6fho=;
	b=uI1xDssijvRPgEhNjgtz/d6LHJHiMoqgk5+aFRRc3TIz6/DmeOdcu5XGL39KBj6KqGOcrO
	0XpSWSnbZwGvXRsm6oGA0z77nqgRCqCaY8XqYmK87caNiCtKeWsyp39NryH3YGo8CBp10x
	PpYi4w3My4PY++qjZzeLrQnUr0/8G+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744715332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BoJpHota7+8QJvowdrK3ydyh8Nvcw7MRfbekl5i6fho=;
	b=MtaJyPc5cWZQYB7VnrET301ACxGfazmbdNZVQOE8fK3bIHQNNZuteBWfh/viz5zxlRkR/q
	cn8LabHNcJ6+clAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744715330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BoJpHota7+8QJvowdrK3ydyh8Nvcw7MRfbekl5i6fho=;
	b=OIOY4hfwzHclarmjQp/4Xik9oOW9ugDd/LWh4EgqDsCEpcQKasmTqt9zbP/1vY4jB9td+q
	xz8DzyK382A+YIWVBzaRfHRQVDMkjsfyAPXOu+dkEyhWVyd3XIV1H8QQ6S/nHrJ3gANo/p
	JFrMhFz5BL7/bLPI+Neg7O2yfNNWCZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744715330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BoJpHota7+8QJvowdrK3ydyh8Nvcw7MRfbekl5i6fho=;
	b=7VatcsVkssUeeHiklmJg5w6/ZXOoXk92eR5NGTr4sNe2dGmEz/70aE/wGW57xDwpjA8vJa
	llng1ct7294y0rAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6F27137A5;
	Tue, 15 Apr 2025 11:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vee7KEI+/mcLdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 11:08:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 664B2A0947; Tue, 15 Apr 2025 13:08:46 +0200 (CEST)
Date: Tue, 15 Apr 2025 13:08:46 +0200
From: Jan Kara <jack@suse.cz>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: jack@suse.cz, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, hch@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH V2] fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr
Message-ID: <tgj6l2ymwspc7gd4mexoxtey27ewmrgj42mdozxmr7uymtubqr@q46d6tdh7kid>
References: <q5zbucxhdxsso7r3ydtnsz7jjkohc2zevz5swfbzwjizceqicp@32vssyaakhqo>
 <20250415092637.251786-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415092637.251786-1-lizhi.xu@windriver.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[e36cc3297bd3afd25e19];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 15-04-25 17:26:37, Lizhi Xu wrote:
> The ntfs3 can use the page cache directly, so its address_space_operations
> need direct_IO. Exit ntfs_direct_IO() if it is a compressed file.
> 
> Fixes: b432163ebd15 ("fs/ntfs3: Update inode->i_mapping->a_ops on compression state")
> Reported-by: syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e36cc3297bd3afd25e19
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

OK, this looks sensible to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V1 -> V2: exit direct io if it is a compressed file.
> 
>  fs/ntfs3/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 3e2957a1e360..0f0d27d4644a 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -805,6 +805,10 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  		ret = 0;
>  		goto out;
>  	}
> +	if (is_compressed(ni)) {
> +		ret = 0;
> +		goto out;
> +	}
>  
>  	ret = blockdev_direct_IO(iocb, inode, iter,
>  				 wr ? ntfs_get_block_direct_IO_W :
> @@ -2068,5 +2072,6 @@ const struct address_space_operations ntfs_aops_cmpr = {
>  	.read_folio	= ntfs_read_folio,
>  	.readahead	= ntfs_readahead,
>  	.dirty_folio	= block_dirty_folio,
> +	.direct_IO	= ntfs_direct_IO,
>  };
>  // clang-format on
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

