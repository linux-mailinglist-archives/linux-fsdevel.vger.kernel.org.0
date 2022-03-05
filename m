Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978F74CE27A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 04:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiCEDl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 22:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiCEDl1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 22:41:27 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A548E2287E2;
        Fri,  4 Mar 2022 19:40:37 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2253eZWb017065
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Mar 2022 22:40:36 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B8EDD15C0038; Fri,  4 Mar 2022 22:40:35 -0500 (EST)
Date:   Fri, 4 Mar 2022 22:40:35 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: Report 2 in ext4 and journal based on v5.17-rc1
Message-ID: <YiLbs9rszWXpHm/P@mit.edu>
References: <YiAow5gi21zwUT54@mit.edu>
 <1646285013-3934-1-git-send-email-byungchul.park@lge.com>
 <YiDSabde88HJ/aTt@mit.edu>
 <20220304032002.GD6112@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304032002.GD6112@X58A-UD3R>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 04, 2022 at 12:20:02PM +0900, Byungchul Park wrote:
> 
> I found a point that the two wait channels don't lead a deadlock in
> some cases thanks to Jan Kara. I will fix it so that Dept won't
> complain it.

I sent my last (admittedly cranky) message before you sent this.  I'm
glad you finally understood Jan's explanation.  I was trying to tell
you the same thing, but apparently I failed to communicate in a
sufficiently clear manner.  In any case, what Jan described is a
fundamental part of how wait queues work, and I'm kind of amazed that
you were able to implement DEPT without understanding it.  (But maybe
that is why some of the DEPT reports were completely incomprehensible
to me; I couldn't interpret why in the world DEPT was saying there was
a problem.)

In any case, the thing I would ask is a little humility.  We regularly
use lockdep, and we run a huge number of stress tests, throughout each
development cycle.

So if DEPT is issuing lots of reports about apparently circular
dependencies, please try to be open to the thought that the fault is
in DEPT, and don't try to argue with maintainers that their code MUST
be buggy --- but since you don't understand our code, and DEPT must be
theoretically perfect, that it is up to the Maintainers to prove to
you that their code is correct.

I am going to gently suggest that it is at least as likely, if not
more likely, that the failure is in DEPT or your understanding of what
how kernel wait channels and locking works.  After all, why would it
be that we haven't found these problems via our other QA practices?

Cheers,

						- Ted
