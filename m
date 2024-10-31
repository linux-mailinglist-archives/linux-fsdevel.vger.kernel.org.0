Return-Path: <linux-fsdevel+bounces-33340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AEE9B7A34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 13:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1FC1C21EF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 12:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BDE19C54F;
	Thu, 31 Oct 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bbvLfPq+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WS4vXqwP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bbvLfPq+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WS4vXqwP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD419B3D7;
	Thu, 31 Oct 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376275; cv=none; b=D0QovwFT4zJ3U9IJsENj5WqVo+vAzhsT2W5xnhfj1xNnzKDU7kGKFfArSO+zcOwaSspDho2umgs+utcGbf4P1rZyKIo+4GQbuPMf011lKqhcsEAU5jQ9QoewvK25LRXlC1NuiapQDh5uvPKxR7LKDKtoXZKDLI7LJglZ8kzuEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376275; c=relaxed/simple;
	bh=0C54W+tTXjTJqd5bzYLh931xiqxblrK1rsSjSruSmpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWvK99N5mQLWB7AJw2LnTn/L4U4DEqDntNaPaokRW2j5XZQ8XvBo2mKLfBBsM6gl4/BkZci0kXoXbrJd8IIt61SkQl1o04q6bPwPNEmMIJBeQGyRjMLR+bqrRHzePi0Vsb94vylnLcQmdhnJA8RGFKL2dqZVZBJbDiSGiliv2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bbvLfPq+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WS4vXqwP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bbvLfPq+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WS4vXqwP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DC4E1FC04;
	Thu, 31 Oct 2024 12:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730376271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afIfZ7ClCntBvNj+WXktFt5DIvv5SvlX7V5d7aVUsRg=;
	b=bbvLfPq+iWwbvRnGaisD1tGhgUyRCdGSL8at6WA9pVTFV7FkBn74l8hFIJZPYmgkrYR+xF
	tzbsCHGRydbqr0nh6mw2qs7u4Bf8rA9Pbb9K3i0P5xqiQ7tKSBV4fmLKEwIOHmFx493YzG
	25LuQ3NdTQ2Xz00+BdctAzZFGO2YGIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730376271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afIfZ7ClCntBvNj+WXktFt5DIvv5SvlX7V5d7aVUsRg=;
	b=WS4vXqwPruMvNw0rPdvNGYwikAi0ifoHNhIhoFQ3riStX2EeekqBr558ZrL4Up2HU68Njn
	Uk0Z+UEzW/LcaHCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730376271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afIfZ7ClCntBvNj+WXktFt5DIvv5SvlX7V5d7aVUsRg=;
	b=bbvLfPq+iWwbvRnGaisD1tGhgUyRCdGSL8at6WA9pVTFV7FkBn74l8hFIJZPYmgkrYR+xF
	tzbsCHGRydbqr0nh6mw2qs7u4Bf8rA9Pbb9K3i0P5xqiQ7tKSBV4fmLKEwIOHmFx493YzG
	25LuQ3NdTQ2Xz00+BdctAzZFGO2YGIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730376271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afIfZ7ClCntBvNj+WXktFt5DIvv5SvlX7V5d7aVUsRg=;
	b=WS4vXqwPruMvNw0rPdvNGYwikAi0ifoHNhIhoFQ3riStX2EeekqBr558ZrL4Up2HU68Njn
	Uk0Z+UEzW/LcaHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 737C113A53;
	Thu, 31 Oct 2024 12:04:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ne8vHE9yI2fGXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 31 Oct 2024 12:04:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0ECA2A086F; Thu, 31 Oct 2024 13:04:23 +0100 (CET)
Date: Thu, 31 Oct 2024 13:04:23 +0100
From: Jan Kara <jack@suse.cz>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: willy@infradead.org, bcrl@kvack.org, brauner@kernel.org, jack@suse.cz,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: aio: Transition from Linked List to Hash Table for
 Active Request Management in AIO
Message-ID: <20241031120423.5rq6uykywklkptkv@quack3>
References: <ZxW3pyyfXWc6Uaqn@casper.infradead.org>
 <20241022070329.144782-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022070329.144782-1-pvmohammedanees2003@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi!

On Tue 22-10-24 12:33:27, Mohammed Anees wrote:
> > Benchmarks, please.  Look at what operations are done on this list.
> > It's not at all obvious to me that what you've done here will improve
> > performance of any operation.
> 
> This patch aims to improve this operation in io_cancel() syscall,
> currently this iterates through all the requests in the Linked list,
> checking for a match, which could take a significant time if the 
> requests are high and once it finds one it deletes it. Using a hash
> table will significant reduce the search time, which is what the comment
> suggests as well.
> 
> /* TODO: use a hash or array, this sucks. */
> 	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
> 		if (kiocb->ki_res.obj == obj) {
> 			ret = kiocb->ki_cancel(&kiocb->rw);
> 			list_del_init(&kiocb->ki_list);
> 			break;
> 		}
> 	}
> 
> I have tested this patch and believe it doesn’t affect the 
> other functions. As for the io_cancel() syscall, please let 
> me know exactly how you’d like me to test it so I can benchmark 
> it accordingly.

Well, I'd say that calling io_cancel() isn't really frequent operation. Or
are you aware of any workload that would be regularly doing that? Hence
optimizing performance for such operation isn't going to bring much benefit
to real users. On the other hand the additional complexity of handling
hashtable for requests in flight (although it isn't big on its own) is
going to impact everybody using AIO. Hence I agree with Matthew that
changes like you propose are not a clear win when looking at the bigger
picture and need good justification.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

