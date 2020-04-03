Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B519D8A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 16:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390957AbgDCOGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 10:06:05 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38362 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390889AbgDCOGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:06:05 -0400
Received: by mail-pj1-f67.google.com with SMTP id m15so2982777pje.3;
        Fri, 03 Apr 2020 07:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a8g22/FwxwkjiRhQiEAJOv2w5JLkw7NJLiR2WpXy++A=;
        b=H3wAHDEwOwW7durYx2PoslkSZulfjwlqrLe/8GCXTEJHGiCXd9JMoDZOcDqawQNSwH
         c+4MF/bD8q7dHKmpKjPPmGTRtlXAvWXdR3jFgFj5KayhCJ4n/Ld9IkU9H0xy9bFIBe0J
         euaTj5fYSQFsBR3xlcgFmC3NLnA9yzN7m42rYn21AsF56U3CyjzmMplTSTCoHMKb4Q4S
         pcoONXrR4hMfpkZ7IfpnTJqunaup55iDICPlF2Hhd7Z6qeq7GhENtkOHedtrkfuinyT1
         eJ3Is05/aCxBSGSyPw8GlP6pKOqG2EX3PX5Czh6dundhvvlMmImfTaTJvMSfInoyoFMN
         ZlTg==
X-Gm-Message-State: AGi0Puau6YiVG3YZVWQRCUkEmJtaSOuPX0kiK+fnZ7x6vnGCPpVzB1K2
        dGEJiag4FbDdtf8VFv2v3Yg=
X-Google-Smtp-Source: APiQypKpERbmgBhQxVd+/uOx5FaWLUkTGZQy3n5jE9fzkYMhWnKNWlUp9kUqvjNDKLGSXYvSgcHF2Q==
X-Received: by 2002:a17:90a:c256:: with SMTP id d22mr10116186pjx.78.1585922764126;
        Fri, 03 Apr 2020 07:06:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z63sm5877782pfb.20.2020.04.03.07.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:06:02 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DDC8640297; Fri,  3 Apr 2020 14:06:01 +0000 (UTC)
Date:   Fri, 3 Apr 2020 14:06:01 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>, yu kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, mhocko@suse.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [RFC 0/3] block: address blktrace use-after-free
Message-ID: <20200403140601.GP11244@42.do-not-panic.com>
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200403081929.GC6887@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403081929.GC6887@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 04:19:29PM +0800, Ming Lei wrote:
> On Wed, Apr 01, 2020 at 11:59:59PM +0000, Luis Chamberlain wrote:
> > Upstream kernel.org korg#205713 contends that there is a UAF in
> > the core debugfs debugfs_remove() function, and has gone through
> > pushing for a CVE for this, CVE-2019-19770.
> > 
> > If correct then parent dentries are not positive, and this would
> > have implications far beyond this bug report. Thankfully, upon review
> > with Nicolai, he wasn't buying it. His suspicions that this was just
> > a blktrace issue were spot on, and this patch series demonstrates
> > that, provides a reproducer, and provides a solution to the issue.
> > 
> > We there would like to contend CVE-2019-19770 as invalid. The
> > implications suggested are not correct, and this issue is only
> > triggerable with root, by shooting yourself on the foot by misuing
> > blktrace.
> > 
> > If you want this on a git tree, you can get it from linux-next
> > 20200401-blktrace-fix-uaf branch [2].
> > 
> > Wider review, testing, and rants are appreciated.
> > 
> > [0] https://bugzilla.kernel.org/show_bug.cgi?id=205713
> > [1] https://nvd.nist.gov/vuln/detail/CVE-2019-19770
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200401-blktrace-fix-uaf
> > 
> > Luis Chamberlain (3):
> >   block: move main block debugfs initialization to its own file
> >   blktrace: fix debugfs use after free
> >   block: avoid deferral of blk_release_queue() work
> > 
> >  block/Makefile               |  1 +
> >  block/blk-core.c             |  9 +--------
> >  block/blk-debugfs.c          | 27 +++++++++++++++++++++++++++
> >  block/blk-mq-debugfs.c       |  5 -----
> >  block/blk-sysfs.c            | 21 ++++++++-------------
> >  block/blk.h                  | 17 +++++++++++++++++
> >  include/linux/blktrace_api.h |  1 -
> >  kernel/trace/blktrace.c      | 19 ++++++++-----------
> >  8 files changed, 62 insertions(+), 38 deletions(-)
> >  create mode 100644 block/blk-debugfs.c
> 
> BTW, Yu Kuai posted one patch for this issue, looks that approach
> is simpler:
> 
> https://lore.kernel.org/linux-block/20200324132315.22133-1-yukuai3@huawei.com/

I cannot see how renaming the possible target directory to a temporary
directory instead of unifying it for both SQ and MQ could be any
simpler. IMHO this keeps the mess and fragile nature of the issue.

The approach taken here unifies the directory we should use for both SQ
and MQ and makes the deferral issue a completely separate issue
addressed in the last patch.

  Luis
