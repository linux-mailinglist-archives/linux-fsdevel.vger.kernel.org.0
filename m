Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D42B530701
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 03:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiEWBMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 21:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiEWBMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 21:12:42 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBE65377F9
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 18:12:37 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 23 May 2022 10:12:36 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 23 May 2022 10:12:36 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Mon, 23 May 2022 10:10:45 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     tj@kernel.org, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com,
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
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, mcgrof@kernel.org, holt@sgi.com
Subject: Re: [REPORT] syscall reboot + umh + firmware fallback
Message-ID: <20220523011045.GA16721@X58A-UD3R>
References: <YnzQHWASAxsGL9HW@slm.duckdns.org>
 <1652354304-17492-1-git-send-email-byungchul.park@lge.com>
 <Yn0SHhnhB8fyd0jq@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn0SHhnhB8fyd0jq@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 09:56:46AM -0400, Theodore Ts'o wrote:
> On Thu, May 12, 2022 at 08:18:24PM +0900, Byungchul Park wrote:
> > I have a question about this one. Yes, it would never been stuck thanks
> > to timeout. However, IIUC, timeouts are not supposed to expire in normal
> > cases. So I thought a timeout expiration means not a normal case so need
> > to inform it in terms of dependency so as to prevent further expiraton.
> > That's why I have been trying to track even timeout'ed APIs.
> 
> As I beleive I've already pointed out to you previously in ext4 and
> ocfs2, the jbd2 timeout every five seconds happens **all** the time
> while the file system is mounted.  Commits more frequently than five
> seconds is the exception case, at least for desktops/laptop workloads.

Thanks, Ted. It's easy to stop tracking APIs with timeout. I've been
just afraid that the cases that we want to suppress anyway will be
skipped.

However, I should stop it if it produces too many false alarms.

> We *don't* get to the timeout only when a userspace process calls
> fsync(2), or if the journal was incorrectly sized by the system
> administrator so that it's too small, and the workload has so many
> file system mutations that we have to prematurely close the
> transaction ahead of the 5 second timeout.

Yeah... It's how journaling works. Thanks.

> > Do you think DEPT shouldn't track timeout APIs? If I was wrong, I
> > shouldn't track the timeout APIs any more.
> 
> DEPT tracking timeouts will cause false positives in at least some
> cases.  At the very least, there needs to be an easy way to suppress
> these false positives on a per wait/mutex/spinlock basis.

The easy way is to stop tracking those that are along with timeout until
DEPT starts to consider waits/events by timeout functionality itself.

Thanks.

	Byungchul
> 
>       	       	    	     	      	   	 - Ted
