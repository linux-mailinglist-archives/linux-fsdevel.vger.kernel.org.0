Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79444668B4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 06:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjAMF2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 00:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbjAMF1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:27:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F78625E9;
        Thu, 12 Jan 2023 21:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u6svsDv3oPWCvjudHdQlqCOrFDk6O3xm8BGo5fakt5c=; b=KNt+kaL9IbofAf4FmOV2p0jmO2
        KviAq8o+wi4QQVov9jCIrj6U+6brA6mRic08K1Y2tpB9yJMyQq2EPYZ0zPfXf+IDz/D/PLdOHZmIS
        7Z85UbD94tOm552z4CxOYzo0SHvDSp/L//wlZcos9lbz8Xj+24Iu6id18I6GU5RAC1VxdWFr5tnZh
        y+rcTSWRJH9zjdjpVluK0YoFs05Zwqrd5UrzKMnFBIvSt6rXf3Mop7n8a2bZO4DXXB5kFqXOLvmsC
        ViTQBlANr/J/qn9T5+2zQP4TRnpxHXQrXz6mFYTAP9aQpxiWR13bpMdKv8Em4eKb6f/AmUEvoZ4/u
        t8NCnQKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGCaK-000UfJ-It; Fri, 13 Jan 2023 05:26:36 +0000
Date:   Thu, 12 Jan 2023 21:26:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y8DrjAuB6kT7tymi@infradead.org>
References: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344728530.2425628.9613910866466387722.stgit@warthog.procyon.org.uk>
 <Y8B4hpF5czsk7pK1@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8B4hpF5czsk7pK1@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 09:15:50PM +0000, Al Viro wrote:
> This cleanup_mode thing is wrong.  It's literally a trivial
> function of ->user_backed and ->data_source - we don't
> even need to look at the ->type.
> 
> Separate it into an inline helper and be done with that;
> don't carry it all over the place.
> 
> It's really "if not user-backed => 0, otherwise it's FOLL_PIN or FOLL_GET,
> depending upon the direction".

That would defintively clean up the bio code as well..
