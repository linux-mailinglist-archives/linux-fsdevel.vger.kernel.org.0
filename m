Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF5131A4AE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 21:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgDJT6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 15:58:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45133 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJT6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:58:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id w11so1380034pga.12;
        Fri, 10 Apr 2020 12:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9egYYB6bTrpDrTzttwKsxVc0B6/GRj6jRTmV+gtkQ74=;
        b=ksLeGT4QCxDaJyVKdpDPp6Us7KFo1tPlmwu1u1ufKBUXfRzPHzY5nQ45TD7ysVJB9D
         MNDE3UmKzHMcKaw9e4g/tGT11gH7F8WwsbCmGDKH3y/n1ttTZ+9UiJ03eRUqv/HxdQE2
         2SLuJ8o9MmAnikyYJxLUF5ZGDI/j2M2SIpmU8JRBpwf65Tb9b/xVjUxMnh0R5ulvyQg0
         VWcmp0HK9rl/pYcrEx+8cg68F+eKK3znJhaK0JXqWNPEbkY9qdZprjFne+G1prMlREzv
         Q3nHrdEA1Gb3nDQzR+q6d84fhr6AibEIPLP37arZhBV0DmLF9B4/jDFux1xmZQEApuMY
         9uNg==
X-Gm-Message-State: AGi0PuY/zoo5+v1dvX+qYDiyOgjQyRjmPH1dCmGsUtks4M125LNT5vDi
        7J9B6ovfj9ovQsBOlDoALIg=
X-Google-Smtp-Source: APiQypIkB3vH8LrSlvbH4JNkcEKZxJNCyG4NdBP0VvNLnRjmPqrr2Gra6b7M/BCoXvFMKaCfdh8HTg==
X-Received: by 2002:aa7:97a6:: with SMTP id d6mr6824993pfq.154.1586548688133;
        Fri, 10 Apr 2020 12:58:08 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q201sm2483234pfq.32.2020.04.10.12.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 12:58:05 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 12FD140630; Fri, 10 Apr 2020 19:58:05 +0000 (UTC)
Date:   Fri, 10 Apr 2020 19:58:05 +0000
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
Subject: Re: [RFC v2 2/5] blktrace: fix debugfs use after free
Message-ID: <20200410195805.GM11244@42.do-not-panic.com>
References: <20200409214530.2413-1-mcgrof@kernel.org>
 <20200409214530.2413-3-mcgrof@kernel.org>
 <88f94070-cd34-7435-9175-e0518a7d7db8@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88f94070-cd34-7435-9175-e0518a7d7db8@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 07:52:59PM -0700, Bart Van Assche wrote:
> On 2020-04-09 14:45, Luis Chamberlain wrote:
> > +void blk_q_debugfs_register(struct request_queue *q)
> > +{
> > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > +					    blk_debugfs_root);
> > +}
> > +
> > +void blk_q_debugfs_unregister(struct request_queue *q)
> > +{
> > +	debugfs_remove_recursive(q->debugfs_dir);
> > +	q->debugfs_dir = NULL;
> > +}
> 
> There are no other functions in the block layer that start with the
> prefix blk_q_. How about changing that prefix into blk_?

I the first patch already introduced blk_debugfs_register(), so I have
now changed the above to:

blk_debugfs_common_register()
blk_debugfs_common_unregister()

Let me know if something else is preferred.

> > -#ifdef CONFIG_BLK_DEBUG_FS
> > +#ifdef CONFIG_DEBUG_FS
> >  	struct dentry		*debugfs_dir;
> > +#endif
> 
> Please add a comment above 'debugfs_dir' that it is used not only by the
> code in block/blk-*debugfs.c but also by the code in
> kernel/trace/blktrace.c. Otherwise this patch looks good to me.

Sure, I'll do that.

In the future, after this patch set I'll follow up with another series
to clean that header file to make it easier to expand on proper
documentaiton with kdoc.

  Luis
