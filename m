Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD3FB02B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 13:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfKMMFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 07:05:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29442 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfKMMFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573646742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yLFHitioaaxpC6mZgafz141WkUvCAGQV3scdUsoDeAY=;
        b=I1UhHResy+G/xKv36foyatUP2X5bAX5iAXCBPuRHLR8KfbktTtxmxQmxSPQA4+DQHr9/t0
        r+OTnzLC2VUQPfN2M0qJiu855VOwJkFPJdMu+o/LvaDjs3v8kXk//9VjkMBtjLVmB9eP79
        vJNFjSY5gKhpfAfu64kLtITqZcWNtpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-wJ12IqlvPv6xGFp9FfA5vQ-1; Wed, 13 Nov 2019 07:05:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 784931852E21;
        Wed, 13 Nov 2019 12:05:39 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D51B56046C;
        Wed, 13 Nov 2019 12:05:36 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id xADC5aGd028404;
        Wed, 13 Nov 2019 07:05:36 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id xADC5aIo028400;
        Wed, 13 Nov 2019 07:05:36 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 13 Nov 2019 07:05:36 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Nikos Tsironis <ntsironis@arrikto.com>
cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        Mike Snitzer <msnitzer@redhat.com>,
        Scott Wood <swood@redhat.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 2/2 v2] list_bl: avoid BUG when the list is not
 locked
In-Reply-To: <7020d479-e8c7-7249-c6cd-c6d01b01c92a@arrikto.com>
Message-ID: <alpine.LRH.2.02.1911130704430.28238@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1911121110430.12815@file01.intranet.prod.int.rdu2.redhat.com> <335dafcb-5e07-63ed-b288-196516170bde@arrikto.com> <alpine.LRH.2.02.1911130616240.20335@file01.intranet.prod.int.rdu2.redhat.com>
 <7020d479-e8c7-7249-c6cd-c6d01b01c92a@arrikto.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: wJ12IqlvPv6xGFp9FfA5vQ-1
X-Mimecast-Spam-Score: 0
Content-Type: TEXT/PLAIN; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 13 Nov 2019, Nikos Tsironis wrote:

> On 11/13/19 1:16 PM, Mikulas Patocka wrote:
> >=20
> >=20
> > On Wed, 13 Nov 2019, Nikos Tsironis wrote:
> >=20
> >> On 11/12/19 6:16 PM, Mikulas Patocka wrote:
> >>> list_bl would crash with BUG() if we used it without locking. dm-snap=
shot=20
> >>> uses its own locking on realtime kernels (it can't use list_bl becaus=
e=20
> >>> list_bl uses raw spinlock and dm-snapshot takes other non-raw spinloc=
ks=20
> >>> while holding bl_lock).
> >>>
> >>> To avoid this BUG, we must set LIST_BL_LOCKMASK =3D 0.
> >>>
> >>> This patch is intended only for the realtime kernel patchset, not for=
 the=20
> >>> upstream kernel.
> >>>
> >>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> >>>
> >>> Index: linux-rt-devel/include/linux/list_bl.h
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> --- linux-rt-devel.orig/include/linux/list_bl.h=092019-11-07 14:01:51=
.000000000 +0100
> >>> +++ linux-rt-devel/include/linux/list_bl.h=092019-11-08 10:12:49.0000=
00000 +0100
> >>> @@ -19,7 +19,7 @@
> >>>   * some fast and compact auxiliary data.
> >>>   */
> >>> =20
> >>> -#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> >>> +#if (defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)) && !defi=
ned(CONFIG_PREEMPT_RT_BASE)
> >>>  #define LIST_BL_LOCKMASK=091UL
> >>>  #else
> >>>  #define LIST_BL_LOCKMASK=090UL
> >>> @@ -161,9 +161,6 @@ static inline void hlist_bl_lock(struct
> >>>  =09bit_spin_lock(0, (unsigned long *)b);
> >>>  #else
> >>>  =09raw_spin_lock(&b->lock);
> >>> -#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> >>> -=09__set_bit(0, (unsigned long *)b);
> >>> -#endif
> >>>  #endif
> >>>  }
> >>> =20
> >>
> >> Hi Mikulas,
> >>
> >> I think removing __set_bit()/__clear_bit() breaks hlist_bl_is_locked()=
,
> >> which is used by the RCU variant of list_bl.
> >>
> >> Nikos
> >=20
> > OK. so I can remove this part of the patch.
> >=20
>=20
> I think this causes another problem. LIST_BL_LOCKMASK is used in various
> functions to set/clear the lock bit, e.g. in hlist_bl_first(). So, if we
> lock the list through hlist_bl_lock(), thus setting the lock bit with
> __set_bit(), and then call hlist_bl_first() to get the first element,
> the returned pointer will be invalid. As LIST_BL_LOCKMASK is zero the
> least significant bit of the pointer will be 1.
>=20
> I think for dm-snapshot to work using its own locking, and without
> list_bl complaining, the following is sufficient:
>=20
> --- a/include/linux/list_bl.h
> +++ b/include/linux/list_bl.h
> @@ -25,7 +25,7 @@
>  #define LIST_BL_LOCKMASK       0UL
>  #endif
>=20
> -#ifdef CONFIG_DEBUG_LIST
> +#if defined(CONFIG_DEBUG_LIST) && !defined(CONFIG_PREEMPT_RT_BASE)
>  #define LIST_BL_BUG_ON(x) BUG_ON(x)
>  #else
>  #define LIST_BL_BUG_ON(x)
>=20
> Nikos

Yes - so, submit this.

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

Mikulas

