Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373AB717DD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbjEaLPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjEaLPu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5161107;
        Wed, 31 May 2023 04:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50662639C2;
        Wed, 31 May 2023 11:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B355C433EF;
        Wed, 31 May 2023 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685531748;
        bh=5Z/ncIIcZ7JrClaUclZ6ZS2IJVWcebebdWD3/h3CjS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9qOuMTW4BKRHf8TO2UJhIzgvmVQk3fWdTT4gt7FrY1jEf+fGA0aCWbzGOrx5F9Vq
         GQc0PZ7A2sFlJMy+q9FH1xrWVPPqbiYUZrGSOJblwsjmCU+KtDotXNKH2udP8/mSq8
         GchTRv5iUNFL551UfzLRXYP8ShbA/ZbiySlhqYFwzZShO6+CRdEeVM+YumIMt5aRMg
         bsnHYDcnXgQaV46kNEV3OXKGn51Pqzk9L8DaSJTqCjAX6Z7rNsFWZRJncqs+HNsyR7
         eRVMzWqCoTpx/KaAdHOCvShbFGEYGMnR52wnIZFiGUWBSofLzNRfn+ebJxNci3ZE/n
         E/TuKQ9mpeD6w==
Date:   Wed, 31 May 2023 13:15:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     chenzhiyin <zhiyin.chen@intel.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nanhai.zou@intel.com
Subject: Re: [PATCH] fs.h: Optimize file struct to prevent false sharing
Message-ID: <20230531-symmetrie-absender-8e9af6834753@brauner>
References: <20230530020626.186192-1-zhiyin.chen@intel.com>
 <20230530-wortbruch-extra-88399a74392e@brauner>
 <CAOQ4uxhAn9JOGioLwqt0W6AvS532B5KOFzanWfPOBEuYHsDPTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhAn9JOGioLwqt0W6AvS532B5KOFzanWfPOBEuYHsDPTA@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 01:02:06PM +0300, Amir Goldstein wrote:
> On Tue, May 30, 2023 at 12:31 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, May 29, 2023 at 10:06:26PM -0400, chenzhiyin wrote:
> > > In the syscall test of UnixBench, performance regression occurred
> > > due to false sharing.
> > >
> > > The lock and atomic members, including file::f_lock, file::f_count
> > > and file::f_pos_lock are highly contended and frequently updated
> > > in the high-concurrency test scenarios. perf c2c indentified one
> > > affected read access, file::f_op.
> > > To prevent false sharing, the layout of file struct is changed as
> > > following
> > > (A) f_lock, f_count and f_pos_lock are put together to share the
> > > same cache line.
> > > (B) The read mostly members, including f_path, f_inode, f_op are
> > > put into a separate cache line.
> > > (C) f_mode is put together with f_count, since they are used
> > > frequently at the same time.
> > >
> > > The optimization has been validated in the syscall test of
> > > UnixBench. performance gain is 30~50%, when the number of parallel
> > > jobs is 16.
> > >
> > > Signed-off-by: chenzhiyin <zhiyin.chen@intel.com>
> > > ---
> >
> > Sounds interesting, but can we see the actual numbers, please?
> > So struct file is marked with __randomize_layout which seems to make
> > this whole reordering pointless or at least only useful if the
> > structure randomization Kconfig is turned off. Is there any precedence
> > to optimizing structures that are marked as randomizable?
> 
> Good question!
> 
> Also does the impressive improvement is gained only with (A)+(B)+(C)?
> 
> (A) and (B) make sense, but something about the claim (C) does not sit right.
> Can you explain this claim?
> 
> Putting the read mostly f_mode with frequently updated f_count seems
> counter to the goal of your patch.
> Aren't f_mode and f_flags just as frequently accessed as f_op?
> Shouldn't f_mode belong with the read-mostly members?
> 
> What am I missing?

I think that f_mode will be more heavily used because it's checked
everytime you call fget variants. For example, f_mode is used to check
whether the file you're about to get a reference to is an O_PATH file
and, depending on the fget variant that the caller used, denies or
allows the caller to get a reference on that file depending on whether
FMODE_PATH is or isn't set. So you have 

        if (unlikely(file->f_mode & mask))
        if (unlikely(!get_file_rcu(file))) // this is just try to bump f_count

everytime you call an fget variant which should be substantial. Other
places are fdget_pos() where f_mode is also checked right after an
fdget()...
