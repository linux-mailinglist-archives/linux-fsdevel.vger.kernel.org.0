Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190C5263BAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 05:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIJD6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 23:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgIJD6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:58:03 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB5CC061573
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2020 20:58:02 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGDiY-00DWsm-6D; Thu, 10 Sep 2020 03:57:50 +0000
Date:   Thu, 10 Sep 2020 04:57:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fput: Allow calling __fput_sync() from !PF_KTHREAD
 thread.
Message-ID: <20200910035750.GX1236603@ZenIV.linux.org.uk>
References: <20200708142409.8965-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <1596027885-4730-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596027885-4730-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 29, 2020 at 10:04:45PM +0900, Tetsuo Handa wrote:
> __fput_sync() was introduced by commit 4a9d4b024a3102fc ("switch fput to
> task_work_add") with BUG_ON(!(current->flags & PF_KTHREAD)) check, and
> the only user of __fput_sync() was introduced by commit 17c0a5aaffa63da6
> ("make acct_kill() wait for file closing."). However, the latter commit is
> effectively calling __fput_sync() from !PF_KTHREAD thread because of
> schedule_work() call followed by immediate wait_for_completion() call.
> That is, there is no need to defer close_work() to a WQ context. I guess
> that the reason to defer was nothing but to bypass this BUG_ON() check.
> While we need to remain careful about calling __fput_sync(), we can remove
> bypassable BUG_ON() check from __fput_sync().
> 
> If this change is accepted, racy fput()+flush_delayed_fput() introduced
> by commit e2dc9bf3f5275ca3 ("umd: Transform fork_usermode_blob into
> fork_usermode_driver") will be replaced by this raceless __fput_sync().

NAK.  The reason to defer is *NOT* to bypass that BUG_ON() - we really do not
want that thing done on anything other than extremely shallow stack.
Incidentally, why is that thing ever done _not_ in a kernel thread context?
