Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985C0B2C53
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2019 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfINRBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Sep 2019 13:01:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58562 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfINRBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Sep 2019 13:01:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9BQg-0003Wa-MJ; Sat, 14 Sep 2019 17:01:46 +0000
Date:   Sat, 14 Sep 2019 18:01:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190914170146.GT1131@ZenIV.linux.org.uk>
References: <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
 <20190909145910.GG1131@ZenIV.linux.org.uk>
 <14888449-3300-756c-2029-8e494b59348b@huawei.com>
 <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
 <20190910215357.GH1131@ZenIV.linux.org.uk>
 <20190914161622.GS1131@ZenIV.linux.org.uk>
 <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 14, 2019 at 09:49:21AM -0700, Linus Torvalds wrote:
> On Sat, Sep 14, 2019 at 9:16 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         OK, folks, could you try the following?  It survives the local beating
> > so far.
> 
> This looks like the right solution to me. Keep the locking simple,
> take the dentry refcount as long as we keep a ref to it in "*res".
> 
> However, the one thing that strikes me is that it looks to me like
> this means that the "cursor" and the dentry in "*res" are basically
> synonymous. Could we drop the cursor entirely, and just keep the ref
> to the last dentry we showd _as_ the cursor?

I thought of that, but AFAICS rename(2) is a fatal problem for such
a scheme.
