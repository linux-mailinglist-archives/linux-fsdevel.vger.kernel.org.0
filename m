Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A9E3F5D79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 13:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbhHXL46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 07:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236905AbhHXL4y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:56:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F281760EE0;
        Tue, 24 Aug 2021 11:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629806170;
        bh=bjw9uQcpwRNe1o5nHIH2UssRYmiCoh1pAur7K0VNfNI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=shApvSf2o+hC1oSvR/cmwDKu1JfqJLNgjipJk7yXB1TjN8tVy78iKnclm0YKc2y21
         AbO24BXExSkFjGDXOPIlJJVWUAFn0PoKpHvLBhNMR0pXYY1Vs3NHJtUcvQ6FNreBTS
         6CAZUrIj86fV0e/F9phXHKL4JUuaw/+hUemqxdjUa2pPn3l9N1Ay/Xk0LQFZYcbbKL
         tARoEbOYxWXzjGGqrhd+7W0q56YRPmd5NczqCHXdIxlx/HCxRDqJpHR/r1XJl/D2Sc
         mI0xXDhuI3B8XsA9h/+gEmUE7VEEVzc4uZ2T6B5CzYKpLkw2JM0YF62M+1evgnI2j4
         1rSqzpHHColdQ==
Message-ID: <552bb9bedfb1c36ea6aa5f7bdd3ab162b81f73d9.camel@kernel.org>
Subject: Re: [PATCH] fs: clean up after mandatory file locking support
 removal
From:   Jeff Layton <jlayton@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Aug 2021 07:56:08 -0400
In-Reply-To: <20210824111259.13077-1-lukas.bulwahn@gmail.com>
References: <20210824111259.13077-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-08-24 at 13:12 +0200, Lukas Bulwahn wrote:
> Commit 3efee0567b4a ("fs: remove mandatory file locking support") removes
> some operations in functions rw_verify_area() and remap_verify_area().
> 
> As these functions are now simplified, do some syntactic clean-up as
> follow-up to the removal as well, which was pointed out by compiler
> warnings and static analysis.
> 
> No functional change.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Jeff, please pick this clean-up patch on top of the commit above.
> 
>  fs/read_write.c  | 10 +++-------
>  fs/remap_range.c |  2 --
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index ffe821b8588e..af057c57bdc6 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -365,12 +365,8 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
>  
>  int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t count)
>  {
> -	struct inode *inode;
> -	int retval = -EINVAL;
> -
> -	inode = file_inode(file);
>  	if (unlikely((ssize_t) count < 0))
> -		return retval;
> +		return -EINVAL;
>  
>  	/*
>  	 * ranged mandatory locking does not apply to streams - it makes sense
> @@ -381,12 +377,12 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
>  
>  		if (unlikely(pos < 0)) {
>  			if (!unsigned_offsets(file))
> -				return retval;
> +				return -EINVAL;
>  			if (count >= -pos) /* both values are in 0..LLONG_MAX */
>  				return -EOVERFLOW;
>  		} else if (unlikely((loff_t) (pos + count) < 0)) {
>  			if (!unsigned_offsets(file))
> -				return retval;
> +				return -EINVAL;
>  		}
>  	}
>  
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index ec6d26c526b3..6d4a9beaa097 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -99,8 +99,6 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
>  			     bool write)
>  {
> -	struct inode *inode = file_inode(file);
> -
>  	if (unlikely(pos < 0 || len < 0))
>  		return -EINVAL;
>  

Thanks Lukas,

I had already removed the second hunk, but I merged read_write.c part
into my queue for v5.15. It should show up in linux-next soon.
-- 
Jeff Layton <jlayton@kernel.org>

