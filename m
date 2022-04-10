Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D048B4FAEE3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Apr 2022 18:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbiDJQdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Apr 2022 12:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiDJQdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:33:02 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 900156461
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Apr 2022 09:30:49 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 1276D15F93A;
        Mon, 11 Apr 2022 01:30:49 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 23AGUlkq045191
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 01:30:48 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 23AGUl1o173045
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 01:30:47 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 23AGUlQQ173044;
        Mon, 11 Apr 2022 01:30:47 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net
Subject: Re: [PATCH v2 3/3] fat: report creation time in statx
References: <20220406085459.102691-1-cccheng@synology.com>
        <20220406085459.102691-3-cccheng@synology.com>
Date:   Mon, 11 Apr 2022 01:30:47 +0900
In-Reply-To: <20220406085459.102691-3-cccheng@synology.com> (Chung-Chiang
        Cheng's message of "Wed, 6 Apr 2022 16:54:59 +0800")
Message-ID: <87czhovr2g.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
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

Chung-Chiang Cheng <cccheng@synology.com> writes:

> creation time is no longer mixed with change time. Add a in-memory
> field for it, and report it in statx.
>

[...]

> +
> +	if (request_mask & STATX_BTIME) {
> +		stat->result_mask |= STATX_BTIME;
> +		stat->btime = MSDOS_I(inode)->i_crtime;
> +	}
> +

[...]

> -	if (sbi->options.isvfat)
> +	if (sbi->options.isvfat) {
>  		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
> -	else
> +		fat_time_fat2unix(sbi, &MSDOS_I(inode)->i_crtime, de->ctime,
> +				  de->cdate, de->ctime_cs);
> +	} else {
>  		fat_truncate_atime(sbi, &inode->i_mtime, &inode->i_atime);
> +		fat_truncate_crtime(sbi, &inode->i_mtime, &MSDOS_I(inode)->i_crtime);
> +	}

This looks strange. MSDOS doesn't have crtime, but set the fake time
from mtime and returns to userspace. Why don't we disable STATX_BTIME
for MSDOS?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
