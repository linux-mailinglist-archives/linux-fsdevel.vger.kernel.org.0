Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8239675B6C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 20:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjGTS2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 14:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjGTS2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:28:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9BE2D51;
        Thu, 20 Jul 2023 11:27:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BADD61B7D;
        Thu, 20 Jul 2023 18:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585D7C433C8;
        Thu, 20 Jul 2023 18:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689877672;
        bh=PveaWa0pZAx+au66P+YMH4ZRlUccBvcGi5t6QBLPtx4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WbZFWiqCDECfQ2LLVFujdB30lRwZiLdacjV5uCQzpPU34Pzh3/ELbyjqmNP7YyLP6
         M4WTdqRx5yNrP1t+QGUBPTFvvhB4Cs4OjAbPpTQWRMbBVnoclFwJ2vrKshRjmXQB1A
         7/9jzzKrPh2EB6sx/sR0b5b2p/0fcixLDtetUVYVtl4hU0tS6ayvdiK/m/jMwt78HW
         hmE9aQA0AUKqdS65JasZCGwhU7VQj1g6LrErgknZHivB0f5XR6VP+50HcsYtkXeH2m
         fqUgYAFNqeQXP5F125y6SWwG7Jvnk17bur3lrAgMY0E+rc6FMlxi8uWgwgfcdj2YuG
         E/hC4S1E1jOaw==
Message-ID: <868611d7f222a19127783cc8d5f2af2e42ee24e4.camel@kernel.org>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        debian-ports <debian-ports@lists.debian.org>
Date:   Thu, 20 Jul 2023 14:27:50 -0400
In-Reply-To: <ZLl2Fq35Ya0cNbIm@casper.infradead.org>
References: <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
         <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
         <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
         <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
         <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
         <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
         <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
         <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
         <ZLlvII/jMPTT32ef@casper.infradead.org>
         <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de>
         <ZLl2Fq35Ya0cNbIm@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-07-20 at 18:59 +0100, Matthew Wilcox wrote:
> On Thu, Jul 20, 2023 at 07:50:47PM +0200, John Paul Adrian Glaubitz wrote=
:
> > > Then we should delete the HFS/HFS+ filesystems.  They're orphaned in
> > > MAINTAINERS and if distros are going to do such a damnfool thing,
> > > then we must stop them.
> >=20
> > Both HFS and HFS+ work perfectly fine. And if distributions or users ar=
e so
> > sensitive about security, it's up to them to blacklist individual featu=
res
> > in the kernel.
> >=20
> > Both HFS and HFS+ have been the default filesystem on MacOS for 30 year=
s
> > and I don't think it's justified to introduce such a hard compatibility
> > breakage just because some people are worried about theoretical evil
> > maid attacks.
> >=20
> > HFS/HFS+ mandatory if you want to boot Linux on a classic Mac or PowerM=
ac
> > and I don't think it's okay to break all these systems running Linux.
>=20
> If they're so popular, then it should be no trouble to find somebody
> to volunteer to maintain those filesystems.  Except they've been
> marked as orphaned since 2011 and effectively were orphaned several
> years before that (the last contribution I see from Roman Zippel is
> in 2008, and his last contribution to hfs was in 2006).

I suspect that this is one of those catch-22 situations: distros are
going to enable every feature under the sun. That doesn't mean that
anyone is actually _using_ them these days.

Is "staging" still a thing? Maybe we should move these drivers into the
staging directory and pick a release where we'll sunset it, and then see
who comes out of the woodwork?

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
