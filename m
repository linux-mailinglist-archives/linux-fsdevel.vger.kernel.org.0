Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB26FD6A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 08:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjEJGS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 02:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjEJGSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 02:18:53 -0400
Received: from out-10.mta1.migadu.com (out-10.mta1.migadu.com [IPv6:2001:41d0:203:375::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC8E2125
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 23:18:51 -0700 (PDT)
Date:   Wed, 10 May 2023 02:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683699529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=55Q8X6t02662mXQC8+LwTPOHKnb3j6o+rlHjx+N49Hg=;
        b=mLR/oq1oA26vtjEchErKnUDqmPN/zAImxyvJCM190/MgRMWxACL21IkwwDIIHANTb5MyGI
        eAZCVOVSeEGXkHMgEUGClnRcpt57PHHrZFosb2W1ZpoA1M3hKKmPirWTOte064phHcWjmO
        nmPp4HM7hyukvVDlP4nm4bsTyjg8fq4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>, dhowells@redhat.com
Subject: Re: [PATCH 06/32] sched: Add task_struct->faults_disabled_mapping
Message-ID: <ZFs3RYgdCeKjxYCw@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510010737.heniyuxazlprrbd6@quack3>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 03:07:37AM +0200, Jan Kara wrote:
> On Tue 09-05-23 12:56:31, Kent Overstreet wrote:
> > From: Kent Overstreet <kent.overstreet@gmail.com>
> > 
> > This is used by bcachefs to fix a page cache coherency issue with
> > O_DIRECT writes.
> > 
> > Also relevant: mapping->invalidate_lock, see below.
> > 
> > O_DIRECT writes (and other filesystem operations that modify file data
> > while bypassing the page cache) need to shoot down ranges of the page
> > cache - and additionally, need locking to prevent those pages from
> > pulled back in.
> > 
> > But O_DIRECT writes invoke the page fault handler (via get_user_pages),
> > and the page fault handler will need to take that same lock - this is a
> > classic recursive deadlock if userspace has mmaped the file they're DIO
> > writing to and uses those pages for the buffer to write from, and it's a
> > lock ordering deadlock in general.
> > 
> > Thus we need a way to signal from the dio code to the page fault handler
> > when we already are holding the pagecache add lock on an address space -
> > this patch just adds a member to task_struct for this purpose. For now
> > only bcachefs is implementing this locking, though it may be moved out
> > of bcachefs and made available to other filesystems in the future.
> 
> It would be nice to have at least a link to the code that's actually using
> the field you are adding.

Bit of a trick to link to a _later_ patch in the series from a commit
message, but...

https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/fs-io.c#n975
https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/fs-io.c#n2454

> Also I think we were already through this discussion [1] and we ended up
> agreeing that your scheme actually solves only the AA deadlock but a
> malicious userspace can easily create AB BA deadlock by running direct IO
> to file A using mapped file B as a buffer *and* direct IO to file B using
> mapped file A as a buffer.

No, that's definitely handled (and you can see it in the code I linked),
and I wrote a torture test for fstests as well.

David Howells was also just running into a strange locking situation with
iov_iters and recursive gups - I don't recall all the details, but it
sounded like this might be a solution for that. David, did you have
thoughts on that?
