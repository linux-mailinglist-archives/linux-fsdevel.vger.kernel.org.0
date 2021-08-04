Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCCC3E02CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 16:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbhHDOIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 10:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbhHDOIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:08:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73390C061798
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Aug 2021 07:08:02 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e5so2710235ljp.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K/1hIIUEbQdHadT/oKJrFQyOilzrUMQ7JriDO/PKmP8=;
        b=CaIy+F5QRGQNevDHXpZTxRH9bA5lR5VAY+6czcBCluc2KlshpMtIkz6lJO5mTRFBnp
         CDutMw01CD2gBZJVoGw5xFXSP+SIgZ0OE74wyP1Bqja2c5LX+ln6tCnOU+MMAUgBKZ7q
         QMxwyN0CvQwPLgGpmNruGFTz77WxXHSfdFzCL9vxOivXEZASS+B74Wrq8/7pkx6hzB1x
         Y13UHB3EssNVwX8LfkUhrivXHqtnvGWf/FRKLDCMDKjQbJOnSM4EsXnfNOXRDtOcPTVy
         gYXducqSiF8TDOpa8S7Q/rvzdvyay09xA1jdaWHZ3ao+zop8j8e4ADNtyLF5jAeLvBzR
         +wfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K/1hIIUEbQdHadT/oKJrFQyOilzrUMQ7JriDO/PKmP8=;
        b=lbIBRHQ3shnJsG62GVdbQdRXomPUs9X1JA8htTB3RjgoXY9FYw6EASiVyMH6TprH4l
         +s9OqaU0q8KFLqv7PAKEOgLRoQjU9DVadsdmBCiEBMn7MUU6OpJ/5KBTvlQXYLFE8eTg
         xZEF3SlmykSMYYHQenLsbQ7oc48gtRobm+1xBCoq6c3Qcu/Mls9b5areUqoEkBo0r1j/
         +5LxbQ1E4qTi/kYIE5mJAo43IMOARKp3hQQ4VnHveNwD9UjFLX3p4TyLC60/oygSJjpe
         7C62LxW+cZXyl1iJFZQLwx7a12PW+u8uL1VPZFxJoq18p/P+PSaDGBdafcjsTt/v1/e4
         GNiw==
X-Gm-Message-State: AOAM531Y4i6RpYNWPNbFHjWxiHQGCkuZswU2F6t1Hba6jNrucK+8iJbl
        3l7Pw3MYr5jkMbkXciFhawuJLw==
X-Google-Smtp-Source: ABdhPJxnNNRjudOBH+EC3ggdRmxYH3p0MEAw3+OrnckCUVM8V25244yYm95tjjoSqYZ64sniZmicUw==
X-Received: by 2002:a2e:9241:: with SMTP id v1mr17640443ljg.48.1628086080453;
        Wed, 04 Aug 2021 07:08:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r8sm168037ljn.52.2021.08.04.07.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:07:59 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 15382102BC1; Wed,  4 Aug 2021 17:08:05 +0300 (+03)
Date:   Wed, 4 Aug 2021 17:08:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/16] huge tmpfs: fcntl(fd, F_HUGEPAGE) and fcntl(fd,
 F_NOHUGEPAGE)
Message-ID: <20210804140805.vpuerwaiqtcvc5or@box.shutemov.name>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
 <1c32c75b-095-22f0-aee3-30a44d4a4744@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c32c75b-095-22f0-aee3-30a44d4a4744@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 12:48:33AM -0700, Hugh Dickins wrote:
> Add support for fcntl(fd, F_HUGEPAGE) and fcntl(fd, F_NOHUGEPAGE), to
> select hugeness per file: useful to override the default hugeness of the
> shmem mount, when occasionally needing to store a hugepage file in a
> smallpage mount or vice versa.

Hm. But why is the new MFD_* needed if the fcntl() can do the same.

> These fcntls just specify whether or not to try for huge pages when
> allocating to the object later: F_HUGEPAGE does not touch small pages
> already allocated (though khugepaged may do so when the file is mapped
> afterwards), F_NOHUGEPAGE does not split huge pages already allocated.
> 
> Why fcntl?  Because it's already in use (for sealing) on memfds; and I'm
> anxious to keep this simple, just applying it to whole files: fallocate,
> madvise and posix_fadvise each involve a range, which would need a new
> kind of tree attached to the inode for proper support.

Most of fadvise() operations ignore the range. I like fadvise() because
it's less prescriptive: kernel is free to ignore it.

-- 
 Kirill A. Shutemov
