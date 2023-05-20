Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB17370A506
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 05:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjETD5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 23:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjETD5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 23:57:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43D81B0;
        Fri, 19 May 2023 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mEJo2AvtRRBovcYEODKkZg/Om1DBMDjK4oNyeFteRYQ=; b=JabwUtm18vAo7f2bgHXyFZnkFF
        q5JhN8/xdLb/wI6GZwYTcOQB8abF4Kb0j/AvXGoh84sVTx64pNxcNof0P/Px5/BSHMGvpQSfIca68
        1k/2bLDxuS2Otnmtw8EgQD0c9fkqjzTD5/vSLcC2d4pSBhExO5zjs9I7oVlc5NABX954qDvdMMH5Q
        BFdBBYsPSsif/58t79XnO0CP3PucPeFr2SXDKH7Tbm6hftKEOYcnAkpNCnfA3oZZGFAkLDDlHDTkB
        bnBm9Fmai18RFKosJO4ZIqA9/rL9sme62hpRkm7QDdFfV0kWHa6U/yOHXHZnzVfTOsD7JvPAktybM
        Ket+sh6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q0DiC-000bY9-2i;
        Sat, 20 May 2023 03:56:56 +0000
Date:   Fri, 19 May 2023 20:56:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
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
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v20 29/32] block: Replace BIO_NO_PAGE_REF with
 BIO_PAGE_REFFED with inverted logic
Message-ID: <ZGhFCCBdlSWWcG1G@infradead.org>
References: <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-30-dhowells@redhat.com>
 <ZGghr0/lFRKmaoAX@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGghr0/lFRKmaoAX@moria.home.lan>
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

On Fri, May 19, 2023 at 09:26:07PM -0400, Kent Overstreet wrote:
> On Fri, May 19, 2023 at 08:40:44AM +0100, David Howells wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > Replace BIO_NO_PAGE_REF with a BIO_PAGE_REFFED flag that has the inverted
> > meaning is only set when a page reference has been acquired that needs to
> > be released by bio_release_pages().
> 
> What was the motivation for this patch?

So that is only is set when we need to release a page, instead telling
code to not release it when it otherwise would, where otherwise would
is implicit and undocumented and changes in this series.
