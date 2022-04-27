Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE0B511F0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiD0Rsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 13:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiD0Rsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:48:39 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 428DCE0B7
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 10:45:26 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 2C8C515F939;
        Thu, 28 Apr 2022 02:45:24 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23RHjMC9005741
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 02:45:24 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23RHjMJL016621
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 02:45:22 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 23RHjM9H016620;
        Thu, 28 Apr 2022 02:45:22 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel@cccheng.net,
        shepjeng@gmail.com
Subject: Re: [PATCH v4 3/3] fat: report creation time in statx
References: <20220423032348.1475539-1-cccheng@synology.com>
        <20220423032348.1475539-3-cccheng@synology.com>
Date:   Thu, 28 Apr 2022 02:45:22 +0900
In-Reply-To: <20220423032348.1475539-3-cccheng@synology.com> (Chung-Chiang
        Cheng's message of "Sat, 23 Apr 2022 11:23:48 +0800")
Message-ID: <87bkwmxvwt.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chung-Chiang Cheng <cccheng@synology.com> writes:

> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index 5369d82e0bfb..9187979fed5d 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -781,6 +781,7 @@ static int vfat_create(struct user_namespace *mnt_userns, struct inode *dir,
>  	}
>  	inode_inc_iversion(inode);
>  	fat_truncate_time(inode, &ts, S_ATIME|S_CTIME|S_MTIME);
> +	fat_truncate_crtime(MSDOS_SB(sb), &MSDOS_I(inode)->i_crtime, &MSDOS_I(inode)->i_crtime);
>  	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
>  
>  	d_instantiate(dentry, inode);

Probably, above should be the follow line?

	fat_truncate_crtime(MSDOS_SB(sb), &ts, &MSDOS_I(inode)->i_crtime);

And furthermore, this is missing to add it to mkdir(2)? And another one,
we would have to update vfat_build_slots() for crtime? I'm not checking
fully though, this seems to need isvfat test

	fat_time_unix2fat(sbi, ts, &time, &date, &time_cs);
	de->time = de->ctime = time;
	de->date = de->cdate = de->adate = date;
	de->ctime_cs = time_cs;

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
