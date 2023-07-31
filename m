Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8990176A3E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 00:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGaWLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 18:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjGaWLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:11:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB1B2;
        Mon, 31 Jul 2023 15:11:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so56062085e9.2;
        Mon, 31 Jul 2023 15:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690841475; x=1691446275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pG9mGaJw0oLWkMWSPqLey0DSlekkz+WPcfbnO7e1pGQ=;
        b=AdJx8ydCFIxARVitkfM9CNQfZXbUI80HNWKPO1Yi0sm8djbBCc5tCgR5RLwKIN7ebu
         D7Vv6AVdl4xoLugu6FzgI97k6sHx6VjhwUBetaw/pVvmMep64HTHs9MCBCWv9BaqDvLg
         geVDaeZkscfBDRXVeU68N9fskl4Cge+UPXjb6UcUJDqvbrQaQyt8kbH3nS3QDvRqR7xP
         V0SONxpWj77cGcJ5BYw27QuZXgdLYNQ9YOn/70OuwP8Q9R0klNLO2QAjRDdDKdFR+Gfz
         HLqhFvyal2Q1BCynQzfZv3RVTNTkae2uDJTB2sK4O8QJTbSEbbuSWu7BTf9UPN6CGAtq
         28Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690841475; x=1691446275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG9mGaJw0oLWkMWSPqLey0DSlekkz+WPcfbnO7e1pGQ=;
        b=Ssn/KsfveQVPQuAyGkuaUQkVvh+/t0ZPdeKip6iOtsgcgO9e4yJ7TzQjL4xiSpGgZt
         fywA4cm24/CNLpJqi6Gjx570F+1UiZ2P+19U2lh/CJDrtBPejUpVMTrf8iDOG6ruYMuC
         m9L6z7d0TSxECXR6VRw2GTOGmHt93KeYxHXCCbwsnNusleUUfGZibjN/22WBfKeH88ba
         I9qmaGeA0cPWgRujf5D61WJNNyHFRIdmlFfYYgiCeOhm81u8npN5zCwdXlbXB1GLMEi/
         TB7iG++m4H2GdCpalmgmxV8gbJYiaHoMQZP6/3+Onlthgdz7hWB2+RzUS9s/G8f56ZdV
         36BA==
X-Gm-Message-State: ABy/qLZgJT3Amcy9jiNmvbxbZnVrTwS0ReWHnjgdiADVIMlrP694BQ8d
        WjC7jw2Y/Ry2d1v3JLTZH5Q=
X-Google-Smtp-Source: APBJJlFou8tDW9Flgwyhx9pQWEeY3FQxFVM+Nrg0yh4xg7Rg2mTQKyrDZDHLxPb2fsVAVFdEHjzSBA==
X-Received: by 2002:a5d:670b:0:b0:317:6263:1ae2 with SMTP id o11-20020a5d670b000000b0031762631ae2mr806329wru.63.1690841474399;
        Mon, 31 Jul 2023 15:11:14 -0700 (PDT)
Received: from krava ([83.240.60.220])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b00317495f88fasm14127444wrp.112.2023.07.31.15.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 15:11:13 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 1 Aug 2023 00:11:11 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>,
        Will Deacon <will@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org, David Hildenbrand <david@redhat.com>,
        Linux regression tracking <regressions@leemhuis.info>,
        regressions@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT
 regions
Message-ID: <ZMgxf++oeQ2VU94J@krava>
References: <20230731215021.70911-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731215021.70911-1-lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:50:21PM +0100, Lorenzo Stoakes wrote:
> Some architectures do not populate the entire range categorised by
> KCORE_TEXT, so we must ensure that the kernel address we read from is
> valid.
> 
> Unfortunately there is no solution currently available to do so with a
> purely iterator solution so reinstate the bounce buffer in this instance so
> we can use copy_from_kernel_nofault() in order to avoid page faults when
> regions are unmapped.
> 
> This change partly reverts commit 2e1c0170771e ("fs/proc/kcore: avoid
> bounce buffer for ktext data"), reinstating the bounce buffer, but adapts
> the code to continue to use an iterator.
> 
> Fixes: 2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")
> Reported-by: Jiri Olsa <olsajiri@gmail.com>

it fixed my issue, thanks

Tested-by: Jiri Olsa <jolsa@kernel.org>

jirka

> Closes: https://lore.kernel.org/all/ZHc2fm+9daF6cgCE@krava
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  fs/proc/kcore.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 9cb32e1a78a0..3bc689038232 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -309,6 +309,8 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
>  
>  static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
> +	struct file *file = iocb->ki_filp;
> +	char *buf = file->private_data;
>  	loff_t *fpos = &iocb->ki_pos;
>  	size_t phdrs_offset, notes_offset, data_offset;
>  	size_t page_offline_frozen = 1;
> @@ -554,11 +556,22 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>  			fallthrough;
>  		case KCORE_VMEMMAP:
>  		case KCORE_TEXT:
> +			/*
> +			 * Sadly we must use a bounce buffer here to be able to
> +			 * make use of copy_from_kernel_nofault(), as these
> +			 * memory regions might not always be mapped on all
> +			 * architectures.
> +			 */
> +			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
> +				if (iov_iter_zero(tsz, iter) != tsz) {
> +					ret = -EFAULT;
> +					goto out;
> +				}
>  			/*
>  			 * We use _copy_to_iter() to bypass usermode hardening
>  			 * which would otherwise prevent this operation.
>  			 */
> -			if (_copy_to_iter((char *)start, tsz, iter) != tsz) {
> +			} else if (_copy_to_iter(buf, tsz, iter) != tsz) {
>  				ret = -EFAULT;
>  				goto out;
>  			}
> @@ -595,6 +608,10 @@ static int open_kcore(struct inode *inode, struct file *filp)
>  	if (ret)
>  		return ret;
>  
> +	filp->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!filp->private_data)
> +		return -ENOMEM;
> +
>  	if (kcore_need_update)
>  		kcore_update_ram();
>  	if (i_size_read(inode) != proc_root_kcore->size) {
> @@ -605,9 +622,16 @@ static int open_kcore(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +static int release_kcore(struct inode *inode, struct file *file)
> +{
> +	kfree(file->private_data);
> +	return 0;
> +}
> +
>  static const struct proc_ops kcore_proc_ops = {
>  	.proc_read_iter	= read_kcore_iter,
>  	.proc_open	= open_kcore,
> +	.proc_release	= release_kcore,
>  	.proc_lseek	= default_llseek,
>  };
>  
> -- 
> 2.41.0
> 
