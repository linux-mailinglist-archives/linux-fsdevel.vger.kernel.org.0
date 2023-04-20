Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ABB6E891F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 06:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjDTEcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 00:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDTEcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 00:32:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFF42D5D;
        Wed, 19 Apr 2023 21:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97A0863A98;
        Thu, 20 Apr 2023 04:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41ACC433D2;
        Thu, 20 Apr 2023 04:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681965135;
        bh=8R4HtSqQRUTLjicHkQSSY5ou4pZTTzXkvITRZgFV+E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGlKghtiWpyeSX4KBX/U2YWmljw6ggohuKe1v9sEgvAwJQcAxkxZ+jYm1mwkBe0d8
         EAj8Jd8w7XE/6YQqbSpPlNlN6j5cWF24HQOT7QgoFAc+LwxdhrxVqG3jD4heisGLin
         qf2RqZ1oYpiAh6A7bXTK88jnpUomVU9RsxctxA0ckZxxwBE0kWvlCfEa8LoJFmedxo
         RyJ2fi3eAbQTF4juuLDu3QgD7DjCEWWc+Ld24qreO3Cof3Xe7rIaM/cMD+Q5pDXWPQ
         7UpZuUVK76dRPGwwRdwmfNxae+NKDXGb2VDtC2JhVOgt1uQkCuYPc3c2OH/KbzsOqw
         uDJ9jTwmpcpMA==
Date:   Wed, 19 Apr 2023 21:32:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chandan Babu R <chandan.babu@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] online repair of filesystems: what next?
Message-ID: <20230420043214.GF360881@frogsfrogsfrogs>
References: <Y/5ovz6HI2Z47jbk@magnolia>
 <CAOQ4uxj6mNbGQBSpg-KpSiDa2UugBFXki4HhM4DPvXeAQMnRWg@mail.gmail.com>
 <20230418044641.GD360881@frogsfrogsfrogs>
 <CAOQ4uxgUOuR80jsAE2DkZhMPVNT_WwnsSX8-GSkZO4=k3VbCsw@mail.gmail.com>
 <20230419021146.GE360889@frogsfrogsfrogs>
 <CAOQ4uxjmTBi9B=0mMKf6i8usLJ2GrAp88RhxFcQcGFK1LjQ_Lw@mail.gmail.com>
 <875y9st2lk.fsf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875y9st2lk.fsf@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 04:28:48PM +0530, Chandan Babu R wrote:
> On Wed, Apr 19, 2023 at 07:06:58 AM +0300, Amir Goldstein wrote:
> > On Wed, Apr 19, 2023 at 5:11 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >>
> >> On Tue, Apr 18, 2023 at 10:46:32AM +0300, Amir Goldstein wrote:
> >> > On Tue, Apr 18, 2023 at 7:46 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >> > >
> >> > > On Sat, Apr 15, 2023 at 03:18:05PM +0300, Amir Goldstein wrote:
> >> > > > On Tue, Feb 28, 2023 at 10:49 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >> > ...
> >> > > > Darrick,
> >> > > >
> >> > > > Quick question.
> >> > > > You indicated that you would like to discuss the topics:
> >> > > > Atomic file contents exchange
> >> > > > Atomic directio writes
> >> > >
> >> > > This one ^^^^^^^^ topic should still get its own session, ideally with
> >> > > Martin Petersen and John Garry running it.  A few cloud vendors'
> >> > > software defined storage stacks can support multi-lba atomic writes, and
> >> > > some database software could take advantage of that to reduce nested WAL
> >> > > overhead.
> >> > >
> >> >
> >> > CC Martin.
> >> > If you want to lead this session, please schedule it.
> >> >
> >> > > > Are those intended to be in a separate session from online fsck?
> >> > > > Both in the same session?
> >> > > >
> >> > > > I know you posted patches for FIEXCHANGE_RANGE [1],
> >> > > > but they were hiding inside a huge DELUGE and people
> >> > > > were on New Years holidays, so nobody commented.
> >> > >
> >> > > After 3 years of sparse review comments, I decided to withdraw
> >> > > FIEXCHANGE_RANGE from general consideration after realizing that very
> >> > > few filesystems actually have the infrastructure to support atomic file
> >> > > contents exchange, hence there's little to be gained from undertaking
> >> > > fsdevel bikeshedding.
> >> > >
> >> > > > Perhaps you should consider posting an uptodate
> >> > > > topic suggestion to let people have an opportunity to
> >> > > > start a discussion before LSFMM.
> >> > >
> >> > > TBH, most of my fs complaints these days are managerial problems (Are we
> >> > > spending too much time on LTS?  How on earth do we prioritize projects
> >> > > with all these drive by bots??  Why can't we support large engineering
> >> > > efforts better???) than technical.
> >> >
> >> > I penciled one session for "FS stable backporting (and other LTS woes)".
> >> > I made it a cross FS/IO session so we can have this session in the big room
> >> > and you are welcome to pull this discussion to any direction you want.
> >>
> >> Ok, thank you.  Hopefully we can get all the folks who do backports into
> >> this one.  That might be a big ask for Chandan, depending on when you
> >> schedule it.
> >>
> >> (Unless it's schedule for 7pm :P)
> >>
> >
> > Oh thanks for reminding me!
> > I moved it to Wed 9am, so it is more convenient for Chandan.
> 
> This maps to 9:30 AM for me. Thanks for selecting a time which is convenient
> for me.

Er... doesn't 9:30am for Chandan map to 9:00*pm* the previous evening
for those of us in Vancouver?

(Or I guess 9:30pm for Chandan if we actually are having a morning
session?)

Chandan: I'll ask Shirley to cancel our staff meeting so you don't have
a crazy(er) meeting schedule during LSF.

--D

> -- 
> chandan
