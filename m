Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02E26786E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 20:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjAWTyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 14:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjAWTyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:54:25 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEA259EE;
        Mon, 23 Jan 2023 11:54:23 -0800 (PST)
Date:   Mon, 23 Jan 2023 14:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674503662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CdSQ03pYT6WirvAUNHMhKox0iGIyl9THQc3ark5MEwo=;
        b=MkamxbSLfWCz3S94Q5h94SbVDr40BLxpRcAac8P8Ee03u4xFoqIBCzRC9uSRdPoQgdsehf
        J+w7y+mpwDQ2EW3TxRGasOKRf1EP0ZVJRFEMg5YNlXpHKpnwMZAEzQT1Y4JFFcWtumFXDy
        /HD8erIZYR3lCf3R2tVGCidNWzHlX1I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/aio: obey min_nr when doing wakeups
Message-ID: <Y87l6sd9JRGa+qFw@moria.home.lan>
References: <20230118152603.28301-1-kent.overstreet@linux.dev>
 <20230120140347.2133611-1-kent.overstreet@linux.dev>
 <x49cz7956ox.fsf@segfault.boston.devel.redhat.com>
 <x491qnl5ioe.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x491qnl5ioe.fsf@segfault.boston.devel.redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:17:53AM -0500, Jeff Moyer wrote:
> Jeff Moyer <jmoyer@redhat.com> writes:
> 
> > Hi, Kent,
> >
> > Kent Overstreet <kent.overstreet@linux.dev> writes:
> >
> >> I've been observing workloads where IPIs due to wakeups in
> >> aio_complete() are ~15% of total CPU time in the profile. Most of those
> >> wakeups are unnecessary when completion batching is in use in
> >> io_getevents().
> >>
> >> This plumbs min_nr through via the wait eventry, so that aio_complete()
> >> can avoid doing unnecessary wakeups.
> >>
> >> v2: This fixes a race in the first version of the patch. If we read some
> >> events out after adding to the waitlist, we need to update wait.min_nr
> >> call prepare_to_wait_event() again before scheduling.
> >
> > I like the idea of the patch, and I'll get some real world performance
> > numbers soon.  But first, this version (and the previous version as
> > well) fails test case 23 in the libaio regression test suite:
> >
> > Starting cases/23.p
> > FAIL: poll missed an event!
> > FAIL: poll missed an event!
> > test cases/23.t completed FAILED.
> 
> It turns out that this only fails on the (relatively) old kernel against
> which I applied the patches.  When I apply both patches to the latest
> tree, there is no test failure.
> 
> Sorry for the noise, I'll be sure to test on the latest going forward.
> Now to figure out what changed elsewhere to fix this....

That's odd - let me know if you'd like me to take a look...
