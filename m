Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F416F60BC49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 23:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiJXVfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 17:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiJXVe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:34:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ECE2DCF31;
        Mon, 24 Oct 2022 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666640508; x=1698176508;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Hy92JwTra/z8JWqWMJC7+K5x6uq/6h9D0Gg0b3wf/6c=;
  b=nBMq4kfN/MNcijXePUW+pQaehHpsgIaljoEgvhElwCH7DABUfTISeSdU
   GpMkTALvLJRwO+o46S05EF8CxaWUA1me0FfJOY1jSq2uMrIvQPdq7LHWz
   o8W/ecETJ4Ll3LZQ4AUICM2gvUfH9XPSWuh9Yptycfii9S8mOxU88nJaG
   NkoIo4dBZd8isX9wcO2nz7Z4PgeEBF5s4z8mXZ5K/bVSOMJEY7lT8ihGU
   43DE6PJN7FwJJp0tBkVWm9dt2jHbYWcklmLEcLgveZaDXrqsr3kpoc4AF
   Ul0+fb4osUlvQP9tb30pd3t4VD+f5DHig4Bs9wZCGQAVSYJBqHNSEClPK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287226292"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="287226292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 12:39:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="694672754"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="694672754"
Received: from relbaz1-mobl.amr.corp.intel.com (HELO [10.209.26.196]) ([10.209.26.196])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 12:39:41 -0700
Message-ID: <feb89e52675ed630e52dc8aacfa66feb6f19fd3a.camel@linux.intel.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Date:   Mon, 24 Oct 2022 12:39:33 -0700
In-Reply-To: <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com>
References: <YjDj3lvlNJK/IPiU@bfoster>
         <YjJPu/3tYnuKK888@casper.infradead.org> <YjM88OwoccZOKp86@bfoster>
         <YjSTq4roN/LJ7Xsy@bfoster> <YjSbHp6B9a1G3tuQ@casper.infradead.org>
         <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
         <6350a5f07bae2_6be12944c@dwillia2-xfh.jf.intel.com.notmuch>
         <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2022-10-23 at 15:38 -0700, Linus Torvalds wrote:
> On Wed, Oct 19, 2022 at 6:35 PM Dan Williams
> <dan.j.williams@intel.com> wrote:
> >=20
> > A report from a tester with this call trace:
> >=20
> > =C2=A0watchdog: BUG: soft lockup - CPU#127 stuck for 134s!
> > [ksoftirqd/127:782]
> > =C2=A0RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x40 [..]
>=20
> Whee.
>=20
> > ...lead me to this thread. This was after I had them force all
> > softirqs
> > to run in ksoftirqd context, and run with rq_affinity =3D=3D 2 to force
> > I/O completion work to throttle new submissions.
> >=20
> > Willy, are these headed upstream:
> >=20
> > https://lore.kernel.org/all/YjSbHp6B9a1G3tuQ@casper.infradead.org
> >=20
> > ...or I am missing an alternate solution posted elsewhere?
>=20
> Can your reporter test that patch? I think it should still apply
> pretty much as-is.. And if we actually had somebody who had a
> test-case that was literally fixed by getting rid of the old bookmark
> code, that would make applying that patch a no-brainer.
>=20
> The problem is that the original load that caused us to do that thing
> in the first place isn't repeatable because it was special production
> code - so removing that bookmark code because we _think_ it now hurts
> more than it helps is kind of a big hurdle.
>=20
> But if we had some hard confirmation from somebody that "yes, the
> bookmark code is now hurting", that would make it a lot more
> palatable
> to just remove the code that we just _think_ that probably isn't
> needed any more..
>=20
>=20
I do think that the original locked page on migration problem was fixed
by commit 9a1ea439b16b. Unfortunately the customer did not respond to
us when we asked them to test their workload when that patch went=C2=A0
into the mainline.=C2=A0

I don't have objection to Matthew's fix to remove the bookmark code,
now that it is causing problems with this scenario that I didn't
anticipate in my original code.

Tim

