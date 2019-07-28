Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 791F677C95
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2019 02:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfG1Azp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jul 2019 20:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfG1Azp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jul 2019 20:55:45 -0400
Received: from [192.168.0.101] (unknown [180.111.32.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E7E20840;
        Sun, 28 Jul 2019 00:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564275345;
        bh=ib6sX26AXwbDi3ZB+Fz05tdgLXwFegl+X7JA9+1MoA8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FE3s7pPpLKE6fNyKadY5IvO9j3S1hknF451M623wEBUgqt0JGE9vZCVBBFQuPk0SE
         loiQOaF8fG2Sdz6nOUVA+6MVkXudeCNLGAeIkDS93jjeSjR5LzpvrnXVL/kyoAd504
         DLc40YM1HqlcAxRpN5F6aCR6xZ4q/oMIIgUapNZ0=
Subject: Re: [f2fs-dev] [PATCH v4 3/3] f2fs: Support case-insensitive file
 name lookups
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
References: <20190723230529.251659-1-drosen@google.com>
 <20190723230529.251659-4-drosen@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <9362e4ed-2be8-39f5-b4d9-9c86e37ab993@kernel.org>
Date:   Sun, 28 Jul 2019 08:55:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190723230529.251659-4-drosen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-7-24 7:05, Daniel Rosenberg via Linux-f2fs-devel wrote:
>  /* Flags that are appropriate for regular files (all but dir-specific ones). */
>  #define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL))

We missed to add F2FS_CASEFOLD_FL here to exclude it in F2FS_REG_FLMASK.

> @@ -1660,7 +1660,16 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  		return -EPERM;
>  
>  	oldflags = fi->i_flags;
> +	if ((iflags ^ oldflags) & F2FS_CASEFOLD_FL) {
> +		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
> +			return -EOPNOTSUPP;
> +
> +		if (!S_ISDIR(inode->i_mode))
> +			return -ENOTDIR;
>  
> +		if (!f2fs_empty_dir(inode))
> +			return -ENOTEMPTY;
> +	}

I applied the patches based on last Jaegeuk's dev branch, it seems we needs to
adjust above code a bit. Otherwise it looks good to me.

BTW, it looks the patchset works fine with generic/556 testcase.

Thanks,
