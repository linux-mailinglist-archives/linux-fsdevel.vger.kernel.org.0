Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D13E7091F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 10:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjESIsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjESIsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 04:48:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C88A180;
        Fri, 19 May 2023 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZAbGvedE1BQJOMrbfCufZTyJ4e2EZLn0BqAhB63sICY=; b=bRy4xB+F05w3yUcX9Qj7jsXixk
        UiPK2HdtbtcNlpwDDsAwCjjVN21Tp6m1GqZVtPqu51Zhc6QFKauy/qn1GcXC52/0SNNQKgEZeknSX
        1dCTZoBtDIOdxZuKa757Yd+g3fbdTG/klmlaRG2fFtO15XaDjQqvTdwnk/Tpkz2ldnTO37pUBCiMF
        LOHeUyGfWDuTGQyuyG3p0D7oGhKcYZggXCvVyz5lpXq3AzvG08oK2f3l3T/faSWz+kBHPlw8dAMTT
        1OJKf6iOGpmKMWIapyjTFeN5r/xDRyfa5hfC5eSXLwrEQyVOiwkPSqmZunppGfp65GiofaE2or3W+
        wUeaUBzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzvmI-00FZoD-04;
        Fri, 19 May 2023 08:47:58 +0000
Date:   Fri, 19 May 2023 01:47:57 -0700
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
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v20 03/32] splice: Make direct_read_splice() limit to eof
 where appropriate
Message-ID: <ZGc3vUU/bUpt+3Tm@infradead.org>
References: <ZGcusJQfz68H1s7S@infradead.org>
 <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-4-dhowells@redhat.com>
 <1742093.1684485814@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1742093.1684485814@warthog.procyon.org.uk>
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

On Fri, May 19, 2023 at 09:43:34AM +0100, David Howells wrote:
> > direct_read_splice (which also appears a little misnamed) really is
> > a splice by calling ->read_iter helper.
> 
> It can be renamed if you want a different name.  copy_splice_read() or
> copy_splice_read_iter()?

Maybe something like that, yes.

> 
> > I we don't do any of this validtion we can just call it directly from
> > splice.c instead of calling into ->splice_read for direct I/O and DAX and
> > remove a ton of boilerplate code.
> 
> There's a couple of places where we might not want to do that - at least for
> non-DAX.  shmem and f2fs for example.  f2fs calls back to buffered reading
> under some circumstances.  shmem ignores O_DIRECT and always splices from the
> pagecache.

So?  even if ->read_iter does buffered I/O for O_DIRECT it will still
work.  This can in fact happen for many other file systems due when
they fall back to buffeed I/O due to various reasons.
