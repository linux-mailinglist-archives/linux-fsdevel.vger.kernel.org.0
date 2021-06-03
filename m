Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAE3399DF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 11:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCJmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 05:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCJmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:42:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CF4C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jun 2021 02:41:07 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lojqZ-0005kG-Qv; Thu, 03 Jun 2021 11:41:03 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lojqY-0005qp-JH; Thu, 03 Jun 2021 11:41:02 +0200
Date:   Thu, 3 Jun 2021 11:41:02 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, brauner@suse.cz,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] quota: Change quotactl_path() systcall to an
 fd-based one
Message-ID: <20210603094102.GB26174@pengutronix.de>
References: <20210602151553.30090-1-jack@suse.cz>
 <20210602151553.30090-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602151553.30090-2-jack@suse.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:08:35 up 105 days, 12:32, 123 users,  load average: 0.09, 0.19,
 0.18
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Honza,

On Wed, Jun 02, 2021 at 05:15:52PM +0200, Jan Kara wrote:
> Some users have pointed out that path-based syscalls are problematic in
> some environments and at least directory fd argument and possibly also
> resolve flags are desirable for such syscalls. Rather than
> reimplementing all details of pathname lookup and following where it may
> eventually evolve, let's go for full file descriptor based syscall
> similar to how ioctl(2) works since the beginning. Managing of quotas
> isn't performance sensitive so the extra overhead of open does not
> matter and we are able to consume O_PATH descriptors as well which makes
> open cheap anyway. Also for frequent operations (such as retrieving
> usage information for all users) we can reuse single fd and in fact get
> even better performance as well as avoiding races with possible remounts
> etc.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/quota/quota.c                  | 27 ++++++++++++---------------
>  include/linux/syscalls.h          |  4 ++--
>  include/uapi/asm-generic/unistd.h |  4 ++--
>  kernel/sys_ni.c                   |  2 +-
>  4 files changed, 17 insertions(+), 20 deletions(-)

Thanks for taking care of this.

I also gave this some testing and it's working ok for me, so at least I
can give you my:

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
