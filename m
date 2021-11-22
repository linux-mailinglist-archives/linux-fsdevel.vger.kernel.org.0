Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955DF458F85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 14:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbhKVNjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 08:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbhKVNjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:39:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E11BC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1cwiZQfpD3SkmGX7XB5Pk6HTisIqRWs63/tTDjYhSDo=; b=k+o80sT5+79Qm730/XvaAGDG5A
        BpHwobOQQ94NSgZ3vciiiRXYky2AjvmAcJaqZi7Q1UAiJCwMCwIfEH6AtT5xac7z7diFc4xPtdQ18
        ymOlkTZocGN+S7TuwPAF3NZH4fYPb9vI3XB0i7p910z2XASjieWlt4gmza50L68t3XDFe3AgMpNmu
        sKx4cclIHi6x/lA2k7xcPkPskQEcTTS6gwDMua7100Dlf/GrzytZo5P+S+iGWlFmmmHgDpwe53VbA
        fAe1Bc0KiwbAMibfuCANziYCaBez6ebb/+R0KWj1AwP4GGFWAVTxfIGutZBPOUAhyU891IeK5iGld
        NfQpNAZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mp9UM-00CszC-Gr; Mon, 22 Nov 2021 13:36:06 +0000
Date:   Mon, 22 Nov 2021 13:36:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm,fs: Split dump_mapping() out from dump_page()
Message-ID: <YZucxp+6g7fRhcgS@casper.infradead.org>
References: <20211121121056.2870061-1-willy@infradead.org>
 <YZtCpK2ZsV0qLm6+@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZtCpK2ZsV0qLm6+@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 08:11:32AM +0100, Michal Hocko wrote:
> On Sun 21-11-21 12:10:56, Matthew Wilcox wrote:
> > dump_mapping() is a big chunk of dump_page(), and it'd be handy to be
> > able to call it when we don't have a struct page.  Split it out and move
> > it to fs/inode.c.  Take the opportunity to simplify some of the debug
> > messages a little.
> 
> Makes sense. I haven't checked the head files inclusion side of this but
> I suspect mm heads do include uaccess.h. Not sure inode.c does as well.

It does ... convolutedly:

linux/fs.h
linux/percpu-rwsem.h
linux/rcuwait.h
linux/sched/signal.h
linux/sched/task.h
linux/uaccess.h

There may be shorter paths to including that file, but that's the
one that's actually used according to cpp.  fs/inode.c includes linux/mm.h,
so it also gets it through

linux/pgtable.h
x86/include/asm/pgtable.h
x86/include/asm/pkru.h
x86/include/asm/fpu/xstate.h

which is probably not how you think the mm files get uaccess.h, but
again, that's the first way that cpp tells me it gets pulled in.  Our
header files remain a mess.

> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

