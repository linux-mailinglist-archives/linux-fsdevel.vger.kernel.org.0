Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17A6B5DA39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 03:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfGCBFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 21:05:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32921 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfGCBFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:05:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so377759edq.0;
        Tue, 02 Jul 2019 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pi01KzgEdIhGIrXlu8OB1kwQXoOUnrYPaRcf2PLxb/U=;
        b=rBDl/pv0TR7OXoDLtY4qDwH4O3XAyoj4V0fiUbjGY2+xdzLZWxDB/TZMz91zWAQJlx
         8zBLKP1eFkYs4j9t8Da2yciljUcB9aURJx3yWKCgQzqh66D6c/8XKo5SyexehiKWyNOp
         ZWrYiq6dCaMItTH8MUNzgLBpTC7SCEuWXRPVvUjJ3B2z/XeOIcg0lCgVCD5f9hyeQDXt
         mZ7b3IqG9l4uy2f1st4KIqnXHTMMEZdmsemj1i0fq9Y3AWXJ/MHhJJ7Dot+zWlOQOgdn
         BcDXqV/O64Z5CiU1FS45nsKgYBjhkzK/mdulCD7+pePhPoSvgHgclOTmd+WheWRCDmAe
         BCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pi01KzgEdIhGIrXlu8OB1kwQXoOUnrYPaRcf2PLxb/U=;
        b=r7CTgElxJYLXXsm61ybKzVBjBzcvA9nIDAX9d6c9BqirffFfjiIWd/Lsg0+Bfc2+eV
         y5VXzrdL9VUMLUQnEYxL+stD31jbYx6EhWBUoPX4NyB5rrCfhb9Ac1ieuloHaVyi4Gxx
         6NB48Jd7NJfZatHwZJcWVK49+BrqJT8DxoX4eZCNCtNFS+wOxjs8xDMtJARJ1M0EB9re
         8rR964zBPzbpT7vlyP4JBgOiDaVjkNrFQKDcE/7xqvI0drdEiLlPS2tx4qxVvMMTMNSR
         csMqfJ2p+hVButcnxikfTN8UCJrAuNPpgOncGYNt+jeQ76RQYltV8ViHQtta38KK/wRz
         2Wbg==
X-Gm-Message-State: APjAAAVdKorEDLo0QlmVJ8atakZJmb+ScuwVmf9SLuLVA1aDVnZt0DsI
        bchqicUK/dq+VWqibTTa/Hk=
X-Google-Smtp-Source: APXvYqx42CglJVsr1ZJyV/elcgmcFYXinubcozjroo+1Dkc9XOZY8Eq/do5QH5nMOg/YC2Qtqrn5Gg==
X-Received: by 2002:aa7:ca54:: with SMTP id j20mr39393692edt.50.1562115901344;
        Tue, 02 Jul 2019 18:05:01 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.gmail.com with ESMTPSA id p23sm136538ejl.43.2019.07.02.18.04.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 18:05:00 -0700 (PDT)
Subject: [PATCH] mm: Support madvise_willneed override by Filesystems
To:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Amir Goldstein <amir73il@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel>
 <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel>
 <20190612230224.GJ14308@dread.disaster.area>
 <20190619082141.GA32409@quack2.suse.cz>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <27171de5-430e-b3a8-16f1-7ce25b76c874@gmail.com>
Date:   Wed, 3 Jul 2019 04:04:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619082141.GA32409@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/06/2019 11:21, Jan Kara wrote:
<>
> Yes, I have patch to make madvise(MADV_WILLNEED) go through ->fadvise() as
> well. I'll post it soon since the rest of the series isn't really dependent
> on it.
> 
> 								Honza
> 

Hi Jan

Funny I'm sitting on the same patch since LSF last. I need it too for other
reasons. I have not seen, have you pushed your patch yet?
(Is based on old v4.20)

~~~~~~~~~
From fddb38169e33d23060ddd444ba6f2319f76edc89 Mon Sep 17 00:00:00 2001
From: Boaz Harrosh <boazh@netapp.com>
Date: Thu, 16 May 2019 20:02:14 +0300
Subject: [PATCH] mm: Support madvise_willneed override by Filesystems

In the patchset:
	[b833a3660394] ovl: add ovl_fadvise()
	[3d8f7615319b] vfs: implement readahead(2) using POSIX_FADV_WILLNEED
	[45cd0faae371] vfs: add the fadvise() file operation

Amir Goldstein introduced a way for filesystems to overide fadvise.
Well madvise_willneed is exactly as fadvise_willneed except it always
returns 0.

In this patch we call the FS vector if it exists.

NOTE: I called vfs_fadvise(..,POSIX_FADV_WILLNEED);
      (Which is my artistic preference)

I could also selectively call
	if (file->f_op->fadvise)
		return file->f_op->fadvise(..., POSIX_FADV_WILLNEED);
If we fear theoretical side effects. I don't mind either way.

CC: Amir Goldstein <amir73il@gmail.com>
CC: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 mm/madvise.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 6cb1ca93e290..6b84ddcaaaf2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -24,6 +24,7 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
+#include <linux/fadvise.h>
 
 #include <asm/tlb.h>
 
@@ -303,7 +304,8 @@ static long madvise_willneed(struct vm_area_struct *vma,
 		end = vma->vm_end;
 	end = ((end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 
-	force_page_cache_readahead(file->f_mapping, file, start, end - start);
+	vfs_fadvise(file, start << PAGE_SHIFT, (end - start) << PAGE_SHIFT,
+		    POSIX_FADV_WILLNEED);
 	return 0;
 }
 
-- 
2.20.1

