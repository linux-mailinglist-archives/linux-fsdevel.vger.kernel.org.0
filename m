Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0683E265490
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 23:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgIJV6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 17:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbgIJLmi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:42:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E778C061573
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 04:25:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGKhg-00Dhm6-2w; Thu, 10 Sep 2020 11:25:24 +0000
Date:   Thu, 10 Sep 2020 12:25:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fput: Allow calling __fput_sync() from !PF_KTHREAD
 thread.
Message-ID: <20200910112524.GY1236603@ZenIV.linux.org.uk>
References: <20200708142409.8965-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <1596027885-4730-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200910035750.GX1236603@ZenIV.linux.org.uk>
 <dae15011-24b0-b382-218a-c988b435fb5c@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dae15011-24b0-b382-218a-c988b435fb5c@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 02:26:46PM +0900, Tetsuo Handa wrote:
> Thank you for responding. I'm also waiting for your response on
> "[RFC PATCH] pipe: make pipe_release() deferrable." at 
> https://lore.kernel.org/linux-fsdevel/7ba35ca4-13c1-caa3-0655-50d328304462@i-love.sakura.ne.jp/
> and "[PATCH] splice: fix premature end of input detection" at 
> https://lore.kernel.org/linux-block/cf26a57e-01f4-32a9-0b2c-9102bffe76b2@i-love.sakura.ne.jp/ .
> 
> > 
> > NAK.  The reason to defer is *NOT* to bypass that BUG_ON() - we really do not
> > want that thing done on anything other than extremely shallow stack.
> > Incidentally, why is that thing ever done _not_ in a kernel thread context?
> 
> What does "that thing" refer to? acct_pin_kill() ? blob_to_mnt() ?
> I don't know the reason because I'm not the author of these functions.

	The latter.  What I mean, why not simply do that from inside of
fork_usermode_driver()?  umd_setup is stored in sub_info->init and
eventually called from call_usermodehelper_exec_async(), right before
the created kernel thread is about to call kernel_execve() and stop
being a kernel thread...
