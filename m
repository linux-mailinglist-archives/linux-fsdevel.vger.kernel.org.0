Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F46791311
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 10:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352522AbjIDIMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 04:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjIDIL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:11:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA70FA;
        Mon,  4 Sep 2023 01:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3AD92CE0B09;
        Mon,  4 Sep 2023 08:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC45DC433C8;
        Mon,  4 Sep 2023 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693815112;
        bh=eic0Rlv8/ijnOm6MyExim2bLdqdZRbo+sFtVidhxkoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pi2IvriTsMei5fvabgi0XyyP9WhLQFtStugPusjyVbXN4OB9VnAjt/9UKP5Wiw8TL
         JpYaU3Z3sjaTXGKoasulamgzT4Fc1c/3RyIex1UWC5oPSpVoyaE/RPLOVwv2XzrB3R
         h3PgLaBrqB9/hzL0BQ1Wy9JZOGBg12ccaTo54em4z1oc5yXOUZcPpw9u5oI6bLACn6
         vphEUHuGbQw9kIE+JKEtm4artidVB8IPiA0dTiRhZmM9iyXsgITTC1nCfg1wn7UdlT
         4eG3vfH+kcEUsCVIuX5w6t35UqEjQ35tNZdUO8kSr4U0g/alEZsqab+P3B5VpjqQEl
         KcNgT9eS7Kj3w==
Date:   Mon, 4 Sep 2023 10:11:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <20230904-beleben-adipositas-ac1ed398927d@brauner>
References: <000000000000e6432a06046c96a5@google.com>
 <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f>
 <ZPUIQzsCSNlnBFHB@dread.disaster.area>
 <CAGudoHE_-2765EttOV_6B9EeSuOxqo1MiRCyFP9y=GbSeCMtZg@mail.gmail.com>
 <ZPUSPAnuGLLe3QWH@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPUSPAnuGLLe3QWH@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 04, 2023 at 09:09:48AM +1000, Dave Chinner wrote:
> On Mon, Sep 04, 2023 at 12:47:53AM +0200, Mateusz Guzik wrote:
> > On 9/4/23, Dave Chinner <david@fromorbit.com> wrote:
> > > On Sun, Sep 03, 2023 at 10:33:57AM +0200, Mateusz Guzik wrote:
> > >> On Sun, Sep 03, 2023 at 03:25:28PM +1000, Dave Chinner wrote:
> > >> > On Sat, Sep 02, 2023 at 09:11:34PM -0700, syzbot wrote:
> > >> > > Hello,
> > >> > >
> > >> > > syzbot found the following issue on:
> > >> > >
> > >> > > HEAD commit:    b97d64c72259 Merge tag
> > >> > > '6.6-rc-smb3-client-fixes-part1' of..
> > >> > > git tree:       upstream
> > >> > > console output:
> > >> > > https://syzkaller.appspot.com/x/log.txt?x=14136d8fa80000
> > >> > > kernel config:
> > >> > > https://syzkaller.appspot.com/x/.config?x=958c1fdc38118172
> > >> > > dashboard link:
> > >> > > https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
> > >> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> > >> > > Debian) 2.40
> > >> > >
> > >> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >> >
> > >> > Been happening for months, apparently, yet for some reason it now
> > >> > thinks a locking hang in __fdget_pos() is an XFS issue?
> > >> >
> > >> > #syz set subsystems: fs
> > >> >
> > >>
> > >> The report does not have info necessary to figure this out -- no
> > >> backtrace for whichever thread which holds f_pos_lock. I clicked on a
> > >> bunch of other reports and it is the same story.
> > >
> > > That's true, but there's nothing that points at XFS in *any* of the
> > > bug reports. Indeed, log from the most recent report doesn't have
> > > any of the output from the time stuff hung. i.e. the log starts
> > > at kernel time 669.487771 seconds, and the hung task report is at:
> > >
> > 
> > I did not mean to imply this is an xfs problem.
> > 
> > You wrote reports have been coming in for months so it is pretty clear
> > nobody is investigating.
> 
> Which is pretty much the case for all filesystem bug reports from
> syzbot except for those reported against XFS. Almost nobody else is

I'll try to address syzkaller reports that we do get for VFS issues
asap but often they're just not VFS issues or have no reproducer.
