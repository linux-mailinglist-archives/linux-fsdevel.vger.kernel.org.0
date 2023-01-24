Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363766798FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjAXNRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjAXNRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:17:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A773C286;
        Tue, 24 Jan 2023 05:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W2+lHouydvSTpaycCGwYD9xOK2GTd/RqMIHUpyMgoSQ=; b=FBzt8gtKF3QFO7P8Ufp6unDk18
        /su/Qx/mJSgZOA4aYDHbp5B4LMX0UHtIQcDvO39PXvIMeTGX4Bi7i11AuKO8ayad0Xc4rEkJaykR0
        9rT2aw1+UGLYRjTTOPLykSh6vg8fFF+4GlyZXt93a5/5wgA/k7PSeNMfm+K8SyVXNtXdMb7kxhZ+G
        tm9yC1hZ2ptCFH0BWGZNHYoL2w53qrZSGar5GT19VNOSunidBqfL1N18o66FZD9iL7j/cUff8jm0W
        YMDfUlwyq3wwUoOt9x+L4g+KWTQs5Yu1gQYD119m4RAlzQopZOMeH4Sg0l8l0cIxtxTos8janJWQx
        7kzQewPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJAX-003uwH-K8; Tue, 24 Jan 2023 13:16:57 +0000
Date:   Tue, 24 Jan 2023 05:16:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] iov_iter: Improve page extraction (pin or just
 list)
Message-ID: <Y8/aSZBVVF7NpDQ0@infradead.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <02063032-61e7-e1e5-cd51-a50337405159@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02063032-61e7-e1e5-cd51-a50337405159@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:44:21PM +0100, David Hildenbrand wrote:
> Once landed upstream, if we feel confident enough (I tend to), we could
> adjust the open() man page to state that O_DIRECT can now be run
> concurrently with fork(). Especially, the following documentation might be
> adjusted:

Note that while these series coverts the two most commonly used
O_DIRECT implementations, there are various others ones that do not
pin the pages yet.
