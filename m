Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0528234F441
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 00:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhC3WcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 18:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhC3Wbl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:31:41 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4F0C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 15:31:41 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 3E769C01D; Wed, 31 Mar 2021 00:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1617143498; bh=Zx8ni7bXpv+YaUKmwi5pdjQo0oUP9rEvUbkdyzjkpAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EhFUAqx3k3O7cCFlhlvZwXt1IuOC95/LIN+RtxE51ypYH7b3hF+4DNLD+YUVjNhl+
         6xit/DbuGPgQ7Vrq05ZXTA/bmeRNrNNpXV1ZeND5bt1AQCAOs0uefNEZJNLdO3kV+i
         ma0r/mRseVlA4rIdVMuBqhm+eo5WnaOu4kfYc1auGBDVibPYsnTED7v79salZBv3HH
         1e9Yr19diO9NOTD51Uy1fieiXktuJptbfBWIq0GqdP9VfdMXBzTibu2Saw/Zifu1jW
         x6YlTAmAM+xPngAwlNLlo4ph05k0FNGR5ip7GTg0LsGuHdBdspQdXysTfMb+DCo+/E
         Chj8fIQ5UauTA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id AF3B4C01A;
        Wed, 31 Mar 2021 00:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1617143496; bh=Zx8ni7bXpv+YaUKmwi5pdjQo0oUP9rEvUbkdyzjkpAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0CuWRmnmSXhvVbGe2Avc+LphhB3/uUfmZsr1n47ZQenA7QBMVvY2f29kC8wNeJgl
         tmd8u0w7Jxar7NGyXGcOrCxEgkbwLo2SPtGojKnMc6nc8kYTiUE/A/T/S/4YSbpLf7
         esEg1DcT7DsVFVSB4OFzaVLv0xZEHnaZroo3HEONwFTuC+3VuZZjj26oAme0F0i1t+
         z/o5uX89zipkmkW2LyFNR8qbMxxDGWn/JGwu18BI138xguH/PSFYUAvLVx5RGJ4N+V
         +qAJqUCTxcqLxsz2pYOdTpBFf6vq42trya/JczlgjNgAKmINv5e9nyMgKDY0ZhAsBj
         Z+N48ZMMkbkbg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 38661fb1;
        Tue, 30 Mar 2021 22:31:33 +0000 (UTC)
Date:   Wed, 31 Mar 2021 07:31:18 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Nicola Girardi <idrarig.alocin@gmail.com>
Cc:     v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH] fs/9p: if O_APPEND, seek to EOF on
 write, not open
Message-ID: <YGOmtkhr8NSMAr9z@codewreck.org>
References: <20210322163553.19888-1-nicolagi@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322163553.19888-1-nicolagi@sdf.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

adding linux-fsdevel@vger in Cc, there's more people who know about this
than me there

Nicola Girardi wrote on Mon, Mar 22, 2021 at 04:35:53PM +0000:
> Quoting the POSIX standard:¹
> 
> 	If the O_APPEND flag of the file status flags is set, the file
> 	offset shall be set to the end of the file prior to each write and
> 	no intervening file modification operation shall occur between
> 	changing the file offset and the write operation.
> 
> Previously, the seek to EOF was only done on open instead.
> 
> ¹ https://pubs.opengroup.org/onlinepubs/9699919799/functions/write.html
> ---
> 
> I noticed the above minor deviation from POSIX while running a tester
> that looks for differences between ext4 and a fs of mine, mounted
> using v9fs. I wrote a small program to reproduce the problem and
> validate the fix:
> https://raw.githubusercontent.com/nicolagi/fsdiff/master/c/repro-read-append.c.

Sorry for the delay in replying, I just didn't take time to test until
now.
So the thing is given how the current 9p servers I know are implemented,
file IOs will be backed by a file which has been opened in O_APPEND and
the behaviour will transparently be correct for them; that's probably
why nobody ever caught up on this until now.


I think it makes sense however, so I'll take the patch unless someone
complains; please note that in case of concurrent accesses a client-side
implementation will not guarantee proper O_APPEND behaviour so it should
really be enforced by the server; because generic_file_llseek relies on
the size stored in the inode in cache (and it would be racy anyway if it
were to refresh attributes)

e.g. if two clients are opening the same file in O_APPEND and alternate
writing to it, they will just be overwriting each other on your server
implementation.


Well, generic_file_llseek has close to zero extra cost so it doesn't
cost much to include this safety, I'll just adjust the commit message to
warn of this pitfall and include the patch after some more testing.

Thanks,

> 
>  fs/9p/vfs_file.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index be5768949cb1..8e9da3abd498 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -68,9 +68,6 @@ int v9fs_file_open(struct inode *inode, struct file *file)
>  			p9_client_clunk(fid);
>  			return err;
>  		}
> -		if ((file->f_flags & O_APPEND) &&
> -			(!v9fs_proto_dotu(v9ses) && !v9fs_proto_dotl(v9ses)))
> -			generic_file_llseek(file, 0, SEEK_END);
>  	}
>  
>  	file->private_data = fid;
> @@ -419,6 +416,8 @@ v9fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (retval <= 0)
>  		return retval;
>  
> +	if (file->f_flags & O_APPEND)
> +		generic_file_llseek(file, 0, SEEK_END);
>  	origin = iocb->ki_pos;
>  	retval = p9_client_write(file->private_data, iocb->ki_pos, from, &err);
>  	if (retval > 0) {
-- 
Dominique
