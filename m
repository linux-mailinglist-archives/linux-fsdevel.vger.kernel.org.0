Return-Path: <linux-fsdevel+bounces-3961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B6E7FA6BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 17:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1269B28188F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D5A36B1A;
	Mon, 27 Nov 2023 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978C6198
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 08:46:42 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8ECA867373; Mon, 27 Nov 2023 17:46:38 +0100 (CET)
Date: Mon, 27 Nov 2023 17:46:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] super: massage wait event mechanism
Message-ID: <20231127164637.GA2398@lst.de>
References: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org> <20231127-vfs-super-massage-wait-v1-1-9ab277bfd01a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-vfs-super-massage-wait-v1-1-9ab277bfd01a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 12:51:30PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/super.c | 51 ++++++++++++++-------------------------------------
>  1 file changed, 14 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index aa4e5c11ee32..f3227b22879d 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -81,16 +81,13 @@ static inline void super_unlock_shared(struct super_block *sb)
>  	super_unlock(sb, false);
>  }
>  
> +static bool super_load_flags(const struct super_block *sb, unsigned int flags)
>  {
>  	/*
>  	 * Pairs with smp_store_release() in super_wake() and ensures
> +	 * that we see @flags after we're woken.
>  	 */
> +	return smp_load_acquire(&sb->s_flags) & flags;

I find the name for this helper very confusing.  Yes, eventually it
is clear that the load maps to a load instruction with acquire semantics
here, but it's a really unusual naming I think.  Unfortunately I can't
offer a better one either.

Otherwise this looks good except for the fact that I really hate
code using smp_load_acquire / smp_store_release directly because of
all the mental load it causes.

