Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07B1A9B1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 12:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896501AbgDOKms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 06:42:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:54260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896482AbgDOKm0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:42:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50499AE72;
        Wed, 15 Apr 2020 10:42:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D21A61E1250; Wed, 15 Apr 2020 12:42:23 +0200 (CEST)
Date:   Wed, 15 Apr 2020 12:42:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "open list:FILESYSTEM DIRECT ACCESS (DAX)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:FILESYSTEM DIRECT ACCESS (DAX)" 
        <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH v2] dax: Add missing annotation for wait_entry_unlocked()
Message-ID: <20200415104223.GB6126@quack2.suse.cz>
References: <20200401153400.23610-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401153400.23610-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 01-04-20 16:33:59, Jules Irenge wrote:
> Sparse reports a warning at wait_entry_unlocked()
> 
> warning: context imbalance in wait_entry_unlocked() - unexpected unlock
> 
> The root cause is the missing annotation at wait_entry_unlocked()
> Add the missing __releases(xas->xa->xa_lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dax.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 35da144375a0..ee0468af4d81 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -244,6 +244,7 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
>   * After we call xas_unlock_irq(), we cannot touch xas->xa.
>   */
>  static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> +	__releases(xas->xa->xa_lock)
>  {
>  	struct wait_exceptional_entry_queue ewait;
>  	wait_queue_head_t *wq;
> -- 
> Change since v2
> - gives more accurate lock variable name
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
