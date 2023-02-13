Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D7C694DEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 18:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjBMR0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 12:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjBMR0d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:26:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C6D1CF72
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 09:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676309141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VNyANMGF9OwsTFd5OqRhUr3qVbMqC/5HgFkj+TRiOzg=;
        b=X+ZR+IsLikqMptjmfSFCdCI/BzihRjp7Ka4fGbgPK51lQUBn8EQf1HC42SRRos/eeMvnIH
        ayOaWO6tUcrMOtOb4gcIuhZZlr/NBjik4yEMCur6Bg3XxHyv6afHJV9zztp/r1qQhztO8J
        NzBf/ptb6ZWpZS8H7hWItrqVmzu0vsc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-P-sviZC_M7-fQF0PQuCCgg-1; Mon, 13 Feb 2023 12:25:35 -0500
X-MC-Unique: P-sviZC_M7-fQF0PQuCCgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42BF8800B24;
        Mon, 13 Feb 2023 17:25:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F4C04010E85;
        Mon, 13 Feb 2023 17:25:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2344208.1676308516@warthog.procyon.org.uk>
References: <2344208.1676308516@warthog.procyon.org.uk> <Y+pdHFFTk1TTEBsO@makrotopia.org>
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
Content-ID: <2344524.1676309132.1@warthog.procyon.org.uk>
Date:   Mon, 13 Feb 2023 17:25:32 +0000
Message-ID: <2344525.1676309132@warthog.procyon.org.uk>
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

David Howells <dhowells@redhat.com> wrote:

> > [   30.379325]  filemap_get_pages+0x254/0x604
> 
> Would you also be able to find out what line that was on?

Actually, I think this is the line of interest:

	[   30.296108] lr : filemap_read_folio+0x40/0x214

David

