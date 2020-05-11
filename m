Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B7B1CDB94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgEKNoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 09:44:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39353 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgEKNoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 09:44:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id u35so1595761pgk.6;
        Mon, 11 May 2020 06:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5yHRVmEBHBF6KUpzT1FQxGuYFGjZXqYCJKdOUr/BlMY=;
        b=GQXgi9BOMOKAMnByHXvS5F7TeT4AFu/Ph9GfLIxDab4HGWH4187k7gFSQAcZh0qo1b
         GoK5GZDGW5KbpdUm7HKshJ8gTaViYQ0tWonkXWj8+v1a3w7G6aMbHHmpD2XNLWSP53Fx
         4QMtBWlKotFdDB9ZzseM+ERHn1J9HTLeE0z6l7zi1x3xOCHNdpEKwP2gfjUi569ZNs7j
         uJmQBQg4jbZv/IE6BJHXqiX7bEEjA3OVVhGwLqjUWm6EJfJw2AGEqvnGnW5oVtcivDH2
         1LwcFEt/c8Gc96R4n0B8nvXmBBtXk/YTcwnh2+M3A5vMcxD7WT/ZTwwcZBpddAXYQGDy
         rjFw==
X-Gm-Message-State: AGi0PuaiAFDGmtGlZQhRyt9F0Y8lCS+01gfSePbFzrm8RiG08asWvnCE
        iYOxGGOSeZNDPYdyjiHo5KM=
X-Google-Smtp-Source: APiQypJZxZWizCffxSnbXzlu9+47Vc63kaG97XNasN1vCFXE0FAeRKKvcKq6QPjG+beSAzIPcVOfbg==
X-Received: by 2002:aa7:808e:: with SMTP id v14mr16890723pff.168.1589204648826;
        Mon, 11 May 2020 06:44:08 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d203sm9037695pfd.79.2020.05.11.06.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:44:07 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A405640605; Mon, 11 May 2020 13:44:06 +0000 (UTC)
Date:   Mon, 11 May 2020 13:44:06 +0000
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
        Christof Schmitt <christof.schmitt@de.ibm.com>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 3/5] blktrace: fix debugfs use after free
Message-ID: <20200511134406.GN11244@42.do-not-panic.com>
References: <20200509031058.8239-1-mcgrof@kernel.org>
 <20200509031058.8239-4-mcgrof@kernel.org>
 <16fe176f-1dbd-d14c-bfc2-5aee1ca8c64e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16fe176f-1dbd-d14c-bfc2-5aee1ca8c64e@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 09, 2020 at 05:58:55PM -0700, Bart Van Assche wrote:
> On 2020-05-08 20:10, Luis Chamberlain wrote:
> > Screenshots of what the debugfs for block looks like after running
> > blktrace on a system with sg0  which has a raid controllerand then sg1
> > as the media changer:
> > 
> >  # ls -l /sys/kernel/debug/block
> > total 0
> > drwxr-xr-x  3 root root 0 May  9 02:31 bsg
> > drwxr-xr-x 19 root root 0 May  9 02:31 nvme0n1
> > drwxr-xr-x 19 root root 0 May  9 02:31 nvme1n1
> > lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p1 -> nvme1n1
> > lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p2 -> nvme1n1
> > lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p3 -> nvme1n1
> > lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p5 -> nvme1n1
> > lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p6 -> nvme1n1
> > drwxr-xr-x  2 root root 0 May  9 02:33 sch0
> > lrwxrwxrwx  1 root root 0 May  9 02:33 sg0 -> bsg/2:0:0:0
> > lrwxrwxrwx  1 root root 0 May  9 02:33 sg1 -> sch0
> > drwxr-xr-x  5 root root 0 May  9 02:31 vda
> > lrwxrwxrwx  1 root root 0 May  9 02:31 vda1 -> vda
> 
> So this patch creates one soft link per partition at partition creation
> time instead of letting the blktrace code create one directory per
> partition when tracing starts?

Yes.

> Does this break running blktrace
> simultaneously for a partition and for the entire block device?

blktrace already has this limitation, one blktrace is only allowed per
request_queue, the next patch clarifies this, as we currently just error
out without telling the user what has happened.e user what has
happened.e user what has happened.e user what has happened.

> > +static struct dentry *queue_debugfs_symlink_type(struct request_queue *q,
> > +						 const char *src,
> > +						 const char *dst,
> > +						 enum blk_debugfs_dir_type type)
> > +{
> > +	struct dentry *dentry = ERR_PTR(-EINVAL);
> > +	char *dir_dst;
> > +
> > +	dir_dst = kzalloc(PATH_MAX, GFP_KERNEL);
> > +	if (!dir_dst)
> > +		return dentry;
> > +
> > +	switch (type) {
> > +	case BLK_DBG_DIR_BASE:
> > +		if (dst)
> > +			snprintf(dir_dst, PATH_MAX, "%s", dst);
> > +		else if (!IS_ERR_OR_NULL(q->debugfs_dir))
> > +			snprintf(dir_dst, PATH_MAX, "%s",
> > +				 q->debugfs_dir->d_name.name);
> > +		else
> > +			goto out;
> > +		break;
> > +	case BLK_DBG_DIR_BSG:
> > +		if (dst)
> > +			snprintf(dir_dst, PATH_MAX, "bsg/%s", dst);
> > +		else
> > +			goto out;
> > +		break;
> > +	}
> > +
> > +	/*
> > +	 * The base block debugfs directory is always used for the symlinks,
> > +	 * their target is what changes.
> > +	 */
> > +	dentry = debugfs_create_symlink(src, blk_debugfs_root, dir_dst);
> > +out:
> > +	kfree(dir_dst);
> > +
> > +	return dentry;
> > +}
> 
> Please use kasprintf() instead of k?alloc() followed by snprintf().

Sure thing.

  Luis
