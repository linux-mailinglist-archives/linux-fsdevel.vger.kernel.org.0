Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1165670CF22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 02:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjEWAY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 20:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjEWAM4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 20:12:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D52E1FF6;
        Mon, 22 May 2023 17:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEB7A62C96;
        Tue, 23 May 2023 00:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14837C4339B;
        Tue, 23 May 2023 00:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684800031;
        bh=lyfJmGLkgdjgHeJSrLwwF6HfUqdYiWsGQeIjY/eZY1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ScFA+6V/haACDctyNZcJLiBoeSdsbN1/9GRgY0vOch4RpWSQFKgM1bgtrdD06dQUc
         Bzdm6yUWJmf69K0Vd10lOudLMjqO4bfURM5zGjvi+zsuunoLarb4r0I2sBZI8ZqFgb
         tgxusQdeSMYpv+Naki3HAekF/GQPmeFIkKgItnPLHJfUG+zc5LINDg83GLwxGlLm7z
         CXAQd4XKKJXb640o3oRKTwqmtbufleHG3gBbkcbSbxjTd692KuVk/UVhSs/rKdOI2E
         WuOULd1zxmWLGr5xoIVY1i3s7el31WsSpWZ+K/EFXUWoCyhq6EqbloBhps/JZTlvGk
         qVSLYgtLjKNlg==
Date:   Tue, 23 May 2023 00:00:29 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Pengfei Xu <pengfei.xu@intel.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, heng.su@intel.com,
        dchinner@redhat.com, lkp@intel.com,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [Syzkaller & bisect] There is BUG: unable to handle kernel NULL
 pointer dereference in xfs_extent_free_diff_items in v6.4-rc3
Message-ID: <20230523000029.GB3187780@google.com>
References: <ZGrOYDZf+k0i4jyM@xpf.sh.intel.com>
 <ZGsOH5D5vLTLWzoB@debian.me>
 <20230522160525.GB11620@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522160525.GB11620@frogsfrogsfrogs>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 09:05:25AM -0700, Darrick J. Wong wrote:
> On Mon, May 22, 2023 at 01:39:27PM +0700, Bagas Sanjaya wrote:
> > On Mon, May 22, 2023 at 10:07:28AM +0800, Pengfei Xu wrote:
> > > Hi Darrick,
> > > 
> > > Greeting!
> > > There is BUG: unable to handle kernel NULL pointer dereference in
> > > xfs_extent_free_diff_items in v6.4-rc3:
> > > 
> > > Above issue could be reproduced in v6.4-rc3 and v6.4-rc2 kernel in guest.
> > > 
> > > Bisected this issue between v6.4-rc2 and v5.11, found the problem commit is:
> > > "
> > > f6b384631e1e xfs: give xfs_extfree_intent its own perag reference
> > > "
> > > 
> > > report0, repro.stat and so on detailed info is link: https://github.com/xupengfe/syzkaller_logs/tree/main/230521_043336_xfs_extent_free_diff_items
> > > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/repro.c
> > > Syzkaller reproduced prog: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/repro.prog
> > > Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/kconfig_origin
> > > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/bisect_info.log
> > > Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/v6.4-rc3_reproduce_dmesg.log
> > > 
> > > v6.4-rc3 reproduced info:
> 
> Diagnosis and patches welcomed.
> 
> Or are we doing the usual syzbot bullshit where you all assume that I'm
> going to do all the fucking work for you?
> 

It looks like Pengfei already took the time to manually bisect this issue to a
very recent commit authored by you.  Is that not helpful?

(Apologies if I didn't include enough profanities for this email to be suitable
for linux-xfs@.)

- Eric
