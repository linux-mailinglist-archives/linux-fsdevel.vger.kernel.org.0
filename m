Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C911AB73A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 07:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406433AbgDPFZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 01:25:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43448 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406053AbgDPFZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:25:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id x26so1098904pgc.10;
        Wed, 15 Apr 2020 22:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kg7nI0Dukhm7hME7k56vQQPnaqgMUKpXaW8k038CnpY=;
        b=N6fkaAenH6mBP6CkcCtj9a4W+2OlFJTtDFNRthR3NlRm3SbO0B6hoC4WOAzlSveL4g
         prde5eX4LJNP6jgCrsJinl45EAjlNsA7gEFDNJAPwhtk5qYWUwVryVE4NFXwG2uGIfar
         J+Qg2h1PMtN5ulhw1auo/K1Aa9VdFq/2IibiW+7iYXXuYHpc4VVlW/Y26vk2Gx2+8VKA
         yoSruUgKxo2AOECVAvELY2nBGmjkA2z1jFcvdB+51rWeTrjWQCkJEM4YUr/DD5b6jXx0
         PaRT3wo8AVcVR7stvsBv5M0ZsZl03U3/JD2am1nlFOTHboThwKY6eV+6q8kJkOAj6cKu
         WQMA==
X-Gm-Message-State: AGi0PuamD27zH4Z1x6rDUhu29zrt9HmHh16hvpnmpejNIbs65dWtered
        WvZr+qW7pcFsjefp4LN7gEg=
X-Google-Smtp-Source: APiQypIg+I4iUy63S0mBZ7fWRB3nVMRCNRDUKQvXsu0TEmZwpSFoQiVN/BIM0RYKLVeyKWhDUMDDWg==
X-Received: by 2002:a62:2a8c:: with SMTP id q134mr32437286pfq.35.1587014726673;
        Wed, 15 Apr 2020 22:25:26 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b13sm6005334pfo.67.2020.04.15.22.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 22:25:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C8C0340277; Thu, 16 Apr 2020 05:25:24 +0000 (UTC)
Date:   Thu, 16 Apr 2020 05:25:24 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/5] blktrace: fix debugfs use after free
Message-ID: <20200416052524.GH11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-3-mcgrof@kernel.org>
 <20200416021036.GA2717677@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416021036.GA2717677@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 10:10:36AM +0800, Ming Lei wrote:
> In theory, multiple partitions can be traced concurrently, but looks
> it never works, so it won't cause trouble for multiple partition trace.
> 
> One userspace visible change is that blktrace debugfs dir name is switched 
> to disk name from partition name in case of partition trace, will it
> break some utilities?

How is this possible, its not clear to me, we go from:

-	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
-					    blk_debugfs_root);

To this:

+	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
+					    blk_debugfs_root);


Maybe I am overlooking something.

  Luis
