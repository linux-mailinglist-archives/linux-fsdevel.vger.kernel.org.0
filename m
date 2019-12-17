Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C42123057
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfLQPau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 10:30:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46608 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfLQPau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:30:50 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihEo9-00065R-R5; Tue, 17 Dec 2019 15:30:45 +0000
Date:   Tue, 17 Dec 2019 15:30:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     qiwuchen55@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [RESEND PATCH] fput: Use unbound workqueue for scheduling
 delayed fput works
Message-ID: <20191217153045.GZ4203@ZenIV.linux.org.uk>
References: <1576595472-27341-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576595472-27341-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:11:12PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> There is a potential starvation that the number of delayed fput works
> increase rapidly if task exit storm or fs unmount issue happens.

Err...  Details, please, ideally along with a reproducer.  In particular,
I would like to understand what does any of that have to do with umount.
Or to task exits, for that matter - exit_files() is called before
exit_task_work(), so you shouldn't normally be seeing task_work_add()
failures when files get closed on exit(2)...

If you are really observing such problems, it might be worth looking
into the underlying situation - something odd appears to be going
on and I'd rather understand what it is.
