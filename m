Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C167675ED19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 10:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGXIJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 04:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjGXIJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7894FE
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 01:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690186133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhhWjOAo127IlI+J36ZFWJ4YvuZh0i268mYvp7khtFo=;
        b=inKVkj4SLnDwuuJykk2NXxDqHlsH6JJthGPq+dLes6KLoN7BiAdkFudvxKyFf7jdga87C1
        1PvjgdJN+hqiM5RcJZIfOxAKm77didrDTgk9xm/YdABObowX9TM6GbPc6iX/C//lRbR9G3
        QaNcq6Fq7xbkP/yC2Z6ecoqo/v96csM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-695-QHXgyZ0wOlaG5Vn_ZaG1gg-1; Mon, 24 Jul 2023 04:08:47 -0400
X-MC-Unique: QHXgyZ0wOlaG5Vn_ZaG1gg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E83429AA3B6;
        Mon, 24 Jul 2023 08:08:46 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 967751401C2E;
        Mon, 24 Jul 2023 08:08:45 +0000 (UTC)
Date:   Mon, 24 Jul 2023 16:08:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Message-ID: <ZL4xif/LX6ZhRqtf@MiWiFi-R3L-srv>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava>
 <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
 <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/24/23 at 08:23am, David Hildenbrand wrote:
> Hi,
> 
> > 
> > I met this too when I executed below command to trigger a kcore reading.
> > I wanted to do a simple testing during system running and got this.
> > 
> >    makedumpfile --mem-usage /proc/kcore
> > 
> > Later I tried your above objdump testing, it corrupted system too.
> > 
> 
> What do you mean with "corrupted system too" --  did it not only fail to
> dump the system, but also actually harmed the system?

From my testing, reading kcore will cause system panic, then reboot. Not
sure if Jiri saw the same phenomenon.

> 
> @Lorenzo do you plan on reproduce + fix, or should we consider reverting
> that change?

When tested on a arm64 system, the reproducution is stable. I will have
a look too to see if I have some finding this week.

