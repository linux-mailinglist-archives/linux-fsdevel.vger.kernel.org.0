Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F94751EFE5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 21:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiEHTRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 15:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346085AbiEHSHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 14:07:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE86B849;
        Sun,  8 May 2022 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LasmEg2rUBS72wUE19EKxuY+AQYVJSkN1z6eFcojeaU=; b=uSEwp/+iuBdu5CaOAO2cQ0XAsx
        3bSQuW2tYAqJSzYarBs5DSvOQ143R5KJH6zJhC99HVjTFa+C5LE8h8zk+eVr9KrSJiHVwgZ2KGM2b
        DgGtHjHONznLxHAer27E+90GqIgUYuRaYK1vgwELwOrHQPyXDWxnEdulbmoyhV3xhlNe+wtoXz0mE
        /B5aQ4oGrORlr7a5ZY+BJNUFWzTOZ9HAPAWYvI+4s5vxdnmqIg2bWWHiTXLsV+kZDTXF4Boa+MRgA
        SC3qLu90w2sf9if0jbK/hu2/4S7BI0j0oGnRe47Rf54/geRFo40hfL2Z1BFXdSYpwM0pSn5Mv+RWe
        R0dHvA7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnlFo-002he6-Vz; Sun, 08 May 2022 18:03:37 +0000
Date:   Sun, 8 May 2022 19:03:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn,
        zhang.yunkai@zte.com.cn
Subject: Re: [PATCH v5] mm/ksm: introduce ksm_force for each process
Message-ID: <YngF+Lz01noCKRFc@casper.infradead.org>
References: <20220507105926.d4423601230f698b0f5228d1@linux-foundation.org>
 <20220508092710.930126-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508092710.930126-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 08, 2022 at 09:27:10AM +0000, cgel.zte@gmail.com wrote:
> If ksm_force is set to 0, cancel the feature of ksm_force of this
> process and unmerge those merged pages belonging to VMAs which is not
> madvised as MADV_MERGEABLE of this process, but leave MADV_MERGEABLE
> areas merged.

Is that actually a useful feature?  Otherwise, we could simply turn
on/off the existing MMF_VM_MERGEABLE flag instead of introducing this
new bool.

> +Controlling KSM with procfs
> +===========================
> +
> +KSM can also operate on anonymous areas of address space of those processes's
> +knob ``/proc/<pid>/ksm_force`` is on, even if app codes doesn't call madvise()
> +explicitly to advise specific areas as MADV_MERGEABLE.
> +
> +You can set ksm_force to 1 to force all anonymous and qualified VMAs of
> +this process to be involved in KSM scanning. But It is effective only when the
> +klob of ``/sys/kernel/mm/ksm/run`` is set as 1.

I think that last sentence doesn't really add any value.

> +	memset(buffer, 0, sizeof(buffer));
> +	if (count > sizeof(buffer) - 1)
> +		count = sizeof(buffer) - 1;
> +	if (copy_from_user(buffer, buf, count)) {
> +		err = -EFAULT;
> +		goto out_return;

This feels a bit unnecessary.  Just 'return -EFAULT' here.

> +	}
> +
> +	err = kstrtoint(strstrip(buffer), 0, &force);
> +
> +	if (err)
> +		goto out_return;

'return err'

> +	if (force != 0 && force != 1) {
> +		err = -EINVAL;
> +		goto out_return;

'return -EINVAL'

> +	}
> +
> +	task = get_proc_task(file_inode(file));
> +	if (!task) {
> +		err = -ESRCH;
> +		goto out_return;

'return -ESRCH'

