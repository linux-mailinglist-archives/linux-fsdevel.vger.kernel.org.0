Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB9754A1E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 00:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiFMWE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 18:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFMWE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:04:58 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F36132B276;
        Mon, 13 Jun 2022 15:04:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CED685ECC56;
        Tue, 14 Jun 2022 08:04:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o0sAy-006IFI-TQ; Tue, 14 Jun 2022 08:04:48 +1000
Date:   Tue, 14 Jun 2022 08:04:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chris Mason <clm@fb.com>
Cc:     djwong@kernel.org, hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH v2] iomap: skip pages past eof in iomap_do_writepage()
Message-ID: <20220613220448.GY227878@dread.disaster.area>
References: <20220608004228.3658429-1-clm@fb.com>
 <20220609005313.GX227878@dread.disaster.area>
 <8f4177bd-80ad-5e22-293e-5d1e944e1921@fb.com>
 <fb72ebb9-df11-7689-0113-5d98783039fd@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb72ebb9-df11-7689-0113-5d98783039fd@fb.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62a7b484
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=8nJEP1OIZ-IA:10 a=JPEYwPQDsx4A:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=dvwgNvh2vzOY59J3_fYA:9 a=wPNLvfGTeEIA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 11, 2022 at 07:34:01PM -0400, Chris Mason wrote:
> On 6/9/22 5:15 PM, Chris Mason wrote:
> > On 6/8/22 8:53 PM, Dave Chinner wrote:
> 
> > > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > 
> > Thanks!  Johannes and I are both going on vacation, but I'll get an
> > experiment rolled to enough hosts to see if the long tails get shorter.
> >  We're unlikely to come back with results before July.
> > 
> 
> Of course, the easiest way to test my theory is live patching against v5.6,
> but there's a wrinkle because v5.6 still has xfs_vm_writepage()
> 
> Looks like the iomap conversion deleted the warning that Jan was originally
> fixing, and I went through some hoops to trigger skipping the pages from
> inside writepage().  As you noted in the commit to delete writepage, this is
> pretty hard to trigger but it does happen once I get down to a few hundred
> MB free.  It doesn't seem to impact fsx runs or other load, and we
> unmount/xfs_repair cleanly.
>
> I don't like to ask people to think about ancient kernels, but am I missing
> any huge problems?  I've got this patch backported on v5.6, and writepage is
> still in place.

Just backport the patch to remove ->writepage as well? I've run test
kernels since ~2017 with the writepage delete in it and never seen
any problems as a result of it. That would seem to me to be the
simplest way of avoiding unexpected issues with reclaim writeback
and truncate races...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
