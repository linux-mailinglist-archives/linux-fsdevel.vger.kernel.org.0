Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37F6819A912
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 12:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgDAKBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 06:01:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:33628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgDAKBc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:01:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2E5DCAE2D;
        Wed,  1 Apr 2020 10:01:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DC2F31E11F4; Wed,  1 Apr 2020 12:01:25 +0200 (CEST)
Date:   Wed, 1 Apr 2020 12:01:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:FILESYSTEM DIRECT ACCESS (DAX)" 
        <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 3/7] dax: Add missing annotation for wait_entry_unlocked()
Message-ID: <20200401100125.GB19466@quack2.suse.cz>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
 <20200331204643.11262-4-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331204643.11262-4-jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 31-03-20 21:46:39, Jules Irenge wrote:
> Sparse reports a warning at wait_entry_unlocked()
> 
> warning: context imbalance in wait_entry_unlocked()
> 	- unexpected unlock
> 
> The root cause is the missing annotation at wait_entry_unlocked()
> Add the missing __releases(xa) annotation.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  fs/dax.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 1f1f0201cad1..adcd2a57fbad 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -244,6 +244,7 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
>   * After we call xas_unlock_irq(), we cannot touch xas->xa.
>   */
>  static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> +	__releases(xa)

Thanks for the patch but is this a proper sparse annotation? I'd rather
expect something like __releases(xas->xa->xa_lock) here...

								Honza

>  {
>  	struct wait_exceptional_entry_queue ewait;
>  	wait_queue_head_t *wq;
> -- 
> 2.24.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
