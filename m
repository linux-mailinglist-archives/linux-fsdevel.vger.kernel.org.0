Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC746563B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 16:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiLZPH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 10:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLZPHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:07:54 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA61C04;
        Mon, 26 Dec 2022 07:07:53 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6A75B1B7;
        Mon, 26 Dec 2022 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672067062;
        bh=b1y7zXkinhxvot9jeetf8cDO0mX7qUONskkFtfjYn9M=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=bmGO0e+PcHHy/MZcIUThzTX+m8GtUlc4/5m6aSlVDWGSgWPweaVF1Nf2kxvc9HdGn
         8L8gJ7zy5uTPEoBUSOIbtKjlnVoQNCRY853bV8eXAr514L5uy2tI0i0DW1fs8OhrH9
         lhHPrvbT7E1CCUPVCB7VBIddsjqLg12jTDfoPFUc=
Received: from [192.168.211.153] (192.168.211.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 26 Dec 2022 18:07:51 +0300
Message-ID: <9e11da02-80f1-55f3-8bb5-28c3508e5396@paragon-software.com>
Date:   Mon, 26 Dec 2022 19:07:50 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fs/ntfs3: fix wrong cast in xattr.c
Content-Language: en-US
To:     Daniel Pinto <danielpinto52@gmail.com>,
        kernel test robot <lkp@intel.com>
CC:     <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <oe-kbuild-all@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <be1a2495-1c46-cda1-4f89-7e3a39d939db@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <be1a2495-1c46-cda1-4f89-7e3a39d939db@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.153]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.11.2022 12:17, Daniel Pinto wrote:
> cpu_to_be32 and be32_to_cpu respectively return and receive
> __be32, change the cast to the correct types.
>
> Fixes the following sparse warnings:
> fs/ntfs3/xattr.c:811:48: sparse: sparse: incorrect type in
>                           assignment (different base types)
> fs/ntfs3/xattr.c:901:34: sparse: sparse: cast to restricted __be32
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
> ---
>   fs/ntfs3/xattr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 8620a7b4b3e6..6056ecbe8e4f 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -808,7 +808,7 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
>   			err = sizeof(u32);
>   			*(u32 *)buffer = le32_to_cpu(ni->std_fa);
>   			if (!strcmp(name, SYSTEM_NTFS_ATTRIB_BE))
> -				*(u32 *)buffer = cpu_to_be32(*(u32 *)buffer);
> +				*(__be32 *)buffer = cpu_to_be32(*(u32 *)buffer);
>   		}
>   		goto out;
>   	}
> @@ -898,7 +898,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
>   		if (size != sizeof(u32))
>   			goto out;
>   		if (!strcmp(name, SYSTEM_NTFS_ATTRIB_BE))
> -			new_fa = cpu_to_le32(be32_to_cpu(*(u32 *)value));
> +			new_fa = cpu_to_le32(be32_to_cpu(*(__be32 *)value));
>   		else
>   			new_fa = cpu_to_le32(*(u32 *)value);

Thank you for your work, applied!
