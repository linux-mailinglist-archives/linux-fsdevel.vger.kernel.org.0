Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8561C19E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 17:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgEAPky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 11:40:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40644 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgEAPkx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 11:40:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id n16so4701410pgb.7;
        Fri, 01 May 2020 08:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EZb14EGk3wI78w7Kr9UulRwJ6g15wvU8vvLNiIxNBjg=;
        b=p85/pEcepwCvDEMMuhC3JtSmlyDv7wucv6fCJKJoOAAIKM5hQv/D2z5jGvE+6W5T4E
         YYGCEgIVBwjV1fuaCg9+9NVvz8GhxVXEUMpRychYvBIT2xpm6UkCcDidhbecyQ8D+7EX
         ZUIbf3hQcjZfr1UdnSWEkKswDIJ9/tHKD7Hjx1qUalMvC3XLu4UE/NE5KXyfZ9lgjq6o
         2mrC40+CCN8tbjPTGqNJGv9H2kD4b1hDspIlLA2KsJ7rYULRTaTTrzuyLmEYn0+AZplA
         pBuQEnGASwnvZVIsOqRb1hqd8S4Vs5Vdj+U61MimKImtAgSR6V4aaW+sYh7005ldgPxu
         HnTQ==
X-Gm-Message-State: AGi0Pub6twUk4nU1LhE4DOeW5krnmdLe7No9nNSaImdTiODX4mkORswY
        TKQUbYSrc7un02EG6VBDWq0=
X-Google-Smtp-Source: APiQypIKENGcjQ8wEJnG/jVN4jklP+/LYCHW7WJrZ1nUigoylvteSvXK0XEmW6rptAeYZk2lCgDJWg==
X-Received: by 2002:a63:3d05:: with SMTP id k5mr4023956pga.302.1588347652702;
        Fri, 01 May 2020 08:40:52 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p65sm2305859pgp.51.2020.05.01.08.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:40:51 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D6D414046C; Fri,  1 May 2020 15:40:50 +0000 (UTC)
Date:   Fri, 1 May 2020 15:40:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, rostedt@goodmis.org,
        mingo@redhat.com, jack@suse.cz, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] blktrace: break out of blktrace setup on
 concurrent calls
Message-ID: <20200501154050.GO11244@42.do-not-panic.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-6-mcgrof@kernel.org>
 <20200429094937.GB2081185@kroah.com>
 <20200501150626.GM11244@42.do-not-panic.com>
 <20200501153423.GA12469@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501153423.GA12469@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 08:34:23AM -0700, Christoph Hellwig wrote:
> On Fri, May 01, 2020 at 03:06:26PM +0000, Luis Chamberlain wrote:
> > > You have access to a block device here, please use dev_warn() instead
> > > here for that, that makes it obvious as to what device a "concurrent
> > > blktrace" was attempted for.
> > 
> > The block device may be empty, one example is for scsi-generic, but I'll
> > use buts->name.
> 
> Is blktrace on /dev/sg something we intentionally support, or just by
> some accident of history?  Given all the pains it causes I'd be tempted
> to just remove the support and see if anyone screams.

From what I can tell I think it was a historic and brutal mistake. I am
more than happy to remove it.

Re-adding support would just be a symlink.

  Luis
