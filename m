Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2791F02EA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 00:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgFEWdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 18:33:23 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53539 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgFEWdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:33:23 -0400
Received: by mail-pj1-f65.google.com with SMTP id i12so3226555pju.3;
        Fri, 05 Jun 2020 15:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vS5y2cwTZmplrWxSMeAOvchEwRxJxoFyQaaO7U/jQTc=;
        b=APz7A3hHruHCdS2eSmB7nHEP33bYuNEdzA2Pq4h5F+mg3JmaGPtq7zeIrlHLlRyG8y
         kpLL/JnHAvmJHKfG8c1/QbdtPIgzGczSGXS3DdnyggiXEm0jYK9S4tMUrJZaT7AQJo6t
         u8LxagURiCOPMX2Lny8pNf5g23fgssAhQdxtyJGtKVa+K2YMtG+6YGwklgoBNL0pN9cA
         Ah9qLakvGGRbwpbDg3LspkIxaScYnJ164GzRYLMA6zOcxYHRhD0m8qRnIui3vIOqlxJe
         IGy+GrJrkmQdbTQCUXkl3SMn6BINMHSUhyPZ5NBhqFD9slkwImclp8yvi4tLcphJ5PqC
         YAPg==
X-Gm-Message-State: AOAM530u/tclCEXyv5tPzOHow2UVqV+zNalHmEwdVHsPBM3GkoawTeT8
        E4Yq5HnaZB6iU4A39/G1NXo=
X-Google-Smtp-Source: ABdhPJyajZB2ekSKunHZEPzroRX0GQ5Qx0oFeO/rItogtY+TqeixJGMKJYPif86T+TAP5R3klqe8dA==
X-Received: by 2002:a17:90a:6f04:: with SMTP id d4mr4924167pjk.134.1591396402606;
        Fri, 05 Jun 2020 15:33:22 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c1sm539415pfo.197.2020.06.05.15.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 15:33:21 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8E4B8403AB; Fri,  5 Jun 2020 22:33:20 +0000 (UTC)
Date:   Fri, 5 Jun 2020 22:33:20 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v5 5/7] blktrace: fix debugfs use after free
Message-ID: <20200605223320.GN11244@42.do-not-panic.com>
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-6-mcgrof@kernel.org>
 <20200519163713.GA29944@infradead.org>
 <20200527031202.GT11244@42.do-not-panic.com>
 <20200601170500.GF13911@42.do-not-panic.com>
 <d4ef5da1-7d11-657c-f864-8b2ca6ea082c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ef5da1-7d11-657c-f864-8b2ca6ea082c@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 04, 2020 at 09:48:43PM -0700, Bart Van Assche wrote:
> On 2020-06-01 10:05, Luis Chamberlain wrote:
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > index a55cbfd060f5..5b0310f38e11 100644
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -511,6 +511,11 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> >  	 */
> >  	if (bdev && bdev != bdev->bd_contains) {
> >  		dir = bdev->bd_part->debugfs_dir;
> > +	} else if (q->sg_debugfs_dir &&
> > +		   strlen(buts->name) == strlen(q->sg_debugfs_dir->d_name.name)
> > +		   && strcmp(buts->name, q->sg_debugfs_dir->d_name.name) == 0) {
> > +		/* scsi-generic requires use of its own directory */
> > +		dir = q->sg_debugfs_dir;
> >  	} else {
> >  		/*
> >  		 * For queues that do not have a gendisk attached to them, that
> > 
> 
> Please Cc Martin Petersen for patches that modify SCSI code.

Sure thing.
> The string comparison check looks fragile to me. Is the purpose of that

> check perhaps to verify whether tracing is being activated through the
> SCSI generic interface?

Yes.

> If so, how about changing that test into
> something like the following?
> 
> 	MAJOR(dev) == SCSI_GENERIC_MAJOR

Sure.

  Luis
