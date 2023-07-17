Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E2E75672E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 17:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGQPJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 11:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGQPJV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:09:21 -0400
Received: from mfwd03.mailplug.co.kr (mfwd03.mailplug.co.kr [14.49.36.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E6BF9
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 08:09:18 -0700 (PDT)
Received: (qmail 13305 invoked from network); 18 Jul 2023 00:09:15 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        18 Jul 2023 00:08:15 +0900
Received: (qmail 510126 invoked from network); 18 Jul 2023 00:08:15 +0900
Received: from unknown (HELO sslauth10) (lsahn@wewakecorp.com@211.253.39.66)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        18 Jul 2023 00:08:15 +0900
Message-ID: <c32d3a3d-c2a7-fd18-9e14-ea5d9e0abb88@wewakecorp.com>
Date:   Tue, 18 Jul 2023 00:08:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] fs: inode: return proper error code in bmap()
To:     Dave Chinner <david@fromorbit.com>, Leesoo Ahn <lsahn@ooseel.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230715082204.1598206-1-lsahn@wewakecorp.com>
 <ZLMtifV5ta5VTQ2e@dread.disaster.area>
Content-Language: en-US
From:   Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <ZLMtifV5ta5VTQ2e@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

23. 7. 16. 08:36에 Dave Chinner 이(가) 쓴 글:
> On Sat, Jul 15, 2023 at 05:22:04PM +0900, Leesoo Ahn wrote:
>  > Return -EOPNOTSUPP instead of -EINVAL which has the meaning of
>  > the argument is an inappropriate value. The current error code doesn't
>  > make sense to represent that a file system doesn't support bmap 
> operation.
>  >
>  > Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
>  > ---
>  > Changes since v1:
>  > - Modify the comments of bmap()
>  > - Modify subject and description requested by Markus Elfring
>  > 
> https://lore.kernel.org/lkml/20230715060217.1469690-1-lsahn@wewakecorp.com/
>  >
>  > fs/inode.c | 4 ++--
>  > 1 file changed, 2 insertions(+), 2 deletions(-)
>  >
>  > diff --git a/fs/inode.c b/fs/inode.c
>  > index 8fefb69e1f84..697c51ed226a 100644
>  > --- a/fs/inode.c
>  > +++ b/fs/inode.c
>  > @@ -1831,13 +1831,13 @@ EXPORT_SYMBOL(iput);
>  > * 4 in ``*block``, with disk block relative to the disk start that 
> holds that
>  > * block of the file.
>  > *
>  > - * Returns -EINVAL in case of error, 0 otherwise. If mapping falls 
> into a
>  > + * Returns -EOPNOTSUPP in case of error, 0 otherwise. If mapping 
> falls into a
>  > * hole, returns 0 and ``*block`` is also set to 0.
>  > */
>  > int bmap(struct inode *inode, sector_t *block)
>  > {
>  > if (!inode->i_mapping->a_ops->bmap)
>  > - return -EINVAL;
>  > + return -EOPNOTSUPP;
>  >
>  > *block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
>  > return 0;
> 
> What about the CONFIG_BLOCK=n wrapper?
How does it work? Could you explain that in details, pls?
However, as far as I understand, bmap operation could be NULL even 
though CONFIG_BLOCK is enabled. It totally depends on the implementation 
of file systems.

> 
> Also, all the in kernel consumers squash this error back to 0, -EIO
> or -EINVAL, so this change only ever propagates out to userspace via
> the return from ioctl(FIBMAP). Do we really need to change this and
> risk breaking userspace that handles -EINVAL correctly but not
> -EOPNOTSUPP?
That's a consideration and we must carefully modify the APIs which 
communicate to users. But -EINVAL could be interpreted by two cases at 
this point that the first, for sure an argument from user to kernel is 
inappropriate, on the other hand, the second case would be that a file 
system doesn't support bmap operation. However, I don't think there is a 
proper way to know which one is right from user.

For me, the big problem is that user could get confused by these two 
cases with the same error code.

Best regards,
Leesoo
