Return-Path: <linux-fsdevel+bounces-14148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57E8786C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 18:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D0528109B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 17:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162AA535C6;
	Mon, 11 Mar 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+iMSDGM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVairj1w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+iMSDGM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVairj1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC07524AF;
	Mon, 11 Mar 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179685; cv=none; b=XXbzWR8TH3fmgb0HS4kiOFK7cGQV0PqcvYQiVMhwETJjCFdzNQnHYokFrHzl4eYZr034DJB1WT/iR7R6WLUJGmWiuYVoWbOl3AsekQOv5iQbei0RItKcU2Nte2pjP0dxjRs79qaDkHLKoprCzpMe4iYTyQdK1+m4fboClbIHLUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179685; c=relaxed/simple;
	bh=BQzSLPqPmRNY3f4OGi1qZV6xc7n2Vd7CQK7C55WEBNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zyt2gakVHMO0TSUXB7WHbSppd4Mt9hJG5vjQMitYek6VHBI2JyfBY5GEPRQNvNwCNlMsFD5XJ3h3b5/3tw8P5t5s/m/aN/2acEc/8VhroGo9EEo73ZRYhiNaynQdp/BRHMY/w8sOX9eB64dts9AB/GaoSx+7+CfE2Xep7y3WIDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+iMSDGM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vVairj1w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+iMSDGM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vVairj1w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBA3234F22;
	Mon, 11 Mar 2024 17:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710179681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQYXUbvbtW2whG6gczcLXf9OVJOGW4gwzkH+ZHqJFn8=;
	b=a+iMSDGMRQNnmhZeMtpbU+L+RuDGPxrQlVH5xax8Hevk7luRSh5UeQ2RwbiCAGtsCKmUJQ
	Qe6wMUFT5GmjgisnGumrvJ6gR2hKUU3qJqxktrR6vNHgm5MPY8Pjp5eBLH8k++Vj9/4Ugm
	skiGdWXYOBGoIWIWkNEXCIS5798hFcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710179681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQYXUbvbtW2whG6gczcLXf9OVJOGW4gwzkH+ZHqJFn8=;
	b=vVairj1wW/0sAKo/rr7Mtd/YQnM5pThBYbI0PZgjVuXsTJNOPv9RPb+G5aLakfOAx4UGfA
	+sC9VUjhx1AVOQCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710179681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQYXUbvbtW2whG6gczcLXf9OVJOGW4gwzkH+ZHqJFn8=;
	b=a+iMSDGMRQNnmhZeMtpbU+L+RuDGPxrQlVH5xax8Hevk7luRSh5UeQ2RwbiCAGtsCKmUJQ
	Qe6wMUFT5GmjgisnGumrvJ6gR2hKUU3qJqxktrR6vNHgm5MPY8Pjp5eBLH8k++Vj9/4Ugm
	skiGdWXYOBGoIWIWkNEXCIS5798hFcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710179681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQYXUbvbtW2whG6gczcLXf9OVJOGW4gwzkH+ZHqJFn8=;
	b=vVairj1wW/0sAKo/rr7Mtd/YQnM5pThBYbI0PZgjVuXsTJNOPv9RPb+G5aLakfOAx4UGfA
	+sC9VUjhx1AVOQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5A30136BA;
	Mon, 11 Mar 2024 17:54:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s89NLGFF72UmMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 17:54:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 182C2A0807; Mon, 11 Mar 2024 18:54:41 +0100 (CET)
Date: Mon, 11 Mar 2024 18:54:41 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+352d78bd60c8e9d6ecdc@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org,
	elic@nvidia.com, jack@suse.cz, jasowang@redhat.com,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, mst@redhat.com,
	nathan@kernel.org, ndesaulniers@google.com, parav@nvidia.com,
	syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget (2)
Message-ID: <20240311175441.o3ppno62leqgo2lw@quack3>
References: <0000000000005b767405ffd4e4ec@google.com>
 <00000000000044b90e061326b102@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000044b90e061326b102@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.68
X-Spamd-Result: default: False [1.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.02)[52.34%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=56c2c781bb4ee18];
	 TAGGED_RCPT(0.00)[352d78bd60c8e9d6ecdc];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Fri 08-03-24 06:06:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f08e0a180000
> start commit:   610a9b8f49fb Linux 6.7-rc8
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=56c2c781bb4ee18
> dashboard link: https://syzkaller.appspot.com/bug?extid=352d78bd60c8e9d6ecdc
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a4d65ee80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1715ad7ee80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
Makes sense.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

