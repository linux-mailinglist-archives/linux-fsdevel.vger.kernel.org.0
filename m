Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0261BDB4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgD2MCe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 08:02:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46661 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgD2MCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:02:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id q124so910136pgq.13;
        Wed, 29 Apr 2020 05:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T/5a3HTQNKy4AqGfHf3RhknW3g8HjozXrYnmRz796hw=;
        b=tkXPzRXFmzRVn8cTlJVqIA6mPwSvX/ZA5RCU1PsM/IDoz1iWWuiCSEVhd3YiOqje6M
         LaDn1larJKJCaGtdWUBSQwm2CciGpptJcstiItqk1Q2h5jlNiM84QL+L44w1boDr7OKu
         Bt6Som4rivqfNfdCIZxWqdvIDVhNUidgD7+URxN8ckJANnnHMx7FvJDAITOw9FfSwnFE
         zStKfir0lTekwX8G3x/ufVgxMMM4yMlCAwX1n3A/WVl6TZ2DE6fQG2v8Cw+JqPXvQGh8
         rTyDiYcTQvmwjrISak81roDmoDJ7aI8JvwYWamKFIDStyE4bNAUIWN8nFC6KmHkdneK4
         l4CA==
X-Gm-Message-State: AGi0PuatFt1McH5yjZiIgznMFAUWSUC+cYsbM6fCwGDGZAix+lMzdVbA
        skyIg1zVbuLg3295CXDyjDc=
X-Google-Smtp-Source: APiQypJ38NBctgYyPwK0lHxz55CDL9L9Qm4z5+xuG8K/h7rrUF64qLHgrKt8mPW901ViFL1i3OsRXQ==
X-Received: by 2002:a63:4646:: with SMTP id v6mr34499795pgk.426.1588161753233;
        Wed, 29 Apr 2020 05:02:33 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 4sm1095932pff.18.2020.04.29.05.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 05:02:31 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D48B1403AB; Wed, 29 Apr 2020 12:02:30 +0000 (UTC)
Date:   Wed, 29 Apr 2020 12:02:30 +0000
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
Message-ID: <20200429120230.GK11244@42.do-not-panic.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-5-mcgrof@kernel.org>
 <20200429112637.GD21892@infradead.org>
 <20200429114542.GJ11244@42.do-not-panic.com>
 <20200429115051.GA27378@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429115051.GA27378@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:50:51AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 29, 2020 at 11:45:42AM +0000, Luis Chamberlain wrote:
> > On Wed, Apr 29, 2020 at 04:26:37AM -0700, Christoph Hellwig wrote:
> > > I can't say I'm a fan of all these long backtraces in commit logs..
> > > 
> > > > +static struct dentry *blk_debugfs_dir_register(const char *name)
> > > > +{
> > > > +	return debugfs_create_dir(name, blk_debugfs_root);
> > > > +}
> > > 
> > > I don't think we really need this helper.
> > 
> > We don't export blk_debugfs_root, didn't think we'd want to, and
> > since only a few scew funky drivers would use the struct gendisk
> > and also support BLKTRACE, I didn't think we'd want to export it
> > now.
> > 
> > A new block private symbol namespace alright?
> 
> Err, that function is static and has two callers.

Yes but that is to make it easier to look for who is creating the
debugfs_dir for either the request_queue or partition. I'll export
blk_debugfs_root and we'll open code all this.

> > > This could be simplified down to:
> > > 
> > > 	if (bdev && bdev != bdev->bd_contains)
> > > 		return bdev->bd_part->debugfs_dir;
> > > 	return q->debugfs_dir;
> > >
> > > Given that bd_part is in __blkdev_get very near bd_contains.
> > 
> > Ah neat.
> > 
> > > Also given that this patch completely rewrites blk_trace_debugfs_dir is
> > > there any point in the previous patch?
> > 
> > Still think it helps with making this patch easier to read, but I don't
> > care, lemme know if I should just fold it.
> 
> In fact I'm not even sure we need the helper.  Modulo the comment
> this just becomes a:
> 
> 	if (bdev && bdev != bdev->bd_contains)
>  		dir = bdev->bd_part->debugfs_dir;
> 	else
> 	 	dir = q->debugfs_dir;
> 
> in do_blk_trace_setup.

True, alright will remove that patch.

  Luis
