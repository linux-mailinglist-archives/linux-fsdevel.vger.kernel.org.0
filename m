Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91D84BB1D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 07:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiBRGJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 01:09:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiBRGJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:09:54 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AC211A80D
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 22:09:34 -0800 (PST)
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.51 with ESMTP; 18 Feb 2022 15:09:33 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.127 with ESMTP; 18 Feb 2022 15:09:33 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 18 Feb 2022 15:09:26 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: [PATCH 02/16] dept: Implement Dept(Dependency Tracker)
Message-ID: <20220218060926.GA26206@X58A-UD3R>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
 <1645095472-26530-3-git-send-email-byungchul.park@lge.com>
 <20220217123656.389e8783@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217123656.389e8783@gandalf.local.home>
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

On Thu, Feb 17, 2022 at 12:36:56PM -0500, Steven Rostedt wrote:
> > +struct dept_ecxt;
> > +struct dept_iecxt {
> > +	struct dept_ecxt *ecxt;
> > +	int enirq;
> > +	bool staled; /* for preventing to add a new ecxt */
> > +};
> > +
> > +struct dept_wait;
> > +struct dept_iwait {
> > +	struct dept_wait *wait;
> > +	int irq;
> > +	bool staled; /* for preventing to add a new wait */
> > +	bool touched;
> > +};
> 
> Nit. It makes it easier to read (and then review) if structures are spaced
> where their fields are all lined up:
> 
> struct dept_iecxt {
> 	struct dept_ecxt		*ecxt;
> 	int				enirq;
> 	bool				staled;
> };
> 
> struct dept_iwait {
> 	struct dept_wait		*wait;
> 	int				irq;
> 	bool				staled;
> 	bool				touched;
> };
> 
> See, the fields stand out, and is nicer on the eyes. Especially for those
> of us that are getting up in age, and our eyes do not work as well as they
> use to ;-)

Sure! I will apply this.

> > + * ---
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your ootion) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, you can access it online at
> > + * http://www.gnu.org/licenses/gpl-2.0.html.
> 
> The SPDX at the top of the file is all that is needed. Please remove this
> boiler plate. We do not use GPL boiler plates in the kernel anymore. The
> SPDX code supersedes that.

Thank you for informing it!

> > +/*
> > + * Can use llist no matter whether CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG is
> > + * enabled because DEPT never race with NMI by nesting control.
> 
>                          "never races with"

Good eyes!

> Although, I'm confused by what you mean with "by nesting control".

I should've expressed it more clearly. It meant NMI and other contexts
never run inside of Dept concurrently in the same CPU by preventing
reentrance.

> > +static void initialize_class(struct dept_class *c)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < DEPT_IRQS_NR; i++) {
> > +		struct dept_iecxt *ie = &c->iecxt[i];
> > +		struct dept_iwait *iw = &c->iwait[i];
> > +
> > +		ie->ecxt = NULL;
> > +		ie->enirq = i;
> > +		ie->staled = false;
> > +
> > +		iw->wait = NULL;
> > +		iw->irq = i;
> > +		iw->staled = false;
> > +		iw->touched = false;
> > +	}
> > +	c->bfs_gen = 0U;
> 
> Is the U really necessary?

I was just wondering if it's really harmful? I want to leave this if
it's harmless because U let us guess the data type of ->bfs_gen correctly
at a glance. Or am I missing some reason why I should fix this?

Thank you very much, Steven.

