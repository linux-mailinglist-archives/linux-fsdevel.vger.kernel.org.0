Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678BA4EE5AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 03:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243741AbiDABZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 21:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243730AbiDABZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85D76433A8
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 18:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648776232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vwOa79y9ibsQuRI0CLlBumdEL7m0Wg1YNnaA9Uyd4Ro=;
        b=UdB/kKOTyr68o5SkUBldvSjepeQvl6fHpU0zZrndSw8iOSahOPOrXaMO9mu17MgsaVBBiy
        utx086tOkC3/bNM7rY563GiW6+8llYRlqt6xvyQjA33Xi7FStnfp8pI1YzPh1wlb3IcL1z
        yB7UWOaYwmYsgvgxar0JlD0lQc403ZI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-QghpayWnMdW2d4GHLWUxDg-1; Thu, 31 Mar 2022 21:23:48 -0400
X-MC-Unique: QghpayWnMdW2d4GHLWUxDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 947AD38035A4;
        Fri,  1 Apr 2022 01:23:47 +0000 (UTC)
Received: from localhost (ovpn-12-192.pek2.redhat.com [10.72.12.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62E70C15D56;
        Fri,  1 Apr 2022 01:23:46 +0000 (UTC)
Date:   Fri, 1 Apr 2022 09:23:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, yangtiezhu@loongson.cn,
        amit.kachhap@arm.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 0/4] Convert vmcore to use an iov_iter
Message-ID: <YkZUHu1n7ZEaqLoq@MiWiFi-R3L-srv>
References: <20220318093706.161534-1-bhe@redhat.com>
 <YkWPrWOe1hlfqGdy@MiWiFi-R3L-srv>
 <YkW8d/HuXewjSuXs@casper.infradead.org>
 <20220331171407.0f7458c480e1c9406ca9337e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331171407.0f7458c480e1c9406ca9337e@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
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

On 03/31/22 at 05:14pm, Andrew Morton wrote:
> On Thu, 31 Mar 2022 15:36:39 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Thu, Mar 31, 2022 at 07:25:33PM +0800, Baoquan He wrote:
> > > Hi Andrew,
> > > 
> > > On 03/18/22 at 05:37pm, Baoquan He wrote:
> > > > Copy the description of v3 cover letter from Willy:
> > > 
> > > Could you pick this series into your tree? I reviewed the patches 1~3
> > > and tested the whole patchset, no issue found.
> > 
> > ... I'd fold patch 4 into patch 1,
> 
> I think so too, please.  The addition then removal of a
> read_from_oldmem() implementation is a bit odd.
> 
> > but yes, Andrew, please take these patches.
> 
> And against current -linus please.  There have been some changes since
> then (rcu stuff).

OK, I will fold 1 to 4, and send v5 based on linus's tree.

