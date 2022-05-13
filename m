Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68205262F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 15:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346448AbiEMNVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380664AbiEMNVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 09:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C723C708
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 06:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35C0F62070
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 13:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067FBC34118;
        Fri, 13 May 2022 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652448073;
        bh=oXa6oGd1RGqE2DSp2cx1XGWOkY3O7PnmKhclx56ha2E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=neG6L/L4A6Z81hOKaouyCwcWS1ifmbrUwRBDh4IJatC/GSPjIezLfEIq1kSOkn/Cl
         n0X7jLMHnXYIDZS0EFbAFC4UzxPxFcWGiXM/c8vMZJIy6P0SZbj4kJJhq1xpV9Pmgq
         3Nl7QsuMkIy33X16C5MW2SdSfKp58SlDr1SG6FrWP/8NYHy9wv5TLW4PoMweWUXYlO
         J/2zCtNmyWpSXtGGx6naqtwi6ftE3BDt/C76goBPLGmFBnM+XfekEERhkhQwm7xZB1
         YKajj6mgeiv1aVk4/Zx9hpgneQ7xX8gz9i7enuLTr0M1zwyVfrh8l1rNW2MtXKx9bD
         MFeh5oJxEvdVA==
Message-ID: <baaab6c574d975aaa08ee99f09dd299d9be008ec.camel@kernel.org>
Subject: Re: Freeing page flags
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     Xiubo Li <xiubli@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 13 May 2022 09:21:11 -0400
In-Reply-To: <Yn5Uu/ZZkNfbdhGA@casper.infradead.org>
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
         <Yn3FZSZbEDssbRnk@localhost.localdomain>
         <Yn3S8A9I/G5F4u80@casper.infradead.org> <87sfpd22kq.fsf@brahms.olymp>
         <Yn5Uu/ZZkNfbdhGA@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-05-13 at 13:53 +0100, Matthew Wilcox wrote:
> On Fri, May 13, 2022 at 10:40:05AM +0100, Lu=EDs Henriques wrote:
> > Matthew Wilcox <willy@infradead.org> writes:
> >=20
> > > On Thu, May 12, 2022 at 10:41:41PM -0400, Josef Bacik wrote:
> > > > On Thu, May 12, 2022 at 09:54:59PM +0100, Matthew Wilcox wrote:
> > > > > The LWN writeup [1] on merging the MGLRU reminded me that I need =
to send
> > > > > out a plan for removing page flags that we can do without.
> > > > >=20
> > > > > 1. PG_error.  It's basically useless.  If the page was read succe=
ssfully,
> > > > > PG_uptodate is set.  If not, PG_uptodate is clear.  The page cach=
e
> > > > > doesn't use PG_error.  Some filesystems do, and we need to transi=
tion
> > > > > them away from using it.
> > > > >=20
> > > >=20
> > > > What about writes?  A cursory look shows we don't clear Uptodate if=
 we fail to
> > > > write, which is correct I think.  The only way to indicate we had a=
 write error
> > > > to check later is the page error.
> > >=20
> > > On encountering a write error, we're supposed to call mapping_set_err=
or(),
> > > not SetPageError().
> > >=20
> > > > > 2. PG_private.  This tells us whether we have anything stored at
> > > > > page->private.  We can just check if page->private is NULL or not=
.
> > > > > No need to have this extra bit.  Again, there may be some filesys=
tems
> > > > > that are a bit wonky here, but I'm sure they're fixable.
> > > > >=20
> > > >=20
> > > > At least for Btrfs we serialize the page->private with the private_=
lock, so we
> > > > could probably just drop PG_private, but it's kind of nice to check=
 first before
> > > > we have to take the spin lock.  I suppose we can just do
> > > >=20
> > > > if (page->private)
> > > > 	// do lock and check thingy
> > >=20
> > > That's my hope!  I think btrfs is already using folio_attach_private(=
) /
> > > attach_page_private(), which makes everything easier.  Some filesyste=
ms
> > > still manipulate page->private and PagePrivate by hand.
> >=20
> > In ceph we've recently [1] spent a bit of time debugging a bug related
> > with ->private not being NULL even though we expected it to be.  The
> > solution found was to replace the check for NULL and use
> > folio_test_private() instead, but we _may_ have not figured the whole
> > thing out.
> >=20
> > We assumed that folios were being recycled and not cleaned-up.  The val=
ues
> > we were seeing in ->private looked like they were some sort of flags as
> > only a few bits were set (e.g. 0x0200000):
> >=20
> > [ 1672.578313] page:00000000e23868c1 refcount:2 mapcount:0 mapping:0000=
000022e0d3b4 index:0xd8 pfn:0x74e83
> > [ 1672.581934] aops:ceph_aops [ceph] ino:10000016c9e dentry name:"faed"
> > [ 1672.584457] flags: 0x4000000000000015(locked|uptodate|lru|zone=3D1)
> > [ 1672.586878] raw: 4000000000000015 ffffea0001d3a108 ffffea0001d3a088 =
ffff888003491948
> > [ 1672.589894] raw: 00000000000000d8 0000000000200000 00000002ffffffff =
0000000000000000
> > [ 1672.592935] page dumped because: VM_BUG_ON_FOLIO(1)
> >=20
> > [1] https://lore.kernel.org/all/20220508061543.318394-1-xiubli@redhat.c=
om/
>=20
> I remember Jeff asking me about this problem a few days ago.  A folio
> passed to you in ->dirty_folio() or ->invalidate_folio() belongs to
> your filesystem.  Nobody else should be storing to the ->private field;
> there's no race that could lead to it being freed while you see it.
> There may, of course, be bugs that are overwriting folio->private, but
> it's definitely not supposed to happen.  I agree with you that it looks
> like a bit has been set (is it possibly bad RAM?)
>=20
> We do use page->private in the buddy allocator, but that stores the order
> of the page; it wouldn't be storing 1<<21.  PG flag 21 is PG_mlocked,
> which seems like a weird one to be setting in the wrong field, so probabl=
y
> not that.
>=20
> Is it always bit 21 that gets set?

No, it varies, but it was always just a few bits in the field that end
up being set. I was never able to reproduce it locally, but saw it in a
run in ceph's teuthology lab a few times. Xiubo did the most digging
here, so he may be able to add more info.

Basically though, we call __filemap_get_folio in netfs_write_begin and
it will sometimes give us a folio that has PG_private clear, but the
->private field has just a few bits that aren't zeroed out. I'm pretty
sure we zero out that field in ceph, so the theory was that the page was
traveling through some other subsystem before coming to us.

He wasn't able to ascertain the cause, and just decided to check for
PG_private instead since you (presumably) shouldn't trust ->private
unless that's set anyway.
--=20
Jeff Layton <jlayton@kernel.org>
