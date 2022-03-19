Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FAA4E18E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 23:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244312AbiCSWug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 18:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244305AbiCSWuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 18:50:35 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BAB49912;
        Sat, 19 Mar 2022 15:49:11 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22JMn9qk026585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Mar 2022 18:49:10 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6AFEB15C0038; Sat, 19 Mar 2022 18:49:09 -0400 (EDT)
Date:   Sat, 19 Mar 2022 18:49:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
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
Subject: Re: [PATCH RFC v5 00/21] DEPT(Dependency Tracker)
Message-ID: <YjZd5ff1DiKQnsrv@mit.edu>
References: <1647397593-16747-1-git-send-email-byungchul.park@lge.com>
 <YjKtZxjIKDJqsSrP@mit.edu>
 <20220318074945.GA17484@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318074945.GA17484@X58A-UD3R>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 04:49:45PM +0900, Byungchul Park wrote:
> 
> I guess it was becasue of the commit b1fca27d384e8("kernel debug:
> support resetting WARN*_ONCE"). Your script seems to reset WARN*_ONCE
> repeatedly.

I wasn't aware this was being done, but your guess was correct.  The
WARN_ONCE state is getting cleared between each test in xfstests, with
the rationale (which IMO is quite reasonable) why this done in the
xfstests commit descrition:

commit c67ea2347454aebbe8eb6e825e9314d099b683da
Author: Lukas Czerner <lczerner@redhat.com>
Date:   Wed Jul 15 13:42:19 2020 +0200

    check: clear WARN_ONCE state before each test
    
    clear WARN_ONCE state before each test to allow a potential problem
    to be reported for each test
    
    [Eryu: replace "/sys/kernel/debug" with $DEBUGFS_MNT ]
    
    Signed-off-by: Lukas Czerner <lczerner@redhat.com>
    Reviewed-by: Zorro Lang <zlang@redhat.com>
    Signed-off-by: Eryu Guan <guaneryu@gmail.com>

Cheers,

						- Ted
