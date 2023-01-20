Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3C675DD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 20:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjATTTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 14:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjATTTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:19:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F10C4E8A
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 11:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674242329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+iEmqgi2xG1bd5OetUWtWkkvH6CIkfAlH9mAdhcmUY=;
        b=bmaZeWbef0MBlJiJeuj2OnB/lpVBBDUswDMhnfS0bFpbtCGEjWIC4JvDvimACDh14CdQf9
        jQbdRgk02+lAV/HK9ARHPFfMcGRG8DXRF/hj5EhgjXbtYM4KHhvWmNUDFfCQDhwO6K1MvI
        xYe9Y+m6st70L74IEhoLIERh4quHzMw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574--LfyQgVcOqum_snKdJpVRw-1; Fri, 20 Jan 2023 14:18:47 -0500
X-MC-Unique: -LfyQgVcOqum_snKdJpVRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A509101A521;
        Fri, 20 Jan 2023 19:18:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB7A22166B2A;
        Fri, 20 Jan 2023 19:18:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8rkjYn7HY/IwHrL@casper.infradead.org>
References: <Y8rkjYn7HY/IwHrL@casper.infradead.org> <20230120175556.3556978-1-dhowells@redhat.com> <20230120175556.3556978-9-dhowells@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 8/8] mm: Renumber FOLL_GET and FOLL_PIN down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3560195.1674242325.1@warthog.procyon.org.uk>
Date:   Fri, 20 Jan 2023 19:18:45 +0000
Message-ID: <3560196.1674242325@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> Although I was hoping you'd renumber some of the others since we
> currently have gaps at 0x200, 0x400, 0x1000, and 0x4000 as well
> as the 0x40 you're using here.

Since the other patches don't require this one, I can renumber them all and
send it directly to Andrew.

David

