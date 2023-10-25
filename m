Return-Path: <linux-fsdevel+bounces-1168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E77C7D6DE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD336B20C55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3D28E06;
	Wed, 25 Oct 2023 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mhnERuMs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3ZuEblM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1C28DDE
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:02:02 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F60189
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80A6B21DDA;
	Wed, 25 Oct 2023 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698242517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xynCP93Xhc9ZGGEVa3rs7gHpVCYsgLgRpaTktTr2VI=;
	b=mhnERuMsNwM8IDzLPgr9LLZvYuwtGqr2fddMgUfRH06u2PPpZ+9l0X2WA2ZeCgdMAjOAiP
	7ONbudz18ijstqrXYOEidDYtYS/m4KkA+CBslpOwry2bTFQQPZDTCTrQUgfQ6ueT61fI02
	mCGu4PR5XCBOpUDxg/QZnQ34RiWD9eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698242517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xynCP93Xhc9ZGGEVa3rs7gHpVCYsgLgRpaTktTr2VI=;
	b=3ZuEblM3xthbNGuN7iD/pAiivJzlrqzqOfn/TW3u7uo+32LCk2I53KisflBiUTNAewTLuE
	++KWYkTdhFVW/jBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7566213524;
	Wed, 25 Oct 2023 14:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ZfShHNUfOWXfEAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 14:01:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 180F1A05BC; Wed, 25 Oct 2023 16:01:57 +0200 (CEST)
Date: Wed, 25 Oct 2023 16:01:57 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] fs: massage locking helpers
Message-ID: <20231025140157.5ro56xffebaflhy2@quack3>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
 <20231024-vfs-super-freeze-v2-1-599c19f4faac@kernel.org>
 <20231025123449.sek6wu5aafztfcwy@quack3>
 <20231025-ungnade-betanken-29f7b98d0265@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-ungnade-betanken-29f7b98d0265@brauner>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]

On Wed 25-10-23 15:21:06, Christian Brauner wrote:
> > Here if locked == true but say !(sb->s_flags & SB_ACTIVE), we fail to
> > unlock the superblock now AFAICT.
> 
> Yeah, I've already fixed that up in-tree. I realized this because I've
> fixed it correctly in the last patch.
> 
> > And here if you really mean it with some kind of clean bail out, we should
> > somehow get rid of the s_active reference we have. But exactly because of
> > that getting super_lock_excl() failure here would be really weird...
> > 
> > Otherwise the patch looks good.
> 
> With the above fix folded in can I take your Ack?

Yes. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

