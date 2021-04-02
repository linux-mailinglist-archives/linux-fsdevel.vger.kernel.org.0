Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CCD35303D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 22:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhDBUZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhDBUZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:25:09 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F18C0613E6
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Apr 2021 13:25:06 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id c3so2977614qvz.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Apr 2021 13:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=blJ2MUdaahXhFYZFRSXvDZnUm7sTjvAs4NUZEMxKrIY=;
        b=i7mTEQ8m5OA9SHvlHX5039IK0LwXOfuS0V4k8bq//K7xUdlMFgRWy5Hth8Tvux3ZVW
         ZJ5ebPv8+YYnvmuGjaswXXhsg2Z5m4M3svqC5jeZ9s3C9sOAclzNer+DDUxyNmE10ixy
         bT8o1NruaNV5Uwfk3/Xvvb3+NXNIHriWJ6cBiW0qlaLWeSGQZEEjDyXhogfKY3euzn0f
         lyA2TxnR1BQPqHFd0Yy/I2qciBW8TOODiIXqmgxQNHLFMAZ40H2m3QJrHmKt43szehUr
         YUTcNLk4sdlBL51Lo8WrxBmO9mmijINSqiISH7kavqrAYCtceIHUCwyloGp1ZeOwn9l1
         +U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=blJ2MUdaahXhFYZFRSXvDZnUm7sTjvAs4NUZEMxKrIY=;
        b=F98oOfwufP8mqq1w73fz6euNsK9xsQUuf1gxiJr9OFf30e7Uq5rbTTLdl2cvwbFdFR
         5qZY0Pv9VFzssfAR+OrJ957+OZLyiLYhx0+shn99IA76ZsTonYa1r/UaihvyIeKvgUlW
         y3eu2VrsCsZV9ilhaNSSQSUsrY3qRuyEQs1IDEDTF/hIh2M1HZxD4CIjwqPByAZI+9rk
         vR/M7Hl0Ye0HBpza/5oi4yRyjcgKhN8SzIOPdv241oWIgudS9eqZ0hmMTyyA12UbfZUF
         O8DX5a8a7YAY6onFSBYvIfcyd4IkR8T4mIFseqZy4KEC5MVIjPQPJZxfOrahc9aViNBd
         yk2A==
X-Gm-Message-State: AOAM533GxPz51Zr/kQ4Omi/+P2peztb3GcgmDaxh/2ryghrTPCf53foy
        CVYYg24cFWJdV0X3kAOzm8RhlQ==
X-Google-Smtp-Source: ABdhPJzojX8if8vKxcSVwXfo3q2dejDgJfZAcThUO3Fq0UfQ+89xMzRMZkblHVmGrV2ts1on7pMkJQ==
X-Received: by 2002:a0c:b303:: with SMTP id s3mr14512574qve.22.1617395105703;
        Fri, 02 Apr 2021 13:25:05 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b17sm7100646qtp.73.2021.04.02.13.25.04
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 02 Apr 2021 13:25:05 -0700 (PDT)
Date:   Fri, 2 Apr 2021 13:24:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
In-Reply-To: <20210402170414.GQ351017@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2104021239060.1092@eggly.anvils>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils> <20210331024913.GS351017@casper.infradead.org> <alpine.LSU.2.11.2103311413560.1201@eggly.anvils> <20210401170615.GH351017@casper.infradead.org> <20210402031305.GK351017@casper.infradead.org>
 <20210402132708.GM351017@casper.infradead.org> <20210402170414.GQ351017@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2 Apr 2021, Matthew Wilcox wrote:

> OK, more competent testing, and that previous bug now detected and fixed.
> I have a reasonable amount of confidence this will solve your problem.
> If you do apply this patch, don't enable CONFIG_TEST_XARRAY as the new
> tests assume that attempting to allocate with a GFP flags of 0 will
> definitely fail, which is true for my userspace allocator, but not true
> inside the kernel.  I'll add some ifdeffery to skip these tests inside
> the kernel, as without a way to deterministically fail allocation,
> there's no way to test this code properly.

Thanks a lot for all your efforts on this, but the news from the front
is disappointing.  The lib/xarray.c you sent here is yesterday's plus
the little __xas_trim() fixup you sent this morning: I set that going
then on three machines, two of them are still good, but one is not (and
yes, I've checked several times that it is the intended kernel running).
xa_dump()s appended below, but I don't expect them to have more to tell.

I think you've been focusing on the old radix-tree -ENOMEM case, which
you'd wanted to clean up anyway, but overlooking the THP collapse_file()
case, which is the one actually hitting me.  collapse_file() does that
xas_create_range(), which Doc tells me will create all the nodes which
might be needed; and if collapse_file() has to give up and revert for
any of many plausible reasons, those nodes may be left over at the end.

There is a "Put holes back where they were" xas_store(&xas, NULL) on
the failure path, which I think we would expect to delete empty nodes.
But it only goes as far as nr_none.  Is it ok to xas_store(&xas, NULL)
where there was no non-NULL entry before?  I should try that, maybe
adjusting the !nr_none break will give a very simple fix.

Or, if you remove the "static " from xas_trim(), maybe that provides
the xas_prune_range() you proposed, or the cleanup pass I proposed.
To be called on collapse_file() failure, or when eviction finds
!mapping_empty().

[ 2927.151739] xarray: ffff888017914c80 head ffff888003a10db2 flags 21 marks 0 0 0
[ 2927.171484] 0-4095: node ffff888003a10db0 max 0 parent 0000000000000000 shift 6 count 3 values 0 array ffff888017914c80 list ffff888003a10dc8 ffff888003a10dc8 marks 0 0 0
[ 2927.213313] 1344-1407: node ffff8880055c8490 offset 21 parent ffff888003a10db0 shift 0 count 0 values 0 array ffff888017914c80 list ffff8880055c84a8 ffff8880055c84a8 marks 0 0 0
[ 2927.257924] 1408-1471: node ffff8880055c8248 offset 22 parent ffff888003a10db0 shift 0 count 0 values 0 array ffff888017914c80 list ffff8880055c8260 ffff8880055c8260 marks 0 0 0
[ 2927.305332] 1472-1535: node ffff8880055c8000 offset 23 parent ffff888003a10db0 shift 0 count 0 values 0 array ffff888017914c80 list ffff8880055c8018 ffff8880055c8018 marks 0 0 0
[ 2927.355811] s_dev 8:8 i_ino 274355 i_size 10092280

[ 3813.689018] xarray: ffff888005511408 head ffff888017624db2 flags 21 marks 0 0 0
[ 3813.716012] 0-4095: node ffff888017624db0 max 2 parent 0000000000000000 shift 6 count 3 values 0 array ffff888005511408 list ffff888017624dc8 ffff888017624dc8 marks 0 0 0
[ 3813.771966] 1344-1407: node ffff888000595b60 offset 21 parent ffff888017624db0 shift 0 count 0 values 0 array ffff888005511408 list ffff888000595b78 ffff888000595b78 marks 0 0 0
[ 3813.828102] 1408-1471: node ffff888000594b68 offset 22 parent ffff888017624db0 shift 0 count 0 values 0 array ffff888005511408 list ffff888000594b80 ffff888000594b80 marks 0 0 0
[ 3813.883603] 1472-1535: node ffff888000594248 offset 23 parent ffff888017624db0 shift 0 count 0 values 0 array ffff888005511408 list ffff888000594260 ffff888000594260 marks 0 0 0
[ 3813.939146] s_dev 8:8 i_ino 274355 i_size 10092280

[14157.780505] xarray: ffff888007c8d988 head ffff88800bccfd9a flags 21 marks 0 0 0
[14157.801557] 0-4095: node ffff88800bccfd98 max 7 parent 0000000000000000 shift 6 count 2 values 0 array ffff888007c8d988 list ffff88800bccfdb0 ffff88800bccfdb0 marks 0 0 0
[14157.845337] 896-959: node ffff8880279fdda8 offset 14 parent ffff88800bccfd98 shift 0 count 0 values 0 array ffff888007c8d988 list ffff8880279fddc0 ffff8880279fddc0 marks 0 0 0
[14157.893594] 960-1023: node ffff8880279fe238 offset 15 parent ffff88800bccfd98 shift 0 count 0 values 0 array ffff888007c8d988 list ffff8880279fe250 ffff8880279fe250 marks 0 0 0
[14157.943810] s_dev 8:8 i_ino 274355 i_size 10092280

Hugh
