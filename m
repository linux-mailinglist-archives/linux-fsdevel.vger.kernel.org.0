Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C936AD6A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 06:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCGFBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 00:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGFBv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:01:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6A33B3FC;
        Mon,  6 Mar 2023 21:01:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E22CFB8161C;
        Tue,  7 Mar 2023 05:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F79C433D2;
        Tue,  7 Mar 2023 05:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678165307;
        bh=cEhxih94ZjGhw6kTOPnnZBI2n9iuMQVze6VasxV7f5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ojih9CPNe7+w2o8LmcXKBRsfqIpxUOG7hDPkv8Ka54AWddLSpVhZubQi7k2oJbuOR
         +JufDA97ufTqvX9CLtlIiQQa1MScjaSVunWowDPy5IF3+tdi2GrMIkjfLAKiFa2dVl
         WA/P/E9uXd1uo0BKSBnVX3bH8U7uI34sFTGNc+dcCHOe+p0tsWSImj5ExUq1wruq6o
         kMWmOX/Wfdf803ZiXudMCFVcM5nNETm4iZhe2EUiJOLbat+D656co0lOlPC5P9LG52
         KKvXycp4zoQJo0rWaOUeACpMR9zjMuJCf95H928PCY2aEI0nmrq2pkewm2aH/RlB4Z
         X5DWtGDOOULqg==
Date:   Mon, 6 Mar 2023 21:01:46 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] bcachefs
Message-ID: <20230307050146.GA1637838@frogsfrogsfrogs>
References: <Y/ZxFwCasnmPLUP6@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ZxFwCasnmPLUP6@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 22, 2023 at 02:46:31PM -0500, Kent Overstreet wrote:
> Hi, I'd like to give an update on bcachefs progress and talk about
> upstreaming.
> 
> There's been a lot of activity over the past year or so:
>  - allocator rewrite
>  - cycle detector for deadlock avoidance

XFS has rather a lot of locks and no ability to unwind a transaction
that has already dirtied incore state.  I bet you and I could have some
very interesting discussions about how to implement robust tx undo in a
filesystem.

(Not sure the /rest/ of the lsf crowd are going to care, but I do.)

>  - backpointers
>  - test infrastructure!

<cough> "test dashboard that we can all share" ?

>  - starting to integrate rust code (!)

I'm curious to hear about this topic, because I look at rust, and I look
at supercomplex filesystem code and wonder how in the world we're ever
going to port a (VERY SIMPLE) filesystem to Rust.  Now that I'm nearly
done with online repair for XFS, there's a lot of stupid crap about C
that I would like to start worrying about less because some other
language added enough guard rails to avoid the stupid.

>  - lots more bug squashing, scalability work, debug tooling improvements
> 
> I'd like to talk more about where things are at, long term goals, and
> finally upstreaming this beast.

Go for it, I say.

--D
