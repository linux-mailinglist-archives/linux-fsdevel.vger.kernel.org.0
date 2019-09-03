Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D084CA6D18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 17:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfICPkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 11:40:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59386 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfICPkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:40:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i5Aud-0007hC-Uy; Tue, 03 Sep 2019 15:40:08 +0000
Date:   Tue, 3 Sep 2019 16:40:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     jack@suse.cz, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>
Subject: Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190903154007.GJ1131@ZenIV.linux.org.uk>
References: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:44:32PM +0800, zhengbin (A) wrote:
> We recently encountered an oops(the filesystem is tmpfs)
> crash> bt
>  #9 [ffff0000ae77bd60] dcache_readdir at ffff0000672954bc
> 
> The reason is as follows:
> Process 1 cat test which is not exist in directory A, process 2 cat test in directory A too.
> process 3 create new file in directory B, process 4 ls directory A.


good grief, what screen width do you have to make the table below readable?

What I do not understand is how the hell does your dtry2 manage to get actually
freed and reused without an RCU delay between its removal from parent's
->d_subdirs and freeing its memory.  What should've happened in that
scenario is
	* process 4, in next_positive() grabs rcu_read_lock().
	* it walks into your dtry2, which might very well be
just a chunk of memory waiting to be freed; it sure as hell is
not positive.  skipped is set to true, 'i' is not decremented.
Note that ->d_child.next points to the next non-cursor sibling
(if any) or to the ->d_subdir of parent, so we can keep walking.
	* we keep walking for a while; eventually we run out of
counter and leave the loop.

Only after that we do rcu_read_unlock() and only then anything
observed in that loop might be freed and reused.

Confused...  OTOH, I might be misreading that table of yours -
it's about 30% wider than the widest xterm I can get while still
being able to read the font...
