Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C08F4CE56E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 16:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiCEPGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 10:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiCEPGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 10:06:15 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE61C65EF
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Mar 2022 07:05:25 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v3so9771541qta.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Mar 2022 07:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=geC5xDAay5dBwn3cRxysbEgCyiuAzwcwhdO/zo7/1yQ=;
        b=tixvP1FGnq2wfskq9ETIT5h8JQ7JPBjYQlaZiVU5QEF2ebRlSOd9Hj4GHFYYxuldWh
         AEzNtAg/yji+2YKFPr0a17Al0EC/FApvTFNyo+sILOPE6zyZMSw0ZdguDzVRFqh+N+G9
         axgAo/svRSLgSVS0G7iScy/imA1XKMIHb1NgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=geC5xDAay5dBwn3cRxysbEgCyiuAzwcwhdO/zo7/1yQ=;
        b=2sUriyCOJNM95aGNSbJwAR//Del16zi34IgKHR55aOtwvSjm+sHxvuLS3Yh3EpSr81
         JCrCha0CNYT881BlexzGcN9P8KydI4HkqEwjkUCYVEHCXt2JXROouyfEmTuZdQPVXwF6
         pzbHv4AdJeJeIfo/DqJFGZS770JzRUZXOoaQBLW6IApZ63bDk3vvdlQLeUi4M3SIjts1
         804DtDXs9+gLped/2V9TuQUGVLdxO3RkSOh5Ov71gw1vQc06A5LkHcD8pdQPnV2xsHTc
         Tg6RvJK9BWtgsIrI/PWbX62oftECKxgXaPq58unqXR3w/cGgeIUYLj6H3Vj36k4bbmFA
         sc7g==
X-Gm-Message-State: AOAM532+wLvuvo21uDkLVD58ERPfnewVgPccSdkCHNSae4db2AvG1HuD
        iQZWUKZAFXnlmQ57mFKpJT3ySA==
X-Google-Smtp-Source: ABdhPJzC6+sWbvHtOZiDBxeMwB424Rg3yPbjjQ/pVZIkOOUQmsA5JEXntpUeTe+z/0BHUPh5FnkxHA==
X-Received: by 2002:a05:622a:3ca:b0:2df:1cae:397b with SMTP id k10-20020a05622a03ca00b002df1cae397bmr3200121qtx.556.1646492724622;
        Sat, 05 Mar 2022 07:05:24 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id t128-20020a37aa86000000b0060ddf2dc3ecsm3859545qke.104.2022.03.05.07.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 07:05:24 -0800 (PST)
Date:   Sat, 5 Mar 2022 15:05:23 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
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
        hamohammed.sa@gmail.com, paulmck@kernel.org
Subject: Re: Report 2 in ext4 and journal based on v5.17-rc1
Message-ID: <YiN8M4FwAeW/UAoN@google.com>
References: <YiAow5gi21zwUT54@mit.edu>
 <1646285013-3934-1-git-send-email-byungchul.park@lge.com>
 <YiDSabde88HJ/aTt@mit.edu>
 <20220304004237.GB6112@X58A-UD3R>
 <YiLYX0sqmtkTEM5U@mit.edu>
 <20220305141538.GA31268@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305141538.GA31268@X58A-UD3R>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 05, 2022 at 11:15:38PM +0900, Byungchul Park wrote:
> On Fri, Mar 04, 2022 at 10:26:23PM -0500, Theodore Ts'o wrote:
> > On Fri, Mar 04, 2022 at 09:42:37AM +0900, Byungchul Park wrote:
> > > 
> > > All contexts waiting for any of the events in the circular dependency
> > > chain will be definitely stuck if there is a circular dependency as I
> > > explained. So we need another wakeup source to break the circle. In
> > > ext4 code, you might have the wakeup source for breaking the circle.
> > > 
> > > What I agreed with is:
> > > 
> > >    The case that 1) the circular dependency is unevitable 2) there are
> > >    another wakeup source for breadking the circle and 3) the duration
> > >    in sleep is short enough, should be acceptable.
> > > 
> > > Sounds good?
> > 
> > These dependencies are part of every single ext4 metadata update,
> > and if there were any unnecessary sleeps, this would be a major
> > performance gap, and this is a very well studied part of ext4.
> > 
> > There are some places where we sleep, sure.  In some case
> > start_this_handle() needs to wait for a commit to complete, and the
> > commit thread might need to sleep for I/O to complete.  But the moment
> > the thing that we're waiting for is complete, we wake up all of the
> > processes on the wait queue.  But in the case where we wait for I/O
> > complete, that wakeupis coming from the device driver, when it
> > receives the the I/O completion interrupt from the hard drive.  Is
> > that considered an "external source"?  Maybe DEPT doesn't recognize
> > that this is certain to happen just as day follows the night?  (Well,
> > maybe the I/O completion interrupt might not happen if the disk drive
> > bursts into flames --- but then, you've got bigger problems. :-)
> 
> Almost all you've been blaming at Dept are totally non-sense. Based on
> what you're saying, I'm conviced that you don't understand how Dept
> works even 1%. You don't even try to understand it before blame.
> 
> You don't have to understand and support it. But I can't response to you
> if you keep saying silly things that way.

Byungchul, other than ext4 have there been any DEPT reports that other
subsystem maintainers' agree were valid usecases?

Regarding false-positives, just to note lockdep is not without its share of
false-positives. Just that (as you know), the signal-to-noise ratio should be
high for it to be useful. I've put up with lockdep's false positives just
because it occasionally saves me from catastrophe.

> > In any case, if DEPT is going to report these "circular dependencies
> > as bugs that MUST be fixed", it's going to be pure noise and I will
> > ignore all DEPT reports, and will push back on having Lockdep replaced
> 
> Dept is going to be improved so that what you are concerning about won't
> be reported.

Yeah I am looking forward to learning more about it however I was wondering
about the following: lockdep can already be used for modeling "resource
acquire/release" and "resource wait" semantics that are unrelated to locks,
like we do in mm reclaim. I am wondering why we cannot just use those existing
lockdep mechanisms for the wait/wake usecases (Assuming that we can agree
that circular dependencies on related to wait/wake is a bad thing. Or perhaps
there's a reason why Peter Zijlstra did not use lockdep for wait/wake
dependencies (such as multiple wake sources) considering he wrote a lot of
that code.

Keep kicking ass brother, you're doing great.

Thanks,

     Joel

