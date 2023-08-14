Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F5477B49A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjHNIsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 04:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjHNIr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527C310C
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692002831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d5No2yWXOwFNofrztFyXIxBaBOAMm52WifJguXNm6mc=;
        b=F77ahRPlwXWxkBhxEbjB/zWF3ojk6Qk9rSSxEErrz5F/kh9TV6D0rdRUchIr1n04wr1/+H
        DIc0N3eFv8I7P4i1oY+Gvs52QJsatRpSc/egEHAqiMI5vVvdRBzbuvzrVcbrR60NM0xfkC
        1pJHvnqNMktD0fwXwGMYwhIeEjecvQs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-m5H72l0VOcyYGOFjWcvkTg-1; Mon, 14 Aug 2023 04:47:04 -0400
X-MC-Unique: m5H72l0VOcyYGOFjWcvkTg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36BDA805AF6;
        Mon, 14 Aug 2023 08:47:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CF21492C13;
        Mon, 14 Aug 2023 08:47:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230811010309.20196-2-zhanghongchen@loongson.cn>
References: <20230811010309.20196-2-zhanghongchen@loongson.cn> <20230811010309.20196-1-zhanghongchen@loongson.cn>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Jens Axboe <axboe@kernel.dk>, David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v5 2/2] pipe: use __pipe_{lock,unlock} instead of spinlock
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3955286.1692002820.1@warthog.procyon.org.uk>
Date:   Mon, 14 Aug 2023 09:47:00 +0100
Message-ID: <3955287.1692002820@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hongchen Zhang <zhanghongchen@loongson.cn> wrote:

> -	spin_lock_irq(&pipe->rd_wait.lock);
> +	__pipe_lock(pipe);

This mustn't sleep.  post_one_notification() needs to be callable with a
spinlock held.

David

