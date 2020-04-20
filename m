Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C841B1506
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 20:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgDTSqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 14:46:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40763 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgDTSqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:46:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id x3so5370391pfp.7;
        Mon, 20 Apr 2020 11:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Io2UxyXTaCPuKOP2Bcw5aenPOuxwH4U0YvtYfrCaCI=;
        b=X4YGDPTBKHqEefDhOrWLLqydfcx/aT4LCN3ygNUl4916NriKSbQKk4X8DDrHTrUFQx
         me5JhrSS03ekaJsuUNJsFBrTxeG1InxTcdUZr4DCx0xi3plIP2TKtA66wLZYUV/EtKC5
         xzzy/FvrbAmh/SA68qKoWlAPKOqBKa08PnyQk2+w75/D6ostx2t399oC/Jk2ZLRvOlse
         BP7rihnHp7dBEPrcfTXm1BHlssKVwVZgyrfPLhI2fwf4/A27baHha+NphLBxsOJXxuS5
         DPvri22IcgZi5NBZ4ohB7ZEKNFg8KjwWsHyGgjrK3xltFbdiC8eIMzLhcIc4pDx4MaHq
         fY2Q==
X-Gm-Message-State: AGi0PuYgtF78Q91Wdb0wIivJpmdPVdt7EJWlOuYYWmhtaTwJkl71rw3H
        ZyFpqLPSnJFJqhqlJzoqW5U=
X-Google-Smtp-Source: APiQypI6Vlthr/j9m1nHRSqAt0W3ii5OsrFyBv0qofjqF/joa/2eogFginfYqIUYfb7fmsyKSIjB/w==
X-Received: by 2002:a63:8b44:: with SMTP id j65mr17495589pge.411.1587408368815;
        Mon, 20 Apr 2020 11:46:08 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g11sm86161pjs.17.2020.04.20.11.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:46:07 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2E8454028E; Mon, 20 Apr 2020 18:46:07 +0000 (UTC)
Date:   Mon, 20 Apr 2020 18:46:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 03/10] blktrace: fix debugfs use after free
Message-ID: <20200420184607.GL11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <91c82e6a-24ce-0b7d-e6e4-e8aa89f3fb79@acm.org>
 <20200420000436.GI11244@42.do-not-panic.com>
 <b77a39c1-6010-24a4-0815-2f26664b6208@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b77a39c1-6010-24a4-0815-2f26664b6208@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 05:38:59PM -0700, Bart Van Assche wrote:
> On 4/19/20 5:04 PM, Luis Chamberlain wrote:
> > > Independent of what the purpose of the above code is, can that code be
> > > rewritten such that it does not depend on the details of how names are
> > > assigned to disks and partitions? Would disk_get_part() be useful here?
> > 
> > I did try, but couldn't figure out a way. I'll keep looking but likewise
> > let me know if you find a way.
> 
> How about making blk_trace_setup() pass the result of the following
> expression as an additional argument to blk_trace_setup():
> 
> 	bdev != bdev->bd_contains
> 
> I think that is a widely used approach to verify after a block device has
> been opened whether or not 'bdev' refers to a partition (bdev !=
> bdev->bd_contains means that 'bdev' represents a partition).

Sweet, that should simplify this considerbly, thanks!

  Luis
