Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE546F4FA0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 07:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjECFFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 01:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjECFFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 01:05:06 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177A330E9
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 22:05:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34354i9r019743
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 01:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683090287; bh=FvORr7FHd1hBjWof7ef5KTgBWPg3huRRQIi7D/9SWE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=K0pZ4wkIz0FwMjJ1JFT6gMXcq0FcOS33EiPOKvpJh227bfZuKJymQsT9q33sPbUdW
         5dsqf9H3DvSTr2CU7VYTRidmlCzaHcsGobTrRDF8oojGAqfFEaiqOfNiLruOj/3y1x
         lr3qrf6hAiMuF9gxdLV9ZYSjve4DIDs8HkTtUGCsbEE82UK+QsxtffWdWjFMDYEvue
         T4TDSjCErV5flWemUcgeVkx05P7QhVVy/ANgaWlJ7V3MXwCjxzxHrKdIGQUE2i4LKW
         7DlWnnHb4PDkR/vkJN1w4AROmBbjVjl4sm8lzTVMIQF0K/PwPkX5Z33V0+bmUQKAyp
         FDM9GbWtb3Iiw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CD23815C02E2; Wed,  3 May 2023 01:04:44 -0400 (EDT)
Date:   Wed, 3 May 2023 01:04:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+e6dab35a08df7f7aa260@syzkaller.appspotmail.com>,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] INFO: task hung in eventpoll_release_file
Message-ID: <20230503050444.GB674745@mit.edu>
References: <000000000000c6dc0305f75b4d74@google.com>
 <ZE4L+x5SjT3+elhh@mit.edu>
 <CANp29Y4cg6HB0dw_4mO05ibiAv2GkdnMksQozSGiBrwan9JvYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y4cg6HB0dw_4mO05ibiAv2GkdnMksQozSGiBrwan9JvYA@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 10:08:44PM +0200, Aleksandr Nogikh wrote:
> Hi Ted,
> 
> On Sun, Apr 30, 2023 at 8:34 AM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > #syz set subsystem: fs
> >
> > This somehow got tagged with the ext4 label, and not the fs label.
> > (And this is not the first one I've noticed).  I'm beginning to
> > suspect there may have been some syzbot database hiccup?  Anyway,
> > fixing...
> 
> FWIW one of this bug's crashes was attributed to ext4 [1] and syzbot's
> logic in this case was to prefer a more specific subsystem (ext4) to a
> more generic one (fs), even if it's not mentioned in the majority of
> crashes.
> 
> [1] https://syzkaller.appspot.com/text?tag=CrashReport&x=171abfaac80000

One of the challenges is that the attribution is not necessasrily
accurate.  One of the CPU's was running an ext4 workqueue task (which
was apparntly making forward progress) at the time of the crash.

It should also be noted that apparently there is a potential patch
which seems to fix the problem, and it's solely in the fs/eventpoll.c.
Unfortunately, it was not in the lore.kernel.org archives, since
apparently it wasn't cc'ed there.  It's in the syzkaller-bugs Google
Groups archive, though, since Pauolo Abeni cc'ed the
syzkaller-bugs@googlegroups.com, but not the lore archive, on his
test:

https://groups.google.com/g/syzkaller-bugs/c/oiBUmGsqz_Q/m/Xi5iOeJNAgAJ

						- Ted
