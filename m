Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009FE243801
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 11:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMJxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 05:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMJxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:53:33 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1C4C061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 02:53:33 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id q16so2983052ybk.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yul9D5KaapMfO0wSYYumb3nXfH25wAQuTtPB6LytFFQ=;
        b=g4mDUYV/kR2xqvMovbB9tOP1UwfQk6O047mQnaEfU/wAgqPu1NK8GhI6gfzcY5gZQ3
         kZdFLbxgB7OqRvASEeMmcEe99LPAOZaz1kZskBXb/8XLTVke3a8uOYyXOpCAh4FedTtR
         9E7hUlfMGcRn3WfwvWi5YlF/FOSHG3E+wgdpSgj+p9Y2eLtGyRueVDENXxuIaA1s3otY
         fFOfdc7Cz1qEY35Es+aJJFSnpioiFZWGZk+LMsIWu/gGIUaAk2if4K2HJi4QVVS8cDdU
         ckMfr+jW5QSRMSVhuiCR8ex32+qd5wmgdgLepZcJIB/BCSs6gIOX0NPYuRcry/7YIAgL
         JPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yul9D5KaapMfO0wSYYumb3nXfH25wAQuTtPB6LytFFQ=;
        b=Qve9fLV82BUXenIbrdEtVLsQapQV6vbJ67Ex/5/hcsnwb2Uxhxd3Ul9YPEb/UJey9K
         XWwcg6+0i81qBs4vT/lv3iITB2QBi1D/VjJOkM5JfsxuyKQBg7C9gRvPnaPEmRgzlcqh
         lRDw+N1qKFmAQeGHGJRQQiUcvXulh3vt94F+SUYcsw5KpwLLp8PUn1aszIpmLvL4+iUv
         xMWBzwZq51Bv/mLZQ8e64+sm0dv5vkfQOBuHvhlQ+4cy++4kiH6fzsuP5xdIDJ3E8K+D
         Pxzn6RoJExjnloljZUlRzggkyndOsIkoAK3/wPfS4o/9dheBdIYB7iVDOO2vHM6A4WCI
         m5pQ==
X-Gm-Message-State: AOAM530y9R/IDcmehVQmqTT475gFKcpNQ8OcPTH7p6qajW322uGLI1QN
        eDkeK9NQiLsQUqpAaLvPrRYKQSPk9gexrscL7gLkxQ==
X-Google-Smtp-Source: ABdhPJzfpaSBTx1xrZzflOrcYcv5QD4lOFsRlbhX3DHwVGqruN6Tmp191fs//DhyO/wYUtsNm9az23vyctAAcFPz7n0=
X-Received: by 2002:a25:ab34:: with SMTP id u49mr5170276ybi.516.1597312412264;
 Thu, 13 Aug 2020 02:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com>
In-Reply-To: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 13 Aug 2020 02:53:20 -0700
Message-ID: <CANN689G0DkL-wpxMha=nyysPYG6LM3Aw7060k2xQTxTA4PAf-w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Try to release mmap_lock temporarily in smaps_rollup
To:     Chinwen Chang <chinwen.chang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 7:14 PM Chinwen Chang
<chinwen.chang@mediatek.com> wrote:
> Recently, we have observed some janky issues caused by unpleasantly long
> contention on mmap_lock which is held by smaps_rollup when probing large
> processes. To address the problem, we let smaps_rollup detect if anyone
> wants to acquire mmap_lock for write attempts. If yes, just release the
> lock temporarily to ease the contention.
>
> smaps_rollup is a procfs interface which allows users to summarize the
> process's memory usage without the overhead of seq_* calls. Android uses it
> to sample the memory usage of various processes to balance its memory pool
> sizes. If no one wants to take the lock for write requests, smaps_rollup
> with this patch will behave like the original one.
>
> Although there are on-going mmap_lock optimizations like range-based locks,
> the lock applied to smaps_rollup would be the coarse one, which is hard to
> avoid the occurrence of aforementioned issues. So the detection and
> temporary release for write attempts on mmap_lock in smaps_rollup is still
> necessary.

I do not mind extending the mmap lock API as needed. However, in the
past I have tried adding rwsem_is_contended to mlock(), and later to
mm_populate() paths, and IIRC gotten pushback on it both times. I
don't feel strongly on this, but would prefer if someone else approved
the rwsem_is_contended() use case.

Couple related questions, how many VMAs are we looking at here ? Would
need_resched() be workable too ?

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
