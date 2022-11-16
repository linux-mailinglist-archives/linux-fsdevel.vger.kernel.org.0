Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6C462BF19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 14:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiKPNK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 08:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiKPNK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:10:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EAF20BCE
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 05:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668604201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LxbfIQXXJrRBV1oeWGkIS80B2DkSE6rGVOWNTAfOIvo=;
        b=SrBZTlhhZMZTHej3WWArH6SrcSBgQzIXMYxjtakNW+gOAokUGdGpzudeHBKTolQsO/i6PK
        aqLAwMpzL0D6kNwwzY4UGQjhub9TFYkked8W9llUKM7ZcIuYM/ks1RRT6ZBSAd5w7KEjzE
        NcIcvTbApWuUjm7uq97nBKD4WgwIL1o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-hTULoGlVNLW4tAQKfocqkg-1; Wed, 16 Nov 2022 08:09:58 -0500
X-MC-Unique: hTULoGlVNLW4tAQKfocqkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AED0E3C0E216;
        Wed, 16 Nov 2022 13:09:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAAF21121314;
        Wed, 16 Nov 2022 13:09:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <34140d2f-4f1f-0d58-c0ca-eb181ca9fde3@samba.org>
References: <34140d2f-4f1f-0d58-c0ca-eb181ca9fde3@samba.org> <88b441af-d6ae-4d46-aae5-0b649e76031d@samba.org> <3609b064-175c-fc18-cd1a-e177d0349c58@samba.org> <166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk> <2147870.1668582019@warthog.procyon.org.uk> <2780586.1668600891@warthog.procyon.org.uk>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     dhowells@redhat.com, smfrench@gmail.com, tom@talpey.com,
        Long Li <longli@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix problem with encrypted RDMA data read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2905842.1668604193.1@warthog.procyon.org.uk>
Date:   Wed, 16 Nov 2022 13:09:53 +0000
Message-ID: <2905843.1668604193@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Okay, that works - though, probably unsurprisingly, it's 5x slower.

If you want to submit this patch, you can add:

	Tested-by: David Howells <dhowells@redhat.com>

David

