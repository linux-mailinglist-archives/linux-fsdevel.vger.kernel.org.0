Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD27436DBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 00:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhJUWve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 18:51:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59472 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhJUWvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 18:51:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58C141FD59;
        Thu, 21 Oct 2021 22:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634856556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDHpYnkAmFo9eAjY7AwXYlbZAwsJIRr7JJORcjSJYRU=;
        b=CmOCnn/AiuATNEW2VSzj1lAxvxbWDn4ardHPbAFskt5IPX90UEq7RPgIuYAHYlhhAaM4JL
        pjtJa/qir67yFr/1B533YbK6Al6xdqXQO4cYp85+8lUsK18ExW0nOxQ1ropobeYcBQuJHn
        lKfhT0KZqR5q3VAJ2dFTr6k+yeS6DkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634856556;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDHpYnkAmFo9eAjY7AwXYlbZAwsJIRr7JJORcjSJYRU=;
        b=8z1v2qM3jIuqVdl3kbTNQzzuPodV0NqyXgNSzwNSvsCJaJMYHDnKl1kwZ2/RzAGdnmFPN6
        n6hXkcQFQt21BIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72DF413BEC;
        Thu, 21 Oct 2021 22:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ziSsBmjucWHJdQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 21 Oct 2021 22:49:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Uladzislau Rezki" <urezki@gmail.com>
Cc:     "Michal Hocko" <mhocko@suse.com>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "Dave Chinner" <david@fromorbit.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
In-reply-to: <20211021104038.GA1932@pc638.lan>
References: <20211019194658.GA1787@pc638.lan>,
 <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>,
 <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>,
 <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>,
 <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>,
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz>,
 <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>,
 <20211020192430.GA1861@pc638.lan>,
 <163481121586.17149.4002493290882319236@noble.neil.brown.name>,
 <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz>, <20211021104038.GA1932@pc638.lan>
Date:   Fri, 22 Oct 2021 09:49:08 +1100
Message-id: <163485654850.17149.3604437537345538737@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 21 Oct 2021, Uladzislau Rezki wrote:
> > On Thu 21-10-21 21:13:35, Neil Brown wrote:
> > > On Thu, 21 Oct 2021, Uladzislau Rezki wrote:
> > > > On Wed, Oct 20, 2021 at 05:00:28PM +0200, Uladzislau Rezki wrote:
> > > > > >
> > > > > > On Wed 20-10-21 16:29:14, Uladzislau Rezki wrote:
> > > > > > > On Wed, Oct 20, 2021 at 4:06 PM Michal Hocko <mhocko@suse.com> =
wrote:
> > > > > > [...]
> > > > > > > > As I've said I am OK with either of the two. Do you or anybod=
y have any
> > > > > > > > preference? Without any explicit event to wake up for neither=
 of the two
> > > > > > > > is more than just an optimistic retry.
> > > > > > > >
> > > > > > > From power perspective it is better to have a delay, so i tend =
to say
> > > > > > > that delay is better.
> > > > > >
> > > > > > I am a terrible random number generator. Can you give me a number
> > > > > > please?
> > > > > >
> > > > > Well, we can start from one jiffy so it is one timer tick: schedule=
_timeout(1)
> > > > >=20
> > > > A small nit, it is better to replace it by the simple msleep() call: =
msleep(jiffies_to_msecs(1));
> > >=20
> > > I disagree.  I think schedule_timeout_uninterruptible(1) is the best
> > > wait to sleep for 1 ticl
> > >=20
> > > msleep() contains
> > >   timeout =3D msecs_to_jiffies(msecs) + 1;
> > > and both jiffies_to_msecs and msecs_to_jiffies might round up too.
> > > So you will sleep for at least twice as long as you asked for, possible
> > > more.
> >=20
> > That was my thinking as well. Not to mention jiffies_to_msecs just to do
> > msecs_to_jiffies right after which seems like a pointless wasting of
> > cpu cycle. But maybe I was missing some other reasons why msleep would
> > be superior.
> >
>=20
> To me the msleep is just more simpler from semantic point of view, i.e.
> it is as straight forward as it can be. In case of interruptable/uninterapt=
able
> sleep it can be more confusing for people.

I agree that msleep() is more simple.  I think adding the
jiffies_to_msec() substantially reduces that simplicity.

>=20
> When it comes to rounding and possibility to sleep more than 1 tick, it
> really does not matter here, we do not need to guarantee exact sleeping
> time.
>=20
> Therefore i proposed to switch to the msleep().

If, as you say, the precision doesn't matter that much, then maybe
   msleep(0)
which would sleep to the start of the next jiffy.  Does that look a bit
weird?  If so, the msleep(1) would be ok.

However now that I've thought about some more, I'd much prefer we
introduce something like
    memalloc_retry_wait();

and use that everywhere that a memory allocation is retried.
I'm not convinced that we need to wait at all - at least, not when
__GFP_DIRECT_RECLAIM is used, as in that case alloc_page will either
  - succeed
  - make some progress a reclaiming or
  - sleep

However I'm not 100% certain, and the behaviour might change in the
future.  So having one place (the definition of memalloc_retry_wait())
where we can change the sleeping behaviour if the alloc_page behavour
changes, would be ideal.  Maybe memalloc_retry_wait() could take a
gfpflags arg.

Thanks,
NeilBrown
