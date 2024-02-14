Return-Path: <linux-fsdevel+bounces-11529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA5E854658
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 10:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC151C2179C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832312E44;
	Wed, 14 Feb 2024 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AH16laAd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ecTqLGVy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AH16laAd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ecTqLGVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA2134A9;
	Wed, 14 Feb 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903965; cv=none; b=dC+Pb/7pvUssL9oENf59VqfON5KHpjHuDJEcboTWMPcaujwX1cmb2m6ph2rM6wf9xh7uoSj+AV+s6TNIUr5qrMaC8Ss0brBKGL2u3oLqRPx4qflW3eapvb/4j86HQFy1YyijosqAKMmcv/qZkVURTq8cCEReNeDjL9j1DSQT1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903965; c=relaxed/simple;
	bh=K+lhWbx0yxGWZ0i2OnK+9Eytn5NgHZSRTY9qc4RNnbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1RlWdMq8CL5Wz8Anp+s5nTZdiQSgiOFzamSFShsFbfBLaKgTWDgDdhq4nLdlSDSItY7DErOoidB9kpnv+7q4RSty7UVsk3W1aUtrTf9PVk/8ZDbVVKYx0SjUfeEO/Zu1V87lqIGikiQDCTj7LpNkYzEKlGQ7/TVxVxe03GIxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AH16laAd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ecTqLGVy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AH16laAd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ecTqLGVy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F6DC1F7EC;
	Wed, 14 Feb 2024 09:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707903960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haymRKrSqrh0B+mONyIe7Y9TYIPAd2zJDwlRYXl1K3Q=;
	b=AH16laAdxZnW5KymEtVjIRAzfVvWMH53LGnj7DpN8IGYdUAaAPaznfG2hOXHIA3G3AO0Ne
	Vt6IO8OXbF4dhk45gwpM8UFE2TjehAsIFW+EeZsEMcYaB5ONQA6I759+6Dl1eFoRzhVZ+Q
	Md04SF5TjDF5T68Y72M4ElHQ5CmEcBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707903960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haymRKrSqrh0B+mONyIe7Y9TYIPAd2zJDwlRYXl1K3Q=;
	b=ecTqLGVym8CdwcwvXg19yD7mUCjt91wC1lffTGDNdE6JiXwkNDqGUImHCElVvCtfS0vYRc
	gvzKs5pFIWZ8SfBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707903960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haymRKrSqrh0B+mONyIe7Y9TYIPAd2zJDwlRYXl1K3Q=;
	b=AH16laAdxZnW5KymEtVjIRAzfVvWMH53LGnj7DpN8IGYdUAaAPaznfG2hOXHIA3G3AO0Ne
	Vt6IO8OXbF4dhk45gwpM8UFE2TjehAsIFW+EeZsEMcYaB5ONQA6I759+6Dl1eFoRzhVZ+Q
	Md04SF5TjDF5T68Y72M4ElHQ5CmEcBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707903960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haymRKrSqrh0B+mONyIe7Y9TYIPAd2zJDwlRYXl1K3Q=;
	b=ecTqLGVym8CdwcwvXg19yD7mUCjt91wC1lffTGDNdE6JiXwkNDqGUImHCElVvCtfS0vYRc
	gvzKs5pFIWZ8SfBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F5FB13A1A;
	Wed, 14 Feb 2024 09:46:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id q+gmG9iLzGWASwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 14 Feb 2024 09:46:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 09067A0809; Wed, 14 Feb 2024 10:45:56 +0100 (CET)
Date: Wed, 14 Feb 2024 10:45:55 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+0994679b6f098bb3da6d@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, anton@tuxera.com,
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel paging request in
 step_into
Message-ID: <20240214094555.bcmnrnae3jndqjez@quack3>
References: <00000000000042f98c05f16c0792@google.com>
 <0000000000001c3739061147c07d@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001c3739061147c07d@google.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AH16laAd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ecTqLGVy
X-Spamd-Result: default: False [2.67 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.02)[51.86%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4];
	 TAGGED_RCPT(0.00)[0994679b6f098bb3da6d];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.67
X-Rspamd-Queue-Id: 7F6DC1F7EC
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Tue 13-02-24 10:42:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10656c42180000
> start commit:   bff687b3dad6 Merge tag 'block-6.2-2022-12-29' of git://git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
> dashboard link: https://syzkaller.appspot.com/bug?extid=0994679b6f098bb3da6d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11307974480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c567f2480000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fs: Block writes to mounted block devices

There seem to be other reproducers which keep working and they don't seem
to be doing anything with the device. So I don't think this is really
fixing it.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

