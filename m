Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5847A67994B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjAXNc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjAXNc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:32:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94094390D;
        Tue, 24 Jan 2023 05:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E45IznY0HJWboJXuzX57iniIDMpYVHRiJ9SSrvw9h4s=; b=G2VVDWQly6/pVagZpDJEjNn7jw
        +9AZ4SOxf3Hj16UmAMPowpruPOhIpBEeJndUwZi4Ha82QkBvWq7BDns6v+RpYTZLalQTkbO6aVpSd
        WkqAkJWXLV4lONJdf685FkxcYz8iD1RfEFVGYBw9J23knps1ALcsvsDRIZP4Bx5RXY5zsneSa2Ms0
        Spnstllxnkorwf+82/2b4zkrhdubKqEvrXBI2TDy4aTVGZ+ZxFobMz+ggvPE8K5D7XBIUEaYF+19m
        peH0WF+HmVfu1fM1fOTyMKMeUMdLAQ2BhBO4b1QUgn563daot55JJpCmQohY7xK0sqT3L/HjrWCKe
        kAq4TgNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJPs-003zT9-Rs; Tue, 24 Jan 2023 13:32:48 +0000
Date:   Tue, 24 Jan 2023 05:32:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] iov_iter: Improve page extraction (pin or just
 list)
Message-ID: <Y8/eAEfzOICZ+PSo@infradead.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <02063032-61e7-e1e5-cd51-a50337405159@redhat.com>
 <Y8/aSZBVVF7NpDQ0@infradead.org>
 <0c043cfb-2cdb-8363-2423-d1510006fc06@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c043cfb-2cdb-8363-2423-d1510006fc06@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:22:36PM +0100, David Hildenbrand wrote:
> > Note that while these series coverts the two most commonly used
> > O_DIRECT implementations, there are various others ones that do not
> > pin the pages yet.
> 
> Thanks for the info ... I assume these are then for other filesystems,
> right? (such that we could adjust the tests to exercise these as well)

Yes.  There's the fs/direct-io.c code still used by a few block based
file systems, and then all the not block based file systems as well
(e.g. NFS, cifs).

> ... do we have a list (or is it easy to make one)? :)

fs/direct-io.c is easy, just grep for blockdev_direct_IO.

The others are more complicated to find, but a grep for
iov_iter_get_pages2 and iov_iter_get_pages_alloc2 in fs/ should be a
good approximation.
