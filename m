Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0366E1B828B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 01:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgDXXro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 19:47:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41045 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXXro (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 19:47:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id 18so4359838pfv.8;
        Fri, 24 Apr 2020 16:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2TZ/4bQaQW3y9S9s+KEU9TLvqWFSpoONWW+8+xgZgBc=;
        b=LMk2AdHz0B7ivTkJdOGBLMywfYrFlVr4ZdZsQfnBBCbOQSijDBJrWHYc0g/WgKSepI
         UQy7uwtn1LS2MnVJt+LIYujj0/hcGyTr9+/yAvQag4yfCs2QI4nDZs6Mu6sh/0PI+Aa7
         q8cNX+ZIA0jnqNETCd+ilJmRpv+m1SwO8G8bOBCJvlJU5KsEZfixX6IY9rjwkK8m86I9
         zetKZNA5mQcOZoKN1G52y3/Ynm7VCkNnX4OrmnKXscyWxUUDfbATXFHPZ+NXSovdGUUt
         QABhX+8DR4MH/dWFl5tLEmIDgzBC4S1Qf894KCQJUlyH9DXX+yBgjs2D+rhGdGN0kn8g
         JXkA==
X-Gm-Message-State: AGi0PuYJOPaxX4PtMgm26RWUqvMrmOnVKnimFYMDIWCelciKvAFdNMVE
        S+OG4GCJ8vShSwLBniHll8g=
X-Google-Smtp-Source: APiQypJDXv1g6ygWuektKKutf1+iC/qYvRTcwuE+lTA64Uab9ASbCz5uzkw/u8ELL9ZSNepYT8C3SQ==
X-Received: by 2002:aa7:8594:: with SMTP id w20mr12551364pfn.137.1587772063332;
        Fri, 24 Apr 2020 16:47:43 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s199sm6990029pfs.124.2020.04.24.16.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 16:47:42 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 91A6D403AB; Fri, 24 Apr 2020 23:47:41 +0000 (UTC)
Date:   Fri, 24 Apr 2020 23:47:41 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, rostedt@goodmis.org,
        mingo@redhat.com, jack@suse.cz, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 03/10] blktrace: fix debugfs use after free
Message-ID: <20200424234741.GE11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <20200420201615.GC302402@kroah.com>
 <20200420204156.GO11244@42.do-not-panic.com>
 <20200421070048.GD347130@kroah.com>
 <20200422072859.GQ11244@42.do-not-panic.com>
 <20200422094320.GH299948@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422094320.GH299948@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:43:20PM +0800, Ming Lei wrote:
> On Wed, Apr 22, 2020 at 07:28:59AM +0000, Luis Chamberlain wrote:
> > At this point in time patch-wise we still haven't reverted back to
> > synchronous request_queue removal. Considering this, a race with the
> > parent disappearing can happen because the request_queue removal is
> > deferred, that is, the request_queue's kobject's release() call used
> > schedule_work() to finish off its removal. We expect the last
> > blk_put_queue() to be called at the end of blk_cleanup_queue(). Since
> 
> Actually no, we expect that request queue is released after disk is
> released. Don't forget that gendisk does hold one extra refcount of
> request queue.

Then by all means using blk_put_queue() from everywhere should be safe
in atomic context, as we have control over that blk_put_queue() on the
block layer.

(Modulo, we accept the races possible today on blk_get_queue(), which
I'll try to address).

  Luis
