Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEB46E70FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 04:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjDSCLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 22:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjDSCLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:11:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E739658E;
        Tue, 18 Apr 2023 19:11:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC474636CA;
        Wed, 19 Apr 2023 02:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BBFC433EF;
        Wed, 19 Apr 2023 02:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681870307;
        bh=RKi7Mt6EnsUgm9EEYpL4pOEZIaDxUzgisEqdQQ4QX7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfPhPb9RCnw9X9uVWJzHxH4h7bieavnTe/rDlR1TrBXSZTzAqzB/RZ/pPF7rOykeX
         kP4Gc/8INWBTmZij7298MvbJCdgbF5polstlseYzDPso/FqD8aQ2l+NNH8aEjmVCzl
         GLm4pY2m8aOggCrVFJpMAef/WqG+3UkWEepdbovYfmbmTdWo1xIimUh5XbeRdeVTDe
         j43negha1JK8RFU23nKLgEZpjHf/wrx+bBY4Iaztp5MMnyHpR9La5v5ruj6BC6DkeE
         yMoJ8zoQgHzXw9JwTNgZCowcaff91Ygby2WkGHk1hbvrSA8sw+vSuQRj/b636pDk8E
         IEvTESWOgMdgQ==
Date:   Tue, 18 Apr 2023 19:11:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] online repair of filesystems: what next?
Message-ID: <20230419021146.GE360889@frogsfrogsfrogs>
References: <Y/5ovz6HI2Z47jbk@magnolia>
 <CAOQ4uxj6mNbGQBSpg-KpSiDa2UugBFXki4HhM4DPvXeAQMnRWg@mail.gmail.com>
 <20230418044641.GD360881@frogsfrogsfrogs>
 <CAOQ4uxgUOuR80jsAE2DkZhMPVNT_WwnsSX8-GSkZO4=k3VbCsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgUOuR80jsAE2DkZhMPVNT_WwnsSX8-GSkZO4=k3VbCsw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023 at 10:46:32AM +0300, Amir Goldstein wrote:
> On Tue, Apr 18, 2023 at 7:46 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Sat, Apr 15, 2023 at 03:18:05PM +0300, Amir Goldstein wrote:
> > > On Tue, Feb 28, 2023 at 10:49 PM Darrick J. Wong <djwong@kernel.org> wrote:
> ...
> > > Darrick,
> > >
> > > Quick question.
> > > You indicated that you would like to discuss the topics:
> > > Atomic file contents exchange
> > > Atomic directio writes
> >
> > This one ^^^^^^^^ topic should still get its own session, ideally with
> > Martin Petersen and John Garry running it.  A few cloud vendors'
> > software defined storage stacks can support multi-lba atomic writes, and
> > some database software could take advantage of that to reduce nested WAL
> > overhead.
> >
> 
> CC Martin.
> If you want to lead this session, please schedule it.
> 
> > > Are those intended to be in a separate session from online fsck?
> > > Both in the same session?
> > >
> > > I know you posted patches for FIEXCHANGE_RANGE [1],
> > > but they were hiding inside a huge DELUGE and people
> > > were on New Years holidays, so nobody commented.
> >
> > After 3 years of sparse review comments, I decided to withdraw
> > FIEXCHANGE_RANGE from general consideration after realizing that very
> > few filesystems actually have the infrastructure to support atomic file
> > contents exchange, hence there's little to be gained from undertaking
> > fsdevel bikeshedding.
> >
> > > Perhaps you should consider posting an uptodate
> > > topic suggestion to let people have an opportunity to
> > > start a discussion before LSFMM.
> >
> > TBH, most of my fs complaints these days are managerial problems (Are we
> > spending too much time on LTS?  How on earth do we prioritize projects
> > with all these drive by bots??  Why can't we support large engineering
> > efforts better???) than technical.
> 
> I penciled one session for "FS stable backporting (and other LTS woes)".
> I made it a cross FS/IO session so we can have this session in the big room
> and you are welcome to pull this discussion to any direction you want.

Ok, thank you.  Hopefully we can get all the folks who do backports into
this one.  That might be a big ask for Chandan, depending on when you
schedule it.

(Unless it's schedule for 7pm :P)

> >
> > (I /am/ willing to have a "Online fs metadata reconstruction: How does
> > it work, and can I have some of what you're smoking?" BOF tho)
> >
> 
> I penciled a session for this one already.
> Maybe it would be interesting for the crowd to hear some about
> "behind the scenes" - how hard it was and still is to pull off an
> engineering project of this scale - lessons learned, things that
> you might have done differently.

Thanks!

--D

> 
> Cheers,
> Amir.
