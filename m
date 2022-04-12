Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA4F4FE768
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 19:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358524AbiDLRoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 13:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358518AbiDLRoo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9150A62A36
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649785344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y5slG8OF+UAcZaYGDxKXmAiKpk4Z0HoOivC1WQ8ffJU=;
        b=aRCCzSwBwNNxRD3o6MQIygVpaLzuOb49cplCYlfuYFmuW4X6hsZ/JxCpESuvez59u9UkXS
        RMGLuzEKbF0u1rQeFzzp0/aP/MKdpsV9SOA09btCvEQDcCOHT0ptf3kcN9VIwFGXdI6yPn
        JI1UZkgiex+QA3bN2jY9Hfx+o7v5HvM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-ZiPfs4npPeGJV4Osz6HNCg-1; Tue, 12 Apr 2022 13:42:08 -0400
X-MC-Unique: ZiPfs4npPeGJV4Osz6HNCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06F1F299E76D;
        Tue, 12 Apr 2022 17:42:08 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0390404D2CA;
        Tue, 12 Apr 2022 17:42:07 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 23CHg7ZY029784;
        Tue, 12 Apr 2022 13:42:07 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 23CHg6a4029780;
        Tue, 12 Apr 2022 13:42:06 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 12 Apr 2022 13:42:06 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] stat: fix inconsistency between struct stat and struct
 compat_stat
In-Reply-To: <CAHk-=wiJTqx4Pec653ZFKEiNv2jtfWsNyevoV9TYa05kD0vVsg@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2204121253260.26107@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com> <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com> <alpine.LRH.2.02.2204120520140.19025@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wiJTqx4Pec653ZFKEiNv2jtfWsNyevoV9TYa05kD0vVsg@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 12 Apr 2022, Linus Torvalds wrote:

> On Mon, Apr 11, 2022 at 11:41 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > Also, if the st_dev and st_rdev values are 32-bit, we don't have to use
> > old_valid_dev to test if the value fits into them. This fixes -EOVERFLOW
> > on filesystems that are on NVMe because NVMe uses the major number 259.
> 
> The problem with this part of the patch is that this:
> 
> > @@ -353,7 +352,7 @@ static int cp_new_stat(struct kstat *sta
> >  #endif
> >
> >         INIT_STRUCT_STAT_PADDING(tmp);
> > -       tmp.st_dev = encode_dev(stat->dev);
> > +       tmp.st_dev = new_encode_dev(stat->dev);
> 
> completely changes the format of that st_dev field.

we have these definitions:

static __always_inline u16 old_encode_dev(dev_t dev)
{
        return (MAJOR(dev) << 8) | MINOR(dev);
}

static __always_inline u32 new_encode_dev(dev_t dev)
{
        unsigned major = MAJOR(dev);
        unsigned minor = MINOR(dev);
        return (minor & 0xff) | (major << 8) | ((minor & ~0xff) << 12);
}

As long as both major and minor numbers are less than 256, these functions 
return equivalent results. So, I think it's safe to replace old_encode_dev 
with new_encode_dev.

old_encode_dev shouldn't be called with minor >= 256, because it blends 
the upper minor bits into the major field - the kernel doesn't do this and 
checks the value with old_valid_dev before calling old_encode_dev. But 
when old_valid_dev returns true, it doesn't matter if you use 
old_encode_dev or new_encode_dev - both give equivalent results.

When I tested it, both gcc and openwatcom return st_dev 0x10301, which is 
the expected value (the NVMe device has major 259 and minor 1).

>  (b) we could just hide the bits in upper bits instead.
> 
> So what I suggest we do is to make old_encode_dev() put the minor bits
> in bits 0..7 _and_ 16..23, and the major bits in 8..15 _and_ 24..32.

new_encode_dev puts the minor value into bits 0..7, 20..31 and the major 
value into bits 8..19

So, we can use this instead of inventing a new format.

Mikulas

