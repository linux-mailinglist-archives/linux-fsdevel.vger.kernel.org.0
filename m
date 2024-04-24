Return-Path: <linux-fsdevel+bounces-17655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3648B1158
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 19:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646411F26213
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 17:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDA816D4E2;
	Wed, 24 Apr 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BXvT2lFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE913777A;
	Wed, 24 Apr 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980518; cv=none; b=FYlhCmAzyEaB038tRDOsHQSNsJMYA7g5WzWhZSgEm7c7yokTgRPB4gXmzjKKLdiQ5YeC6Bi+OaFw2IkHq0JQ56H1paijMAyQBVlRC/FsNEHTUuJ0j9mc54ByW164iuBkLE4ITgSdpsPgzJTweUB82zK76bY7thIyx3MKa3MhdOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980518; c=relaxed/simple;
	bh=rzIGskttzZEZ6yA8Ya5sZoIK/iWbYQdhuesi5VGFu3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCYqf2muAmfSHPaX9PB7aiqG0erhVgXaKHkJT7iBbIRgg/ra+7crb4qKiw0hMFvs4+yb9nkDUti0vkPz92dK5u1HnlziSUnVUqTugMcV9Xr1S4nFMfWJEF9p93GplqScHKSgfHUSnUPPwDuNuczB/X6pmfeTPlZlfu4Hr1FdD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BXvT2lFP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pmCM4ZRC7PzrjVELSoDq0bCfVQk1Ajd90li1QmbuF7k=; b=BXvT2lFPFXXIPnM1ZCgaoAChvD
	V3MPYe8GJ93zgM21lwvjNW5WR1VIJHFBTUUf+Byf/aMLDLU8aJ1qpjYHUvFcHi7F/FcEzzazN7vHx
	9UzHHNuQH1Xa62cC+4WH+pvcP6DZAsBMCHAJH1J644hj7jJlWZQ4ls66mwWLmu1bkuWdCTMqlPnWp
	R/RRYAtOaKF2lDBA5JqA4hjLwMaPQV91uTnISxd8Zj0pTwhJnMF8oyywLLSvi+QJdhYySQD+pT188
	vv5tju1n4dWVyUkT+KVbgoe996W5VFeQruy13LYEjUXM2onX1t3iN9LJ7NEOmbGpgGknRDhqn/6gz
	OaSAh0Lg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzgcu-00000001Mvd-1JxD;
	Wed, 24 Apr 2024 17:41:48 +0000
Date: Wed, 24 Apr 2024 18:41:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	brauner@kernel.org, jlayton@kernel.org, eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Message-ID: <ZilEXC3qLiqMTs29@casper.infradead.org>
References: <0000000000000866ea0616cb082c@google.com>
 <20240424172240.148883-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424172240.148883-1-aha310510@gmail.com>

On Thu, Apr 25, 2024 at 02:22:40AM +0900, Jeongjun Park wrote:
> Due to overflow, a value that is too large is entered into the agno 
> value. Therefore, we need to add code to check the agno value.

This is clearly wrong.

#define BLKTOAG(b,sbi)  ((b) >> ((sbi)->bmap->db_agl2size))

I'd suggest that something has either corrupted the sbi->bmap
pointer or the sbi->bmap->db_agl2size value.

All your patch does is cover up the problem, not fix it.

> Reported-by: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  fs/jfs/jfs_imap.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 2ec35889ad24..0aac083bc0db 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -881,6 +881,11 @@ int diFree(struct inode *ip)
>  	 */
>  	agno = BLKTOAG(JFS_IP(ip)->agstart, JFS_SBI(ip->i_sb));
>  
> +	if(agno >= MAXAG || agno < 0){
> +		jfs_error(ip->i_sb, "invalid array index (0 <= agno < MAXAG), agno = %d\n", agno);
> +		return -ENOMEM;
> +	}
> +
>  	/* Lock the AG specific inode map information
>  	 */
>  	AG_LOCK(imap, agno);
> -- 
> 2.34.1
> 

