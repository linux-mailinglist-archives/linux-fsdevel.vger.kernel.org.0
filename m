Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3DCFA9F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 07:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKMGBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 01:01:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45784 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725858AbfKMGBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 01:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573624893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BI1DBbTBrcq16pSAoz/BMA31HAPi7JaaeyCMiqZAhfE=;
        b=J6vyXx5TL4SivpuPm9SALV30pua4eYyY280l+uLdUS3cBB1xphJIlh/cU9aV1Z3UhvvNO4
        I79JPm5fnOBFjrh5iE8cB3msXn6EanIVQlJtxdDBHUFpl1IknPiBzKcBrlPN/5V0IAFDXJ
        VFXuUwUhFDL9KBgkQqRD/PEU6skUOeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-ZdQCrH3AO6aLXcu4nSUO7g-1; Wed, 13 Nov 2019 01:01:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03C51107ACC7;
        Wed, 13 Nov 2019 06:01:29 +0000 (UTC)
Received: from ovpn-116-229.phx2.redhat.com (ovpn-116-229.phx2.redhat.com [10.3.116.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7730C101E3CB;
        Wed, 13 Nov 2019 06:01:22 +0000 (UTC)
Message-ID: <048d9e5ea9ea9cebe18aa96d59bd0a67b3429529.camel@redhat.com>
Subject: Re: [PATCH 1/2] dm-snapshot: fix crash with the realtime kernel
From:   Scott Wood <swood@redhat.com>
To:     Nikos Tsironis <ntsironis@arrikto.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Ilias Tsitsimpis <iliastsi@arrikto.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <dwagner@suse.de>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <a6f588d3-2403-d50a-70a1-ed644082cc83@arrikto.com>
References: <alpine.LRH.2.02.1911110811060.28408@file01.intranet.prod.int.rdu2.redhat.com>
         <c9a772e9-e305-cf0b-1155-fb19bdb84e55@arrikto.com>
         <20191112011444.GA32220@redhat.com>
         <alpine.LRH.2.02.1911120240020.25757@file01.intranet.prod.int.rdu2.redhat.com>
         <a6f588d3-2403-d50a-70a1-ed644082cc83@arrikto.com>
Organization: Red Hat
MIME-Version: 1.0
Date:   Wed, 13 Nov 2019 00:01:06 -0600
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ZdQCrH3AO6aLXcu4nSUO7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-11-12 at 13:45 +0200, Nikos Tsironis wrote:
> On 11/12/19 9:50 AM, Mikulas Patocka wrote:
> >=20
> > On Mon, 11 Nov 2019, Mike Snitzer wrote:
> >=20
> > > On Mon, Nov 11 2019 at 11:37am -0500,
> > > Nikos Tsironis <ntsironis@arrikto.com> wrote:
> > >=20
> > > > On 11/11/19 3:59 PM, Mikulas Patocka wrote:
> > > > > Snapshot doesn't work with realtime kernels since the commit
> > > > > f79ae415b64c.
> > > > > hlist_bl is implemented as a raw spinlock and the code takes two
> > > > > non-raw
> > > > > spinlocks while holding hlist_bl (non-raw spinlocks are blocking
> > > > > mutexes
> > > > > in the realtime kernel, so they couldn't be taken inside a raw
> > > > > spinlock).
> > > > >=20
> > > > > This patch fixes the problem by using non-raw spinlock
> > > > > exception_table_lock instead of the hlist_bl lock.
> > > > >=20
> > > > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > > > Fixes: f79ae415b64c ("dm snapshot: Make exception tables
> > > > > scalable")
> > > > >=20
> > > >=20
> > > > Hi Mikulas,
> > > >=20
> > > > I wasn't aware that hlist_bl is implemented as a raw spinlock in th=
e
> > > > real time kernel. I would expect it to be a standard non-raw
> > > > spinlock,
> > > > so everything works as expected. But, after digging further in the
> > > > real
> > > > time tree, I found commit ad7675b15fd87f1 ("list_bl: Make list head
> > > > locking RT safe") which suggests that such a conversion would break
> > > > other parts of the kernel.
> > >=20
> > > Right, the proper fix is to update list_bl to work on realtime (which
> > > I
> > > assume the referenced commit does).  I do not want to take this
> > > dm-snapshot specific workaround that open-codes what should be done
> > > within hlist_{bl_lock,unlock}, etc.
> >=20
> > If we change list_bl to use non-raw spinlock, it fails in dentry lookup=
=20
> > code. The dentry code takes a seqlock (which is implemented as preempt=
=20
> > disable in the realtime kernel) and then takes a list_bl lock.
> >=20
> > This is wrong from the real-time perspective (the chain in the hash
> > could=20
> > be arbitrarily long, so using non-raw spinlock could cause unbounded=20
> > wait), however we can't do anything with it.
> >=20
> > I think that fixing dm-snapshot is way easier than fixing the dentry
> > code.=20
> > If you have an idea how to fix the dentry code, tell us.
>=20
> I too think that it would be better to fix list_bl. dm-snapshot isn't
> really broken. One should be able to acquire a spinlock while holding
> another spinlock.

That's not universally true -- even in the absence of RT there are nesting
considerations.  But it would probably be good if raw locks weren't hidden
inside other locking primitives without making it clear (ideally in the
function names) that it's a raw lock.

> Moreover, apart from dm-snapshot, anyone ever using list_bl is at risk
> of breaking the realtime kernel, if he or she is not aware of that
> particular limitation of list_bl's implementation in the realtime tree.

In particular the non-rcu variant seems inherently bad unless you protect
traversal with some other lock (in which case why use bl at all?).  Maybe
fully separate the rcu version of list_bl and keep using raw locks there
(with the name clearly indicating so), with the side benefit that
accidentally mixing rcu and non-rcu operations on the same list would becom=
e
a build error, and convert the non-rcu list_bl to use non-raw locks on RT.

BTW, I'm wondering what makes bit spinlocks worse than raw spinlocks on
RT...  commit ad7675b15fd87f19 says there's no lockdep visibility, but that
seems orthogonal to RT, and could be addressed by adding a dep_map on debug
builds the same way the raw lock is currently added.  The other bit spinloc=
k
conversion commits that I could find are replacing them with non-raw locks.

-Scott


