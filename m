Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED066A434E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 14:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjB0NuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 08:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjB0NuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:50:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FA31CADF
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 05:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677505775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbh0k81SJj8KXcQWsPETE7GSsJc/6C/vn1XuCZ3ElNk=;
        b=XAS1fQmdiUpxaG0KZ+xvGIXOd9zPpGYz/NgqtFcUHpZap91Yo4rf6VJpL3ZfrcQCuyTqW0
        5JXEL/7wbK1QfLPiLX0oenL8nTBBaauM7Xh/9lilo8v5zST6qZO52EuKKIXl4k+J/t0c5z
        q+oNT2V7eFx6zGfce5245HYapwN8f7A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-SA1C-3EVN9iuDzHDZrUQJg-1; Mon, 27 Feb 2023 08:49:29 -0500
X-MC-Unique: SA1C-3EVN9iuDzHDZrUQJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EEC33C21C21;
        Mon, 27 Feb 2023 13:49:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28010404BEC5;
        Mon, 27 Feb 2023 13:49:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230202204428.3267832-5-willy@infradead.org>
References: <20230202204428.3267832-5-willy@infradead.org> <20230202204428.3267832-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH 4/5] afs: Zero bytes after 'oldsize' if we're expanding the file
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2730678.1677505767.1@warthog.procyon.org.uk>
Date:   Mon, 27 Feb 2023 13:49:27 +0000
Message-ID: <2730679.1677505767@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> POSIX requires that "If the file size is increased, the extended area
> shall appear as if it were zero-filled".  It is possible to use mmap to
> write past EOF and that data will become visible instead of zeroes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

That seems to work.  Do you want me to pass it on to Linus?  If not:

Acked-by: David Howells <dhowells@redhat.com>

