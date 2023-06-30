Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912A0743EF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjF3Pdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjF3PdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69C8527D
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2RRepOp7BBkzoiWTZGgUNtL5p6yT9JMH864pOX91L68=;
        b=MH+GLSBfMHWMl3OpA2XKNccCFPY66h2uJdihREmfBeZ1D8awkGGtqM27V0T4IReY/J4BVC
        jMPx4inxL5IMn9ASjETTMvCyS6D298i5dYyIphl4S7XBbVvGjmMCd0aP4vGu/VbjTJiZoS
        IE4m1/DWMMC8d19zjSuGMafKGpepLGM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-qXsOTZnVPBOawnT-lDiFOA-1; Fri, 30 Jun 2023 11:29:37 -0400
X-MC-Unique: qXsOTZnVPBOawnT-lDiFOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 533A785A58A;
        Fri, 30 Jun 2023 15:29:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E332B40C6CCD;
        Fri, 30 Jun 2023 15:29:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZJ7cQ8Wdiyb0Ax/r@corigine.com>
References: <ZJ7cQ8Wdiyb0Ax/r@corigine.com> <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-3-dhowells@redhat.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] splice: Make vmsplice() steal or copy
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <661359.1688138974.1@warthog.procyon.org.uk>
Date:   Fri, 30 Jun 2023 16:29:34 +0100
Message-ID: <661360.1688138974@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simon Horman <simon.horman@corigine.com> wrote:

> But, on a more mundane level, GCC reports that user_page_pipe_buf_ops is
> (now) unused.  I guess this was the last user, and user_page_pipe_buf_ops
> can be removed as part of this patch.

See patch 3.

David

