Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C749E7A310
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfG3I1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 04:27:07 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:55358 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfG3I1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:27:06 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 9A60115F924;
        Tue, 30 Jul 2019 17:27:05 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x6U8R47a029798
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 17:27:05 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x6U8R4HR032190
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 17:27:04 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x6U8R0Qq032189;
        Tue, 30 Jul 2019 17:27:00 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, adrian.hunter@intel.com, anton@tuxera.com,
        dedekind1@gmail.com, gregkh@linuxfoundation.org, hch@lst.de,
        jaegeuk@kernel.org, jlbec@evilplan.org, richard@nod.at,
        tj@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-ntfs-dev@lists.sourceforge.net, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 03/20] timestamp_truncate: Replace users of
 timespec64_trunc
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
        <20190730014924.2193-4-deepa.kernel@gmail.com>
Date:   Tue, 30 Jul 2019 17:27:00 +0900
In-Reply-To: <20190730014924.2193-4-deepa.kernel@gmail.com> (Deepa Dinamani's
        message of "Mon, 29 Jul 2019 18:49:07 -0700")
Message-ID: <87d0hsapwr.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Deepa Dinamani <deepa.kernel@gmail.com> writes:

> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index 1e08bd54c5fb..53bb7c6bf993 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -307,8 +307,9 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
>  		inode->i_atime = (struct timespec64){ seconds, 0 };
>  	}
>  	if (flags & S_CTIME) {
> -		if (sbi->options.isvfat)
> -			inode->i_ctime = timespec64_trunc(*now, 10000000);
> +		if (sbi->options.isvfat) {
> +			inode->i_ctime = timestamp_truncate(*now, inode);
> +		}
>  		else
>  			inode->i_ctime = fat_timespec64_trunc_2secs(*now);
>  	}

Looks like broken. It changed to sb->s_time_gran from 10000000, and
changed coding style.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
