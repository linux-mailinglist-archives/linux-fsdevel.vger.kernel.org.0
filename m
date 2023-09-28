Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEFA7B1CEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 14:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjI1MuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjI1MuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:50:11 -0400
X-Greylist: delayed 506 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 05:50:07 PDT
Received: from mail.alarsen.net (mail.alarsen.net [144.76.18.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1997180;
        Thu, 28 Sep 2023 05:50:07 -0700 (PDT)
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:5e7e:df38:32c1:aeb5])
        by joe.alarsen.net (Postfix) with ESMTPS id 44D1918090B;
        Thu, 28 Sep 2023 14:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1695904897; bh=7wmGsnWi3L6eimoKMMVKN4B7zijNh0V4YtFFMUwRxGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6eMn7N8ng72EQQrIOSUUobTmfVc1W1v933uzlyCaRMEK8SIeKyYH0Gak6Nb9nr31
         AwGcPkG2zPBRTYSxc0fb1J4wERInn63FvWogR8ycSonFgbEb56Wy4vYHjU+ya+5zgq
         rnHmAy7DkpU2mPlFsPS0JDui6V2h9AZnoFEi0i+g=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTPS id 2E6841395;
        Thu, 28 Sep 2023 14:41:37 +0200 (CEST)
From:   Anders Larsen <al@alarsen.net>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 62/87] fs/qnx4: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 14:41:37 +0200
Message-ID: <3384318.5fSG56mABF@oscar>
In-Reply-To: <20230928110413.33032-61-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org> <20230928110413.33032-1-jlayton@kernel.org> <20230928110413.33032-61-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-09-28 13:03 Jeff Layton wrote:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/qnx4/inode.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index a7171f5532a1..6eb9bb369b57 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -301,10 +301,8 @@ struct inode *qnx4_iget(struct super_block *sb,
> unsigned long ino) i_gid_write(inode,
> (gid_t)le16_to_cpu(raw_inode->di_gid));
>  	set_nlink(inode, le16_to_cpu(raw_inode->di_nlink));
>  	inode->i_size    = le32_to_cpu(raw_inode->di_size);
> -	inode->i_mtime.tv_sec   = le32_to_cpu(raw_inode->di_mtime);
> -	inode->i_mtime.tv_nsec = 0;
> -	inode->i_atime.tv_sec   = le32_to_cpu(raw_inode->di_atime);
> -	inode->i_atime.tv_nsec = 0;
> +	inode_set_mtime(inode, le32_to_cpu(raw_inode->di_mtime), 0);
> +	inode_set_atime(inode, le32_to_cpu(raw_inode->di_atime), 0);
>  	inode_set_ctime(inode, le32_to_cpu(raw_inode->di_ctime), 0);
>  	inode->i_blocks  = le32_to_cpu(raw_inode->di_first_xtnt.xtnt_size);

Acked-by: Anders Larsen <al@alarsen.net>



