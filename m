Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937FC59E876
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245656AbiHWQ7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245747AbiHWQ6f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F83F7646D
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661264099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=34PbuF0eVwU1fZKmyxntLGj0oriQwCLeUvgJJbU6faI=;
        b=gPDHTqxComfuxYHBM3hqAdRbNvAeCGf6NLqKiGQluW0tuGiDVM07HlC1b030JbiWFSbZHy
        PpD2rNsmWMJQh1kf/grYGWCFwsOsB4YIpO0Kw1Rcge4K8F5YkC2PR9lykmRGlGnSWoof0d
        iDD1Qc67o9TlNRNRS6y6UyUeposKgSI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-Q7bLziqjNHmD9kYI60vzyg-1; Tue, 23 Aug 2022 10:14:56 -0400
X-MC-Unique: Q7bLziqjNHmD9kYI60vzyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 229909682A2;
        Tue, 23 Aug 2022 14:14:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 013C81415138;
        Tue, 23 Aug 2022 14:14:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YwTfPRDq04/DGTVT@casper.infradead.org>
References: <YwTfPRDq04/DGTVT@casper.infradead.org> <166126004083.548536.11195647088995116235.stgit@warthog.procyon.org.uk> <166126006184.548536.12909933168251738646.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, sfrench@samba.org, linux-cifs@vger.kernel.org,
        lsahlber@redhat.com, jlayton@kernel.org, dchinner@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: Re: [PATCH 3/5] smb3: fix temporary data corruption in collapse range
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <714207.1661264094.1@warthog.procyon.org.uk>
Date:   Tue, 23 Aug 2022 15:14:54 +0100
Message-ID: <714208.1661264094@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

>         truncate_pagecache_range(inode, start, end);
> 
> ... and presumably, you'd also want the error check?

truncate_pagecache_range() is void.

David

