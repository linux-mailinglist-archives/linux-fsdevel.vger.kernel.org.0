Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D747844E4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 23:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfFMVVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 17:21:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38575 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMVVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:21:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so124442qtl.5;
        Thu, 13 Jun 2019 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0v9rxXyrt/oumJFTrMOMHu3FGLQRsByRDgIPJ5m2WUM=;
        b=Me7H5hQMJp+1aqQY871nL/yGYHiEW3+3jRaGCeh7r+zYK3eiFxCnxKRX/upZFMVYPH
         NteppeHTQhEa3ig7TTzs4yNey69twkZqavgykh02bU0dXhKJl8A0x9bOcRa1hLYjQrIv
         ABytd1Ba79nQ563JVsuf/6H0WItrCf87YPqskbKzxXhGSVcvCzP285AtXvXAkZ8Ppbou
         z+ILwFeQqPOe/SgatiHuX75oZUlzHzLh7JhWayOsgRyvDOmta+RMKRzS38f7SoV9DqpL
         IiQScCueUo3LYPTW9KAMm1ufW10vyHpUqX7K/HvFtXxzExQrSLvBVczilDphPTczzn9C
         6Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0v9rxXyrt/oumJFTrMOMHu3FGLQRsByRDgIPJ5m2WUM=;
        b=nmMlq3QpnuJBCCZL3u/D9niKqFivQFnCuQwNGdGqywj6OpphJOKgX8bNilW5SRA+At
         3wLu4lhSM+CEe+nRMvUCnuKHO6Jxfp7RNtmsrNWx0Ed+QvW8zK6Cy8BTAghyEdPG4hI4
         hEVSLSOefCJ3V0lH7EI1JCnVegMayWi1lmLGppEbBHdD9czOo9kP+uPjIYohPoaXI+zw
         PSqZTGops/VXj49yuhtWUNt5RY0lz6yAs3UjNL3iiKGcTVjGca3PIKNI0muvd/dT8GsW
         z7VFAX5iAoQRqCoyxCVOweGhJehSstyCWaKEshmh7UaU2DsyfJ4x1h2SJJ/jpPUqyF+8
         Tbqw==
X-Gm-Message-State: APjAAAXZKpPMo9aLn3bh+adg3NB93uwh3gExXy7k5DQW/Uu/kB/U+UAY
        TxIT9VmlEQN8gPQD84lMag==
X-Google-Smtp-Source: APXvYqzkZ3YHHNI5sQCGFJfB3JVDieHfRZzEtq80wOh7IQh3p4yzZG5ow375+4MQgtf2N1HoAkHMow==
X-Received: by 2002:ac8:70cd:: with SMTP id g13mr9927363qtp.325.1560460875422;
        Thu, 13 Jun 2019 14:21:15 -0700 (PDT)
Received: from kmo-pixel (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id y20sm551232qka.14.2019.06.13.14.21.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 14:21:14 -0700 (PDT)
Date:   Thu, 13 Jun 2019 17:21:12 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: pagecache locking (was: bcachefs status update) merged)
Message-ID: <20190613212112.GB28171@kmo-pixel>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel>
 <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel>
 <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel>
 <AE838C22-1A11-4F93-AB88-80CF009BD301@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AE838C22-1A11-4F93-AB88-80CF009BD301@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:13:40PM -0600, Andreas Dilger wrote:
> There are definitely workloads that require multiple threads doing non-overlapping
> writes to a single file in HPC.  This is becoming an increasingly common problem
> as the number of cores on a single client increase, since there is typically one
> thread per core trying to write to a shared file.  Using multiple files (one per
> core) is possible, but that has file management issues for users when there are a
> million cores running on the same job/file (obviously not on the same client node)
> dumping data every hour.

Mixed buffered and O_DIRECT though? That profile looks like just buffered IO to
me.

> We were just looking at this exact problem last week, and most of the threads are
> spinning in grab_cache_page_nowait->add_to_page_cache_lru() and set_page_dirty()
> when writing at 1.9GB/s when they could be writing at 5.8GB/s (when threads are
> writing O_DIRECT instead of buffered).  Flame graph is attached for 16-thread case,
> but high-end systems today easily have 2-4x that many cores.

Yeah I've been spending some time on buffered IO performance too - 4k page
overhead is a killer.

bcachefs has a buffered write path that looks up multiple pages at a time and
locks them, and then copies the data to all the pages at once (I stole the idea
from btrfs). It was a very significant performance increase.

https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/fs-io.c#n1498
