Return-Path: <linux-fsdevel+bounces-62122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1397DB84C6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0524B547125
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 13:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7285230BBA2;
	Thu, 18 Sep 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sq0OZ9C7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Xtdmabv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sq0OZ9C7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Xtdmabv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B092FE575
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201486; cv=none; b=ri7Pjw6sdutobgDTwCG5IFrFFZ7Q8ZFzRwa8chbEjbnQrTC4D6fkL+99EWJn3+ICkrkjpUiDze+jlcRzUMc0efCn7FUOD4zSYQLR5lPbCiyAdi6GCuj80oYZS5bCPRqiNXc8lCqcEXOloxzVHMeGKqDxbu79yc7rEPU/vSijGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201486; c=relaxed/simple;
	bh=Ur3gRiy1j/DCQASrWQRFq7NUf3cAF+cMtkmd/6TnNCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBiwOgcgJ/HJQiFci7Nj7KLFpxIDnzfT0gUdmXMUsQW2+N4eXkqez3cSGXd1i0vvn4qjyPw4EHOAWdey2LRrqn1L5CKZJYtIBon2yJT/P5xq+h5v1d35Yu9o+ar7lW2OZGvjqTPHnve/nrv3MAu8p9QZOsBdBudCZmmI3Zuhvuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sq0OZ9C7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Xtdmabv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sq0OZ9C7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Xtdmabv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 058C01FB4E;
	Thu, 18 Sep 2025 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758201483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81F1VhD1BCWbjrcHGBn6mjVM/rtHwBcVTNIVqbPn+9c=;
	b=Sq0OZ9C7BfGy2gCccawpG99U1hWrAqWYGg/7R5ZWVqnAp6k9WMTW0/wEPoxpeRR/Gpi1Va
	AhhiBLcO8BMsUsJCL5U4/Yrpv5FOmisSaSNOEaKrrw3OcCa0Sh0jEkf3E+9w5NK23BTXlf
	9Q+kiaWdiuGy6TG5bjlIVvixTWF8wig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758201483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81F1VhD1BCWbjrcHGBn6mjVM/rtHwBcVTNIVqbPn+9c=;
	b=3Xtdmabv45CD1bZaaxb7uvoZSjJ7kWVA7J5rS+Fz9DGG3aTYho6itZACIzsKOO08Jt6Qtr
	HVsPw3xdkc8nkjBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Sq0OZ9C7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3Xtdmabv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758201483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81F1VhD1BCWbjrcHGBn6mjVM/rtHwBcVTNIVqbPn+9c=;
	b=Sq0OZ9C7BfGy2gCccawpG99U1hWrAqWYGg/7R5ZWVqnAp6k9WMTW0/wEPoxpeRR/Gpi1Va
	AhhiBLcO8BMsUsJCL5U4/Yrpv5FOmisSaSNOEaKrrw3OcCa0Sh0jEkf3E+9w5NK23BTXlf
	9Q+kiaWdiuGy6TG5bjlIVvixTWF8wig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758201483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81F1VhD1BCWbjrcHGBn6mjVM/rtHwBcVTNIVqbPn+9c=;
	b=3Xtdmabv45CD1bZaaxb7uvoZSjJ7kWVA7J5rS+Fz9DGG3aTYho6itZACIzsKOO08Jt6Qtr
	HVsPw3xdkc8nkjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E94CF13A39;
	Thu, 18 Sep 2025 13:18:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XuTwOIoGzGgWLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Sep 2025 13:18:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8DF1CA09B1; Thu, 18 Sep 2025 15:17:54 +0200 (CEST)
Date: Thu, 18 Sep 2025 15:17:54 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 04/33] block: use extensible_ioctl_valid()
Message-ID: <dg5xugicejwym44ibxl24st3xgicga6dzryoxvklqoix3an6js@qkcpc5ig7n56>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-4-1a247645cef5@kernel.org>
 <02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk>
 <aMlouk_55OXZv8w5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMlouk_55OXZv8w5@stanley.mountain>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 058C01FB4E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com,linaro.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RL9r1cnt7e4118fjryeg1c95sa)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Spam-Score: -2.51

Christian, this bug still seems to be present in your vfs.all branch. Can
you please fix it up? Thanks!

								Honza

On Tue 16-09-25 16:40:10, Dan Carpenter wrote:
> Yeah, the:
> 
> 	if (extensible_ioctl_valid(cmd, FS_IOC_GETLBMD_CAP, LBMD_SIZE_VER0))
> 		return -ENOIOCTLCMD;
> 
> test is inverted...  It should be if (!valid) return instead of if (valid)
> return;
> 
> regards,
> dan carpenter
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

