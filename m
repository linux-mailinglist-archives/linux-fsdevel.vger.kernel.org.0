Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F028E526058
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347690AbiEMKwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiEMKw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 06:52:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B8F2181CD
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 03:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E88CB82AF1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 10:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB8CC34113;
        Fri, 13 May 2022 10:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652439143;
        bh=G3QM+lpQj+8TfVcd+lU2aev91X7FtyCxL/CsvAnEvVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLvrtxBhIaZ0SOSkr/F1V0n+K06eTWvmpJ1WoaGmhxCjvFoytBTMeP8eFwNtVSzuf
         9nrjQuTfStrruyzXqbrKxIgskS36EnXQmIv9FzHEC1y6WWJBKUSnE9fxoPZI9XiMkr
         ZovgQB5E53SbKdqNhZXWoEIQ2o3zYh5rOLby1GFeQQxXkP7GgIRhp2HtDGU3bHX7Ut
         3rVN3UxHavZkQQGk8mS4ka3TIgH5smCu/qBauUWXXnQLdBeb1PsWd8UIKh59sXsxZI
         oXPg6rxfDCF+WmMvsS0PILM6miChD13OqrVPzZE7BBDwARn0zFvGiCyN2K+yn+uYr+
         1vBX4Kg3plMpg==
Date:   Fri, 13 May 2022 12:52:18 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>, Todd Kjos <tkjos@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [RFC] unify the file-closing stuff in fs/file.c
Message-ID: <20220513105218.6feck5rqd7igipj2@wittgenstein>
References: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 09:20:51PM +0000, Al Viro wrote:
> 	Right now we have two places that do such removals - pick_file()
> and {__,}close_fd_get_file().
> 
> 	They are almost identical - the only difference is in calling
> conventions (well, and the fact that __... is called with descriptor
> table locked).
> 
> 	Calling conventions are... interesting.
> 
> 1) pick_file() - returns file or ERR_PTR(-EBADF) or ERR_PTR(-EINVAL).
> The latter is for "descriptor is greater than size of descriptor table".
> One of the callers treats all ERR_PTR(...) as "return -EBADF"; another
> uses ERR_PTR(-EINVAL) as "end the loop now" indicator.
> 
> 2) {__,}close_fd_get_file() returns 0 or -ENOENT (huh?), with file (or NULL)
> passed to caller by way of struct file ** argument.  One of the callers
> (binder) ignores the return value completely and checks if the file is NULL.
> Another (io_uring) checks for return value being negative, then maps
> -ENOENT to -EBADF, not that any other value would be possible.
> 
> ERR_PTR(-EINVAL) magic in case of pick_file() is borderline defensible;
> {__,}close_fd_get_file() conventions are insane.  The older caller
> (in binder) had never even looked at return value; the newer one
> patches the bogus -ENOENT to what it wants to report, with strange
> "defensive" BS logics just in case __close_fd_get_file() would somehow
> find a different error to report.
> 
> At the very least, {__,}close_fd_get_file() callers would've been happier
> if it just returned file or NULL.  What's more, I'm seriously tempted
> to make pick_file() do the same thing.  close_fd() won't care (checking
> for NULL is just as easy as for IS_ERR) and __range_close() could just
> as well cap the max_fd argument with last_fd(files_fdtable(current->files)).

Originally, __close_range() did that last_fd() thing for both the
cloexec and the non-cloexec case. But that proved buggy for the cloexec
part (dumb oversight). So the cloexec part retrieves the last_fd() and
marks cloexec under the spinlock to make sure it's stable.

We could've done the same that this patch does now and retrieved
last_fd() in __range_close() too. But without having looked at
{__,}close_fd_get_file() it was more obvious imho to let pick_file()
tell the caller when to terminate the loop as it avoids fiddling
last_fd() out from under the rcu lock given that we below we had to take
the spinlock anyway.

With the motivation of reducing __close_fd_get_file() to pick_file() the
other way is more sensible.

> 
> Does anybody see problems with the following?
> 
> commit 8819510a641800a63ab10d6b5ab283cada1cbd50
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Thu May 12 17:08:03 2022 -0400
> 
>     Unify the primitives for file descriptor closing
>     
>     Currently we have 3 primitives for removing an opened file from descriptor
>     table - pick_file(), __close_fd_get_file() and close_fd_get_file().  Their
>     calling conventions are rather odd and there's a code duplication for no
>     good reason.  They can be unified -
>     
>     1) have __range_close() cap max_fd in the very beginning; that way
>     we don't need separate way for pick_file() to report being past the end
>     of descriptor table.
>     
>     2) make {__,}close_fd_get_file() return file (or NULL) directly, rather
>     than returning it via struct file ** argument.  Don't bother with
>     (bogus) return value - nobody wants that -ENOENT.
>     
>     3) make pick_file() return NULL on unopened descriptor - the only caller
>     that used to care about the distinction between descriptor past the end
>     of descriptor table and finding NULL in descriptor table doesn't give
>     a damn after (1).
>     
>     4) lift ->files_lock out of pick_file()
>     
>     That actually simplifies the callers, as well as the primitives themselves.
>     Code duplication is also gone...
>     
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

The change in io_close() looked a bit subtle because ret was overriden
in there by __close_fd_get_file() prior to changing it to return struct
file but ret is set to -EBADF at the top of io_close() so it looks fine.

Since you change pick_file() to require the caller to hold the lock it'd
be good to add a:

	Context: Caller must hold files_lock.

to the kernel-doc I added; similar to what I did for last_fd().

Also, there's a bunch of regression tests I added in:

tools/testing/selftests/core/close_range_test.c

including various tests for issues reported by syzbot. Might be worth
running to verify we didn't regress anything.

Thanks!
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
