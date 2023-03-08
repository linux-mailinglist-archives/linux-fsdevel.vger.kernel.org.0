Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF846B07F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 14:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCHNHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 08:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjCHNHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:07:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67E0D08D9
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 05:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678280581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E+JpZdzShNnz09SI24AkbLkWXPdhG4xH8w/Z8yC3hnY=;
        b=TglU4s19Rk1k9mHftQdTC6wyJYWtIugIdxxfvDWy5azwLGS+DwxqC4YKCUIoBGVeGOd7lq
        STDo9L099ANSEA7enXCjNoXyPVPJZCb9Ae2EGc+rWNPAgjf4vBWrxk/foj7FaHjxNE/geW
        Znn5bn1MHmh7r7Sy92I90aZyawHdGCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-ttX-xMO6NXiDvSMEyLvwqw-1; Wed, 08 Mar 2023 08:02:55 -0500
X-MC-Unique: ttX-xMO6NXiDvSMEyLvwqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74DB018A63F2;
        Wed,  8 Mar 2023 13:02:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D36CF4024CA1;
        Wed,  8 Mar 2023 13:02:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <4eb320f0fee86b259fd499cd2d97127922a57e66.camel@kernel.org>
References: <4eb320f0fee86b259fd499cd2d97127922a57e66.camel@kernel.org> <20220210094454.826716-1-rbergant@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com,
        Roberto Bergantinos Corpas <rbergant@redhat.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: parse sloppy mount option in correct order
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1971388.1678280573.1@warthog.procyon.org.uk>
Date:   Wed, 08 Mar 2023 13:02:53 +0000
Message-ID: <1971389.1678280573@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> This looks like it will do the right thing. We definitely _don't_ want
> order-dependent option parsing.

If we don't want order-dependent option parsing, then we really need to
accumulate all the options in the kernel and only then fully parse/interpret
them - and go through them at least twice where we know we may have options
that retroactively affect other options:-/

I guess we can't kill off "sloppy" for the moment.

David

