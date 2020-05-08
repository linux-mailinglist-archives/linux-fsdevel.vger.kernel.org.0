Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E291CB25B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgEHO5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgEHO5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 10:57:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE21FC061A0C;
        Fri,  8 May 2020 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LHxKO+UrbR4+N0mrKQD3SVjztItTGAPxETGyiyCS0KY=; b=tYAv3EZiihxSVIyjLOo2dQQ7a9
        Bl/iA0wlNBAcurTP2/8JqFqwEiJij4LmdgLOHMQW1Lqi6DFGUhEvTU/wyN4pbsTMjx2HcVm7FMqWY
        U6UXavvfgjdbsJPeDSfV9eG/eoVMrohfDnyXXrkH+oCnvAzZRsV/3dEgizbxIgBq9Uyl2OsTebpPY
        VJNy3L2drtIqgfxSpUiY77XbXu2bkKFIpuiq1WUgEXEiNd0ecij/1runxNHl3qoDntIuAxWCyn0t4
        0X7zDJQqo+b2dehNS/V0SXyaQ4Oet0TSd8ApfQsnfaVFKmWboZrCku77ZeD0E3VD9vwCVfWaHvLzt
        lXiahHTA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX4Qt-0002IW-AC; Fri, 08 May 2020 14:56:59 +0000
Date:   Fri, 8 May 2020 07:56:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH RFC 8/8] dcache: prevent flooding with negative dentries
Message-ID: <20200508145659.GQ16070@bombadil.infradead.org>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
 <158894061332.200862.9812452563558764287.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158894061332.200862.9812452563558764287.stgit@buzz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 03:23:33PM +0300, Konstantin Khlebnikov wrote:
> This patch implements heuristic which detects such scenarios and prevents
> unbounded growth of completely unneeded negative dentries. It keeps up to
> three latest negative dentry in each bucket unless they were referenced.
> 
> At first dput of negative dentry when it swept to the tail of siblings
> we'll also clear it's reference flag and look at next dentries in chain.
> Then kill third in series of negative, unused and unreferenced denries.
> 
> This way each hash bucket will preserve three negative dentry to let them
> get reference and survive. Adding positive or used dentry into hash chain
> also protects few recent negative dentries. In result total size of dcache
> asymptotically limited by count of buckets and positive or used dentries.
> 
> This heuristic isn't bulletproof and solves only most practical case.
> It's easy to deceive: just touch same random name twice.

I'm not sure if that's "easy to deceive" ... My concern with limiting
negative dentries is something like a kernel compilation where there
are many (11 for mm/mmap.c, 9 in general) and there will be a lot of
places where <linux/fs.h> does not exist

-isystem /usr/lib/gcc/x86_64-linux-gnu/9/include
-I../arch/x86/include
-I./arch/x86/include/generated
-I../include
-I./include
-I../arch/x86/include/uapi
-I./arch/x86/include/generated/uapi
-I../include/uapi
-I./include/generated/uapi
-I ../mm
-I ./mm

So it'd be good to know that kernel compilation times are unaffected by
this patch.
