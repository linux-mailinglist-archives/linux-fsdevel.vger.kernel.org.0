Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298CC5262E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346283AbiEMNSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 09:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380682AbiEMNSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 09:18:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A16765D4
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 06:17:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D54F321A80;
        Fri, 13 May 2022 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652447868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQp8AFGoU7gWUI3cKHxk9+DMV49PGkfvvEEfn0vnKbA=;
        b=npNmC5Vu2NMRZlYvu33vzub0nOatrq58BmdtQVOBDKjQfie7YoBh0tLQHYNW4bGLgZToAE
        DPYj4fIn4xCelMKf81zcEngTlaZCEZr3Qj4eRO8bP84vdE07U5SsSpgzpfkQRKvAbaPhlT
        INlTN7vFBdU/oKxAcaUp4fVPux5G6Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652447868;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQp8AFGoU7gWUI3cKHxk9+DMV49PGkfvvEEfn0vnKbA=;
        b=Hq3D6ZhYNQJ1fv9FBJVxqpSEsSNmaeCojdWpM7phggT1z9ir6BM2JwdSLHhYa5t18ZghCW
        7rHyXcXOYbO3Y5CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AF1A13446;
        Fri, 13 May 2022 13:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ds4RF3xafmIabAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 13 May 2022 13:17:48 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id c511b819;
        Fri, 13 May 2022 13:18:23 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Freeing page flags
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
        <Yn3FZSZbEDssbRnk@localhost.localdomain>
        <Yn3S8A9I/G5F4u80@casper.infradead.org> <87sfpd22kq.fsf@brahms.olymp>
        <Yn5Uu/ZZkNfbdhGA@casper.infradead.org>
Date:   Fri, 13 May 2022 14:18:23 +0100
In-Reply-To: <Yn5Uu/ZZkNfbdhGA@casper.infradead.org> (Matthew Wilcox's message
        of "Fri, 13 May 2022 13:53:15 +0100")
Message-ID: <87bkw1fu5c.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, May 13, 2022 at 10:40:05AM +0100, Lu=C3=ADs Henriques wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>>=20
>> > On Thu, May 12, 2022 at 10:41:41PM -0400, Josef Bacik wrote:
>> >> On Thu, May 12, 2022 at 09:54:59PM +0100, Matthew Wilcox wrote:
>> >> > The LWN writeup [1] on merging the MGLRU reminded me that I need to=
 send
>> >> > out a plan for removing page flags that we can do without.
>> >> >=20
>> >> > 1. PG_error.  It's basically useless.  If the page was read success=
fully,
>> >> > PG_uptodate is set.  If not, PG_uptodate is clear.  The page cache
>> >> > doesn't use PG_error.  Some filesystems do, and we need to transiti=
on
>> >> > them away from using it.
>> >> >
>> >>=20
>> >> What about writes?  A cursory look shows we don't clear Uptodate if w=
e fail to
>> >> write, which is correct I think.  The only way to indicate we had a w=
rite error
>> >> to check later is the page error.
>> >
>> > On encountering a write error, we're supposed to call mapping_set_erro=
r(),
>> > not SetPageError().
>> >
>> >> > 2. PG_private.  This tells us whether we have anything stored at
>> >> > page->private.  We can just check if page->private is NULL or not.
>> >> > No need to have this extra bit.  Again, there may be some filesyste=
ms
>> >> > that are a bit wonky here, but I'm sure they're fixable.
>> >> >=20
>> >>=20
>> >> At least for Btrfs we serialize the page->private with the private_lo=
ck, so we
>> >> could probably just drop PG_private, but it's kind of nice to check f=
irst before
>> >> we have to take the spin lock.  I suppose we can just do
>> >>=20
>> >> if (page->private)
>> >> 	// do lock and check thingy
>> >
>> > That's my hope!  I think btrfs is already using folio_attach_private()=
 /
>> > attach_page_private(), which makes everything easier.  Some filesystems
>> > still manipulate page->private and PagePrivate by hand.
>>=20
>> In ceph we've recently [1] spent a bit of time debugging a bug related
>> with ->private not being NULL even though we expected it to be.  The
>> solution found was to replace the check for NULL and use
>> folio_test_private() instead, but we _may_ have not figured the whole
>> thing out.
>>=20
>> We assumed that folios were being recycled and not cleaned-up.  The valu=
es
>> we were seeing in ->private looked like they were some sort of flags as
>> only a few bits were set (e.g. 0x0200000):
>>=20
>> [ 1672.578313] page:00000000e23868c1 refcount:2 mapcount:0 mapping:00000=
00022e0d3b4 index:0xd8 pfn:0x74e83
>> [ 1672.581934] aops:ceph_aops [ceph] ino:10000016c9e dentry name:"faed"
>> [ 1672.584457] flags: 0x4000000000000015(locked|uptodate|lru|zone=3D1)
>> [ 1672.586878] raw: 4000000000000015 ffffea0001d3a108 ffffea0001d3a088 f=
fff888003491948
>> [ 1672.589894] raw: 00000000000000d8 0000000000200000 00000002ffffffff 0=
000000000000000
>> [ 1672.592935] page dumped because: VM_BUG_ON_FOLIO(1)
>>=20
>> [1] https://lore.kernel.org/all/20220508061543.318394-1-xiubli@redhat.co=
m/
>
> I remember Jeff asking me about this problem a few days ago.  A folio
> passed to you in ->dirty_folio() or ->invalidate_folio() belongs to
> your filesystem.  Nobody else should be storing to the ->private field;
> there's no race that could lead to it being freed while you see it.

Right, I would assume so, obviously.  Our question was more on re-using
folios: is it guaranteed that this field will always be set to NULL, or is
it just the flag that is cleaned?

> There may, of course, be bugs that are overwriting folio->private, but
> it's definitely not supposed to happen.  I agree with you that it looks
> like a bit has been set (is it possibly bad RAM?)

No, I don't think it's bad RAM.  Both me and Xiubo were able to reproduce
it (although it took a while, at least for me) in different boxes (VMs).

> We do use page->private in the buddy allocator, but that stores the order
> of the page; it wouldn't be storing 1<<21.  PG flag 21 is PG_mlocked,
> which seems like a weird one to be setting in the wrong field, so probably
> not that.
>
> Is it always bit 21 that gets set?

No, it wasn't always the same bits and it wasn't always a single bit.  The
only examples I've here with me are 0x0200000 and 0x0d0000, but I'm sure
we've seen other similar values.

So, from what you stated above, looks like we'll need to revisit this and
do some more debug.

Cheers,
--=20
Lu=C3=ADs
