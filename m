Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4516E4093
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 09:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDQHTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 03:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjDQHTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B943C01
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 00:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681715945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ywuq69NDoGYBzQBvoab/Vrezh1wLVkJwTzR8zqW+Rk=;
        b=JclyqtbxAjBMl77edCRgg/2NcbK+kuhioh8YLeHGgBazqc9PlIRKueyINAiscltHVn6sx9
        MymMrYC6Jmb3zGx055aPo/SO/psA/ms54tK+r5BuH1gCbOqBhWDRt6iVRKzGWIpZUoY5kU
        SYAB9P9tYN2aCWhr6zjKAc6d/741UtM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-GuH0lb_pPn6g73_mhRP5ZQ-1; Mon, 17 Apr 2023 03:18:59 -0400
X-MC-Unique: GuH0lb_pPn6g73_mhRP5ZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 570C68996E8;
        Mon, 17 Apr 2023 07:18:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1602140C6E6E;
        Mon, 17 Apr 2023 07:18:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <2d5fa5e3-dac5-6973-74e5-eeedf36a42b@google.com>
References: <2d5fa5e3-dac5-6973-74e5-eeedf36a42b@google.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next] shmem: minor fixes to splice-read implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1379546.1681715874.1@warthog.procyon.org.uk>
From:   David Howells <dhowells@redhat.com>
Date:   Mon, 17 Apr 2023 08:18:57 +0100
Message-ID: <1379675.1681715937@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hugh Dickins <hughd@google.com> wrote:

> +	if (unlikely(!len))
> +		return 0;

Should this be done in do_splice_to() instead?

Also, is it too late for Jens to fold this into the original patch since it's
not upstream yet?

Otherwise:

Reviewed-by: David Howells <dhowells@redhat.com>

