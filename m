Return-Path: <linux-fsdevel+bounces-1176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23FD7D6E65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A51C20D44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBD928E0C;
	Wed, 25 Oct 2023 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RcOOSBww";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fYrT4h2G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE627EEC
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:06:02 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44D1198
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:05:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A66421DD9;
	Wed, 25 Oct 2023 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698242723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQovpG0eP0MvW4z3fs2sbApr9a0jyHJn7q883yYylkQ=;
	b=RcOOSBww1V7b8KdH7tz4DKrM3Tk9vRhBfSZ3psPii/vRvmat+5cf5GJv+XWJI3PReNl1SY
	BkLWfB38/jdbcegxy6gHFsejCClG3RpHeRdW2y1K/dotQ7Qo/dUkQB738FcBLmD7i9Ny5X
	94OuzOr7WOz78Hl/KID9DFRRVCa45h4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698242723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQovpG0eP0MvW4z3fs2sbApr9a0jyHJn7q883yYylkQ=;
	b=fYrT4h2GvkcjBRI/OZlTx6YwRcQfBRovQJbPJqoyFcgBgW0eEIRBlkkNp8zhxz05B6VSIA
	jsKXaQ8SDuA+/CBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7220213524;
	Wed, 25 Oct 2023 14:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jS/RG6MgOWXDEgAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 14:05:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E1D64A05BC; Wed, 25 Oct 2023 16:05:22 +0200 (CEST)
Date: Wed, 25 Oct 2023 16:05:22 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] porting: document block device freeze and thaw
 changes
Message-ID: <20231025140522.immnjj5d5zhyt53b@quack3>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
 <20231024-vfs-super-freeze-v2-9-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-freeze-v2-9-599c19f4faac@kernel.org>
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

On Tue 24-10-23 15:01:15, Christian Brauner wrote:
> Link: https://lore.kernel.org/r/20230927-vfs-super-freeze-v1-7-ecc36d9ab4d9@kernel.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---

...

> +
> +---
> +
> +**recommended**
> +
> +Block device freezing and thawing have been moved to holder operations.
> +
> +Before this change, get_active_super() would only be able to find the
> +superblock of the main block device, i.e., the one stored in sb->s_bdev. Block
> +device freezing now works for any block device owned by a given superblock, not
> +just the main block device. The get_active_super() helper is gone, so are
> +bd_fsfreeze_sb, and bd_fsfreeze_mutex.

Well, bd_fsfreeze_mutex is still there... Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

