Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537521A71CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 05:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404748AbgDNDct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 23:32:49 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55263 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgDNDcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:32:48 -0400
Received: by mail-pj1-f68.google.com with SMTP id np9so4718811pjb.4;
        Mon, 13 Apr 2020 20:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ArgnOF6jLXpb/Aiqzc0Aon2OsGQE4oCrOJZfbEaRH+I=;
        b=bn5RUFOoLjNufGkZiwp+HvhbtDf+SXl58erARtI9EBH9cETeOXao+x/CLmeULiCjnp
         lNgEHUz2GMvRrSOWEXaxOrkah+FqA0mCsLFLjkOsywlgHp0xiVhCPQPoUiJm5t7/jEH0
         0UEyorNelLbBB8qXPceyL2lPJPLbxNRtF5tYBRbBihNqKXGX4umJSe+t9HcyB2MBc5tW
         Cu8bcnXj2VQ9af9u4lMAc5qsDWcgBaYSTWLXfy3zro8bv1KONjTne/ys5TZQfKZPz+ZW
         x6uTUmwfmgZC/y9wXIMtDDsiWLyquSvIryanXSoNx9G+W+S9ziZa6ak60Z0mKWy+u1tq
         KF1g==
X-Gm-Message-State: AGi0PuYduIQC+z6m77/RE8Lp4Bpp2bqrNclkpYzjYoW6gagfOtrWy+xc
        2RetwDv+3mMaAtzx/dxVV3U=
X-Google-Smtp-Source: APiQypID3YxvbyG2BHdjJhI/9Ccmf+GO9Qf3+pzzIuUIxcf0WguocjZaoZm68OvUVdP61Q4w8oVZnQ==
X-Received: by 2002:a17:902:bc48:: with SMTP id t8mr2486948plz.311.1586835167370;
        Mon, 13 Apr 2020 20:32:47 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u8sm2686875pjy.16.2020.04.13.20.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 20:32:46 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 757DF40277; Tue, 14 Apr 2020 03:32:44 +0000 (UTC)
Date:   Tue, 14 Apr 2020 03:32:44 +0000
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
Message-ID: <20200414033244.GN11244@42.do-not-panic.com>
References: <20200409214530.2413-1-mcgrof@kernel.org>
 <20200409214530.2413-3-mcgrof@kernel.org>
 <88f94070-cd34-7435-9175-e0518a7d7db8@acm.org>
 <20200410195805.GM11244@42.do-not-panic.com>
 <0837b27e-e07b-b61c-5842-00cdf78873ca@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0837b27e-e07b-b61c-5842-00cdf78873ca@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 11, 2020 at 04:09:13PM -0700, Bart Van Assche wrote:
> On 2020-04-10 12:58, Luis Chamberlain wrote:
> > On Thu, Apr 09, 2020 at 07:52:59PM -0700, Bart Van Assche wrote:
> >> On 2020-04-09 14:45, Luis Chamberlain wrote:
> >>> +void blk_q_debugfs_register(struct request_queue *q)
> >>> +{
> >>> +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> >>> +					    blk_debugfs_root);
> >>> +}
> >>> +
> >>> +void blk_q_debugfs_unregister(struct request_queue *q)
> >>> +{
> >>> +	debugfs_remove_recursive(q->debugfs_dir);
> >>> +	q->debugfs_dir = NULL;
> >>> +}
> >>
> >> There are no other functions in the block layer that start with the
> >> prefix blk_q_. How about changing that prefix into blk_?
> > 
> > I the first patch already introduced blk_debugfs_register(), so I have
> > now changed the above to:
> > 
> > blk_debugfs_common_register()
> > blk_debugfs_common_unregister()
> > 
> > Let me know if something else is preferred.
> 
> I just realized that the "q" in "blk_q_" probably refers to the word
> "queue"? How about renaming these funtions into
> blk_queue_debugfs_register/unregister()?

Sure.

  Luis
