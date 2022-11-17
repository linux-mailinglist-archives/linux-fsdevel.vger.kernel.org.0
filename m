Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A7062E70D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 22:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiKQVg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 16:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiKQVgy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:36:54 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB30BC11
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Nov 2022 13:36:53 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q1so3227286pgl.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Nov 2022 13:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aey2YA9Wxv099mJZe3QO4Iedu/+ayidOgLWrrXYQ8U4=;
        b=GWvtXFyYd6Geow5HM40xhPAE40y7wK6YzEI0W8+EVaakcb5oXXApUSFwPNcuEBN3RZ
         dqf4q65FF8QnRtdqBkirWyBQGns61jNLTaiuXnbwcmhlG0xwXYa5XrPCm/WICSgawd1D
         kTi/AvSwYgk6Hw1lNm2gsM4XvGmIafUgCYi1wQj5Zavvg2PPA0m5Y92xLp94K4Ih+sHi
         lRR0Ldc7kNaFyCIEq7GPj+zawjEQ06wMa+pQ/6Y7XTpRMMPdqwtdA30wQZdIweQYVrAj
         2b8O6omsooDpPxbnxzAv0X1nXhZsMciDkioFJ+PtkdhPYtvWo4E2vUCkhWJ20qKgClAG
         6nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aey2YA9Wxv099mJZe3QO4Iedu/+ayidOgLWrrXYQ8U4=;
        b=zVS/75+SNtv+Nt3lUNDKwTpYEkoohWLMubDhDeHVq73QiCFE95gafGHBY9Bk22npCr
         exgpu04C97YjJmC7GKFPlEKInS1vi3ENBd2s3qN8Tb/PnNY0lgNbB0ZmHkmSph48M6YQ
         VASwGSMrbwHoM1tMBZyj1+MVu/LvTUqNdDz1oCL0303bSVd4xjs7gl1lFSiMQSFIZlAM
         CCQzj0naaRLJP7z2k/VdEo+YagcAxQahgSXErwUgTvz9AcCdLuV7DCaH7uRwisbYNCk9
         puazk6Nz6UbpCv/4Y4D80W8D3YgZnmtCOYv9deP0ulfIjMs0X1EuDYywppz4HF/qcGGz
         AI5w==
X-Gm-Message-State: ANoB5plZ48FIYAbkddUZMQz4pmKIAVxoLehEpd/Vb4HWSM8WaaahIGqO
        vEzDwnQ/dDExmDj3uhojwx5BN0roP5D4qw==
X-Google-Smtp-Source: AA0mqf7yraDxC5Qf8PFbY3YC621ZNEgNz1JksSHfWMbhUjsSF1kuPJhKq2TB+lnliQzYGRimUBCmnw==
X-Received: by 2002:a63:d407:0:b0:476:e0fc:8d8a with SMTP id a7-20020a63d407000000b00476e0fc8d8amr3830648pgh.145.1668721013453;
        Thu, 17 Nov 2022 13:36:53 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id y129-20020a62ce87000000b0056bd737fdf3sm1624797pfg.123.2022.11.17.13.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:36:53 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ovmYy-00FRlu-L0; Fri, 18 Nov 2022 08:36:48 +1100
Date:   Fri, 18 Nov 2022 08:36:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <20221117213648.GG3600936@dread.disaster.area>
References: <20221117055810.498014-1-david@fromorbit.com>
 <20221117055810.498014-9-david@fromorbit.com>
 <Y3aEfxus3Eem0ppe@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3aEfxus3Eem0ppe@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:59:11AM -0800, Darrick J. Wong wrote:
> On Thu, Nov 17, 2022 at 04:58:09PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>

[snip code, I'm on PTO for the next coupleof days so, just a quick
process answer here...]

> So the next question is -- how should we regression-test the
> revalidation schemes in the write and writeback paths?  Do you have
> something ready to go that supersedes what I built in patches 13-16 of
> https://lore.kernel.org/linux-xfs/166801781760.3992140.10078383339454429922.stgit@magnolia/T/#u

Short answer is no.

Longer answer is that I haven't needed to write new tests to
exercise the code added to fix the bug.

I've found that g/346 stresses the IOMAP_F_STALE path quite well
because it mixes racing unaligned sub-folio write() calls with mmap
write faults, often to the same folio. It's similar in nature to the
original reproducer in that it does racing concurrent ascending
offset unaligned sub-block writes to a single file. 

g/346 repeatedly found data corruptions (it's a data integrity test)
as a result of the dellalloc punch code doing the wrong thing with
1kB block size, as well as with 4kB block size when the mmap page
faults instatiated multi-page folios....

g269 and g/270 also seem to trigger IOMAP_F_STALE conditions quite
frequently - streaming writes at ENOSPC trigger with fsstress
running in the background executing sync() operations means
writeback is racing with the streaming writes all the time. These
tests exposed bugs that caused stale delalloc blocks to be left
behind by the delalloc punch code.

fsx also tripped over a couple of corruptions, too, when being
run with buffered writes. Because fsx is single threaded, this
implies that it was writeback that was triggering the IOMAP_F_STALE
write() invalidations....

So from a "exercise the IOMAP_F_STALE write() case causing iomap
invalidation, delalloc punching and continuing to complete the rest
of the write", I think we've got a fair bunch of existing tests that
cover both the "racing mmap dirties data in the punch range" and the
"writeback/racing mmap triggers extent changes so triggers
IOMAP_F_STALE" cases.

As for the specific data corruption reproducer, I haven't done
anything other than run the original regression test. I've been
using it as, well, a regression test. I haven't had a chance to look
at any of the other variants that have been written, because all the
actual development was done running "-g rw -g enospc" on 1kB block
size filesystems and repeatedly running g/346 and g/270 until they
passed tens of iterations in a row. I only ran the original
regression test to confirm that I hadn't broken the fix whilsts
getting all the fstests to pass....

> Please let me know what you're thinking.

I'll look at the other tests next week. Until then, I can't really
comment on them.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
