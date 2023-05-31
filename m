Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE956718F23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 01:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjEaXsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 19:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEaXsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 19:48:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6AB13E
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 16:48:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b0201d9a9eso2573415ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 16:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685576929; x=1688168929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bapLcT1rfgF5eXP0K5sMoe265ENn9lfWlaeN3allmSs=;
        b=YV/VGUCm3cO8v9Pt3ZyWyo4W+JosjwST1qxgNAOzMZYt+nWwG+aISOYjKzh9jyWIaW
         BcD/xwqOPxKHiNkxFU1lS3wknEP4nUn44Ok1VifFX+OGo/QpS7ATmW6Mi4SFAKzYkifd
         uzSxA8QMG7kzAar91JCJgqCBJCW/+Lk1Q9c1qbOVISGbwLCrhtks4izUCzoxFACqk2VF
         0fyMJMoxCq3i1grLOBC8Ly7IfHEoGJeZQDGmi8iJVE0tnv7hLPZbktXIOlYStIElrYtY
         PQosmB1fQCIy/6BgntmRoakEzbTtpDaAXItwzVyqcjt28hFIFmhwznbAWuGGn7IPzAs6
         JpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685576929; x=1688168929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bapLcT1rfgF5eXP0K5sMoe265ENn9lfWlaeN3allmSs=;
        b=AxVc29EcQdyEZmOGkxbaPEXUkbPSgiZKW1SLy5qPY2IeXYN0IQ1p/dsOzW9DoVaOXE
         UaCL7lLcBSXCp36bSqpo0G8WsAF5BtJ+IQ3vQk1q16mgtt4FDtEKeef/gLiWPd5Bx7UH
         0d6v8NN+r+x4mkXBn5BDjCV9CPtadnIBqRSpDvWSb7ivIzhUOpnUrRUUWuw2wdeQHAjm
         Poy5ggzJDWSSPPGkpGAqaAwbqWQGrBEIb3UWYWBvsza6yXf9/AG3zXCrbJJ/sTKLBFui
         BE7DPA7y4SlCKZCbX+94Z08TBWMwtwkL+OY5ahPC/NqGvXtiMPWUk1e77NJF04ZubnUk
         oc7w==
X-Gm-Message-State: AC+VfDypXaAycAIdt7/tshYDVnBnimcDMP7+CvdlvJ9jg9zZ3pI9pFUz
        v0xEiyY23zDirJ4huB6v2Du/GgyyLdUO3NFlFXI=
X-Google-Smtp-Source: ACHHUZ75YAULNe67vWw2+IHca2+HfoohrGo37Wkj1DLaLuSiBLHhhOk9FEPeleT3/wn6oUQe7zel5g==
X-Received: by 2002:a17:902:aa07:b0:1a0:76e8:a4d with SMTP id be7-20020a170902aa0700b001a076e80a4dmr142755plb.14.1685576929033;
        Wed, 31 May 2023 16:48:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id q4-20020a63e944000000b0053fb1fbd3f2sm1788299pgj.91.2023.05.31.16.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 16:48:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q4VYb-006IPu-0W;
        Thu, 01 Jun 2023 09:48:45 +1000
Date:   Thu, 1 Jun 2023 09:48:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 6/8] xfs: introduce xfs_fs_destroy_super()
Message-ID: <ZHfc3V4KKmW8QTR2@dread.disaster.area>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
 <20230531095742.2480623-7-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531095742.2480623-7-qi.zheng@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 09:57:40AM +0000, Qi Zheng wrote:
> From: Kirill Tkhai <tkhai@ya.ru>
> 
> xfs_fs_nr_cached_objects() touches sb->s_fs_info,
> and this patch makes it to be destructed later.
> 
> After this patch xfs_fs_nr_cached_objects() is safe
> for splitting unregister_shrinker(): mp->m_perag_tree
> is stable till destroy_super_work(), while iteration
> over it is already RCU-protected by internal XFS
> business.
> 
> Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  fs/xfs/xfs_super.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 7e706255f165..694616524c76 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -743,11 +743,18 @@ xfs_fs_drop_inode(
>  }
>  
>  static void
> -xfs_mount_free(
> +xfs_free_names(
>  	struct xfs_mount	*mp)
>  {
>  	kfree(mp->m_rtname);
>  	kfree(mp->m_logname);
> +}
> +
> +static void
> +xfs_mount_free(
> +	struct xfs_mount	*mp)
> +{
> +	xfs_free_names(mp);
>  	kmem_free(mp);
>  }
>  
> @@ -1136,8 +1143,19 @@ xfs_fs_put_super(
>  	xfs_destroy_mount_workqueues(mp);
>  	xfs_close_devices(mp);
>  
> -	sb->s_fs_info = NULL;
> -	xfs_mount_free(mp);
> +	xfs_free_names(mp);
> +}
> +
> +static void
> +xfs_fs_destroy_super(
> +	struct super_block	*sb)
> +{
> +	if (sb->s_fs_info) {
> +		struct xfs_mount	*mp = XFS_M(sb);
> +
> +		kmem_free(mp);
> +		sb->s_fs_info = NULL;
> +	}
>  }
>  
>  static long
> @@ -1165,6 +1183,7 @@ static const struct super_operations xfs_super_operations = {
>  	.dirty_inode		= xfs_fs_dirty_inode,
>  	.drop_inode		= xfs_fs_drop_inode,
>  	.put_super		= xfs_fs_put_super,
> +	.destroy_super		= xfs_fs_destroy_super,
>  	.sync_fs		= xfs_fs_sync_fs,
>  	.freeze_fs		= xfs_fs_freeze,
>  	.unfreeze_fs		= xfs_fs_unfreeze,

I don't really like this ->destroy_super() callback, especially as
it's completely undocumented as to why it exists. This is purely a
work-around for handling extended filesystem superblock shrinker
functionality, yet there's nothing that tells the reader this.

It also seems to imply that the superblock shrinker can continue to
run after the existing unregister_shrinker() call before ->kill_sb()
is called. This violates the assumption made in filesystems that the
superblock shrinkers have been stopped and will never run again
before ->kill_sb() is called. Hence ->kill_sb() implementations
assume there is nothing else accessing filesystem owned structures
and it can tear down internal structures safely.

Realistically, the days of XFS using this superblock shrinker
extension are numbered. We've got a lot of the infrastructure we
need in place to get rid of the background inode reclaim
infrastructure that requires this shrinker extension, and it's on my
list of things that need to be addressed in the near future. 

In fact, now that I look at it, I think the shmem usage of this
superblock shrinker interface is broken - it returns SHRINK_STOP to
->free_cached_objects(), but the only valid return value is the
number of objects freed (i.e. 0 is nothing freed). These special
superblock extension interfaces do not work like a normal
shrinker....

Hence I think the shmem usage should be replaced with an separate
internal shmem shrinker that is managed by the filesystem itself
(similar to how XFS has multiple internal shrinkers).

At this point, then the only user of this interface is (again) XFS.
Given this, adding new VFS methods for a single filesystem
for functionality that is planned to be removed is probably not the
best approach to solving the problem.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
