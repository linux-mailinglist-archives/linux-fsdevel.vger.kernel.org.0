Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A474876DF76
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 06:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjHCEoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 00:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHCEoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 00:44:14 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E552102
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 21:43:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-563e860df0fso331684a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 21:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691037828; x=1691642628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51KdePp9UCu+CkzAWbROKOfq+nzZG4kv4UKe7P4wfXI=;
        b=hKXqzhT0sX8LbhJSfWMn5U1qYETub11429O5OJsQafgjLenoAxvyvyDkX8WEt+7SIn
         olT3ifRfYRAnb9Z24W9nCQOUIJACSXNRNlmN3h6uq2ApvWenbJPG1SYGjJeSO5e61XfS
         sbxqLM5Mqfcg9VYomE8nHeHl3eA4K0SCtIEIAR67qqY9ECNTSbEKyV8e/rYUsT2mu08Y
         qtSoQ8Dq9c3QyAozBMxB/grxlYIxCNkipDhi+TwOczw8DN3BZ9w7FgmrOnz/P3FeSrIa
         L8TtyeM+GQZNdA3AWvDSWen4foAeVKJvtYfAVw8IaYRCFDLoWniY5Aqi6d7xczptZUjm
         6P2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691037828; x=1691642628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=51KdePp9UCu+CkzAWbROKOfq+nzZG4kv4UKe7P4wfXI=;
        b=I6COSEuGAhb++BFTcY7of/95i3ikpSl8YYG3ANmwt6bRVKz2IjXwGfBu/0HefmoGtG
         t2IvhhEysKamVYgFKoFsTLa72Qkc/ziE7wNyCk+pvUVln5X7RKBEfW5YLG5JhOVfce4o
         JyROrJzVpT8/TF0WAjtiSfomANxEV2TkWkekjoNx7z+aMZFM661uEswD34LkOElMVHgW
         ikErqL4QV37TIYs/nDMyZdEZ0R3nxgtRZJUQJPJ1OVsx5Cz6npB0VzJZoWqB4fJ7mep4
         oj3WnS/WnoU+urNYl1l2q+qn7QKUPhmXk8cAmpFxI4/7Iz2RHdYoo+Ox5QnbGZaKLUpL
         Jt9Q==
X-Gm-Message-State: ABy/qLbnKGPxVp9QdMfjDEhmagOdH4b/dOS1eqtm8TpKmsTXBwgrBbBm
        ZWtHDHBTk+gCL9Fvl/AA9tSUSg==
X-Google-Smtp-Source: APBJJlFuO/Tjd6V7LvISCmtGfOzewCC61lwiEmprE/Li8tIRyiP0B/87spw3HCtD+QnG7xzcHEO49Q==
X-Received: by 2002:a05:6a20:430d:b0:126:af02:444e with SMTP id h13-20020a056a20430d00b00126af02444emr23156944pzk.8.1691037828402;
        Wed, 02 Aug 2023 21:43:48 -0700 (PDT)
Received: from [10.255.204.88] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7800a000000b0068338b6667asm11791985pfi.212.2023.08.02.21.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 21:43:47 -0700 (PDT)
Message-ID: <cb8436b9-ccba-7086-d8f5-f63578463345@bytedance.com>
Date:   Thu, 3 Aug 2023 12:43:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] fuse: write back dirty pages before direct write in
 direct_io_relax mode
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net,
        miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
References: <20230801080647.357381-1-hao.xu@linux.dev>
 <20230801080647.357381-4-hao.xu@linux.dev>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20230801080647.357381-4-hao.xu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/8/1 16:06, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> In direct_io_relax mode, there can be shared mmaped files and thus dirty
> pages in its page cache. Therefore those dirty pages should be written
> back to backend before direct io to avoid data loss.
> 
> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> ---
>   fs/fuse/file.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 60f64eafb231..0bcdf0aafeb7 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1485,6 +1485,13 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>   	if (!ia)
>   		return -ENOMEM;
>   
> +	if (fopen_direct_io && fc->direct_io_relax) {
> +		res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
> +		if (res) {
> +			fuse_io_free(ia);
> +			return res;
> +		}
> +	}
>   	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
>   		if (!write)
>   			inode_lock(inode);


Reviewed-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>

Thanks,
Jiachen
