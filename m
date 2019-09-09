Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1327DADB98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 16:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbfIIO7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 10:59:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60344 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfIIO7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:59:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i7L8I-0000cd-Fy; Mon, 09 Sep 2019 14:59:10 +0000
Date:   Mon, 9 Sep 2019 15:59:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     jack@suse.cz, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        renxudong1@huawei.com, Hou Tao <houtao1@huawei.com>
Subject: Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190909145910.GG1131@ZenIV.linux.org.uk>
References: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
 <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 10:10:00PM +0800, zhengbin (A) wrote:

Hmm...  So your theory is that what you are seeing is the insertion
into the list done by list_add() exposing an earlier ->next pointer
to those who might be doing lockless walk through the list.
Potentially up to the last barrier done before the list_add()...

> We can solute it in 2 ways:
> 
> 1. add a smp_wmb between __d_alloc and list_add(&dentry->d_child, &parent->d_subdirs)
> 2. revert commit ebaaa80e8f20 ("lockless next_positive()")

I want to take another look at the ->d_subdirs/->d_child readers...
I agree that the above sounds plausible, but I really want to be
sure about the exclusion we have for those accesses.

I'm not sure that smp_wmb() alone would suffice, BTW - the reader side
loop would need to be careful as well.

Which architecture it was, again?  arm64?
