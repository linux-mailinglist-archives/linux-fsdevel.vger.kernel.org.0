Return-Path: <linux-fsdevel+bounces-35884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 326049D94E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 10:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E57BB23037
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9AD1BD4F7;
	Tue, 26 Nov 2024 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0kRHeVaY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UnOK01oO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0kRHeVaY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UnOK01oO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A701BCA0D;
	Tue, 26 Nov 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613597; cv=none; b=iZqEq5aaUFCqOXZBOOXcALA0EVVlfyc1LzwzFYuIP+T8M3nlFBxfrHtQQt48NnqWlcY5Ph0+o5k2lAAznEEWARLl1aQkkofGJn8alPzUiuojzt4RUt/LAwE4ErCGPzXt1NFdp+YwrMnz1wAkF4dr9/wgpEiMNEUNgO89jyNXS4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613597; c=relaxed/simple;
	bh=Wbc0vvzr9PT5ZxEVvtI2ydNZZVXz5EN4F+RXZpsUZiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/tevB/t+SLKvoO0z2bMcstRUJUkEIlfWMUM30W97ay2fjUJpJ5CBv7HwLpiIDEUBxz61EMp15s7RQFD1genAYpmWsy0PKDEVAynzolvq5Cp7TI6PazCStc0mUlzY6NDAlMgYnKBOSFCweyQk0tKtJlwBzKCYo0TD+f3oFsYx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0kRHeVaY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UnOK01oO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0kRHeVaY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UnOK01oO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9DF981F45E;
	Tue, 26 Nov 2024 09:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732613593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qEeCeTbcmNgP4kZTcR728RzH4D8VWMJ/56QxE4hH38=;
	b=0kRHeVaYBbzOAlXngQITnQbd3EdoBXaP+A0ortzEHiGZlcUb3Q/IRKY71ovjITR2kM2v1U
	4voQw7C+mIwmqCwmkWDZgd/4vCOQWacu7lyU0ikpeiVe682VuPhy4AKR1MeCcQBvoQoves
	ut2L4xNWMxzL4NkVOp2bP3ckv51YNwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732613593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qEeCeTbcmNgP4kZTcR728RzH4D8VWMJ/56QxE4hH38=;
	b=UnOK01oOMUBomYCFcj9NdcCrUb1m87naRo1+/JsfWUI76dE+LlwKt3TpnPa2yhlV08xajn
	vl+v+IUMuNGfEDAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732613593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qEeCeTbcmNgP4kZTcR728RzH4D8VWMJ/56QxE4hH38=;
	b=0kRHeVaYBbzOAlXngQITnQbd3EdoBXaP+A0ortzEHiGZlcUb3Q/IRKY71ovjITR2kM2v1U
	4voQw7C+mIwmqCwmkWDZgd/4vCOQWacu7lyU0ikpeiVe682VuPhy4AKR1MeCcQBvoQoves
	ut2L4xNWMxzL4NkVOp2bP3ckv51YNwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732613593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qEeCeTbcmNgP4kZTcR728RzH4D8VWMJ/56QxE4hH38=;
	b=UnOK01oOMUBomYCFcj9NdcCrUb1m87naRo1+/JsfWUI76dE+LlwKt3TpnPa2yhlV08xajn
	vl+v+IUMuNGfEDAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DD9013890;
	Tue, 26 Nov 2024 09:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZYOOItmVRWeLCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 09:33:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3CCD8A08CA; Tue, 26 Nov 2024 10:33:13 +0100 (CET)
Date: Tue, 26 Nov 2024 10:33:13 +0100
From: Jan Kara <jack@suse.cz>
To: Leo Stone <leocstone@gmail.com>
Cc: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com,
	brauner@kernel.org, quic_jjohnson@quicinc.com, jack@suse.cz,
	viro@zeniv.linux.org.uk, sandeen@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, shuah@kernel.org,
	anupnewsmail@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] hfs: Sanity check the root record
Message-ID: <20241126093313.2t7nu67e6cjvbe7b@quack3>
References: <67400d16.050a0220.363a1b.0132.GAE@google.com>
 <20241123194949.9243-1-leocstone@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123194949.9243-1-leocstone@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[2db3c7526ba68f4ea776];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,kernel.org,quicinc.com,suse.cz,zeniv.linux.org.uk,redhat.com,vger.kernel.org,googlegroups.com,gmail.com,lists.linuxfoundation.org];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Sat 23-11-24 11:49:47, Leo Stone wrote:
> In the syzbot reproducer, the hfs_cat_rec for the root dir has type
> HFS_CDR_FIL after being read with hfs_bnode_read() in hfs_super_fill().
> This indicates it should be used as an hfs_cat_file, which is 102 bytes.
> Only the first 70 bytes of that struct are initialized, however,
> because the entrylength passed into hfs_bnode_read() is still the length of
> a directory record. This causes uninitialized values to be used later on,
> when the hfs_cat_rec union is treated as the larger hfs_cat_file struct.
> 
> Add a check to make sure the retrieved record has the correct type
> for the root directory (HFS_CDR_DIR).

This certainly won't hurt but shouldn't we also add some stricter checks
for entry length so that we know we've loaded enough data to have full info
about the root dir?

								Honza

> 
> Reported-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2db3c7526ba68f4ea776
> Tested-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
> Signed-off-by: Leo Stone <leocstone@gmail.com>
> ---
>  fs/hfs/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 3bee9b5dba5e..02d78992eefd 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -354,6 +354,8 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
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

