Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20D175B5F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjGTR4X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 13:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjGTR4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:56:22 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171171998;
        Thu, 20 Jul 2023 10:56:21 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qMXsn-002CO9-HB; Thu, 20 Jul 2023 19:56:09 +0200
Received: from p57bd98fd.dip0.t-ipconnect.de ([87.189.152.253] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qMXsn-003Zmq-8y; Thu, 20 Jul 2023 19:56:09 +0200
Message-ID: <b93ff5ca1ecd40084cd7a18e8490bf4e421fd6b9.camel@physik.fu-berlin.de>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Matthew Wilcox <willy@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        debian-powerpc <debian-powerpc@lists.debian.org>
Date:   Thu, 20 Jul 2023 19:56:08 +0200
In-Reply-To: <ZLlvII/jMPTT32ef@casper.infradead.org>
References: <000000000000dbce4e05f170f289@google.com>
         <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
         <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
         <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
         <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
         <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
         <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
         <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
         <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
         <ZLlvII/jMPTT32ef@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.152.253
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(Please ignore my previous mail which was CC'ed to the wrong list)

Hello!

On Thu, 2023-07-20 at 18:30 +0100, Matthew Wilcox wrote:
> On Thu, Jul 20, 2023 at 05:27:57PM +0200, Dmitry Vyukov wrote:
> > On Thu, 5 Jan 2023 at 17:45, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> > > > On Wed, Jan 04, 2023 at 08:37:16PM -0800, Viacheslav Dubeyko wrote:
> > > > > Also, as far as I can see, available volume in report (mount_0.gz) somehow corrupted already:
> > > > 
> > > > Syzbot generates deliberately-corrupted (aka fuzzed) filesystem images.
> > > > So basically, you can't trust anything you read from the disc.
> > > > 
> > > 
> > > If the volume has been deliberately corrupted, then no guarantee that file system
> > > driver will behave nicely. Technically speaking, inode write operation should never
> > > happened for corrupted volume because the corruption should be detected during
> > > b-tree node initialization time. If we would like to achieve such nice state of HFS/HFS+
> > > drivers, then it requires a lot of refactoring/implementation efforts. I am not sure that
> > > it is worth to do because not so many guys really use HFS/HFS+ as the main file
> > > system under Linux.
> > 
> > 
> > Most popular distros will happily auto-mount HFS/HFS+ from anything
> > inserted into USB (e.g. what one may think is a charger). This creates
> > interesting security consequences for most Linux users.
> > An image may also be corrupted non-deliberately, which will lead to
> > random memory corruptions if the kernel trusts it blindly.
> 
> Then we should delete the HFS/HFS+ filesystems.  They're orphaned in
> MAINTAINERS and if distros are going to do such a damnfool thing,
> then we must stop them.

Both HFS and HFS+ work perfectly fine. And if distributions or users are so
sensitive about security, it's up to them to blacklist individual features
in the kernel.

Both HFS and HFS+ have been the default filesystem on MacOS for 30 years
and I don't think it's justified to introduce such a hard compatibility
breakage just because some people are worried about theoretical evil
maid attacks.

HFS/HFS+ mandatory if you want to boot Linux on a classic Mac or PowerMac
and I don't think it's okay to break all these systems running Linux.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
