Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EBF749366
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 04:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjGFCAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 22:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjGFCAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:00:37 -0400
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Jul 2023 19:00:31 PDT
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B99981BDF;
        Wed,  5 Jul 2023 19:00:31 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id D02902055F9C;
        Thu,  6 Jul 2023 10:54:11 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 3661sAmO013519
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 10:54:11 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 3661sAor045796
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 10:54:10 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.2/8.17.2/Submit) id 3661s99N045795;
        Thu, 6 Jul 2023 10:54:09 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 44/92] fat: convert to ctime accessor functions
In-Reply-To: <20230705190309.579783-42-jlayton@kernel.org> (Jeff Layton's
        message of "Wed, 5 Jul 2023 15:01:09 -0400")
References: <20230705185755.579053-1-jlayton@kernel.org>
        <20230705190309.579783-1-jlayton@kernel.org>
        <20230705190309.579783-42-jlayton@kernel.org>
Date:   Thu, 06 Jul 2023 10:54:09 +0900
Message-ID: <87zg49yfcu.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> @@ -1407,8 +1407,9 @@ static int fat_read_root(struct inode *inode)
>  	MSDOS_I(inode)->mmu_private = inode->i_size;
>  
>  	fat_save_attrs(inode, ATTR_DIR);
> -	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec = 0;
> -	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = 0;
> +	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode_set_ctime(inode,
> +									0, 0).tv_sec;
> +	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = 0;

Maybe, this should simply be

	inode->i_mtime = inode->i_atime = inode_set_ctime(inode, 0, 0);

?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
