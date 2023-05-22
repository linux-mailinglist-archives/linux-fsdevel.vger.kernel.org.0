Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10FB70BF1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjEVNFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjEVNEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:04:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5630495;
        Mon, 22 May 2023 06:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E146C61554;
        Mon, 22 May 2023 13:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537D5C433D2;
        Mon, 22 May 2023 13:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684760691;
        bh=mFfLhqjncW4OLzUDyLmeZPcjuCp7LsL0ZYwEqeI6upY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDOTyggWu4xxm0+x1HgMCzIkoWLn7pPelgUikEj/GT4l6ixVnKu47mQ/OF6BW+2dr
         4T/86huG8affHcPTbR7KBXk6k4ez4EEMrLDs+qlp06AQ4vvn69+X3VyKFZXlnt9gsG
         gZlHrCFQWdff4CNiRB/21DLex+JtnDOr31jKhBgYZtBefcruNvfhWvIBqEqca5ZhE6
         SRmqdUKPm5SUSncISh1SvCYNzkOz8g1Ildx3yPXdDvQLk2y6M/5B8bp5vfYXnu1zdB
         KrHFPZ8+b/o7MfMVy4+kWAjoROvQ7Jtqw6zUSliiKRlgemkP1TQAvAqwKCwH/8bh+V
         q7fvKZZR3MOYQ==
Date:   Mon, 22 May 2023 15:04:46 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <20230522-unlustig-flegel-7a1d0d0adae3@brauner>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230510044557.GF2651828@dread.disaster.area>
 <20230516-brand-hocken-a7b5b07e406c@brauner>
 <ZGOsgI7a68mWYVQH@moria.home.lan>
 <ZGQOlrcvLplTfZmf@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGQOlrcvLplTfZmf@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 09:15:34AM +1000, Dave Chinner wrote:
> On Tue, May 16, 2023 at 12:17:04PM -0400, Kent Overstreet wrote:
> > On Tue, May 16, 2023 at 05:45:19PM +0200, Christian Brauner wrote:
> > > On Wed, May 10, 2023 at 02:45:57PM +1000, Dave Chinner wrote:
> > > There's a bit of a backlog before I get around to looking at this but
> > > it'd be great if we'd have a few reviewers for this change.
> > 
> > It is well tested - it's been in the bcachefs tree for ages with zero
> > issues. I'm pulling it out of the bcachefs-prerequisites series though
> > since Dave's still got it in his tree, he's got a newer version with
> > better commit messages.
> > 
> > It's a significant performance boost on metadata heavy workloads for any
> > non-XFS filesystem, we should definitely get it in.
> 
> I've got an up to date vfs-scale tree here (6.4-rc1) but I have not
> been able to test it effectively right now because my local
> performance test server is broken. I'll do what I can on the old
> small machine that I have to validate it when I get time, but that
> might be a few weeks away....
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git vfs-scale
> 
> As it is, the inode hash-bl changes have zero impact on XFS because
> it has it's own highly scalable lockless, sharded inode cache. So
> unless I'm explicitly testing ext4 or btrfs scalability (rare) it's
> not getting a lot of scalability exercise. It is being used by the
> root filesytsems on all those test VMs, but that's about it...

I think there's a bunch of perf tests being run on -next. So we can
stuff it into a vfs.unstable.* branch and see what -next thinks of this
performance wise.
