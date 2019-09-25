Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6C6BDE06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 14:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfIYMWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 08:22:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37406 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbfIYMWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 08:22:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iD6J4-0007Bz-OF; Wed, 25 Sep 2019 12:22:06 +0000
Date:   Wed, 25 Sep 2019 13:22:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190925122206.GJ26530@ZenIV.linux.org.uk>
References: <20190914170146.GT1131@ZenIV.linux.org.uk>
 <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk>
 <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk>
 <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk>
 <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk>
 <CAOQ4uxh-FH7JZP9fVqHXYJkbLA+NK6fX7HQex-XwY0Sha-R_kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh-FH7JZP9fVqHXYJkbLA+NK6fX7HQex-XwY0Sha-R_kw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 25, 2019 at 02:59:47PM +0300, Amir Goldstein wrote:
> On Mon, Sep 23, 2019 at 5:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > FWIW, #next.dcache has the straight conversion to hlist.
> 
> Note that this:
> @@ -108,8 +108,8 @@ struct dentry {
>                 struct list_head d_lru;         /* LRU list */
>                 wait_queue_head_t *d_wait;      /* in-lookup ones only */
>         };
> -       struct list_head d_child;       /* child of parent list */
> -       struct list_head d_subdirs;     /* our children */
> +       struct hlist_node d_sibling;    /* child of parent list */
> +       struct hlist_head d_children;   /* our children */
> 
> Changes the 'standard' struct dentry size from 192 to 184.
> 
> Does that matter for cache line alignment?
> 
> Should struct dentry be ____cacheline_aligned?

*shrug*

DNAME_INLINE_LEN would need to be adjusted; it's just that I think
it would make a lot of sense to represent cursors not by dentries and
hang those on an additional hlist_head in dentry...
