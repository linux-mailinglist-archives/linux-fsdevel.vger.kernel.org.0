Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809CC72A343
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 21:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjFITiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 15:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFITiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:38:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B37E0;
        Fri,  9 Jun 2023 12:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A3C460B5E;
        Fri,  9 Jun 2023 19:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8656C433EF;
        Fri,  9 Jun 2023 19:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686339532;
        bh=KQ+ES1E5wxW23Q6pqFG/rgRMYzDlynrMzW80Gfo0T2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfwMswqtVJFTIfibEupHCJvRXnjzMvUKlJoYkcqPQHI6cX5jBk6h9xuZeGD6PRbS2
         ZNIkBHCV6z6HB5DxvGKQ8bO2m+nDBUme8rZyUmWbvOSs44ARURQWQjNJYLzk0VMLmd
         C5HzhRJ254sPIDIF9qEEQsPKb3UzFBhgBFzYzVJyaJPAF70FuNoyt+RqbL0j7wZUWf
         XkLCl4NjV8XwIOJbSFz4vVo12dy4wWk4tNYwx/HPWTVzElY/wMfabPtGs/0P5TP1Rn
         4w7N5MGdXIeia6BqFh6u88QmZ7L30bBfP2fYgGVX5Bknh2/rEREd3VzWIki/BEFO8d
         qEHmTcHAMw++g==
Date:   Fri, 9 Jun 2023 12:38:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: fuzzing bcachefs with dm-flakey
Message-ID: <20230609193852.GI72224@frogsfrogsfrogs>
References: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com>
 <20230602011355.GA16848@frogsfrogsfrogs>
 <7bf96e58-7151-a63d-317f-1ddedd4927ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf96e58-7151-a63d-317f-1ddedd4927ad@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 08:56:37PM +0200, Mikulas Patocka wrote:
> 
> 
> On Thu, 1 Jun 2023, Darrick J. Wong wrote:
> 
> > On Mon, May 29, 2023 at 04:59:40PM -0400, Mikulas Patocka wrote:
> >
> > > #!/bin/sh -ex
> > > umount /mnt/test || true
> > > dmsetup remove_all || true
> > > rmmod brd || true
> > > SRC=/usr/src/git/bcachefs-tools
> > > while true; do
> > >         modprobe brd rd_size=1048576
> > >         bcachefs format --replicas=2 /dev/ram0 /dev/ram1
> > >         dmsetup create flakey --table "0 `blockdev --getsize /dev/ram0` linear /dev/ram0 0"
> > >         mount -t bcachefs /dev/mapper/flakey:/dev/ram1 /mnt/test
> > >         dmsetup load flakey --table "0 `blockdev --getsize /dev/ram0` flakey /dev/ram0 0 0 1 4 random_write_corrupt 100000000 random_read_corrupt 100000000"
> > 
> > Hey, that's really neat!
> > 
> > Any chance you'd be willing to get the dm-flakey changes merged into
> > upstream so that someone can write a recoveryloop fstest to test all the
> > filesystems systematically?
> > 
> > :D
> > 
> > --D
> 
> Yes, we will merge improved dm-flakey in the next merge window.

Thank you!

--D

> Mikulas
> 
