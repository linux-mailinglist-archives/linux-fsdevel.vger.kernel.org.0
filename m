Return-Path: <linux-fsdevel+bounces-36256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ADA9E0231
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 13:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8F4B24170
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197C41FE467;
	Mon,  2 Dec 2024 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NMLlDLkS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QWKlhe7b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DusRw5C4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NmJFpoCW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83AC1E521;
	Mon,  2 Dec 2024 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142269; cv=none; b=SLWQkZ6ePieZv7Qa9hGn51AbYAhu4yHbB7AMglASf2NsP5XX3pDZ1rE75YXwII2xi8qpf2N81daUkCSqu4Eq8Q7lfN0sl4VfiVELvh6tuwmUjQEp7LVgiPskzTtVjSG0+cjk3PU8vnRF2XsniKK+wdBBSXDZwW8ubjWOEnKRNcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142269; c=relaxed/simple;
	bh=9EzQTl1oflHEWlT9P3nU8F0iIJZT7VnkWYMoiOsqE4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjOe24cLVZlp9trB1E83Qm0s5UbkVQ9eJmokGcbt20pnCoypoK6wjF3k7dVRQyP5zxxzts8iptOSJxELQWTqY75i9oHb/7ihee0x/HSszXoEZqJa+mhop2NlwfmnNNFjBl8ZhDprbwwiIXqpz4Kg8l9wTsidvLDF3UtxCTO5KDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NMLlDLkS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QWKlhe7b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DusRw5C4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NmJFpoCW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D87741F444;
	Mon,  2 Dec 2024 12:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733142266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhN1mDBN4xhMmKlyLRU/hUBnHq/O8a6UVW4pozGBAaA=;
	b=NMLlDLkS2gsLcmetOE0NBm3CigRFDqQ5HIE35E1Qf5gFvaEDDwAP1FYGmyI6Ycg26PpPIL
	cmYsrM1Irqlvj/dMeUbSxrjaHb4Kd+N9W/svD+l5DBErGghqvacqFH8irIJ1NlvO89a2Rh
	UHUtgUFK7JweP7owlbiGG8egXKExa/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733142266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhN1mDBN4xhMmKlyLRU/hUBnHq/O8a6UVW4pozGBAaA=;
	b=QWKlhe7b0HUF8tivKigGjtPZ6U7dTO415fPr8G/uFAr9MQjuKPF8msJCflI7KNQoo7oCdX
	GYTSpOy0JXfTxVBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733142265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhN1mDBN4xhMmKlyLRU/hUBnHq/O8a6UVW4pozGBAaA=;
	b=DusRw5C4q14UVWgx4ZvpYGolHtc/P9YIBGY2Kmnxq6XN7+tuUxOtfhKbWS6UuSlWR3JmEC
	330wjP68QGo0O/lLP6Se9hz2AzpONfm9r/k8mvj+oRw3IzvQbF/myejqdKGgVSUJIFJTI6
	z0LhicaLA2UyUZ+7dufAtrN70QthGjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733142265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhN1mDBN4xhMmKlyLRU/hUBnHq/O8a6UVW4pozGBAaA=;
	b=NmJFpoCWGegmqphCc0VksQmTYkcO0yBmKwG5w8wZyKTOhGk6HiP4LTw8vipcRefaAGeRrN
	P5/Twe/PVjWesOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8CF313A31;
	Mon,  2 Dec 2024 12:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tBL/MPmmTWdAdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Dec 2024 12:24:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7BE31A07B4; Mon,  2 Dec 2024 13:24:25 +0100 (CET)
Date: Mon, 2 Dec 2024 13:24:25 +0100
From: Jan Kara <jack@suse.cz>
To: Leo Stone <leocstone@gmail.com>
Cc: brauner@kernel.org, sandeen@redhat.com, jack@suse.cz,
	viro@zeniv.linux.org.uk, quic_jjohnson@quicinc.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] hfs: Sanity check the root record
Message-ID: <20241202122425.rlxuge77wq7iiz6w@quack3>
References: <20241201051420.77858-1-leocstone@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201051420.77858-1-leocstone@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[2db3c7526ba68f4ea776];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Sat 30-11-24 21:14:19, Leo Stone wrote:
> In the syzbot reproducer, the hfs_cat_rec for the root dir has type
> HFS_CDR_FIL after being read with hfs_bnode_read() in hfs_super_fill().
> This indicates it should be used as an hfs_cat_file, which is 102 bytes.
> Only the first 70 bytes of that struct are initialized, however,
> because the entrylength passed into hfs_bnode_read() is still the length of
> a directory record. This causes uninitialized values to be used later on,
> when the hfs_cat_rec union is treated as the larger hfs_cat_file struct.
> 
> Add a check to make sure the retrieved record has the correct type
> for the root directory (HFS_CDR_DIR), and make sure we load the correct
> number of bytes for a directory record.
> 
> Reported-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2db3c7526ba68f4ea776
> Tested-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
> Tested-by: Leo Stone <leocstone@gmail.com>
> Signed-off-by: Leo Stone <leocstone@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
> v2: Made the check on fd.entrylength more strict. Tested with real HFS
>     images.
> v1: https://lore.kernel.org/all/20241123194949.9243-1-leocstone@gmail.com
> ---
>  fs/hfs/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 3bee9b5dba5e..fe09c2093a93 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -349,11 +349,13 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  		goto bail_no_root;
>  	res = hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
>  	if (!res) {
> -		if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) {
> +		if (fd.entrylength != sizeof(rec.dir)) {
>  			res =  -EIO;
>  			goto bail_hfs_find;
>  		}
>  		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
> +		if (rec.type != HFS_CDR_DIR)
> +			res = -EIO;
>  	}
>  	if (res)
>  		goto bail_hfs_find;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

