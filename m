Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D46790EE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 00:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbjICW1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 18:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjICW1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 18:27:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B338DDD
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Sep 2023 15:27:19 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-56f84de64b9so439783a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Sep 2023 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1693780039; x=1694384839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uey9X37TsXxaxDDta+GmGK9zdrWEFlBTA4HM9sllgko=;
        b=aFcW5hhFseVJYvY9BxkVUGdq94OzhJT+piPShTn7nfOvOqUIAbtvyW6pEs7Y5AszBo
         iWDtNnMZCtAlW7+p0HLHWbaSGMMLbNDURG9IT+WAldCcrTaFHwbwT7Dx/diDOf4lQlJY
         6R8KK0OgpgRCqAM9PY7WLMAuvaLp/HcrE/qv+CrBQQZp8QV4dBd4GpggNanfFa707RJU
         cBumvp0S6srNTFZ1wM/rPnYIQ48zm/ZbT39aeE+R4mflHAQriKOlszZTvYgc2DzoX0lx
         IttOIZ7Me4UdAI3Vflqk+fMvvoJ1lRrTPU3SSzDtUc0bK+lCEN50YMeadQ37y7ZCwPz+
         8UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693780039; x=1694384839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uey9X37TsXxaxDDta+GmGK9zdrWEFlBTA4HM9sllgko=;
        b=OK8D1CLUGauqhRD56hEJfZNfdEOztg4RtAuxeHwO72rAmdyfVH47nxJ1AjVA+tuGjo
         6Pn7PB4Bx2kCfBmBq1+XVC52O87QPblmXyfHmFvLLgjfYZpG1DXVn0o/cMZxTNg7MfMA
         njAD7TDn//XI1cx7DwQoafn2Aq6upgVUpuvMgvqoB+UnMbaJTjTQKugvhc4kvLkTvVPi
         s8Yg3dCplPKYKx8hu3u54IhWUHWelL2hfy8BOA1VSbIL98HA/SxiSbjojdI9PWulDq+M
         iHYQvjud5hCXs8JnyEMXLz3zcaeiL6jcSsMBUTMbPk7Yg7D4c8BONXyl3hoEkDV9rO9J
         V/Og==
X-Gm-Message-State: AOJu0YxR77YkKH5FFxQgx/Xf63UxPL96J2Kfjam7kPpeCovkTnLYYvnt
        k+upHz85r9H1X0Ue7lz4oQFvww==
X-Google-Smtp-Source: AGHT+IGeAVpJ32MwLia9j7b+fincRrOYrEYNNZjKkEpbapJ86ueujIl+j6DWTleN+nP733gdLcwaIQ==
X-Received: by 2002:a17:90b:d94:b0:267:f8f4:73ab with SMTP id bg20-20020a17090b0d9400b00267f8f473abmr11150197pjb.16.1693780039113;
        Sun, 03 Sep 2023 15:27:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id gb16-20020a17090b061000b00263f446d432sm7845229pjb.43.2023.09.03.15.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 15:27:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qcvYp-00ASAZ-2e;
        Mon, 04 Sep 2023 08:27:15 +1000
Date:   Mon, 4 Sep 2023 08:27:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <ZPUIQzsCSNlnBFHB@dread.disaster.area>
References: <000000000000e6432a06046c96a5@google.com>
 <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903083357.75mq5l43gakuc2z7@f>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 03, 2023 at 10:33:57AM +0200, Mateusz Guzik wrote:
> On Sun, Sep 03, 2023 at 03:25:28PM +1000, Dave Chinner wrote:
> > On Sat, Sep 02, 2023 at 09:11:34PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    b97d64c72259 Merge tag '6.6-rc-smb3-client-fixes-part1' of..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14136d8fa80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=958c1fdc38118172
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Been happening for months, apparently, yet for some reason it now
> > thinks a locking hang in __fdget_pos() is an XFS issue?
> > 
> > #syz set subsystems: fs
> > 
> 
> The report does not have info necessary to figure this out -- no
> backtrace for whichever thread which holds f_pos_lock. I clicked on a
> bunch of other reports and it is the same story.

That's true, but there's nothing that points at XFS in *any* of the
bug reports. Indeed, log from the most recent report doesn't have
any of the output from the time stuff hung. i.e. the log starts
at kernel time 669.487771 seconds, and the hung task report is at:

684.588608][   T28] INFO: task syz-executor.0:19830 blocked for more than 143 seconds

About 25 seconds later. So the hung tasks were running at about
540s, and that's just not in the logs.

Every report has a different combination of filesystems being
exercised, and a couple of them didn't even have XFS in them.

So at this point, there is no single filesystem that the reports
actually indicate is the cause, the reports don't contain the actual
operations that hung, and there's basically nothing to go on so far.
Hence putting it in the "fs" bucket (which encompasses all things
filesystems!) is the rigth thing to do.

The only commonality I kinda see is that secondary processes that
are hung seem mostly to be in directory operations waiting on inode
locks - either lookup or readdir, so it's entirely possible that a
filesystem has screwed up ->iterate_shared locking in some way...

> Can the kernel be configured to dump backtraces from *all* threads?

It already is (sysrq-t), but I'm not sure that will help - if it is
a leaked unlock then nothing will show up at all.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
