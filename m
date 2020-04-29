Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B9D1BDAED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgD2Lpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 07:45:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41336 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2Lpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:45:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id d24so746467pll.8;
        Wed, 29 Apr 2020 04:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mT5Z8qNqQ+AcBEqStzPHJNFT7xvT58WmUFXj+uz8ENw=;
        b=PQY+SYMlY1rPDbYAFRv/+Ziv8QN8sUr8Jp7RmQnyXY/weHGE2VEquH3wxkw3tNOzG7
         N1Zg/N37xVdHgodkEnbhoFUElnatz2lEyHwYJHPtjtx8lQk6ES7BLrZyq9V2I+m2F8vo
         52nvKTUktQnEcS8F48pGxLyEWL3/+sOrfJY1RHpWE8xvUbSaQXeZL5Uu+MlCFPJ9OHOH
         omYc6k1qWHp3oeerwG5CEOHfFMyyR1zY88GtVgbJGZVVq2JEFaAhb/v7w8+D8OwQ05qP
         BlASzmc3gqr71NAG2Zwc5tmxnwczhPnpD15haDqZ5Dl+R13qw315j4XTBvao+r1eH0uw
         hcHA==
X-Gm-Message-State: AGi0PuYuHDTJ6EJMqkczPmVxk/sO8VruKaX7hKkQHPXfkALDrhiiRNeG
        iV1yptB5p541/1WJ2c0xg6Q=
X-Google-Smtp-Source: APiQypIOvFFBsXlgaoYDJnpshsiDSFtn+ydVciDyw+1/YHZGH/+uxaJ5/jJ6qSPm43haEY/HT4nkoA==
X-Received: by 2002:a17:90a:ead6:: with SMTP id ev22mr2749372pjb.94.1588160744731;
        Wed, 29 Apr 2020 04:45:44 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h193sm1001007pfe.30.2020.04.29.04.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 04:45:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A8F8E403AB; Wed, 29 Apr 2020 11:45:42 +0000 (UTC)
Date:   Wed, 29 Apr 2020 11:45:42 +0000
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
Subject: Re: [PATCH v3 4/6] blktrace: fix debugfs use after free
Message-ID: <20200429114542.GJ11244@42.do-not-panic.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-5-mcgrof@kernel.org>
 <20200429112637.GD21892@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429112637.GD21892@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:26:37AM -0700, Christoph Hellwig wrote:
> I can't say I'm a fan of all these long backtraces in commit logs..
> 
> > +static struct dentry *blk_debugfs_dir_register(const char *name)
> > +{
> > +	return debugfs_create_dir(name, blk_debugfs_root);
> > +}
> 
> I don't think we really need this helper.

We don't export blk_debugfs_root, didn't think we'd want to, and
since only a few scew funky drivers would use the struct gendisk
and also support BLKTRACE, I didn't think we'd want to export it
now.

A new block private symbol namespace alright?

> > +void blk_part_debugfs_unregister(struct hd_struct *p)
> > +{
> > +	debugfs_remove_recursive(p->debugfs_dir);
> > +	p->debugfs_dir = NULL;
> > +}
> 
> Why do we need to clear the pointer here?

True, not needed for partition.

> > +#ifdef CONFIG_DEBUG_FS
> > +	/* Currently only used by kernel/trace/blktrace.c */
> > +	struct dentry *debugfs_dir;
> > +#endif
> 
> Does that comment really add value?

I'll nuke it.

> > +static struct dentry *blk_trace_debugfs_dir(struct block_device *bdev,
> > +					    struct request_queue *q)
> >  {
> > +	struct hd_struct *p = NULL;
> >  
> > +	 * Some drivers like scsi-generic use a NULL block device. For
> > +	 * other drivers when bdev != bdev->bd_contain we are doing a blktrace
> > +	 * on a parition, otherwise we know we are working on the whole
> > +	 * disk, and for that the request_queue already has its own debugfs_dir.
> > +	 * which we have been using for other things other than blktrace.
> > +	 */
> > +	if (bdev && bdev != bdev->bd_contains)
> > +		p = bdev->bd_part;
> >  
> > +	if (p)
> > +		return p->debugfs_dir;
> > +
> > +	return q->debugfs_dir;
> 
> This could be simplified down to:
> 
> 	if (bdev && bdev != bdev->bd_contains)
> 		return bdev->bd_part->debugfs_dir;
> 	return q->debugfs_dir;
>
> Given that bd_part is in __blkdev_get very near bd_contains.

Ah neat.

> Also given that this patch completely rewrites blk_trace_debugfs_dir is
> there any point in the previous patch?

Still think it helps with making this patch easier to read, but I don't
care, lemme know if I should just fold it.

> > @@ -491,6 +500,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> >  	struct dentry *dir = NULL;
> >  	int ret;
> >  
> > +
> >  	if (!buts->buf_size || !buts->buf_nr)
> >  		return -EINVAL;
> >  
> 
> Spurious whitespace change.

Will nuke.

  Luis
