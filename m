Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E459310175
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 01:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhBEAQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 19:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhBEAQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:16:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC796C0613D6;
        Thu,  4 Feb 2021 16:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=UMFNjYapoD8y9Zb2loJ5hYIa9ykCl8ZDwdjgDf7L2RQ=; b=rk9CyHLligNgqgIOcRfByDlu1B
        GMvRQ3EIJwV2uwY3tFQMq8n9QCQQIVJiZpYfHMFagxFt63zWfTTVkPYxJ7OCyMrUdpD6LZHMlcy9e
        04+qWbF/Qg/Z/vKnitFgG5QH3x0oqh4jsGI3JVL4oXzXkJPLy7WJyKstKPWIeKvghN9yYaPQ6PqXQ
        QwFY4Km1a56wwke0QV/IDl42GqWGNTZanpSrRfpcirhYhDpW9mRbvLoUlZh/7vRlg0vH2H583Z92H
        9L6D+e2+Z/nRPT2lVqgJJ6U/Tx//j5XpK7ALU/hQD22ue1/8fzmkhAO6h4cVVc2Jo10e/Qhe1UlSx
        fSzAP4pQ==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7omT-0008HR-AH; Fri, 05 Feb 2021 00:15:25 +0000
Subject: Re: [PATCH v2 2/2] dmabuf: Add dmabuf inode number to /proc/*/fdinfo
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        kernel-team@android.com, Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210204232854.451676-1-kaleshsingh@google.com>
 <20210204232854.451676-2-kaleshsingh@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4e71615b-bdc9-bd5f-ffe3-25f50ce5b882@infradead.org>
Date:   Thu, 4 Feb 2021 16:15:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210204232854.451676-2-kaleshsingh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/4/21 3:28 PM, Kalesh Singh wrote:
> If a FD refers to a DMA buffer add the DMA buffer inode number to
> /proc/<pid>/fdinfo/<FD> and /proc/<pid>/task/<tid>/fdindo/<FD>.
> 
> The dmabuf inode number allows userspace to uniquely identify the buffer
> and avoids a dependency on /proc/<pid>/fd/* when accounting per-process
> DMA buffer sizes.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Hi,
Please document this change in
Documentation/filesystems/proc.rst.

Thanks.

> 
> Changes in v2: 
>   - Update patch desciption
> 
>  drivers/dma-buf/dma-buf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 9ad6397aaa97..d869099ede83 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -414,6 +414,7 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
>  {
>  	struct dma_buf *dmabuf = file->private_data;
>  
> +	seq_printf(m, "dmabuf_inode_no:\t%lu\n", file_inode(file)->i_ino);
>  	seq_printf(m, "size:\t%zu\n", dmabuf->size);
>  	/* Don't count the temporary reference taken inside procfs seq_show */
>  	seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);
> 


-- 
~Randy

