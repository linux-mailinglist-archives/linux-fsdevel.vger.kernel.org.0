Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7304C6F75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 15:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbiB1O3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 09:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiB1O3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56A3F237D2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 06:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646058519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T7bpbKpVEq9MLTWx6hiGqkGi7ZJ+dBk/1YROkWUQd0k=;
        b=YPHTgc7lTQs3uuuH8YhjbAMVTFe26Qe2xVT2BHjXVO9zfS4PRmFNd3FQQo4r64RVNuXfOR
        FlFBvr9lBx1YwWmRpgYf9I1FpIsvD/lb8SUj8cii8BrkOCD5gi2woW5t0uoCL9GRK5JEPa
        +BBIfZvwOuBzBY5Vs4PyxPDWm0CkYi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-J65TzDB_MTehWf8efipJpQ-1; Mon, 28 Feb 2022 09:28:36 -0500
X-MC-Unique: J65TzDB_MTehWf8efipJpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1250FC81;
        Mon, 28 Feb 2022 14:28:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7A561057FCB;
        Mon, 28 Feb 2022 14:28:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CACdtm0Z4zXpbPBLJx-=AgBRd63hp_n+U-5qc0gQDQW0c2PY7gg@mail.gmail.com>
References: <CACdtm0Z4zXpbPBLJx-=AgBRd63hp_n+U-5qc0gQDQW0c2PY7gg@mail.gmail.com> <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk> <164311919732.2806745.2743328800847071763.stgit@warthog.procyon.org.uk> <CACdtm0YtxAUMet_PSxpg69OR9_TQbMQOzU5Kbm_5YDe_C7Nb-w@mail.gmail.com> <3013921.1644856403@warthog.procyon.org.uk>
To:     Rohith Surabattula <rohiths.msft@gmail.com>
Cc:     dhowells@redhat.com, smfrench@gmail.com, nspmangalore@gmail.com,
        jlayton@kernel.org, linux-cifs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] cifs: Use netfslib to handle reads
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2498967.1646058507.1@warthog.procyon.org.uk>
Date:   Mon, 28 Feb 2022 14:28:27 +0000
Message-ID: <2498968.1646058507@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rohith Surabattula <rohiths.msft@gmail.com> wrote:

> R=00000006 READAHEAD c=00000000 ni=0 s=0 1000
>               vi-1631    [000] .....  2519.247540: netfs_read:

"c=00000000" would indicate that no fscache cookie was allocated for this
inode.

> COOKIE   VOLUME   REF ACT ACC S FL DEF
> ======== ======== === === === = == ================
> 00000002 00000001   1   0   0 - 4008 302559bec76a7924,
> 0a13e961000000000a13e96100000000d01f4719d01f4719
> 00000003 00000001   1   0   0 - 4000 0000000000640090,
> 37630162000000003763016200000000e8650f119c49f411

But we can see some cookies have been allocated.

Can you turn on:

  echo 1 >/sys/kernel/debug/tracing/events/fscache/fscache_acquire/enable

David

