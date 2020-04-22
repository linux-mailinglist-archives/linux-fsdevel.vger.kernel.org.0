Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871EA1B3951
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgDVHsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 03:48:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36660 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgDVHsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:48:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id g30so671510pfr.3;
        Wed, 22 Apr 2020 00:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+SMYq/4vJ74M0LfJtwun4BRKxfhWvtLo+wkfl9OYurc=;
        b=aXiZj2rZEHQUVuS1IPtOwokWeWWRiskWQUgYfqeeF8bakjcUajCkH6RwRIMzjzFNXw
         AvIfkFtHxgV3KLWzr0cXx0+U+o7atpgw40kGNFLCjqNWROrQdXM4sIBf/BHwdsT2Ymun
         Cuk+K5FxNxnHVAHfN2nvI4uHAt6H5dUjzpsrJjW2ByTvpm1UDx5ZR3F1IIemSQH5S2mr
         swCCIOAY3dkJhKdVxwL+0LC4KehjL4LmlAOyssagovXZ6gWA5xUN0pKxvHqoYunFFd7l
         4DzHLjeYD02OB4YiG+pnROz01vkanXtGYUKf3B9r2ovAdO/4WFSv+/6Ci7R+4pqB++3y
         JsmA==
X-Gm-Message-State: AGi0PubOvXnSfmfOnPltDzmoH8XPU5yiK502xUeQeErw7pkL0d6wBozu
        ilpbappA6Ru6AImLcSapfLA=
X-Google-Smtp-Source: APiQypLRQPdTJrBV6I/vZtyxwxFN1GzQ0y7RzxhSMbXI2z5hooPeifS431qso2u8rbsgVBHwKEY4Bw==
X-Received: by 2002:a63:6f07:: with SMTP id k7mr26600891pgc.274.1587541684638;
        Wed, 22 Apr 2020 00:48:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id fh18sm16882435pjb.0.2020.04.22.00.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 00:48:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D50C1402A1; Wed, 22 Apr 2020 07:48:02 +0000 (UTC)
Date:   Wed, 22 Apr 2020 07:48:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
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
Message-ID: <20200422074802.GS11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <20200422072715.GC19116@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422072715.GC19116@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:27:15AM -0700, Christoph Hellwig wrote:
> On Sun, Apr 19, 2020 at 07:45:22PM +0000, Luis Chamberlain wrote:
> > +{
> > +	struct dentry *dir = NULL;
> > +
> > +	/* This can happen if we have a bug in the lower layers */
> > +	dir = debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root);
> > +	if (dir) {
> > +		pr_warn("%s: registering request_queue debugfs directory twice is not allowed\n",
> > +			kobject_name(q->kobj.parent));
> > +		dput(dir);
> > +		return -EALREADY;
> > +	}
> 
> I don't see why we need this check.  If it is valueable enough we
> should have a debugfs_create_dir_exclusive or so that retunrns an error
> for an exsting directory, instead of reimplementing it in the caller in
> a racy way.  But I'm not really sure we need it to start with.

In short races, and even with synchronous request_queue removal I'm
seeing the race is still possible, but that's due to some other races
I'm going to chase down now.

The easier solution really is to just have a debugfs dir created for
each partition if debugfs is enabled, this way the directory will
always be there, and the lookups are gone.

> > +
> > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > +					    blk_debugfs_root);
> > +	if (!q->debugfs_dir)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> > +void blk_queue_debugfs_unregister(struct request_queue *q)
> > +{
> > +	debugfs_remove_recursive(q->debugfs_dir);
> > +	q->debugfs_dir = NULL;
> > +}
> 
> Which to me suggests we can just fold these two into the callers,
> with an IS_ENABLED for the creation case given that we check for errors
> and the stub will always return an error.

Sorry not sure I follow this.

> >  	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
> >  
> >  	/*
> > @@ -856,9 +853,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
> >  
> >  void blk_mq_debugfs_unregister(struct request_queue *q)
> >  {
> > -	debugfs_remove_recursive(q->debugfs_dir);
> >  	q->sched_debugfs_dir = NULL;
> > -	q->debugfs_dir = NULL;
> >  }
> 
> This function is weird - the sched dir gets removed by the
> debugfs_remove_recursive, so just leaving a function that clears
> a pointer is rather odd.  In fact I don't think we need to clear
> either sched_debugfs_dir or debugfs_dir anywhere.

Indeed. Will clean it up.

> > @@ -975,6 +976,14 @@ int blk_register_queue(struct gendisk *disk)
> >  		goto unlock;
> >  	}
> >  
> > +	ret = blk_queue_debugfs_register(q);
> > +	if (ret) {
> > +		blk_trace_remove_sysfs(dev);
> > +		kobject_del(&q->kobj);
> > +		kobject_put(&dev->kobj);
> > +		goto unlock;
> > +	}
> > +
> 
> Please use a goto label to consolidate the common cleanup code.

Sure.

> Also I think these generic debugfs changes probably should be separate
> to the blktrace changes.

I'll try to do that.

> >  static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
> > +					    struct request_queue *q,
> >  					    struct blk_trace *bt)
> >  {
> >  	struct dentry *dir = NULL;
> >  
> > +	/* This can only happen if we have a bug on our lower layers */
> > +	if (!q->kobj.parent) {
> > +		pr_warn("%s: request_queue parent is gone\n", buts->name);
> > +		return NULL;
> > +	}
> 
> Why is this not simply a WARN_ON_ONCE()?

I'll actually remove it and instead fix the race where it happens.

> > +	if (blk_trace_target_disk(buts->name, kobject_name(q->kobj.parent))) {
> > +		if (!q->debugfs_dir) {
> > +			pr_warn("%s: expected request_queue debugfs_dir is not set\n",
> > +				buts->name);
> > +			return NULL;
> > +		}
> > +		/*
> > +		 * debugfs_lookup() is used to ensure the directory is not
> > +		 * taken from underneath us. We must dput() it later once
> > +		 * done with it within blktrace.
> > +		 */
> > +		dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > +		if (!dir) {
> > +			pr_warn("%s: expected request_queue debugfs_dir dentry is gone\n",
> > +				buts->name);
> > +			return NULL;
> > +		}
> > +		 /*
> > +		 * This is a reaffirmation that debugfs_lookup() shall always
> > +		 * return the same dentry if it was already set.
> > +		 */
> > +		if (dir != q->debugfs_dir) {
> > +			dput(dir);
> > +			pr_warn("%s: expected dentry dir != q->debugfs_dir\n",
> > +				buts->name);
> > +			return NULL;
> > +		}
> > +		bt->backing_dir = q->debugfs_dir;
> > +		return bt->backing_dir;
> > +	}
> 
> Even with the gigantic commit log I don't get the point of this
> code.  It looks rather sketchy and I can't find a rationale for it.

Yeah I think this is going to be much easier on the eyes with the
revert to synchronous request_queue removal first.

  Luis
