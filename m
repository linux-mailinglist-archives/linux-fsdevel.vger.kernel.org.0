Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C116686654
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjBANBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjBANBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:01:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7ABB451;
        Wed,  1 Feb 2023 05:01:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E7BC61790;
        Wed,  1 Feb 2023 13:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6047C433EF;
        Wed,  1 Feb 2023 13:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675256478;
        bh=BF9Af+7x+SsrvTMtNgvUMxvWEGNjDDO5pYoM1oqxYW4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N+z42sNiTXZPsMJTvkmx2nOHwmxxA03LWW/zQ/06IwhW1cKdt38TDX4GG3T1mx+eX
         2b37O74tPVK3OciYXlb2pMpDwXVr2CXchws6+2XU2F8ny8ZNtDMRcAxTRjEbJQx9+x
         YOzlcSvAR8o/Mt2mXDc7wNMX93iRUCtSfBXpiZ5r1zTIW8n+ipvY70YYUVddudQdtr
         HCKwXDjIhB8RYY9HdR9RZDeXciqgdOjKit4weFPsBBpK+fFNDIuaA79tDXvt/YwwCH
         4lGvAUQuFI1bVWewWlOwv7QtC8tZR7fUfRF4c3xPj7T552nI6zhfkwY5Tujh4AHx30
         XRgXdj7BEodBg==
Message-ID: <93c1e281-82a5-d7d0-04b1-67ac2cf3d0fa@kernel.org>
Date:   Wed, 1 Feb 2023 21:01:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] proc: fix to check name length in proc_lookup_de()
Content-Language: en-US
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, adobriyan@gmail.com
References: <20230131155559.35800-1-chao@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230131155559.35800-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

Could you please take a look at this patchset? Or should I ping
Alexey Dobriyan?

Thanks,

On 2023/1/31 23:55, Chao Yu wrote:
> __proc_create() has limited dirent's max name length with 255, let's
> add this limitation in proc_lookup_de(), so that it can return
> -ENAMETOOLONG correctly instead of -ENOENT when stating a file which
> has out-of-range name length.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/proc/generic.c  | 5 ++++-
>   fs/proc/internal.h | 3 +++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 878d7c6db919..f547e9593a77 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -245,6 +245,9 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
>   {
>   	struct inode *inode;
>   
> +	if (dentry->d_name.len > PROC_NAME_LEN)
> +		return ERR_PTR(-ENAMETOOLONG);
> +
>   	read_lock(&proc_subdir_lock);
>   	de = pde_subdir_find(de, dentry->d_name.name, dentry->d_name.len);
>   	if (de) {
> @@ -401,7 +404,7 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
>   		goto out;
>   	qstr.name = fn;
>   	qstr.len = strlen(fn);
> -	if (qstr.len == 0 || qstr.len >= 256) {
> +	if (qstr.len == 0 || qstr.len > PROC_NAME_LEN) {
>   		WARN(1, "name len %u\n", qstr.len);
>   		return NULL;
>   	}
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index b701d0207edf..7611bc684d9e 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -142,6 +142,9 @@ unsigned name_to_int(const struct qstr *qstr);
>   /* Worst case buffer size needed for holding an integer. */
>   #define PROC_NUMBUF 13
>   
> +/* Max name length of procfs dirent */
> +#define PROC_NAME_LEN		255
> +
>   /*
>    * array.c
>    */
