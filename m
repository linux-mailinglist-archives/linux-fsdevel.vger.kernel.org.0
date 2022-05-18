Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2375A52C131
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbiERRqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 13:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbiERRqH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 13:46:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9798460068;
        Wed, 18 May 2022 10:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E9D8B81F31;
        Wed, 18 May 2022 17:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BB6C385A5;
        Wed, 18 May 2022 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652895962;
        bh=RHuQvfGJad+0pY5yu6xwPWnVxtuvlO9bjRDUb1H5LiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sAgWV3VlrxHOfFBNTBtOCBslOzTBkY3S4OqCsCTg+o9kqhiukopfAMkmA37kes29I
         jxrQyedjJrJ7oifewXYzkO5A31I5YWPwZL1OK5PgIE3Cv3opBGj38hqFCkhxi45j2S
         hjCnG+wSs5tauK0ydMYgyTzlJvFQcWrI7nADmsdw=
Date:   Wed, 18 May 2022 10:46:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     <keescook@chromium.org>, <viro@zeniv.linux.org.uk>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>
Subject: Re: [PATCH -next] exec: Remove redundant check in
 do_open_execat/uselib
Message-Id: <20220518104601.fc21907008231b60a0e54a8e@linux-foundation.org>
In-Reply-To: <20220518081227.1278192-1-chengzhihao1@huawei.com>
References: <20220518081227.1278192-1-chengzhihao1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 May 2022 16:12:27 +0800 Zhihao Cheng <chengzhihao1@huawei.com> wrote:

> There is a false positive WARNON happening in execve(2)/uselib(2)
> syscalls with concurrent noexec-remount.
> 
>        execveat                           remount
> do_open_execat(path/bin)
>   do_filp_open
>     path_openat
>       do_open
>         may_open
>           path_noexec() // PASS
> 	                            remount(path->mnt, MS_NOEXEC)
> WARNON(path_noexec(&file->f_path)) // path_noexec() checks fail

You're saying this is a race condition?  A concurrent remount causes
this warning?

> Since may_open() has already checked the same conditions, fix it by
> removing 'S_ISREG' and 'path_noexec' check in do_open_execat()/uselib(2).
> 
> ...
>
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -141,16 +141,6 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
>  	if (IS_ERR(file))
>  		goto out;
>  
> -	/*
> -	 * may_open() has already checked for this, so it should be
> -	 * impossible to trip now. But we need to be extra cautious
> -	 * and check again at the very end too.
> -	 */
> -	error = -EACCES;
> -	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
> -			 path_noexec(&file->f_path)))
> -		goto exit;
> -

Maybe we should retain the `goto exit'.  The remount has now occurred,
so the execution attempt should be denied.  If so, the comment should
be updated to better explain what's happening.

I guess we'd still be racy against `mount -o exec', but accidentally
denying something seems less serious than accidentally permitting it.


