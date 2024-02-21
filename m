Return-Path: <linux-fsdevel+bounces-12302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF485E56B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C4A1F24EDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19985284;
	Wed, 21 Feb 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f3fCtDTJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GL/RRd3y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FPiHdmbd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WdSReT2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B184FC5;
	Wed, 21 Feb 2024 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539675; cv=none; b=Koi5ZJaxYaiTqgTPXvYeag4Owkz5sJsnFc/0z2yJwmJuf4/U5H4zgC0S28ng+lO2VBuRZhEpba3uVXOuAPImJ3//O+t/c4ToRqHwCSv+uXO8H7vTJN2uVUCIz1LJYD7krHo1UiGqBJf2P0I2cmE389FkUNXKbc6oKoq7K0os2OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539675; c=relaxed/simple;
	bh=Sr1AJVKrVpeqLPLU1XkAOTKTlNrmsDXjfpbAq2O7xwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG39etoh7GvLEr+Zs3TNvjAj6uHZiUQp10HUBP+DPPOQG6rtm9uNySxRzIlhv3lyCm0oZvmDhYJdsuRw8okJbRivIIdtsWcJQW4jA4LIvFmV9xQFsLEh43lu0VYmy1Esllx9bVgtqGA9ikZ8sQwPAUg6lSVKUJ8NkaMPdZbC3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f3fCtDTJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GL/RRd3y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FPiHdmbd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WdSReT2v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D0C921D88;
	Wed, 21 Feb 2024 18:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708539671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ucMo/pFa3P/tHEtP/GGd5/qHak2MY8RQPnwdWtQalPY=;
	b=f3fCtDTJ3twEcO420Dqxv6CQZNIQXT/VOiXw05C0/myjnddKSbsRfnyFo4R6Ovl9UtCvy6
	XvsMnsUy/+82MFbz6qO7DdB3v/JVisTa7MKOEoD2l4SH0A7J2JCRY+FdQiHGD0IaZsAuEG
	PNBiGRdSoj3ri+5KQ2+AYFzBiNCUbCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708539671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ucMo/pFa3P/tHEtP/GGd5/qHak2MY8RQPnwdWtQalPY=;
	b=GL/RRd3y4VXFGpR2zKV1IOepKZzY57fbPuJEAzdfxkJi7mCxJR8Bxpzvb+tfk89NWM22tM
	bSd6Wm4Ap0UZ60CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708539670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ucMo/pFa3P/tHEtP/GGd5/qHak2MY8RQPnwdWtQalPY=;
	b=FPiHdmbdeSn7N2YxW2tEDXpEi6Giyv6ZxaOqL5BsFTCFp7bmhdjgw5RwsSnIpWTOq15kDT
	BSCcylY+5HFqOAp7n/q1uvC0t+ex7YDaVc8XlCcj4UOSHHJLZE0mDwkYyMeyTg4vX18RK1
	Im8m7osHNMcgMY1+5yLbp5I0VmhBruM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708539670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ucMo/pFa3P/tHEtP/GGd5/qHak2MY8RQPnwdWtQalPY=;
	b=WdSReT2vYU3fzDg6IinL7/8uH12Xsrq5tqqivH0jIoSNf/PCljk7ry3L9amnSeqgITHtJG
	B2JlEwn8wvBAISDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CF18139D1;
	Wed, 21 Feb 2024 18:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id D2y1BhY/1mUBfgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 21 Feb 2024 18:21:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 97CB6A0807; Wed, 21 Feb 2024 19:21:09 +0100 (CET)
Date: Wed, 21 Feb 2024 19:21:09 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+a3db10baf0c0ee459854@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [udf?] KASAN: slab-out-of-bounds Write in
 udf_adinicb_writepage
Message-ID: <20240221182109.akwfhujzzxt5bev3@quack3>
References: <000000000000e190b405f79d218b@google.com>
 <0000000000003bf562061157df75@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003bf562061157df75@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.70
X-Spamd-Result: default: False [1.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[39.32%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7];
	 TAGGED_RCPT(0.00)[a3db10baf0c0ee459854];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Wed 14-02-24 05:56:05, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15458262180000
> start commit:   e8d018dd0257 Linux 6.3-rc3
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7
> dashboard link: https://syzkaller.appspot.com/bug?extid=a3db10baf0c0ee459854
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159fa1d6c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bbce16c80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

