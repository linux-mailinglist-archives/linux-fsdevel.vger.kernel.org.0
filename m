Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BAC717F59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjEaL7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjEaL7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:59:00 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDFEE5;
        Wed, 31 May 2023 04:58:58 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2af2602848aso59797531fa.2;
        Wed, 31 May 2023 04:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685534337; x=1688126337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IX4gzV66YT4zrvW9HS28mQBpWf+TvKBCO6//YvTcJYQ=;
        b=AYU4PNqVMIRw9Gwmb045moSUBW8/BbXR3Ld1NE78edC2mPBAeHOm2+0nwIj4JQtREq
         5XcrgRqd6esjeRVx322/QD+kGGA1rC9CZfpul/DXdUWu5wP7Mq/OLfkD3+UZzXUfU2+g
         uW5f/KyHWO3knis/EWwHFD+aF3uxeXzNxhq2rktYAxKrcRCeVYHdoDfbnYexdsb6vd2f
         tuZHxTdG/9FZstvq+JUboVVNt4IKjlQXqKt/WJVq7HtaKDGd9SuILvb6tKLQMG3KNwMW
         R7i9I47h/X4H9ciz7DToZYYiXV4fXDqh3i6c4GWw0peiptW4ujuTQA2caaIPNvBgKeXV
         wj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685534337; x=1688126337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX4gzV66YT4zrvW9HS28mQBpWf+TvKBCO6//YvTcJYQ=;
        b=Rloit+AiONL64ig2VGjVSq3km4WNK8RDGYO/lpaCq2Pv/H9qV54asQ04cHVRKAx/O9
         C70Q11JQPOA3gxDcEvaqtQqN821KiSMcH6WUKH/bIz1ZmXlwPdkSDruPZOLLQ5RkmGhU
         ph5/UVxBBQJ7zWpZjM+rM8m/VvyUgo7P+2QKmneK26/19oY4cAVdhaL2wBiayUU4sPO6
         T+x8gYJKQaKt0UJZBNtxo2N9tU2RZuB9zaB/4/UXmhALGEQnjaKvyDuNKZV6WklnrBSZ
         Ib1eq5ZMfuPeHaHPpF2K/CrALBMt0xEKkvRSkhuCFcUfg97i/FesSgwjcFmwAp2nqvhE
         E0fw==
X-Gm-Message-State: AC+VfDxqhwBo19+Wq1jC0G1hQnX2s+P+OG7jv32C4hZu3AOXri+mu7DZ
        Ixbn1Qc83DS+Pimgs01SD/I=
X-Google-Smtp-Source: ACHHUZ5SKzEs+gPeYQJC6iSOXmf4/OM5YKps36aprdVuouI9ByjmxeBEQzy0XVLwSTTp9I7BXjYzBg==
X-Received: by 2002:a2e:8283:0:b0:2a8:e4d3:11e2 with SMTP id y3-20020a2e8283000000b002a8e4d311e2mr2738972ljg.39.1685534336824;
        Wed, 31 May 2023 04:58:56 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b0094e62aa8bcesm8793829ejb.29.2023.05.31.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 04:58:56 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 31 May 2023 13:58:54 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Message-ID: <ZHc2fm+9daF6cgCE@krava>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:15:16AM +0000, Lorenzo Stoakes wrote:
> Commit df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext data")
> introduced the use of a bounce buffer to retrieve kernel text data for
> /proc/kcore in order to avoid failures arising from hardened user copies
> enabled by CONFIG_HARDENED_USERCOPY in check_kernel_text_object().
> 
> We can avoid doing this if instead of copy_to_user() we use _copy_to_user()
> which bypasses the hardening check. This is more efficient than using a
> bounce buffer and simplifies the code.
> 
> We do so as part an overall effort to eliminate bounce buffer usage in the
> function with an eye to converting it an iterator read.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

hi,
sorry for late feedback, but looks like this one breaks reading
/proc/kcore with objdump for me:

  # cat /proc/kallsyms | grep ksys_read
  ffffffff8150ebc0 T ksys_read
  # objdump -d  --start-address=0xffffffff8150ebc0 --stop-address=0xffffffff8150ebd0 /proc/kcore 

  /proc/kcore:     file format elf64-x86-64

  objdump: Reading section load1 failed because: Bad address

reverting this makes it work again

thanks,
jirka

> ---
>  fs/proc/kcore.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 71157ee35c1a..556f310d6aa4 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -541,19 +541,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  		case KCORE_VMEMMAP:
>  		case KCORE_TEXT:
>  			/*
> -			 * Using bounce buffer to bypass the
> -			 * hardened user copy kernel text checks.
> +			 * We use _copy_to_user() to bypass usermode hardening
> +			 * which would otherwise prevent this operation.
>  			 */
> -			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
> -				if (clear_user(buffer, tsz)) {
> -					ret = -EFAULT;
> -					goto out;
> -				}
> -			} else {
> -				if (copy_to_user(buffer, buf, tsz)) {
> -					ret = -EFAULT;
> -					goto out;
> -				}
> +			if (_copy_to_user(buffer, (char *)start, tsz)) {
> +				ret = -EFAULT;
> +				goto out;
>  			}
>  			break;
>  		default:
> -- 
> 2.39.2
> 
