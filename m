Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7346470E22E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 18:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbjEWQtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbjEWQtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 12:49:13 -0400
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4AE5
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 09:49:11 -0700 (PDT)
Date:   Tue, 23 May 2023 12:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684860549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G5nor1odEvltlOg9yz8O08fTQiIli5/Sp675o7e3SQw=;
        b=dE7DP+ZcesSaqKf/vGAK7JJ4yjJ//Milpfy6z8dTQLCfoYuvrp6e6BO/FxXZNN9UvCiDiY
        po8NPW1Lh4CONt501RR4qnXT19OvGnUsfVW7bmT9oXNXE9hP39nES7ra0jumcGnzf8cDZV
        ATZZtAEExaVzRfglCjVePA2yubgNfwM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>, dhowells@redhat.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH 06/32] sched: Add task_struct->faults_disabled_mapping
Message-ID: <ZGzugpw7vgCFxOYL@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523133431.wwrkjtptu6vqqh5e@quack3>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > No, that's definitely handled (and you can see it in the code I linked),
> > and I wrote a torture test for fstests as well.
> 
> I've checked the code and AFAICT it is all indeed handled. BTW, I've now
> remembered that GFS2 has dealt with the same deadlocks - b01b2d72da25
> ("gfs2: Fix mmap + page fault deadlocks for direct I/O") - in a different
> way (by prefaulting pages from the iter before grabbing the problematic
> lock and then disabling page faults for the iomap_dio_rw() call). I guess
> we should somehow unify these schemes so that we don't have two mechanisms
> for avoiding exactly the same deadlock. Adding GFS2 guys to CC.

Oof, that sounds a bit sketchy. What happens if the dio call passes in
an address from the same address space? What happens if we race with the
pages we faulted in being evicted?

> Also good that you've written a fstest for this, that is definitely a useful
> addition, although I suspect GFS2 guys added a test for this not so long
> ago when testing their stuff. Maybe they have a pointer handy?

More tests more good.

So if we want to lift this scheme to the VFS layer, we'd start by
replacing the lock you added (grepping for it, the name escapes me) with
a different type of lock - two_state_shared_lock in my code, it's like a
rw lock except writers don't exclude other writers. That way the DIO
path can use it without singlethreading writes to a single file.
