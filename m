Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C34F30A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 14:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbiDEJxZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 05:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344183AbiDEJSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BD2063BE8
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 02:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649149498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rIfAwkshslHsyBEcRq37RepeRC/o2pa9Iv1u9kDoOp8=;
        b=InCT8tvz50DU2ldCz1X+HCiiOLmLurNwStv0maIY+Ojmt7HUvkawvEauKaXG09ObjgX6Ye
        Q9O+D0YT9BcPp5uwXR1LS0UZkE5GG2V9O+bmr9FpQUh6gVTPQkHCAvzKRnBM3W0rKdGoI5
        NgrWUlk1m1+a+rdWhAmL3vMnk7jJBgE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-TgqGk4AON6G7A7V85iHh5w-1; Tue, 05 Apr 2022 05:04:57 -0400
X-MC-Unique: TgqGk4AON6G7A7V85iHh5w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D79B3801ECB;
        Tue,  5 Apr 2022 09:04:56 +0000 (UTC)
Received: from localhost (ovpn-12-104.pek2.redhat.com [10.72.12.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DE8041617C;
        Tue,  5 Apr 2022 09:04:55 +0000 (UTC)
Date:   Tue, 5 Apr 2022 17:04:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, yangtiezhu@loongson.cn,
        amit.kachhap@arm.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 0/3] Convert vmcore to use an iov_iter
Message-ID: <YkwGM9yVb1lZ2HL7@MiWiFi-R3L-srv>
References: <20220402043008.458679-1-bhe@redhat.com>
 <20220404143443.2258fc7e97b45172f7608a77@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404143443.2258fc7e97b45172f7608a77@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/04/22 at 02:34pm, Andrew Morton wrote:
> > On Sat,  2 Apr 2022 12:30:05 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> You were on the patch delivery path, so these patches should have had
> your signoff.  Documentation/process/submitting-patches.rst explains.

OK, will update and repost after our IT replying and fixing the mail issue.

> 
> > Copy the description of v3 cover letter from Willy:
> > ===
> > For some reason several people have been sending bad patches to fix
> > compiler warnings in vmcore recently.  Here's how it should be done.
> > Compile-tested only on x86.  As noted in the first patch, s390 should
> > take this conversion a bit further, but I'm not inclined to do that
> > work myself.
> 
> We should tell the S390 maintainers this!
> 
> Can you please fix the signoff issue, add the S390 team to Cc and resend?

S390 maintainer has already known this. Heiko replied to v1 saying he
will take care of the s390 part, please see his comment from below link.
I will add Heiko in CC when resend.
https://lore.kernel.org/all/YbsGxJRo1153aykr@osiris/T/#u

