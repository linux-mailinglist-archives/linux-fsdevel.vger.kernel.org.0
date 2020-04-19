Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82401AFECC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 01:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDSXFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 19:05:41 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40172 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgDSXFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 19:05:40 -0400
Received: by mail-pj1-f68.google.com with SMTP id a22so3596140pjk.5;
        Sun, 19 Apr 2020 16:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YJTrIfx/lTXBrxRhvPPVDY2x+cMSRZK5c/JFw4v1j9o=;
        b=TOuimSgxsnIPVDQcZ5MXMPBv8XcsuF9ob1z2tPxuRhXz7QpK/RLNOfZ5ObehfF7DY0
         3a0B1GF4EvOQQnNHp6YdgiNUkv+Gnq+pA8a/99VBSOBluxE7PFYicYMuCVMnm3p6ZpE2
         mubJl6OlH7S5fjtjrkBuqoAohuKU3WDqZRHEPwYWOYDSzwdq367CCOal84nvDHzXWaIs
         uX81GMecv4WoUJKk71twMhcCYgRtTINJpqwsTiIrrcgBzOFBTPf2Feroo2ZmCAOZbH4h
         dc9CScAI36bX/BN5nlAqY9/a53YoFtf9s77wmIURK29kKwwFxnh7SM3277PlSQ7+7JIz
         4Z0A==
X-Gm-Message-State: AGi0PuZPWac9BDV18cEqBzUQLReiSxG8G40qpNTS4EZ1R/WDIrCTblmc
        olS3dqCrUys0BAHOpcE0Na4=
X-Google-Smtp-Source: APiQypLX1bYPgykU3ZP7zEmkJU3lEhVMCZnqRms/YIQbuGnJEBd6DNYdezzhhxxk1VGEWWm12j1PtQ==
X-Received: by 2002:a17:90a:414b:: with SMTP id m11mr17790229pjg.160.1587337539909;
        Sun, 19 Apr 2020 16:05:39 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i8sm7384626pfq.126.2020.04.19.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 16:05:38 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 6F34F403EA; Sun, 19 Apr 2020 23:05:37 +0000 (UTC)
Date:   Sun, 19 Apr 2020 23:05:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] blktrace: add checks for created debugfs files
 on setup
Message-ID: <20200419230537.GG11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-9-mcgrof@kernel.org>
 <38240225-e48e-3035-0baa-4929948b23a3@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38240225-e48e-3035-0baa-4929948b23a3@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 03:57:58PM -0700, Bart Van Assche wrote:
> On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> > Even though debugfs can be disabled, enabling BLK_DEV_IO_TRACE will
> > select DEBUG_FS, and blktrace exposes an API which userspace uses
> > relying on certain files created in debugfs. If files are not created
> > blktrace will not work correctly, so we do want to ensure that a
> > blktrace setup creates these files properly, and otherwise inform
> > userspace.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >   kernel/trace/blktrace.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > index 9cc0153849c3..fc32a8665ce8 100644
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -552,17 +552,19 @@ static int blk_trace_create_debugfs_files(struct blk_user_trace_setup *buts,
> >   					  struct dentry *dir,
> >   					  struct blk_trace *bt)
> >   {
> > -	int ret = -EIO;
> > -
> >   	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
> >   					       &blk_dropped_fops);
> > +	if (!bt->dropped_file)
> > +		return -ENOMEM;
> >   	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
> > +	if (!bt->msg_file)
> > +		return -ENOMEM;
> >   	bt->rchan = relay_open("trace", dir, buts->buf_size,
> >   				buts->buf_nr, &blk_relay_callbacks, bt);
> >   	if (!bt->rchan)
> > -		return ret;
> > +		return -EIO;
> >   	return 0;
> >   }
> 
> I should have had a look at this patch before I replied to the previous
> patch.
> 
> Do you agree that the following code can be triggered by
> debugfs_create_file() and also that debugfs_create_file() never returns
> NULL?

If debugfs is enabled, and not that we know it is in this blktrace code,
as we select it, it can return ERR_PTR(-ERROR) if an error occurs.

  Luis
