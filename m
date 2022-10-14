Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679375FEDED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 14:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJNMWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 08:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJNMWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5C31CBAB6
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665750158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eTJ6H+vkHbZWZzz1kcdrU95L06MHJ63ZS+qqL/O1J7Y=;
        b=bm+Jm3BU+Fnor19mjxDPedYJutDz3UHYyla76If26LwN5jWXVGBsIhG/2Sl8I1fvkWstiP
        IldYMPRwG0mmDrIgLrog5rTfBm1M0boe5KxPshTKuYGE0zr0OlBcyD68hO4q4PPg8aYOc5
        RWIMtl3IUpmFv2ol9sWVJYuuAsWky9k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-7hvqyvaBNoeS4ukpc1w-4Q-1; Fri, 14 Oct 2022 08:22:33 -0400
X-MC-Unique: 7hvqyvaBNoeS4ukpc1w-4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0308800186;
        Fri, 14 Oct 2022 12:22:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BC52C15BB3;
        Fri, 14 Oct 2022 12:22:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yy5pzHiQ4GRCOoXV@ZenIV>
References: <Yy5pzHiQ4GRCOoXV@ZenIV> <3750754.1662765490@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, jlayton@redhat.com, smfrench@gmail.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] iov_iter: Add extraction functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1366584.1665750147.1@warthog.procyon.org.uk>
Date:   Fri, 14 Oct 2022 13:22:27 +0100
Message-ID: <1366586.1665750147@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> How is it better than "iov_iter_get_pages2() into a fixed-sized
> array and handle the result" done in a loop?

I did that first - and you objected on the basis that I shouldn't be taking
page refs if it's not necessary, and under some circumstances some of the
pages pointed to by the iterator might not be something that I should attempt
to take a ref on.

David

