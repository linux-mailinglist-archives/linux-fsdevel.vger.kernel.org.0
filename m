Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF82526352
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 15:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiEMN53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiEMN51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 09:57:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3664570907
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 06:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D27F1B83030
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 13:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB07C34100;
        Fri, 13 May 2022 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652450241;
        bh=vJSZZ/Y309SkdPp+jQqbFc3ZblQnJbXXPNQYBIhDrUc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uYfzZRi1bsN6Ps1L8ZQ8bbR8/erc36RkMqLD0k82b68ZohdU0yD6AOy+H/H4dGQtN
         AT7jCdATTTAtUOLGtYt7xmzQsgmZoWtWlbrSVmme1nBfrSJ6TFynaJrKU+jJc96PuX
         amA9lBKk93m/AxzI/wDX5H+Je6lDCd0mUNexROUy+cV2iiq2v4laSLHz01GrmMabuS
         HvPjDy28D+oYw6R4PV7Bqj+aZ7ba80kszjc/4+aFcEBTo35wCNpHJ4Q4SF4uLLdAMF
         5UWwl3s6oRLE9aCelFHFxqF2oigZm6JQ4oq2HN7Kr2FF4UMP1UnJ79r5jztITm/sR3
         GnMGMcqQ6tJKA==
Message-ID: <063f8a744f08f3bbc33aa840b4e91c5a443d41c3.camel@kernel.org>
Subject: Re: Freeing page flags
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 13 May 2022 09:57:19 -0400
In-Reply-To: <Yn5fXm83IfUWkv8w@casper.infradead.org>
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
         <Yn3FZSZbEDssbRnk@localhost.localdomain>
         <Yn3S8A9I/G5F4u80@casper.infradead.org> <87sfpd22kq.fsf@brahms.olymp>
         <Yn5Uu/ZZkNfbdhGA@casper.infradead.org>
         <baaab6c574d975aaa08ee99f09dd299d9be008ec.camel@kernel.org>
         <Yn5fXm83IfUWkv8w@casper.infradead.org>
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

On Fri, 2022-05-13 at 14:38 +0100, Matthew Wilcox wrote:
> On Fri, May 13, 2022 at 09:21:11AM -0400, Jeff Layton wrote:
> > On Fri, 2022-05-13 at 13:53 +0100, Matthew Wilcox wrote:
> > > On Fri, May 13, 2022 at 10:40:05AM +0100, Lu=EDs Henriques wrote:
> > > > Matthew Wilcox <willy@infradead.org> writes:
> > > >=20
> > > > > On Thu, May 12, 2022 at 10:41:41PM -0400, Josef Bacik wrote:
> > > > > > On Thu, May 12, 2022 at 09:54:59PM +0100, Matthew Wilcox wrote:
> > > > > > > The LWN writeup [1] on merging the MGLRU reminded me that I n=
eed to send
> > > > > > > out a plan for removing page flags that we can do without.
> > > > > > >=20
> > > > > > > 1. PG_error.  It's basically useless.  If the page was read s=
uccessfully,
> > > > > > > PG_uptodate is set.  If not, PG_uptodate is clear.  The page =
cache
> > > > > > > doesn't use PG_error.  Some filesystems do, and we need to tr=
ansition
> > > > > > > them away from using it.
> > > > > > >=20
> > > > > >=20
> > > > > > What about writes?  A cursory look shows we don't clear Uptodat=
e if we fail to
> > > > > > write, which is correct I think.  The only way to indicate we h=
ad a write error
> > > > > > to check later is the page error.
> > > > >=20
> > > > > On encountering a write error, we're supposed to call mapping_set=
_error(),
> > > > > not SetPageError().
> > > > >=20
> > > > > > > 2. PG_private.  This tells us whether we have anything stored=
 at
> > > > > > > page->private.  We can just check if page->private is NULL or=
 not.
> > > > > > > No need to have this extra bit.  Again, there may be some fil=
esystems
> > > > > > > that are a bit wonky here, but I'm sure they're fixable.
> > > > > > >=20
> > > > > >=20
> > > > > > At least for Btrfs we serialize the page->private with the priv=
ate_lock, so we
> > > > > > could probably just drop PG_private, but it's kind of nice to c=
heck first before
> > > > > > we have to take the spin lock.  I suppose we can just do
> > > > > >=20
> > > > > > if (page->private)
> > > > > > 	// do lock and check thingy
> > > > >=20
> > > > > That's my hope!  I think btrfs is already using folio_attach_priv=
ate() /
> > > > > attach_page_private(), which makes everything easier.  Some files=
ystems
> > > > > still manipulate page->private and PagePrivate by hand.
> > > >=20
> > > > In ceph we've recently [1] spent a bit of time debugging a bug rela=
ted
> > > > with ->private not being NULL even though we expected it to be.  Th=
e
> > > > solution found was to replace the check for NULL and use
> > > > folio_test_private() instead, but we _may_ have not figured the who=
le
> > > > thing out.
> > > >=20
> > > > We assumed that folios were being recycled and not cleaned-up.  The=
 values
> > > > we were seeing in ->private looked like they were some sort of flag=
s as
> > > > only a few bits were set (e.g. 0x0200000):
> > > >=20
> > > > [ 1672.578313] page:00000000e23868c1 refcount:2 mapcount:0 mapping:=
0000000022e0d3b4 index:0xd8 pfn:0x74e83
> > > > [ 1672.581934] aops:ceph_aops [ceph] ino:10000016c9e dentry name:"f=
aed"
> > > > [ 1672.584457] flags: 0x4000000000000015(locked|uptodate|lru|zone=
=3D1)
> > > > [ 1672.586878] raw: 4000000000000015 ffffea0001d3a108 ffffea0001d3a=
088 ffff888003491948
> > > > [ 1672.589894] raw: 00000000000000d8 0000000000200000 00000002fffff=
fff 0000000000000000
> > > > [ 1672.592935] page dumped because: VM_BUG_ON_FOLIO(1)
> > > >=20
> > > > [1] https://lore.kernel.org/all/20220508061543.318394-1-xiubli@redh=
at.com/
> > >=20
> > > I remember Jeff asking me about this problem a few days ago.  A folio
> > > passed to you in ->dirty_folio() or ->invalidate_folio() belongs to
> > > your filesystem.  Nobody else should be storing to the ->private fiel=
d;
> > > there's no race that could lead to it being freed while you see it.
> > > There may, of course, be bugs that are overwriting folio->private, bu=
t
> > > it's definitely not supposed to happen.  I agree with you that it loo=
ks
> > > like a bit has been set (is it possibly bad RAM?)
> > >=20
> > > We do use page->private in the buddy allocator, but that stores the o=
rder
> > > of the page; it wouldn't be storing 1<<21.  PG flag 21 is PG_mlocked,
> > > which seems like a weird one to be setting in the wrong field, so pro=
bably
> > > not that.
> > >=20
> > > Is it always bit 21 that gets set?
> >=20
> > No, it varies, but it was always just a few bits in the field that end
> > up being set. I was never able to reproduce it locally, but saw it in a
> > run in ceph's teuthology lab a few times. Xiubo did the most digging
> > here, so he may be able to add more info.
> >=20
> > Basically though, we call __filemap_get_folio in netfs_write_begin and
> > it will sometimes give us a folio that has PG_private clear, but the
> > ->private field has just a few bits that aren't zeroed out. I'm pretty
> > sure we zero out that field in ceph, so the theory was that the page wa=
s
> > traveling through some other subsystem before coming to us.
>=20
> It _shouldn't_ be.  __filemap_get_folio() may return a page that was
> already in the page cache (and so may have had page->private set by
> the filesystem originally), or it may allocate a fresh page in
> filemap_alloc_folio() which _should_ come with page->private clear.
> Adding an assert that is true might be a good debugging tactic:
>=20
> +++ b/mm/filemap.c
> @@ -2008,6 +2008,7 @@ struct folio *__filemap_get_folio(struct address_sp=
ace *mapping, pgoff_t index,
>                                 goto repeat;
>                 }
>=20
> +VM_BUG_ON_FOLIO(folio->private, folio);
>                 /*
>                  * filemap_add_folio locks the page, and for mmap
>                  * we expect an unlocked page.
>=20
> > He wasn't able to ascertain the cause, and just decided to check for
> > PG_private instead since you (presumably) shouldn't trust ->private
> > unless that's set anyway.
>=20
> They are usually in sync ... which means we can reclaim the flag ;-)

Agreed. I'm all for freeing up a page bit and PG_private seems like
belt-and-suspenders stuff. There are some details in this tracker
ticket.

This note in particular seems to indicate that ->private is not always
coming back as zero:

    https://tracker.ceph.com/issues/55421#note-20

--=20
Jeff Layton <jlayton@kernel.org>
