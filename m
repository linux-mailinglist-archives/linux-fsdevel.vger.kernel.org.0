Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6C1525EE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 12:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379038AbiEMJjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 05:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353324AbiEMJje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 05:39:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8D4291CDC
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 02:39:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8935521ABA;
        Fri, 13 May 2022 09:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652434771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RKGLaV6peCQRz1XBWcpMDRG/NtpXOzj4Bb4XSCgxoy8=;
        b=BiWpz7uatSEHH+dWThvoCEO+79pncusW/90PUh4zgcM1REc5gyAV8Mn5Wvkxww0KvU1rWw
        Z2K3Nly/EzbEXCWy1WtNWccd7qYiFKZLnChmX2wlfm1VR/XQwJrauBAQlGutl/S5yGR836
        IW47ibAzrT8yMChWW1RtfdXiOH2O1HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652434771;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RKGLaV6peCQRz1XBWcpMDRG/NtpXOzj4Bb4XSCgxoy8=;
        b=/jp3FHVCnKqoxGNsYQ4W9NR+12RudgIyq56nvLnP51ZPtYYmjBlths786gOTQlbODXwSsX
        beHEQqjt1IEVaCCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1319A13A84;
        Fri, 13 May 2022 09:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jm8gAFMnfmIEAwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 13 May 2022 09:39:30 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 3d4c2108;
        Fri, 13 May 2022 09:40:05 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Freeing page flags
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
        <Yn3FZSZbEDssbRnk@localhost.localdomain>
        <Yn3S8A9I/G5F4u80@casper.infradead.org>
Date:   Fri, 13 May 2022 10:40:05 +0100
In-Reply-To: <Yn3S8A9I/G5F4u80@casper.infradead.org> (Matthew Wilcox's message
        of "Fri, 13 May 2022 04:39:28 +0100")
Message-ID: <87sfpd22kq.fsf@brahms.olymp>
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

> On Thu, May 12, 2022 at 10:41:41PM -0400, Josef Bacik wrote:
>> On Thu, May 12, 2022 at 09:54:59PM +0100, Matthew Wilcox wrote:
>> > The LWN writeup [1] on merging the MGLRU reminded me that I need to se=
nd
>> > out a plan for removing page flags that we can do without.
>> >=20
>> > 1. PG_error.  It's basically useless.  If the page was read successful=
ly,
>> > PG_uptodate is set.  If not, PG_uptodate is clear.  The page cache
>> > doesn't use PG_error.  Some filesystems do, and we need to transition
>> > them away from using it.
>> >
>>=20
>> What about writes?  A cursory look shows we don't clear Uptodate if we f=
ail to
>> write, which is correct I think.  The only way to indicate we had a writ=
e error
>> to check later is the page error.
>
> On encountering a write error, we're supposed to call mapping_set_error(),
> not SetPageError().
>
>> > 2. PG_private.  This tells us whether we have anything stored at
>> > page->private.  We can just check if page->private is NULL or not.
>> > No need to have this extra bit.  Again, there may be some filesystems
>> > that are a bit wonky here, but I'm sure they're fixable.
>> >=20
>>=20
>> At least for Btrfs we serialize the page->private with the private_lock,=
 so we
>> could probably just drop PG_private, but it's kind of nice to check firs=
t before
>> we have to take the spin lock.  I suppose we can just do
>>=20
>> if (page->private)
>> 	// do lock and check thingy
>
> That's my hope!  I think btrfs is already using folio_attach_private() /
> attach_page_private(), which makes everything easier.  Some filesystems
> still manipulate page->private and PagePrivate by hand.

In ceph we've recently [1] spent a bit of time debugging a bug related
with ->private not being NULL even though we expected it to be.  The
solution found was to replace the check for NULL and use
folio_test_private() instead, but we _may_ have not figured the whole
thing out.

We assumed that folios were being recycled and not cleaned-up.  The values
we were seeing in ->private looked like they were some sort of flags as
only a few bits were set (e.g. 0x0200000):

[ 1672.578313] page:00000000e23868c1 refcount:2 mapcount:0 mapping:00000000=
22e0d3b4 index:0xd8 pfn:0x74e83
[ 1672.581934] aops:ceph_aops [ceph] ino:10000016c9e dentry name:"faed"
[ 1672.584457] flags: 0x4000000000000015(locked|uptodate|lru|zone=3D1)
[ 1672.586878] raw: 4000000000000015 ffffea0001d3a108 ffffea0001d3a088 ffff=
888003491948
[ 1672.589894] raw: 00000000000000d8 0000000000200000 00000002ffffffff 0000=
000000000000
[ 1672.592935] page dumped because: VM_BUG_ON_FOLIO(1)

[1] https://lore.kernel.org/all/20220508061543.318394-1-xiubli@redhat.com/

Cheers,
--=20
Lu=C3=ADs
