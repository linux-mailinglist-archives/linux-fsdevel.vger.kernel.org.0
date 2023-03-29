Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF66CD149
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 06:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjC2Eyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 00:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjC2Eye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A0D2D46
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 21:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680065633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S01Y/zhEA4qaJvTIo0c2m8xjYqU32cqDPsOeaeS0mgQ=;
        b=VN8RSeU1m2u2IXd36Idhjio0ZJmk5FM0ysvBTKtA6T9ri03CeopGAe1fCWEOTvKGp1OqVI
        8hWe1+7XZpOwmBFiK0XbHbw1cYP2r7WlPREYYstPp/QG7XQTQc5xBTZjSajYjAFH5iKD01
        W0H3NmOOL4Z2bqhdsrO5IE8INF/c/1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-Ii-LZ0zMOzmqRxZZOA6_Ig-1; Wed, 29 Mar 2023 00:53:50 -0400
X-MC-Unique: Ii-LZ0zMOzmqRxZZOA6_Ig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 418F6101A531;
        Wed, 29 Mar 2023 04:53:49 +0000 (UTC)
Received: from localhost (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D181B1121331;
        Wed, 29 Mar 2023 04:53:36 +0000 (UTC)
Date:   Wed, 29 Mar 2023 12:53:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 0/4] convert read_kcore(), vread() to use iterators
Message-ID: <ZCPETTt8g6+kL5GX@MiWiFi-R3L-srv>
References: <cover.1679566220.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679566220.git.lstoakes@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/23/23 at 10:15am, Lorenzo Stoakes wrote:
> While reviewing Baoquan's recent changes to permit vread() access to
> vm_map_ram regions of vmalloc allocations, Willy pointed out [1] that it
> would be nice to refactor vread() as a whole, since its only user is
> read_kcore() and the existing form of vread() necessitates the use of a
> bounce buffer.
> 
> This patch series does exactly that, as well as adjusting how we read the
> kernel text section to avoid the use of a bounce buffer in this case as
> well.
> 
> This has been tested against the test case which motivated Baoquan's
> changes in the first place [2] which continues to function correctly, as do
> the vmalloc self tests.
> 
> [1] https://lore.kernel.org/all/Y8WfDSRkc%2FOHP3oD@casper.infradead.org/
> [2] https://lore.kernel.org/all/87ilk6gos2.fsf@oracle.com/T/#u

The whole series looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

