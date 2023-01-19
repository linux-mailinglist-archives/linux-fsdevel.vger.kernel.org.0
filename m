Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57660673A5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjASNec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 08:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjASNeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:34:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617B87CCC7;
        Thu, 19 Jan 2023 05:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dd4KE++vWIKamqThkehHj7fJpHW3aChCNzZyFef73OI=; b=ZiBP9IU8e0RQ32NiZKka8MnWTR
        Dn0s9lTcFdzt4feEZuNn6vIgEPzmD5cviY4HNiw+EGim/+fdqSp83CwedDaJFyd2q2vePAOMF7R47
        /mT/pV3FrXZ0OCNIOm/rgdNiJAiF9udqbmgCvdv8tlfjrQES8QDp+06hIwoNapYXBTR+i6XKWX5ij
        qkK3CEH0iS8hZp+JgId9L10gYqA1yZnepzrHrEzU/DThBM4jGZH4pD6906x9w3V5a2ZVJlG7+GsLd
        IX8t76QoYPJmUT+lx0lOj7EEt0PIr724UtBaPXC85udHqrL+r1umcOCxsWYgULtsg+F/hymdVlFkZ
        MS0yEAZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIV3G-00106x-OP; Thu, 19 Jan 2023 13:33:58 +0000
Date:   Thu, 19 Jan 2023 13:33:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        longman@redhat.com
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
Message-ID: <Y8lGxkBrls6qQOdM@casper.infradead.org>
References: <Y8bmeffIQ3iXU3Ux@boqun-archlinux>
 <1674109388-6663-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674109388-6663-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:23:08PM +0900, Byungchul Park wrote:
> Boqun wrote:
> > *	Looks like the DEPT dependency graph doesn't handle the
> > 	fair/unfair readers as lockdep current does. Which bring the
> > 	next question.
> 
> No. DEPT works better for unfair read. It works based on wait/event. So
> read_lock() is considered a potential wait waiting on write_unlock()
> while write_lock() is considered a potential wait waiting on either
> write_unlock() or read_unlock(). DEPT is working perfect for it.
> 
> For fair read (maybe you meant queued read lock), I think the case
> should be handled in the same way as normal lock. I might get it wrong.
> Please let me know if I miss something.

From the lockdep/DEPT point of view, the question is whether:

	read_lock(A)
	read_lock(A)

can deadlock if a writer comes in between the two acquisitions and
sleeps waiting on A to be released.  A fair lock will block new
readers when a writer is waiting, while an unfair lock will allow
new readers even while a writer is waiting.

