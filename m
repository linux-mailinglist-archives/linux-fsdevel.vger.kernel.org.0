Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637855256D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 23:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358622AbiELVHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 17:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358599AbiELVHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 17:07:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A61F5C65A;
        Thu, 12 May 2022 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IXavWz4RVwW+N7NqHtEfLphEvWnC63XDl89hHqWIYYM=; b=X1EUyNzIPqRbThayuGlNzSMDo6
        vWAYGXBSIROCH076Xjc27JeBIIAVWJZbeybapVoesv86Ud8mKmhNGIy0DwQdA0H2wiID24am85i/m
        QBfv3drxjQSk5FwvDabV//9wMITnx0hB+EVkcFK6B16WnjUj2oj9uX3GQdoGb51OG3fwZHBIZYpUT
        F/SO1YAfID4K2KV3Bo0KtvvvAWmVfUuItHGwoUzO+nu7G45B/7SVpqlCxwBh/U7Q7vbeutb1uoKLz
        BsnfBCNZYgVIlbjbMzb3gUgkW0MabgcolqZkwUTAzxQdWVu8zsss+4XL1k3PKCaEbREeUJD8qjsju
        8THA1Jnw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npG1d-006kSG-SZ; Thu, 12 May 2022 21:07:09 +0000
Date:   Thu, 12 May 2022 22:07:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, corbet@lwn.net,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH v6] mm/ksm: introduce ksm_force for each process
Message-ID: <Yn12/ZMyQEnSh0Ge@casper.infradead.org>
References: <20220510122242.1380536-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510122242.1380536-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 12:22:42PM +0000, cgel.zte@gmail.com wrote:
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -32,7 +32,7 @@ are swapped back in: ksmd must rediscover their identity and merge again).
>  Controlling KSM with madvise
>  ============================
>  
> -KSM only operates on those areas of address space which an application
> +KSM can operates on those areas of address space which an application

"can operate on"

> +static ssize_t ksm_force_write(struct file *file, const char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +	char buffer[PROC_NUMBUF];
> +	int force;
> +	int err = 0;
> +
> +	memset(buffer, 0, sizeof(buffer));
> +	if (count > sizeof(buffer) - 1)
> +		count = sizeof(buffer) - 1;
> +	if (copy_from_user(buffer, buf, count))
> +		return -EFAULT;
> +
> +	err = kstrtoint(strstrip(buffer), 0, &force);
> +	if (err)
> +		return err;
> +
> +	if (force != 0 && force != 1)
> +		return -EINVAL;
> +
> +	task = get_proc_task(file_inode(file));
> +	if (!task)
> +		return -ESRCH;
> +
> +	mm = get_task_mm(task);
> +	if (!mm)
> +		goto out_put_task;
> +
> +	if (mm->ksm_force != force) {
> +		if (mmap_write_lock_killable(mm)) {
> +			err = -EINTR;
> +			goto out_mmput;
> +		}
> +
> +		if (force == 0)
> +			mm->ksm_force = force;
> +		else {
> +			/*
> +			 * Force anonymous pages of this mm to be involved in KSM merging
> +			 * without explicitly calling madvise.
> +			 */
> +			if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
> +				err = __ksm_enter(mm);
> +			if (!err)
> +				mm->ksm_force = force;
> +		}
> +
> +		mmap_write_unlock(mm);
> +	}

There's a much simpler patch hiding inside this complicated one.

	if (force) {
		set_bit(MMF_VM_MERGEABLE, &mm->flags));
		for each VMA
			set VM_MERGEABLE;
		err = __ksm_enter(mm);
	} else {
		clear_bit(MMF_VM_MERGEABLE, &mm->flags));
		for each VMA
			clear VM_MERGEABLE;
	}

... and all the extra complications you added go away.
