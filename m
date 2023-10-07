Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BC97BC59E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 09:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343720AbjJGHaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 03:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbjJGHaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC73EDB
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Oct 2023 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696663762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P2XYj63JutQ2NopEHr3614ehw4VQD2DCO6wPQwn2C2A=;
        b=hz6oT4njxv8MutcApmtguAkGLuSZ3KbUwzjOvX9zEV/8/Fqf8JFm9G6GA/2VsA9Mj7SavV
        EZ5bmSBBNI+use0K/sN1c+GWp0RmlTtHEaNJrI7uJMht2UXeDZFl2Hh+V4nm59PfG2cm9l
        FDmsizFTNoWOZ3WRjoewtVg1ZdXn3e8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-Id4xzfQGNO-7JeT9k6sb-w-1; Sat, 07 Oct 2023 03:29:18 -0400
X-MC-Unique: Id4xzfQGNO-7JeT9k6sb-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A24B8380200F;
        Sat,  7 Oct 2023 07:29:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D59FCC15BB8;
        Sat,  7 Oct 2023 07:29:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <356ef449-44bf-539f-76c0-7fe9c6e713bb@google.com>
References: <356ef449-44bf-539f-76c0-7fe9c6e713bb@google.com> <20230925120309.1731676-9-dhowells@redhat.com> <20230925120309.1731676-1-dhowells@redhat.com> <1809398.1696238751@warthog.procyon.org.uk>
To:     Hugh Dickins <hughd@google.com>
Cc:     dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] iov_iter: fix copy_page_from_iter_atomic()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <231154.1696663754.1@warthog.procyon.org.uk>
Date:   Sat, 07 Oct 2023 08:29:14 +0100
Message-ID: <231155.1696663754@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hugh Dickins <hughd@google.com> wrote:

> -		__copy_from_iter(p, n, i);
> +		n = __copy_from_iter(p, n, i);

Yeah, that looks right.  Can you fold it in, Christian?

David

