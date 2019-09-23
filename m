Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86089BAD6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 07:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbfIWFJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 01:09:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54090 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389251AbfIWFJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 01:09:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCGao-0005uD-Jw; Mon, 23 Sep 2019 05:08:58 +0000
Date:   Mon, 23 Sep 2019 06:08:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190923050858.GB26530@ZenIV.linux.org.uk>
References: <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
 <20190909145910.GG1131@ZenIV.linux.org.uk>
 <14888449-3300-756c-2029-8e494b59348b@huawei.com>
 <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
 <20190910215357.GH1131@ZenIV.linux.org.uk>
 <20190914161622.GS1131@ZenIV.linux.org.uk>
 <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190922212934.GC29065@ZenIV.linux.org.uk>
 <0848b6c7-386c-21fb-233f-be8d9965fbf7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0848b6c7-386c-21fb-233f-be8d9965fbf7@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:32:43AM +0800, zhengbin (A) wrote:

> 
> Is it possible to trigger ABBA deadlock? In next_positive, the lock order is (parent, dentry),
> 
> while in dput, the lock order is (dentry, parent). Cause we use spin_trylock(parent), so the ABBA deadlock will not open.
> 
> dput
> 
>     fast_dput
> 
>        spin_lock(&dentry->d_lock)
> 
>    dentry_kill
> 
>        spin_trylock(&parent->d_lock))
> 
> Is there any other scene like dput, but do not use spin_trylock? I am looking for the code, till now do not find this

There should be none.  The order is parent, then child.  And
all changes of the tree topology are serialized by rename_lock.
