Return-Path: <linux-fsdevel+bounces-2063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD977E1E84
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 11:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F2DB21038
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367918030;
	Mon,  6 Nov 2023 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yNwEXiXJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MGRNbnC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137201799B
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 10:39:28 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C8184
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 02:39:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 474031F45A;
	Mon,  6 Nov 2023 10:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699267166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P430HGSXFW1u0/o9nRc5GpDQIJalsis8UDyzr9h2aX4=;
	b=yNwEXiXJ9R6rWAOT5poBCnuVx2RVMPooe2wPeTwExkq9C7KXj2VB/v35uIPrBQX2xEIYL4
	wGFak1Rtr++zKXmQTJ7ZVRTDrgJhraG4TlMMwbwNCvDjZaWh6jKOqXn2LlLoS7pSTfVU8V
	RNTDKOHHsBTh1oZffnhnr+czBi3bDQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699267166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P430HGSXFW1u0/o9nRc5GpDQIJalsis8UDyzr9h2aX4=;
	b=MGRNbnC/2ND24nfZjUCGW2VqrucOxE8RSsEqABOE5ULprl8zi36Y9yFNB8feUATI7dxDUp
	VEi24Wc3ivrbP/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39EE0138E5;
	Mon,  6 Nov 2023 10:39:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 9VodDl7CSGV6GQAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 06 Nov 2023 10:39:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C0F13A07BE; Mon,  6 Nov 2023 11:39:25 +0100 (CET)
Date: Mon, 6 Nov 2023 11:39:25 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs: remove dead check
Message-ID: <20231106103925.cpcaaudml57rkwcq@quack3>
References: <20231104-vfs-multi-device-freeze-v2-0-5b5b69626eac@kernel.org>
 <20231104-vfs-multi-device-freeze-v2-1-5b5b69626eac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104-vfs-multi-device-freeze-v2-1-5b5b69626eac@kernel.org>

On Sat 04-11-23 15:00:12, Christian Brauner wrote:
> Above we call super_lock_excl() which waits until the superblock is
> SB_BORN and since SB_BORN is never unset once set this check can never
> fire. Plus, we also hold an active reference at this point already so
> this superblock can't even be shutdown.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

