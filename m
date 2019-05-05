Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B219513F94
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2019 15:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfEENFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 May 2019 09:05:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42664 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfEENFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 May 2019 09:05:35 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hNGpd-0006Z0-4o; Sun, 05 May 2019 13:05:29 +0000
Date:   Sun, 5 May 2019 14:05:29 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKP <lkp@01.org>
Subject: Re: [PATCH] fsnotify: fix unlink performance regression
Message-ID: <20190505130528.GA23075@ZenIV.linux.org.uk>
References: <20190505091549.1934-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505091549.1934-1-amir73il@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 05, 2019 at 12:15:49PM +0300, Amir Goldstein wrote:
> __fsnotify_parent() has an optimization in place to avoid unneeded
> take_dentry_name_snapshot().  When fsnotify_nameremove() was changed
> not to call __fsnotify_parent(), we left out the optimization.
> Kernel test robot reported a 5% performance regression in concurrent
> unlink() workload.
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Link: https://lore.kernel.org/lkml/20190505062153.GG29809@shao2-debian/
> Link: https://lore.kernel.org/linux-fsdevel/20190104090357.GD22409@quack2.suse.cz/
> Fixes: 5f02a8776384 ("fsnotify: annotate directory entry modification events")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> The linked 5.1-rc1 performance regression report came with bad timing.
> Not sure if Linus is planning an rc8. If not, you will probably not
> see this before the 5.1 release and we shall have to queue it for 5.2
> and backport to stable 5.1.
> 
> I crafted the patch so it applies cleanly both to master and Al's
> for-next branch (there are some fsnotify changes in work.dcache).

Charming...  What about rename() and matching regressions there?
