Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9150A777F1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 19:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjHJRbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 13:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJRbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:31:11 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E94042132;
        Thu, 10 Aug 2023 10:31:09 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id D971D2055FAB;
        Fri, 11 Aug 2023 02:31:08 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 37AHV7kP264046
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 02:31:08 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 37AHV7ZT402781
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 02:31:07 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.2/8.17.2/Submit) id 37AHV73Q402780;
        Fri, 11 Aug 2023 02:31:07 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Frank Sorenson <sorenson@redhat.com>, Jan Kara <jack@suse.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fat: remove i_version handling from fat_update_time
In-Reply-To: <20230810-ctime-fat-v1-1-327598fd1de8@kernel.org> (Jeff Layton's
        message of "Thu, 10 Aug 2023 09:12:04 -0400")
References: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
        <20230810-ctime-fat-v1-1-327598fd1de8@kernel.org>
Date:   Fri, 11 Aug 2023 02:31:07 +0900
Message-ID: <87r0oan6sk.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> commit 6bb885ecd746 (fat: add functions to update and truncate
> timestamps appropriately") added an update_time routine for fat. That
> patch added a section for handling the S_VERSION bit, even though FAT
> doesn't enable SB_I_VERSION and the S_VERSION bit will never be set when
> calling it.
>
> Remove the section for handling S_VERSION since it's effectively dead
> code, and will be problematic vs. future changes.
>
> Cc: Frank Sorenson <sorenson@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> ---
>  fs/fat/misc.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index ab28173348fa..37f4afb346af 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -354,9 +354,6 @@ int fat_update_time(struct inode *inode, int flags)
>  			dirty_flags |= I_DIRTY_SYNC;
>  	}
>  
> -	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> -		dirty_flags |= I_DIRTY_SYNC;
> -
>  	__mark_inode_dirty(inode, dirty_flags);
>  	return 0;
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
