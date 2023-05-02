Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27C36F40C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjEBKMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEBKM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446A1BFF;
        Tue,  2 May 2023 03:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F8F8622AF;
        Tue,  2 May 2023 10:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B07C433EF;
        Tue,  2 May 2023 10:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683022346;
        bh=aM94D7DjS72A/xp1gAzDQwrhIU7LM7u1+sqKjvi5MHk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eLxA1yXf39CWFW9N6n3/xRGGcd/EQyeBUrgZcgthpSDgueB/Td+pzErg6LRLJG6cW
         0XUhgGKXEz++uqaciP6qgrDZL6x0NYjUnLRlt54TgRjEB5fQyqAZ1WQ9cnPCwy3Nx1
         oLdsYIDvkvI7DCVgxSg0bk9sBTVIZ8Qe2BBQfVRDFx34ENNLVWiaAV7QgRW2rb3vuE
         6h9uZqfoQEZYcLyeiSDjlJ14aQea/M7XJx+8Zgks4fxnXglZlaCL5iLF6CeI/HQc6G
         8To9CcfpiGx4cU1jkv1qPoIuDw7X7ZpK9DRH8BdBYs2o7gP8ESDOk2SIQYdxfVRX/X
         FudCgXb+t2LJw==
Message-ID: <500fc91b75ef67263825cf3410a8a66c7bc0fd85.camel@kernel.org>
Subject: Re: [jlayton:ctime] [ext4]  ff9aaf58e8: ltp.statx06.fail
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-ext4@vger.kernel.org, ltp@lists.linux.it,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 02 May 2023 06:12:24 -0400
In-Reply-To: <20230502003929.GG2155823@dread.disaster.area>
References: <202305012130.cc1e2351-oliver.sang@intel.com>
         <0dc1a9d7f2b99d2bfdcabb7adc51d7c0b0c81457.camel@kernel.org>
         <20230502003929.GG2155823@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-05-02 at 10:39 +1000, Dave Chinner wrote:
> On Mon, May 01, 2023 at 12:05:17PM -0400, Jeff Layton wrote:
> > On Mon, 2023-05-01 at 22:09 +0800, kernel test robot wrote:
> > The test does this:
> >=20
> >         SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &before_time);
> >         clock_wait_tick();
> >         tc->operation();
> >         clock_wait_tick();
> >         SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
> >=20
> > ...and with that, I usually end up with before/after_times that are 1ns
> > apart, since my machine is reporting a 1ns granularity.
> >=20
> > The first problem is that the coarse grained timestamps represent the
> > lower bound of what time could end up in the inode. With multigrain
> > ctimes, we can end up grabbing a fine-grained timestamp to store in the
> > inode that will be later than either coarse grained time that was
> > fetched.
> >=20
> > That's easy enough to fix -- grab a coarse time for "before" and a fine=
-
> > grained time for "after".
> >=20
> > The clock_getres function though returns that it has a 1ns granularity
> > (since it does). With multigrain ctimes, we no longer have that at the
> > filesystem level. It's a 2ns granularity now (as we need the lowest bit
> > for the flag).
>=20
> Why are you even using the low bit for this? Nanosecond resolution
> only uses 30 bits, leaving the upper two bits of a 32 bit tv_nsec
> field available for internal status bits. As long as we mask out the
> internal bits when reading the VFS timestamp tv_nsec field, then
> we don't need to change the timestamp resolution, right?
>=20

Yeah, that should work. Let me give that a shot on the next pass.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
