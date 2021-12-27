Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E444947F9B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 03:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhL0CJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 21:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhL0CJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 21:09:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51598C06173E;
        Sun, 26 Dec 2021 18:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=t6MHcFRQOEAfAbf+pBhcCNXckGDe+GUmSYQySEIVgis=; b=FleukhVUyFoQqc0DFr9Mofp9Bw
        BAGQvyPVmANzpJ09/f7kPV+IgBFWC/S+iRRIXcwcmO93IL9q6d4m9K7IFKIKmnP2auG7vmsUS4ZFs
        tCP7Hmsat6c+XiRPf8zPvkfeVQdDglfL+1XeX4nDqiRM2xrhs0Ow5jwQUKmE9GE33DZymihlf5EO2
        QaVfTaw5bKW5VpuHEx7Ahxd41/rZWyjj1vgvRthdbQpcXo1vkcIOF/UcHB4us4FFIiCS3n9WW+qJm
        iCVtdYTVNd6fGZCm51kcgpdde6081ZireGvim/HRfR3UfsHR9bsXw0ssRSUNp42gx9xXwOjq3CAXp
        AG8HfzJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n1fRa-0074rg-3W; Mon, 27 Dec 2021 02:08:58 +0000
Date:   Mon, 27 Dec 2021 02:08:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] fs: super: possible ABBA deadlocks in
 do_thaw_all_callback() and freeze_bdev()
Message-ID: <YckgOocIWOrOoRvf@casper.infradead.org>
References: <e3de0d83-1170-05c8-672c-4428e781b988@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3de0d83-1170-05c8-672c-4428e781b988@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 27, 2021 at 10:03:35AM +0800, Jia-Ju Bai wrote:
> My static analysis tool reports several possible ABBA deadlocks in Linux
> 5.10:
> 
> do_thaw_all_callback()
>   down_write(&sb->s_umount); --> Line 1028 (Lock A)
>   emergency_thaw_bdev()
>     thaw_bdev()
>       mutex_lock(&bdev->bd_fsfreeze_mutex); --> Line 602 (Lock B)
> 
> freeze_bdev()
>   mutex_lock(&bdev->bd_fsfreeze_mutex); --> Line 556 (Lock B)
>   freeze_super()
>     down_write(&sb->s_umount); --> Line 1716 (Lock A)
>     down_write(&sb->s_umount); --> Line 1738 (Lock A)
>   deactivate_super()
>     down_write(&s->s_umount); --> Line 365 (Lock A)
> 
> When do_thaw_all_callback() and freeze_bdev() are concurrently executed, the
> deadlocks can occur.
> 
> I am not quite sure whether these possible deadlocks are real and how to fix
> them if them are real.
> Any feedback would be appreciated, thanks :)

As a rule, ABBA deadlocks that can actually occur are already found by
lockdep.    Tools that think they've found something are generally wrong.
I'm not inclined to look in detail to find out why this tool is wrong
because lockdep is so effective.
