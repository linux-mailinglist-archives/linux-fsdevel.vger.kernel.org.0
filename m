Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627D24FF382
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiDMJcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiDMJb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 497CB2FFE0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649842173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ss4icJRzT/CRgX0lA3mqnDiaVS28swR/SsJFvAdocPs=;
        b=FsEp52HG2Pn+Wnra06glss+E/aJhzY8B0XIIl3mZPNGv8Bv6ZB0JeGD8FlyTaRU44dOgBT
        4I6JegHw1L4cm6D0W0BNF2uAH/nQ5gVvmk1NAXyBsD7tfxK+QZ3/j260E6DI8kpF9F1XCe
        s92G9QLwUIkbBcVWpfvjLLoaxVO3L5E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-OHjYqE3rOxCCBirmZYSY5Q-1; Wed, 13 Apr 2022 05:29:29 -0400
X-MC-Unique: OHjYqE3rOxCCBirmZYSY5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33BA1899EC1;
        Wed, 13 Apr 2022 09:29:29 +0000 (UTC)
Received: from localhost (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11343C27E8E;
        Wed, 13 Apr 2022 09:29:27 +0000 (UTC)
Date:   Wed, 13 Apr 2022 17:29:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>, hch@lst.de
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        yangtiezhu@loongson.cn, amit.kachhap@arm.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 RESEND 0/3] Convert vmcore to use an iov_iter
Message-ID: <YlaX9CxqPUvCN2dS@MiWiFi-R3L-srv>
References: <20220408090636.560886-1-bhe@redhat.com>
 <Yk//TCkucXiVD3s0@MiWiFi-R3L-srv>
 <YlPt+3R63XYP22um@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlPt+3R63XYP22um@osiris>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/11/22 at 10:59am, Heiko Carstens wrote:
> On Fri, Apr 08, 2022 at 05:24:28PM +0800, Baoquan He wrote:
> > Add Heiko to CC.
> > 
> > On 04/08/22 at 05:06pm, Baoquan He wrote:
> > > Copy the description of v3 cover letter from Willy:
> > > ===
> > > For some reason several people have been sending bad patches to fix
> > > compiler warnings in vmcore recently.  Here's how it should be done.
> > > Compile-tested only on x86.  As noted in the first patch, s390 should
> > > take this conversion a bit further, but I'm not inclined to do that
> > > work myself.
> > 
> > Forgot adding Heiko to CC again.
> > 
> > Hi Heiko,
> > 
> > Andrew worried you may miss the note, "As noted in the first patch,
> > s390 should take this conversion a bit further, but I'm not inclined
> > to do that work myself." written in cover letter from willy.
> > 
> > I told him you had already known this in v1 discussion. So add you in CC
> > list as Andrew required. Adding words to explain, just in case confusion.
> 
> Thanks for letting me know again. I'm still aware of this, but would
> appreciate if I could be added to cc in the first patch of this
> series, so I get notified when Andrew sends this Linus.

Right, it's my neglect. I should CC all involved during the discussion.

By the way, could both of you, Heiko, Christoph, help check this
patchset and offer your ack again if it's OK to you? I removed
Christoph's Reviewed-by because there's some change as per Al's 
comment, and replace my own 'Acked-by' with 'Signed-off-by' according to
our posting rule.

