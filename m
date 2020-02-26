Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86CE916FA02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 09:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgBZIxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 03:53:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:43922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgBZIxB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:53:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE22EAEAF;
        Wed, 26 Feb 2020 08:52:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8F5281E0EA2; Wed, 26 Feb 2020 09:52:59 +0100 (CET)
Date:   Wed, 26 Feb 2020 09:52:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/16] fsnotify: replace inode pointer with tag
Message-ID: <20200226085259.GC10728@quack2.suse.cz>
References: <20200217131455.31107-1-amir73il@gmail.com>
 <20200217131455.31107-8-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217131455.31107-8-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 17-02-20 15:14:46, Amir Goldstein wrote:
> The event inode field is used only for comparison in queue merges and
> cannot be dereferenced after handle_event(), because it does not hold a
> refcount on the inode.
> 
> Replace it with an abstract tag do to the same thing. We are going to
> set this tag for values other than inode pointer in fanotify.
...
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> -static inline void fsnotify_init_event(struct fsnotify_event *event,
> -				       struct inode *inode)
> +static inline void fsnotify_init_event(struct fsnotify_event *event, void *tag)
>  {
>  	INIT_LIST_HEAD(&event->list);
> -	event->inode = inode;
> +	event->tag = (unsigned long)tag;
>  }

Oh, and why not make the argument to fsnotify_init_event() unsigned long
from the start? It would be IMHO cleaner and using void * doesn't really
save us many type casts...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
