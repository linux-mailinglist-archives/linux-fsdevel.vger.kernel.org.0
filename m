Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFAA1CDB6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgEKNjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 09:39:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36642 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgEKNjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 09:39:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id f15so3954819plr.3;
        Mon, 11 May 2020 06:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a77Oq5OXHF7el+BrAxI3YkOcCnUkeWqP0J5f4YEVkXM=;
        b=YQs25M+jwEExvjUyvU+Ezm/hkPO1YVNHZrH0kjTbgn6gYpmPkufFzN9GKUTKYXIeHK
         K1sshT+U1LP0nRJ3nHccr+atUmWQwJGcPnNkQNJZU6O7UJudGrmRKs9FGgw1JCd5CE7L
         UVOPGTna4jQJQRNbVHuIlaZP+pmpsClZHcQQ2KEBAElfAoTp2oAI3iuwbEwia6lxLJAd
         uBJV/c4zNqfWvsD7b1LcL8LAh+HiGnJCZxbKdXc01dxj+1NLOLYbOuo/w4UumGo9zEyF
         kUELN0mtUyh3K1ikqC2bEEMCV9ZOe5qWMPH9q85zmAm9zF83ajU1qS97CZL/VO6gOOfV
         Piug==
X-Gm-Message-State: AGi0Pubo6PBDSnrXkqCNKSXcQs52IvYAkhNEojqwPiZUbTZCsGmUXNx7
        6tBC0M8RoWo3UH/8Yiu0ifk=
X-Google-Smtp-Source: APiQypKqHlxgJmo3bwvHjknzSYEsG4x2Ee1DWrk4HLFXH26haXIT+z521EOT/qAn2yUInaHP1vs5wQ==
X-Received: by 2002:a17:90a:c702:: with SMTP id o2mr22379928pjt.196.1589204342837;
        Mon, 11 May 2020 06:39:02 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t8sm8122734pgn.81.2020.05.11.06.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:39:01 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8354D40605; Mon, 11 May 2020 13:39:00 +0000 (UTC)
Date:   Mon, 11 May 2020 13:39:00 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] blktrace: break out of blktrace setup on
 concurrent calls
Message-ID: <20200511133900.GL11244@42.do-not-panic.com>
References: <20200509031058.8239-1-mcgrof@kernel.org>
 <20200509031058.8239-5-mcgrof@kernel.org>
 <e728acea-61c1-fcb5-489b-9be8cafe61ea@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e728acea-61c1-fcb5-489b-9be8cafe61ea@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 09, 2020 at 06:09:38PM -0700, Bart Van Assche wrote:
> On 2020-05-08 20:10, Luis Chamberlain wrote:
> > @@ -493,6 +496,12 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> >  	 */
> >  	strreplace(buts->name, '/', '_');
> >  
> > +	if (q->blk_trace) {
> > +		pr_warn("Concurrent blktraces are not allowed on %s\n",
> > +			buts->name);
> > +		return -EBUSY;
> > +	}
> > +
> >  	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
> >  	if (!bt)
> >  		return -ENOMEM;
> 
> Is this really sufficient? Shouldn't concurrent do_blk_trace_setup()
> calls that refer to the same request queue be serialized to really
> prevent that debugfs attribute creation fails?

We'd have to add something like a linked list. Right now I'm just
clarifying things which were not clear before. What you describe is
a functional feature change. I'm just trying to fix a bug and clarify
limitations.

> How about using the block device name instead of the partition name in
> the error message since the concurrency context is the block device and
> not the partition?

blk device argument can be NULL here. sg-generic is one case.

 Luis
