Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A24C4E2C4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 16:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350273AbiCUPca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 11:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350274AbiCUPc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EAD81697B7
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647876661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hhSp8iQTKVEga9dadR4O7uujQ52rzrIccc6xagF59Sc=;
        b=Jx8536CASrSnokKby28qO3RpyfVuwK+1BNXpbLiTiw803hIxQkhb1zTB5gANxK2gg2RQ6J
        2TargcLKDHm8BUlx3gVr0HZHt10Oe1Exo5mUrpgpRheRIauGQpUlBPa8k+/nPaZbQr3kwj
        TJ/h7SR7dVqc45A3CONXoSPyy0ORGNo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-RGOmsTb4OT-rq4KGBvxN3w-1; Mon, 21 Mar 2022 11:30:56 -0400
X-MC-Unique: RGOmsTb4OT-rq4KGBvxN3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41FDC28EA6E3;
        Mon, 21 Mar 2022 15:30:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27A1A40C1241;
        Mon, 21 Mar 2022 15:30:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YjiX5oXYkmN6WrA3@casper.infradead.org>
References: <YjiX5oXYkmN6WrA3@casper.infradead.org> <20220316131723.111553-1-jefflexu@linux.alibaba.com> <20220316131723.111553-4-jefflexu@linux.alibaba.com> <YjiAVezd5B9auhcP@casper.infradead.org> <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com> <YjiLACenpRV4XTcs@casper.infradead.org> <adb957da-8909-06d8-1b2c-b8a293b37930@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, JeffleXu <jefflexu@linux.alibaba.com>,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1035024.1647876652.1@warthog.procyon.org.uk>
Date:   Mon, 21 Mar 2022 15:30:52 +0000
Message-ID: <1035025.1647876652@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> Absolutely; just use xa_lock() to protect both setting & testing the
> flag.

How should Jeffle deal with xarray dropping the lock internally in order to do
an allocation and then taking it again (actually in patch 5)?

David

