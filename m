Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F884BC77A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Feb 2022 11:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbiBSKF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 05:05:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241984AbiBSKFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:05:53 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45935C4281
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 02:05:28 -0800 (PST)
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 19 Feb 2022 19:05:27 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.126 with ESMTP; 19 Feb 2022 19:05:27 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Sat, 19 Feb 2022 19:05:19 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: [PATCH 00/16] DEPT(Dependency Tracker)
Message-ID: <20220219100519.GB10342@X58A-UD3R>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
 <Yg5u7dzUxL3Vkncg@mit.edu>
 <20220217120005.67f5ddf4@gandalf.local.home>
 <Yg6AigFqdhdO5/ya@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg6AigFqdhdO5/ya@casper.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 05:06:18PM +0000, Matthew Wilcox wrote:
> On Thu, Feb 17, 2022 at 12:00:05PM -0500, Steven Rostedt wrote:
> > On Thu, 17 Feb 2022 10:51:09 -0500
> > "Theodore Ts'o" <tytso@mit.edu> wrote:
> > 
> > > I know that you're trying to help us, but this tool needs to be far
> > > better than Lockdep before we should think about merging it.  Even if
> > > it finds 5% more potential deadlocks, if it creates 95% more false
> > > positive reports --- and the ones it finds are crazy things that
> > > rarely actually happen in practice, are the costs worth the benefits?
> > > And who is bearing the costs, and who is receiving the benefits?
> > 
> > I personally believe that there's potential that this can be helpful and we
> > will want to merge it.
> > 
> > But, what I believe Ted is trying to say is, if you do not know if the
> > report is a bug or not, please do not ask the maintainers to determine it
> > for you. This is a good opportunity for you to look to see why your tool
> > reported an issue, and learn that subsystem. Look at if this is really a
> > bug or not, and investigate why.
> 
> I agree with Steven here, to the point where I'm willing to invest some
> time being a beta-tester for this, so if you focus your efforts on
> filesystem/mm kinds of problems, I can continue looking at them and
> tell you what's helpful and what's unhelpful in the reports.

I appreciate your support. I'll do my best to make it *THE* perfect tool
for that purpose. I'd feel great if it helps a lot and saves you guys'
time in advance, it might not for now tho.

Thanks,
Byungchul
