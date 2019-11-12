Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96069F89ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 08:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfKLHux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 02:50:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51412 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbfKLHux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573545052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9J79Eguj1xOMc4fb92h3Xp5A3yIeU0L/YK+6R1EqEQg=;
        b=DDTlnqrZ982c1+c7pV4Afr48w8KFwgwmaYoEoORjtbW34snFUOCxHyuGGMxOdaYL3Mz4o3
        6ONIGzSjlSoCjN2s5Umji8vpk4r6e/PNCcRvtz+/C6KjEKdO+p+EAjpkWgeHaZLv90xW8o
        0qpY467DlYV9mGeovXGDkRx1HVog4BY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-2vqHdp87O06bEiy0p5g2cg-1; Tue, 12 Nov 2019 02:50:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 471A518B5FA0;
        Tue, 12 Nov 2019 07:50:48 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 622B360852;
        Tue, 12 Nov 2019 07:50:42 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id xAC7oge0031234;
        Tue, 12 Nov 2019 02:50:42 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id xAC7ogaK031230;
        Tue, 12 Nov 2019 02:50:42 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 12 Nov 2019 02:50:42 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Mike Snitzer <snitzer@redhat.com>
cc:     Nikos Tsironis <ntsironis@arrikto.com>,
        Scott Wood <swood@redhat.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] dm-snapshot: fix crash with the realtime kernel
In-Reply-To: <20191112011444.GA32220@redhat.com>
Message-ID: <alpine.LRH.2.02.1911120240020.25757@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1911110811060.28408@file01.intranet.prod.int.rdu2.redhat.com> <c9a772e9-e305-cf0b-1155-fb19bdb84e55@arrikto.com> <20191112011444.GA32220@redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 2vqHdp87O06bEiy0p5g2cg-1
X-Mimecast-Spam-Score: 0
Content-Type: TEXT/PLAIN; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 11 Nov 2019, Mike Snitzer wrote:

> On Mon, Nov 11 2019 at 11:37am -0500,
> Nikos Tsironis <ntsironis@arrikto.com> wrote:
>=20
> > On 11/11/19 3:59 PM, Mikulas Patocka wrote:
> > > Snapshot doesn't work with realtime kernels since the commit f79ae415=
b64c.
> > > hlist_bl is implemented as a raw spinlock and the code takes two non-=
raw
> > > spinlocks while holding hlist_bl (non-raw spinlocks are blocking mute=
xes
> > > in the realtime kernel, so they couldn't be taken inside a raw spinlo=
ck).
> > >=20
> > > This patch fixes the problem by using non-raw spinlock
> > > exception_table_lock instead of the hlist_bl lock.
> > >=20
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > Fixes: f79ae415b64c ("dm snapshot: Make exception tables scalable")
> > >=20
> >=20
> > Hi Mikulas,
> >=20
> > I wasn't aware that hlist_bl is implemented as a raw spinlock in the
> > real time kernel. I would expect it to be a standard non-raw spinlock,
> > so everything works as expected. But, after digging further in the real
> > time tree, I found commit ad7675b15fd87f1 ("list_bl: Make list head
> > locking RT safe") which suggests that such a conversion would break
> > other parts of the kernel.
>=20
> Right, the proper fix is to update list_bl to work on realtime (which I
> assume the referenced commit does).  I do not want to take this
> dm-snapshot specific workaround that open-codes what should be done
> within hlist_{bl_lock,unlock}, etc.

If we change list_bl to use non-raw spinlock, it fails in dentry lookup=20
code. The dentry code takes a seqlock (which is implemented as preempt=20
disable in the realtime kernel) and then takes a list_bl lock.

This is wrong from the real-time perspective (the chain in the hash could=
=20
be arbitrarily long, so using non-raw spinlock could cause unbounded=20
wait), however we can't do anything with it.

I think that fixing dm-snapshot is way easier than fixing the dentry code.=
=20
If you have an idea how to fix the dentry code, tell us.

> I'm not yet sure which realtime mailing list and/or maintainers should
> be cc'd to further the inclussion of commit ad7675b15fd87f1 -- Nikos do
> you?
>=20
> Thanks,
> Mike

Mikulas

