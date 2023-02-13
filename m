Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFAA694DC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 18:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjBMRQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 12:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjBMRQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:16:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0196F1E9E6
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 09:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676308521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lOkMPiRsM3su8G8btqTABKq0jq916HIkb564+wSAHZY=;
        b=JeLCXYenOfWZVwaTM8RX4zN7Q7X/fihSiBYwbimCD3biL+ou2FDxEnhPPoVVedrDj52iNw
        Mo29xiD6CkjcaoF3ZDI4stJy9M+zj9N2iP7MpXf2sfHCOIG1YKghb7pcUNKHfj2u/uVv3o
        l5txloIkSqVY2lBNjEGungSqlf5Sg1I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-i8k1n6HjNNe-lzbx8dv4Xw-1; Mon, 13 Feb 2023 12:15:19 -0500
X-MC-Unique: i8k1n6HjNNe-lzbx8dv4Xw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5B321C0896E;
        Mon, 13 Feb 2023 17:15:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7192F2026D4B;
        Mon, 13 Feb 2023 17:15:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+pdHFFTk1TTEBsO@makrotopia.org>
References: <Y+pdHFFTk1TTEBsO@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     dhowells@redhat.com, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: regression in next-20230213: "splice: Do splice read from a buffered file without using ITER_PIPE"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2344207.1676308516.1@warthog.procyon.org.uk>
Date:   Mon, 13 Feb 2023 17:15:16 +0000
Message-ID: <2344208.1676308516@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daniel Golle <daniel@makrotopia.org> wrote:

> I'm Currently trying linux-next daily on various MediaTek ARM64 SoCs.
> As of next-20230213 I'm now facing this bug:

Do you have any information about what the machine was using as the source and
destination of sendfile()?  What filesystem was involved?  It looks like it
was doing a cat.

> [   30.379325]  filemap_get_pages+0x254/0x604

Would you also be able to find out what line that was on?

David

