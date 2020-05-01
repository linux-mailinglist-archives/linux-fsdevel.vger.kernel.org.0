Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E431C18EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 17:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgEAPGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 11:06:30 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52962 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbgEAPGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 11:06:30 -0400
Received: by mail-pj1-f67.google.com with SMTP id a5so7380pjh.2;
        Fri, 01 May 2020 08:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xZEuUIfKchT+EMbxhxCN46MIcCVcFm3FAvFpx36VX5s=;
        b=siMrVTnv76sHVgyryxeCag4mzdiPllfjhxdBsdoCPtD4YTwuArBXu/LIbbZv0Cew4M
         A1Jb/q1OhitBZ8qsdI0SJCfI/WxEBpe+bXtnFTfNbITtcj6/uQgskySb6tDBBPS3bhzh
         /pIimOiLbNCymlK6d3QNp01EG8je0btr+QXLw+09tHLkcYZH7qLsB/rbLlX3pzkgh3re
         ubljy6qDQ/uz7mcxhpHK6kVzIuCthNdHapVnXFNMjRNP/TPd++eMizPO1P/xwz581K5w
         T4aoW4gOtu1SAB4pFDt+rTE9n/JwsjLvc72sKeDznr9jIhnBGIVzN4MXgb+DsVZfv4Ci
         Pq+w==
X-Gm-Message-State: AGi0PuYuZxqPm3EeKLR6WQrkmp9AaEKcL52JGupy8XxKq43DkmX/VyID
        aafRqbUXd7Tv1oXxpZ7XAuA=
X-Google-Smtp-Source: APiQypLRVmetlTXe8oQnydpwRXsMDCGv8wGQxNnx9xTkyckOaqUJcm8Xfuuqc69dMqg8NZhPGGC9qQ==
X-Received: by 2002:a17:90a:690b:: with SMTP id r11mr5175418pjj.119.1588345589022;
        Fri, 01 May 2020 08:06:29 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p16sm15627pjz.2.2020.05.01.08.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:06:27 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id CABA44046C; Fri,  1 May 2020 15:06:26 +0000 (UTC)
Date:   Fri, 1 May 2020 15:06:26 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] blktrace: break out of blktrace setup on
 concurrent calls
Message-ID: <20200501150626.GM11244@42.do-not-panic.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-6-mcgrof@kernel.org>
 <20200429094937.GB2081185@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429094937.GB2081185@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:49:37AM +0200, Greg KH wrote:
> On Wed, Apr 29, 2020 at 07:46:26AM +0000, Luis Chamberlain wrote:
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > index 5c52976bd762..383045f67cb8 100644
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -516,6 +518,11 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> >  	 */
> >  	strreplace(buts->name, '/', '_');
> >  
> > +	if (q->blk_trace) {
> > +		pr_warn("Concurrent blktraces are not allowed\n");
> > +		return -EBUSY;
> 
> You have access to a block device here, please use dev_warn() instead
> here for that, that makes it obvious as to what device a "concurrent
> blktrace" was attempted for.

The block device may be empty, one example is for scsi-generic, but I'll
use buts->name.

  Luis
