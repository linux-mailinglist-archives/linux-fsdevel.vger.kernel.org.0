Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759016942A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 11:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjBMKTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 05:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjBMKTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:19:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651831714D;
        Mon, 13 Feb 2023 02:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=szHm+HvGboe4zElnYyIS9I3M5ezn3gwosKJMm81UK2o=; b=4raiYwiGmbF9QTaprA787JVha+
        ukzcXidyJqobihaG/aamGI8SdzEgpBKzI/9gN/rpadv+v6tiT8tIG5Xf8uy0yZjcIemuSJdtSww81
        VXerBX49HpFpDZGzSKhOiuKuBhmIppBB9Qn68/e5+Wj+u1wzKRu68uSz2VD8wkUwRyvAwZ/V9hrgN
        l8vf+RbafdbnIOiIcLmjV2BpEKg8U7/xKx+VfpZ3Qjwq09lGXGBNsLCuMP6V1V48I8xnznuaOgd+K
        mmF4NKBzOxh4rDqsoLngtbV4HWWmf3ivQW08PNJOEMdwo6zVNbxrPQjU8HyldQyrMhMK2rb7LfaAe
        g0C5HWPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRVue-00E5Ci-0Q; Mon, 13 Feb 2023 10:18:20 +0000
Date:   Mon, 13 Feb 2023 02:18:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v13 03/12] splice: Do splice read from a buffered file
 without using ITER_PIPE
Message-ID: <Y+oOa3bbJZallKtl@infradead.org>
References: <Y+n0n2UE8BQa/OwW@infradead.org>
 <20230209102954.528942-1-dhowells@redhat.com>
 <20230209102954.528942-4-dhowells@redhat.com>
 <1753989.1676283061@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1753989.1676283061@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:11:01AM +0000, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > Also why doesn't this use init_sync_kiocb?
> 
> I'm not sure I want ki_flags.

Why?
