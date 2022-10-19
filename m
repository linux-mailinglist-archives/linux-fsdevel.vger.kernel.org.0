Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D1F605016
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 21:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiJSTEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 15:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJSTEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E231C2088
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666206253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfIdnF8ljPzne2VfJo4i9CcwD188vJ7S/S8s9L1Huro=;
        b=dFWzxrYMNhFk2HLFxTQQZUjO8btofsSbDBfbBEf6M4A65SRjQHcwk0H/Bo/dIyKin0R+ob
        +pGBD36Y2uKUDjyoJ+Pl3Z2qUYtVmvr3P2U020Z/AEp2Yp3lmrJv/j1qS4d81yQjI0NjCV
        +fCUDGAFRPdSKk0mxmcv16oIikLEais=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-0GDJMe1gMjWu9u8mMbaFWg-1; Wed, 19 Oct 2022 15:04:09 -0400
X-MC-Unique: 0GDJMe1gMjWu9u8mMbaFWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17A2F1035DE2;
        Wed, 19 Oct 2022 19:04:01 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C427D408A3C5;
        Wed, 19 Oct 2022 19:03:43 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org,
        "Venkataramanan\, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
References: <20221016150656.5803-1-fmdefrancesco@gmail.com>
        <x49h6zzvn1a.fsf@segfault.boston.devel.redhat.com>
        <2851287.e9J7NaK4W3@mypc>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 19 Oct 2022 15:07:34 -0400
In-Reply-To: <2851287.e9J7NaK4W3@mypc> (Fabio M. De Francesco's message of
        "Wed, 19 Oct 2022 20:52:04 +0200")
Message-ID: <x494jvztyx5.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Fabio M. De Francesco" <fmdefrancesco@gmail.com> writes:

> On Wednesday, October 19, 2022 5:41:21 PM CEST Jeff Moyer wrote:
>> "Fabio M. De Francesco" <fmdefrancesco@gmail.com> writes:
>>=20
>> > The use of kmap() and kmap_atomic() are being deprecated in favor of
>> > kmap_local_page().
>> >
>> > There are two main problems with kmap(): (1) It comes with an overhead=
 as
>> > the mapping space is restricted and protected by a global lock for
>> > synchronization and (2) it also requires global TLB invalidation when =
the
>> > kmap=E2=80=99s pool wraps and it might block when the mapping space is=
 fully
>> > utilized until a slot becomes available.
>> >
>> > With kmap_local_page() the mappings are per thread, CPU local, can take
>> > page faults, and can be called from any context (including interrupts).
>> > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
>> > the tasks can be preempted and, when they are scheduled to run again, =
the
>> > kernel virtual addresses are restored and still valid.
>> >
>> > Since its use in fs/aio.c is safe everywhere, it should be preferred.
>>=20
>> That sentence is very ambiguous.  I don't know what "its" refers to, and
>> I'm not sure what "safe" means in this context.
>
> I'm sorry for not being clearer.
>
> "its use" means "the use of kmap_local_page()". Few lines above you may a=
lso=20
> see "It is faster", meaning "kmap_local_page() is faster".

Got it, thanks.

> The "safety" is a very concise way to assert that I've checked, by code=20
> inspection and by testing (as it is better detailed some lines below) tha=
t=20
> these conversions (1) don't break any of the rules of use of local mappin=
g=20
> when converting kmap() (please read highmem.rst about these) and (2) the =
call=20
> sites of kmap_atomic() didn't rely on its side effects (pagefaults disabl=
e and=20
> potential preemption disables).=20

OK, good.  I agree that the aio code wasn't relying on the side effects of
kmap_atomic.

> Therefore, you may read it as it was: "The use of kmap_local_page() in fs/
> aio.c has been carefully checked to assure that the conversions won't bre=
ak=20
> the code, therefore the newer API is preferred".
>
> I hope it makes my argument clearer.

Yes, thank you for explaining!

-Jeff

>
>>=20
>> The patch looks okay to me.
>>=20
>> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>>=20
>
> Thank you so much for the  "Reviewed-by" tag.
>
> Regards,
>
> Fabio=20

