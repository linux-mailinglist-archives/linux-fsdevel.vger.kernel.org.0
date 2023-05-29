Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D2271523B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 01:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjE2XMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 19:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjE2XMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 19:12:51 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0018EAD
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 16:12:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64fec2e0e25so592036b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 16:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685401968; x=1687993968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CEb/q2oR2f3xfXECLF27YKQHP0Ck5BcAeCfMowWxLOI=;
        b=SXnysAqeo5Rxm3JiV+6zcZTSUSoVK4qMgntm47CBE+ZEFBLEugelygVkWX+EJWS5rO
         fzb3pl6PbLDwgdwVdebX+75ZJt53UVAERhmPuEZ4uYHw5roVgtMuKmHYUOc1sNLXEzLu
         EBXvNxWRMmschp/RnK5ysp+mPHSZXI5LUhHOy2KaSR9ctkwBRvriyeU4KFNyL3KVKCRd
         RSm7WESovrc7HFHynM9P21zqoS+Q3m8HPKAVLHzb7hrlieu+BI5bA9jK+lTkrKvSxFb7
         X8fsMrwxlg3cXgn2Vt5GIa6Ush5rFOZwlkQbHkLXTeRkQCCCimSlHyIvPLrikGlZro8t
         f83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685401968; x=1687993968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEb/q2oR2f3xfXECLF27YKQHP0Ck5BcAeCfMowWxLOI=;
        b=YR7Q2TV2CKukEjpRJyTQU3zDZ7aoDbuTrQaGYFzo3VH4wN2yeAu1yIbR/rDHcnGu3g
         lF4vanU8D2hDQi9G8Ciy3eDoTWAurDG599LCbAg6qeyCV3d0WRVwogh6gnlSpawndgG/
         27jbm7EGnIz2+nbMZU99T6+9Fy4CNbhtWPI7CfgdrH5tNYWgQYVyDHaGfRkMzJLpLu6o
         uHuWDOcUPPzoICuDFwlQWQ4rU3KRcnIIakepofjaBDpdRCSDpBLdO9AyFSP2CwJmYURX
         p5ZRL+OOLxuVUOGceGLQIAVf1v9ztqU/7PK13IBI1VdKnKO84t43omg11vkea7fiiMGD
         57jQ==
X-Gm-Message-State: AC+VfDzJt6IluE7ZsNTmxmRgACDiaNlTXJ2fe0iL+GuHkxjuFbAPCTJM
        zmRUHxhLwzSkcvGazq3qPHDdVA==
X-Google-Smtp-Source: ACHHUZ7Q5mP843nhoE0+BC2QT5pCXDuq4Cdhm+ZbTapkVUOV3QG9I8B9Dc17Xb/SzUwDSi8xRONYzg==
X-Received: by 2002:a05:6a20:a5a8:b0:10e:f1e3:8217 with SMTP id bc40-20020a056a20a5a800b0010ef1e38217mr451730pzb.17.1685401968467;
        Mon, 29 May 2023 16:12:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id j31-20020a63fc1f000000b00502e7115cbdsm7469726pgi.51.2023.05.29.16.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 16:12:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q3m2e-005UaD-1Z;
        Tue, 30 May 2023 09:12:44 +1000
Date:   Tue, 30 May 2023 09:12:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: fuzzing bcachefs with dm-flakey
Message-ID: <ZHUxbLh1P9yiq2c9@dread.disaster.area>
References: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com>
 <ZHUVy7jut1Ex1IGJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHUVy7jut1Ex1IGJ@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 29, 2023 at 10:14:51PM +0100, Matthew Wilcox wrote:
> On Mon, May 29, 2023 at 04:59:40PM -0400, Mikulas Patocka wrote:
> > Hi
> > 
> > I improved the dm-flakey device mapper target, so that it can do random 
> > corruption of read and write bios - I uploaded it here: 
> > https://people.redhat.com/~mpatocka/testcases/bcachefs/dm-flakey.c
> > 
> > I set up dm-flakey, so that it corrupts 10% of read bios and 10% of write 
> > bios with this command:
> > dmsetup create flakey --table "0 `blockdev --getsize /dev/ram0` flakey /dev/ram0 0 0 1 4 random_write_corrupt 100000000 random_read_corrupt 100000000"
> 
> I'm not suggesting that any of the bugs you've found are invalid, but 10%
> seems really high.  Is it reasonable to expect any filesystem to cope
> with that level of broken hardware?  Can any of our existing ones cope
> with that level of flakiness?  I mean, I've got some pretty shoddy USB
> cables, but ...

It's realistic in that when you have lots of individual storage
devices, load balanced over all of them, and then one fails
completely we'll see an IO error rate like this. These are the sorts
of setups I'd expect to be using erasure coding with bcachefs, so
the IO failure rate should be able to head towards 20-30% before
actual loss and/or corruption should start occurring.

In this situation, if the failures were isolated to an individual
device, then I'd want the filesystem to kick that device out of the
backing pool. Hence all the failures go away and then rebuild of the
redundancy the erasure coding provides can take place. i.e. an IO
failure rate this high should be a very short lived incident for a
filesystem that directly manages individual devices.

But within a single, small device, it's not a particularly realistic
scenario. If it's really corrupting this much active metadata, then
the filesystem should be shutting down at the first
uncorrectable/unrecoverable metadata error and every other IO error
is then superfluous.

Of course, bcachefs might be doing just that - cleanly shutting down
an active filesystem is a very hard problem. XFS still has intricate
and subtle issues with shutdown of active filesystems that can cause
hangs and/or crashes, so I wouldn't expect bcachefs to be able to
handle these scenarios completely cleanly at this stage of it's
development....

Perhaps it is worthwhile running the same tests on btrfs so we can
something to compare the bcachefs behaviour to. I suspect that btrfs
will fair little better on the single device, no checksums
corruption test....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
