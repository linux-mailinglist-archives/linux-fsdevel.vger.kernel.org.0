Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5BF2E7703
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 09:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgL3I2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Dec 2020 03:28:24 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1187 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726240AbgL3I2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Dec 2020 03:28:23 -0500
X-IronPort-AV: E=Sophos;i="5.78,460,1599494400"; 
   d="scan'208";a="103077286"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Dec 2020 16:27:34 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9AE354CE5CE3;
        Wed, 30 Dec 2020 16:27:28 +0800 (CST)
Received: from [10.167.225.206] (10.167.225.206) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 30 Dec 2020 16:27:28 +0800
Subject: Re: [PATCH] fs: fix: second lock in function d_prune_aliases().
To:     YANG LI <abaci-bugfix@linux.alibaba.com>, <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1609311685-99562-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
Message-ID: <1c0dfdc1-911c-a12c-c25a-e88b082acb25@cn.fujitsu.com>
Date:   Wed, 30 Dec 2020 16:27:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1609311685-99562-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.167.225.206]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 9AE354CE5CE3.AE2DC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/12/30 15:01, YANG LI wrote:
> Goto statement jumping will cause lock to be executed again without
> executing unlock, placing the lock statement in front of goto
> label to fix this problem.
>
> Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
> Reported-by: Abaci <abaci@linux.alibaba.com>
> ---
>  fs/dcache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 97e81a8..bf38446 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1050,6 +1050,6 @@ void d_prune_aliases(struct inode *inode)
>  {
>      struct dentry *dentry;
> -restart:
>      spin_lock(&inode->i_lock);

This inode lock should be released at __dentry_kill->dentry_unlink_inode.

Regards,
Hao Lee

>
> +restart:
>      hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
>          spin_lock(&dentry->d_lock);



