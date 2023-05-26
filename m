Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D217C7121FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbjEZISQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbjEZISJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:18:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B1FD9;
        Fri, 26 May 2023 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zY2JucRUrNWziMftW7L1MRIScvAVGPwtouR2Nzo2DAQ=; b=RXuWcxZ4sIlRrdZ3VkR6pFOeJA
        JDVu86XKLUYmiocYTp/lqmmxFU+WCz2Tang9PJ8lbXpIenVRjFwdF4Mj9bHFWtB5XiSXZ+uFbZjgR
        VXdyjrlwV2bU9Msust0jkBvr4JOOsxYRwMuFFQLxWSBQVRZlCdkJ7/k86htchqfIkrkm6HcC3Sgw3
        FyYRw4RLLfR18H0n35hdwgF1GDGVFyP/UQYLKC6GC5Gy1O610axvksi39sLsQsADcHy/BSO7fZPsD
        ClTArYVp4X/H6UWnIaQ9wM11ZZ36w0ZVXOSI941gVTRzAe0+q0KxWyDec2mX5FNhc7V8pAbOdunZ3
        QNVTtRaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2Se1-001Zpy-2G;
        Fri, 26 May 2023 08:17:53 +0000
Date:   Fri, 26 May 2023 01:17:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
Message-ID: <ZHBrMTkKiqhxBo5w@infradead.org>
References: <20230525223953.225496-1-dhowells@redhat.com>
 <20230525223953.225496-2-dhowells@redhat.com>
 <89c7f535-8fc5-4480-845f-de94f335d332@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89c7f535-8fc5-4480-845f-de94f335d332@lucifer.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 09:10:33AM +0100, Lorenzo Stoakes wrote:
> On Thu, May 25, 2023 at 11:39:51PM +0100, David Howells wrote:
> > Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a pointer
> > to it from the page tables and make unpin_user_page*() correspondingly
> > ignore a ZERO_PAGE when unpinning.  We don't want to risk overrunning a
> > zero page's refcount as we're only allowed ~2 million pins on it -
> > something that userspace can conceivably trigger.
> 
> I guess we're not quite as concerned about FOLL_GET because FOLL_GET should
> be ephemeral and FOLL_PIN (horrifically) adds GUP_PIN_COUNTING_BIAS each
> time?

I think FOLL_GET would be just as useful.  But given that we have
a few places that release pins while gets just do a put_page it would
be a lot more effort to audit all of them.  Maybe it's better do only
do this once we've converted all the places that should do pin and
have very few FOLL_GET users left.
