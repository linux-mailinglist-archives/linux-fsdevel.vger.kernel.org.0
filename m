Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A2F5A0A02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 09:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiHYHVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 03:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbiHYHV0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:21:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B87696DA;
        Thu, 25 Aug 2022 00:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBACB619CC;
        Thu, 25 Aug 2022 07:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4619DC433C1;
        Thu, 25 Aug 2022 07:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661412083;
        bh=9udJCAgNHvS41DLCf14O6mR9ebvxwpEYWnWLv9uTcMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0KAAhJPpLLzcVvWyCncSp4hb8RkfzPchoc0cSnYqQfE1si7KR47q9CpBG1ZjMM5e7
         b0mgVHVpi8YqqGufROcBxn5gBlfGnDAVq9y8mpeCaCX/4bweKKt7NGFWYNbpbFXPuK
         9nKI5kusVJo9xotOEeV+pXeYaITVvS+9GJ1JFUSY=
Date:   Thu, 25 Aug 2022 09:21:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v2 2/4] fs/proc/task_mmu: Implement IOCTL to get and
 clear soft dirty PTE bit
Message-ID: <Ywci73JxlWGCMnrK@kroah.com>
References: <20220825070926.2922471-1-usama.anjum@collabora.com>
 <20220825070926.2922471-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825070926.2922471-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:09:24PM +0500, Muhammad Usama Anjum wrote:
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..a7e48ba9457b 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -305,4 +305,17 @@ typedef int __bitwise __kernel_rwf_t;
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>  			 RWF_APPEND)
>  
> +struct pagemap_sd_args {
> +	void __user *start;
> +	int len;

"int" is not a valid type to cross the user/kernel boundry, sorry.
Please be explicit here (__u64?  __u32?)

> +	loff_t __user *vec;
> +	int vec_len;
> +	int flags;

Same with these.

thanks,

greg k-h
