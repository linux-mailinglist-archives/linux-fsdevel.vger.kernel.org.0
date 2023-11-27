Return-Path: <linux-fsdevel+bounces-3936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF27FA1D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 15:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0AE28194A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E330FA0;
	Mon, 27 Nov 2023 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFE2384F
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 05:59:48 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1476E67373; Mon, 27 Nov 2023 14:59:46 +0100 (CET)
Date: Mon, 27 Nov 2023 14:59:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] super: don't bother with WARN_ON_ONCE()
Message-ID: <20231127135945.GB24437@lst.de>
References: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org> <20231127-vfs-super-massage-wait-v1-2-9ab277bfd01a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-vfs-super-massage-wait-v1-2-9ab277bfd01a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 12:51:31PM +0100, Christian Brauner wrote:
> diff --git a/fs/super.c b/fs/super.c
> index f3227b22879d..844ca13e9d93 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -2067,10 +2067,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
>  	/* Release s_umount to preserve sb_start_write -> s_umount ordering */
>  	super_unlock_excl(sb);
>  	sb_wait_write(sb, SB_FREEZE_WRITE);
> -	if (!super_lock_excl(sb)) {
> -		WARN_ON_ONCE("Dying superblock while freezing!");
> -		return -EINVAL;
> -	}
> +	__super_lock_excl(sb);

This looks ok, but I still find these locking helper so horrible to
follow..


