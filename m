Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC84754CD0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 01:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjGOXgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 19:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGOXgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 19:36:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3495710DC
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jul 2023 16:36:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-263036d54b9so2188820a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jul 2023 16:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1689464206; x=1692056206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/mkW0jGzSqPxmGw9V0X5RkM5ItEmfXI12w10A2Eres=;
        b=ASLyRtXp8Yh09OikOhVYeIlu5bNpY1KPbFNZmvzee+mQSlD1a4yuBjIeYrCHl6OWro
         SRX0mHttxJTRKFZy6ihmc+Q20IlDS2cBlDSmGuITxJ0dNZrwqmDnvXQ8skguRkgzU1dU
         yMO2S2RQnxdwQErxmQH1R4cx0C5ST3d5RpqoM80FQwgMl0xIcr3iXBu2xdAHRi34mDkg
         cREPVv8GpoB47rP/7MJ1WrymktFTRyxN7c30Ih5exBOGdb03bK9UUgyppXmDWGlJAd/Q
         0IXYjXeCTDTJhg0GXlQyjPUPIuBfEXfOyaMGZTv9cSchPM0wUQV+W0c1YRYro1Juz+3G
         Z1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689464206; x=1692056206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/mkW0jGzSqPxmGw9V0X5RkM5ItEmfXI12w10A2Eres=;
        b=XUvQJ9PUfOTTkV1m8wnGDy+ha2HnePZiv1j2LmdK+Y4unF1uFD2SDnH2fwDcYmQZRN
         KICKT3Ry+wscdIlxEyRQRTs8Ig3TTuSG3NloB78pg7q0uzg+88xXnihCNpQ8rNi5V1P1
         6JbDltPBEnXf5CyRVMRbhc+jXmgQB8dioj5XQQ6ET93QPFiy1X8UhlV+9l3LkZWSgwV4
         eSA/9ae0aUaCKMiUhmootuAUBY/1RSQjnzRcJspnxI2Bd0NlYtXHCqUVKVwUY81/Txiv
         QaDY8CiOdFB/rr7c8BxiKiNW5kmgFr+eg6teePD8wmP3641VMNYoBQmZtcGEyVswsWTL
         Rj0A==
X-Gm-Message-State: ABy/qLZAkrB3qdoqZKJken4nN74dMLyE1lUSobA+LMSlUXdiNR3ImFyY
        zDts6/UKdiTRBp6mrqVHVlmqRAw6YRKWEKX+a7E=
X-Google-Smtp-Source: APBJJlHBHNn9ic8rlAZHn4iUhijf/z7EF3FUM1bqEZgsTAkGKX1Rp8C01GUKBrM4SByqZu0DMgo+aw==
X-Received: by 2002:a17:90b:482:b0:263:41d2:4e2 with SMTP id bh2-20020a17090b048200b0026341d204e2mr8518613pjb.32.1689464206607;
        Sat, 15 Jul 2023 16:36:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au. [49.186.119.116])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a19c400b00263e4dc33aasm3103081pjj.11.2023.07.15.16.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 16:36:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qKoob-006YsO-27;
        Sun, 16 Jul 2023 09:36:41 +1000
Date:   Sun, 16 Jul 2023 09:36:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Leesoo Ahn <lsahn@ooseel.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leesoo Ahn <lsahn@wewakecorp.com>
Subject: Re: [PATCH v2] fs: inode: return proper error code in bmap()
Message-ID: <ZLMtifV5ta5VTQ2e@dread.disaster.area>
References: <20230715082204.1598206-1-lsahn@wewakecorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715082204.1598206-1-lsahn@wewakecorp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 15, 2023 at 05:22:04PM +0900, Leesoo Ahn wrote:
> Return -EOPNOTSUPP instead of -EINVAL which has the meaning of
> the argument is an inappropriate value. The current error code doesn't
> make sense to represent that a file system doesn't support bmap operation.
> 
> Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
> ---
> Changes since v1:
> - Modify the comments of bmap()
> - Modify subject and description requested by Markus Elfring
> https://lore.kernel.org/lkml/20230715060217.1469690-1-lsahn@wewakecorp.com/
> 
>  fs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 8fefb69e1f84..697c51ed226a 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1831,13 +1831,13 @@ EXPORT_SYMBOL(iput);
>   *	4 in ``*block``, with disk block relative to the disk start that holds that
>   *	block of the file.
>   *
> - *	Returns -EINVAL in case of error, 0 otherwise. If mapping falls into a
> + *	Returns -EOPNOTSUPP in case of error, 0 otherwise. If mapping falls into a
>   *	hole, returns 0 and ``*block`` is also set to 0.
>   */
>  int bmap(struct inode *inode, sector_t *block)
>  {
>  	if (!inode->i_mapping->a_ops->bmap)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>  
>  	*block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
>  	return 0;

What about the CONFIG_BLOCK=n wrapper?

Also, all the in kernel consumers squash this error back to 0, -EIO
or -EINVAL, so this change only ever propagates out to userspace via
the return from ioctl(FIBMAP).  Do we really need to change this and
risk breaking userspace that handles -EINVAL correctly but not
-EOPNOTSUPP?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
