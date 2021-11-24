Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC8645D0E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 00:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345044AbhKXXQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 18:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343891AbhKXXQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:16:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A7FC061574;
        Wed, 24 Nov 2021 15:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vGQngjOGcSFO/nTOXakra4wP0oJq1Hd0DuybwmOplPc=; b=r0RYYqt2p9ubjKgHix4L9Xjqds
        QDeaB001k/KSTeyct0LUKzSU6zTxPO1ydmKy603qD+LJgQZKajqzdRm8n7xkH0u8n6y9Fbt3RTDrT
        pcK89MdyKMlUucEhV2sxmBZ1FNf7VHDbuGwdtAMNCdes/nncrApPenGDktUjbBczqsVvmum3IjFa0
        wtw6hixCkpIqUt8vltu/Hf0295Zt1cT4K+9XWDTpxMMlzetL78caBmsxBVcKFayOVe37zuJ59MlnO
        fXrxQ4xDFli9gxyrjKlI3k1pGVft95RfnWpzTlK5pNuEsugyEfb/TAiGMdlQHEJMECHgx1wBMitNY
        rh8pmlvg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq1R7-0063VW-GG; Wed, 24 Nov 2021 23:12:21 +0000
Date:   Wed, 24 Nov 2021 15:12:21 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, akpm@linux-foundation.org,
        keescook@chromium.org, yzaikin@google.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        pmladek@suse.com, senozhatsky@chromium.org, wangqing@vivo.com,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] sysctl: Move some boundary constants from
 sysctl.c to sysctl_vals
Message-ID: <YZ7G1YsmR8TrbfbK@bombadil.infradead.org>
References: <20211123202347.818157-1-mcgrof@kernel.org>
 <20211123202347.818157-3-mcgrof@kernel.org>
 <87k0gygnq4.fsf@email.froward.int.ebiederm.org>
 <a2d657e4-617a-ff4b-1334-928560701589@huawei.com>
 <87zgpte9o4.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgpte9o4.fsf@email.froward.int.ebiederm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 11:38:19AM -0600, Eric W. Biederman wrote:
> Looking a little more.  I think it makes sense to do something like:
> 
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 1fa2b69c6fc3..c299009421ea 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -121,8 +121,8 @@ struct ctl_table {
>         struct ctl_table *child;        /* Deprecated */
>         proc_handler *proc_handler;     /* Callback for text formatting */
>         struct ctl_table_poll *poll;
> -       void *extra1;
> -       void *extra2;
> +       long min;
> +       long max;
>  } __randomize_layout;
> 
> Any chance we can do that for a cleanup instead of extending sysctl_vals?

Essentially the change is *big*. We either do that *not yet implemented*
change *now, and then have to rebase all the non-upstream work to adapt
to that, or we do that after the cleanup.

Both I think are going to cause some suffering. I'd prefer to do it
after though. Would you be OK with that?

  Luis
