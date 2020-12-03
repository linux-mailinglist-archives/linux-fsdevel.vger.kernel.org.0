Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243D92CE10C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 22:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgLCVqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 16:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgLCVqn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:46:43 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBEBC061A51
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 13:46:03 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id z24so3260155oto.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 13:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EEDpEPg20mrOi+gLZZh/e5E2eO12nJVyTtIJrwc4Hhw=;
        b=veGdRpfzhPNSwO2u8ojbMsIDoZ8aR5PYS3mHe8rLoapltHRQzi9akp4g3CPjhqCRig
         t2zzXVuOnK2AwkcLlnboyxiwmD/RXyFNpOh15F4j62lWfvmoL2RP6Yw5sFKTtlm51O1N
         8YYQ91xP/ABKVuDOUha6ZMg/dNnrSEKOQwyaeL4ny3yIiS7/2LWByc+twsVedE/zwbK+
         /s2qCZaOL7bEk+vwlTzSisxNfiKE0XDJtPLFK/g0RfnY9MIJnyh4nMilsazklb8wkj8Q
         6sA80gGOrB65McsgEFlhtiRkP+7fSaDCgZSb+k0HZDx7jtL543G/NB5Q7HzmMLXDlpnH
         h7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EEDpEPg20mrOi+gLZZh/e5E2eO12nJVyTtIJrwc4Hhw=;
        b=kKylerO6OaikdSuuyUeJmYCci1iSkKnQs4X7ALt36MlUSAzCxhAqXCy/2vU0kvCxvZ
         peFlLS8JsDpB5MB9fmI45SykRQoCw8vNajwdK3JPcJ5afMlxSnzp07fpymVYahbEgwmp
         mV9IKOZ2c3Yhv2Z8BDTWvzCkzZ10RSIEYuelofuPIINJFK0jL/5PVdlzjNzRZvdyHZMy
         FrkS2eh9O71QkSz0edrFguEIRYAdk7f01A/NMjCXCeAkHuGl5L+1pdYfeYMU2nCJFHHe
         Sm6gzbLhIXvFCbV/ckk7XS9HpGpdfGPlDMd3Hy8eSX4lbAzLr7FEYiF5lbVaPjIbFRNd
         gVDQ==
X-Gm-Message-State: AOAM532fY9CbeTkJ+yNZM/HiuyzbA3iGnXTj+yPF0bZwu/dE9r3BNNEN
        4TlaBBOx7zSrx1BevUDpLYeYFA==
X-Google-Smtp-Source: ABdhPJzKBX1t/CV6B7SK6h/3beXEgh1qUYgW8FGMbJ3JkvzZauTEh6LkobizKmuZQMhHy0BIdpeAZw==
X-Received: by 2002:a9d:4b03:: with SMTP id q3mr1085136otf.53.1607031962853;
        Thu, 03 Dec 2020 13:46:02 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o6sm194057oon.7.2020.12.03.13.46.01
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Dec 2020 13:46:02 -0800 (PST)
Date:   Thu, 3 Dec 2020 13:45:42 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Marek Szyprowski <m.szyprowski@samsung.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Qian Cai <qcai@redhat.com>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
In-Reply-To: <0107bae8-baaa-9d39-5349-8174cb8abbbe@samsung.com>
Message-ID: <alpine.LSU.2.11.2012031305070.12944@eggly.anvils>
References: <20201112212641.27837-1-willy@infradead.org> <alpine.LSU.2.11.2011160128001.1206@eggly.anvils> <20201117153947.GL29991@casper.infradead.org> <alpine.LSU.2.11.2011170820030.1014@eggly.anvils> <20201117191513.GV29991@casper.infradead.org>
 <20201117234302.GC29991@casper.infradead.org> <20201125023234.GH4327@casper.infradead.org> <bb95be97-2a50-b345-fc2c-3ff865b60e08@samsung.com> <CGME20201203172725eucas1p2fddec1d269c55095859d490942b78b93@eucas1p2.samsung.com>
 <0107bae8-baaa-9d39-5349-8174cb8abbbe@samsung.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1876154756-1607031962=:12944"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1876154756-1607031962=:12944
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 3 Dec 2020, Marek Szyprowski wrote:
> On 03.12.2020 16:46, Marek Szyprowski wrote:
> > On 25.11.2020 03:32, Matthew Wilcox wrote:
> >> On Tue, Nov 17, 2020 at 11:43:02PM +0000, Matthew Wilcox wrote:
> >>> On Tue, Nov 17, 2020 at 07:15:13PM +0000, Matthew Wilcox wrote:
> >>>> I find both of these functions exceptionally confusing.=C2=A0 Does t=
his
> >>>> make it easier to understand?
> >>> Never mind, this is buggy.=C2=A0 I'll send something better tomorrow.
> >> That took a week, not a day.=C2=A0 *sigh*.=C2=A0 At least this is shor=
ter.
> >>
> >> commit 1a02863ce04fd325922d6c3db6d01e18d55f966b
> >> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> Date:=C2=A0=C2=A0 Tue Nov 17 10:45:18 2020 -0500
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 fix mm-truncateshmem-handle-truncates-that-sp=
lit-thps.patch
> >
> > This patch landed in todays linux-next (20201203) as commit=20
> > 8678b27f4b8b ("8678b27f4b8bfc130a13eb9e9f27171bcd8c0b3b"). Sadly it=20
> > breaks booting of ANY of my ARM 32bit test systems, which use initrd.=
=20
> > ARM64bit based systems boot fine. Here is example of the crash:

kernel BUG at fs/inode.c:531
evict() hitting clear_inode()'s BUG_ON(inode->i_data.nr_pages)
Same here on i386 on mmotm (slightly different line number on mmotm).

>=20
> One more thing. Reverting those two:
>=20
> 1b1aa968b0b6 mm-truncateshmem-handle-truncates-that-split-thps-fix-fix
>=20
> 8678b27f4b8b mm-truncateshmem-handle-truncates-that-split-thps-fix
>=20
> on top of linux next-20201203 fixes the boot issues.

Thanks a lot for the report, Marek.  Yes, reverting those two
(of which "-fix" amounts to a rewrite, and "-fix-fix" is far from
complete) takes the linux-next tree back to how truncate was before it
took in yesterday's mmotm: not crashing on 32-bit, but still not good.

The 32-bit breakage may turn out to be a simple one-liner like a
missing cast, or overflow from 0 to -1, somewhere in the rewritten
truncate_inode_pages_range(); but it did not stand out to me, and
it does not immediately matter, since other fixes are needed to
that patch.  I'm afraid it's proving to be work in progress.

I did ask Andrew to revert these earlier in the thread, but it looks
like that got lost in the jungle of his inbox: I'll send a better
targetted mail, but what we need is to revert these *four* patches,
until we have a better tested and stable version.

mm-truncateshmem-handle-truncates-that-split-thps.patch
mm-truncateshmem-handle-truncates-that-split-thps-fix.patch
mm-truncateshmem-handle-truncates-that-split-thps-fix-fix.patch
mm-filemap-return-only-head-pages-from-find_get_entries.patch

Hugh
--0-1876154756-1607031962=:12944--
