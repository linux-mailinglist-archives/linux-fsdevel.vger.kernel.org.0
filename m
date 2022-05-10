Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91491522573
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 22:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiEJUaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 16:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiEJUaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 16:30:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5E4393F5;
        Tue, 10 May 2022 13:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36C01B81E1D;
        Tue, 10 May 2022 20:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81084C385CA;
        Tue, 10 May 2022 20:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652214618;
        bh=iEm7x6KjhRExhpq8F0JTOjT9f0YF/VsiFX+gYeNlJK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qnY0IAokRE1n24DouxgKQ/dIlTNTA/skbjaNu0JimqWU696PDSQa5aznRCubtNuQr
         +hyAhNTkUT6YnJZMQrne3P8Wvp8+Hh0P/3UPvBr79RmcJSbWWQpKi+OXIB05k9Yr/s
         UydUk+T0xCHaGO+tzGOxcDoIaAsbYX/8OsSsyCcQ=
Date:   Tue, 10 May 2022 13:30:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     cgel.zte@gmail.com, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        xu xin <xu.xin16@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Linux fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] mm/ksm: introduce ksm_force for each process
Message-Id: <20220510133016.9feff1aeec1a7a9ae137a8c3@linux-foundation.org>
In-Reply-To: <435b5f7a-fcbd-f7ae-b66f-670e5997aa1b@gnuweeb.org>
References: <20220507105926.d4423601230f698b0f5228d1@linux-foundation.org>
        <20220508092710.930126-1-xu.xin16@zte.com.cn>
        <435b5f7a-fcbd-f7ae-b66f-670e5997aa1b@gnuweeb.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 11 May 2022 03:10:31 +0700 Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:

> On 5/8/22 4:27 PM, cgel.zte@gmail.com wrote:
> > +static ssize_t ksm_force_write(struct file *file, const char __user *buf,
> > +				size_t count, loff_t *ppos)
> > +{
> > +	struct task_struct *task;
> > +	struct mm_struct *mm;
> > +	char buffer[PROC_NUMBUF];
> > +	int force;
> > +	int err = 0;
> > +
> > +	memset(buffer, 0, sizeof(buffer));
> > +	if (count > sizeof(buffer) - 1)
> > +		count = sizeof(buffer) - 1;
> > +	if (copy_from_user(buffer, buf, count)) {
> > +		err = -EFAULT;
> > +		goto out_return;
> > +	}
> 
> This one looks like over-zeroing to me. You don't need to zero
> all elements in the array. You're going to overwrite it with
> `copy_from_user()` anyway.
> 
> Just zero the last potentially useful element by using @count
> as the index. It can be like this:
> 
> ```
> 	char buffer[PROC_NUMBUF];
> 
> 	if (count > sizeof(buffer) - 1)
> 		count = sizeof(buffer) - 1;
> 	if (copy_from_user(buffer, buf, count))
> 		return -EFAULT;
> 	buffer[count] = '\0';
> ```

Use strncpy_from_user()?

Can this code use proc_dointvec_minmax() or similar?
