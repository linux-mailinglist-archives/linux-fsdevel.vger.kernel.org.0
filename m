Return-Path: <linux-fsdevel+bounces-45879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEACBA7E0CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6AFE3A56C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579891C700A;
	Mon,  7 Apr 2025 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pknnaTGq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OqsFJTHW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pknnaTGq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OqsFJTHW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103B1C6FE9
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034967; cv=none; b=O8+2fkFK/fCgVXF9LY/igBM11LTFuQiMnFXFEtnJOKsn+Dp4raiyV5FaJAPDWt+JMLyQg+oX7J6xYLK9ur/lw7XyLSKZJCn8YTzQcoMwzBZPPk6ANAUorNoKei60c8qKyQdyLArQdGOzx7rnJrY4uoQ4LWv68D+oQH7pbP8bWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034967; c=relaxed/simple;
	bh=jZu643QBmP9JcttgqOqCs5fFJL+ZkvH0VzUdiUhi2Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfdbMzoljj8ne0mZLOkXc3GuQ9A/VYXgpF1pVU7Q4fuuqovYKvrKVGk/hVEM79gIZDajab4nd2CgwmQuYh4vpVmuSDwZQCe2B4dV4leRVC3n/TYR78xCHaLvxvWERALVT/TqqVi+2h23mROCr5dRieJfBeA6sYRoUiliWfnaoyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pknnaTGq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OqsFJTHW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pknnaTGq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OqsFJTHW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABB231F388;
	Mon,  7 Apr 2025 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f8STsXEKz+qnPPWBOT2wZaKeKCIz/yiDx2Tm5zAFTp4=;
	b=pknnaTGq7x1n/CVmWNGSzu2VcS3B7a8ZV31iIXhiOva+/N13wVEg2WuWYhFooZIob+7QQc
	BWM8n3KIgPPctJ14XZtojJA0nqjwStliv1a2/rFR2LWIBUzeWvJlsg8TI/dYGGYsZSpF+K
	IrUykmCLidxBI06sWgY+DjgmHQ7uVnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f8STsXEKz+qnPPWBOT2wZaKeKCIz/yiDx2Tm5zAFTp4=;
	b=OqsFJTHWAoF60564JYEuWN9EQ9P+ZJYEm5Bwb5btLSvcwiKYCh5Gz1VY5QzpRDcv0SvYtL
	UwzI5s6eWcgev4Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pknnaTGq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OqsFJTHW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f8STsXEKz+qnPPWBOT2wZaKeKCIz/yiDx2Tm5zAFTp4=;
	b=pknnaTGq7x1n/CVmWNGSzu2VcS3B7a8ZV31iIXhiOva+/N13wVEg2WuWYhFooZIob+7QQc
	BWM8n3KIgPPctJ14XZtojJA0nqjwStliv1a2/rFR2LWIBUzeWvJlsg8TI/dYGGYsZSpF+K
	IrUykmCLidxBI06sWgY+DjgmHQ7uVnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f8STsXEKz+qnPPWBOT2wZaKeKCIz/yiDx2Tm5zAFTp4=;
	b=OqsFJTHWAoF60564JYEuWN9EQ9P+ZJYEm5Bwb5btLSvcwiKYCh5Gz1VY5QzpRDcv0SvYtL
	UwzI5s6eWcgev4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C79E13691;
	Mon,  7 Apr 2025 14:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sjUtJpPc82eDIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 14:09:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5E3D1A08D2; Mon,  7 Apr 2025 16:09:23 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:09:23 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH 6/9] selftests/filesystems: add first test for anonymous
 inodes
Message-ID: <yjlpcan6bfpamqsp7vjg45cdddsyugfshnetrp7czwurzjb6zi@6hmqves4ohgt>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-6-53a44c20d44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-work-anon_inode-v1-6-53a44c20d44e@kernel.org>
X-Rspamd-Queue-Id: ABB231F388
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,suse.cz,kernel.org,toxicpanda.com,syzkaller.appspotmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[5d8e79d323a13aa0b248];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 07-04-25 11:54:20, Christian Brauner wrote:
> Test that anonymous inodes cannot be chown()ed.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  tools/testing/selftests/filesystems/.gitignore     |  1 +
>  tools/testing/selftests/filesystems/Makefile       |  2 +-
>  .../selftests/filesystems/anon_inode_test.c        | 26 ++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
> index 828b66a10c63..7afa58e2bb20 100644
> --- a/tools/testing/selftests/filesystems/.gitignore
> +++ b/tools/testing/selftests/filesystems/.gitignore
> @@ -2,3 +2,4 @@
>  dnotify_test
>  devpts_pts
>  file_stressor
> +anon_inode_test
> diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
> index 66305fc34c60..b02326193fee 100644
> --- a/tools/testing/selftests/filesystems/Makefile
> +++ b/tools/testing/selftests/filesystems/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  CFLAGS += $(KHDR_INCLUDES)
> -TEST_GEN_PROGS := devpts_pts file_stressor
> +TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test
>  TEST_GEN_PROGS_EXTENDED := dnotify_test
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
> new file mode 100644
> index 000000000000..f2cae8f1ccae
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/anon_inode_test.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#define __SANE_USERSPACE_TYPES__
> +
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <sys/stat.h>
> +
> +#include "../kselftest_harness.h"
> +#include "overlayfs/wrappers.h"
> +
> +TEST(anon_inode_no_chown)
> +{
> +	int fd_context;
> +
> +	fd_context = sys_fsopen("tmpfs", 0);
> +	ASSERT_GE(fd_context, 0);
> +
> +	ASSERT_LT(fchown(fd_context, 1234, 5678), 0);
> +	ASSERT_EQ(errno, EOPNOTSUPP);
> +
> +	EXPECT_EQ(close(fd_context), 0);
> +}
> +
> +TEST_HARNESS_MAIN
> +
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

