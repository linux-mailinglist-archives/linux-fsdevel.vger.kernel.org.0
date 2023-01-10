Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8590D6641FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 14:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbjAJNfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 08:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbjAJNes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:34:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EE95792F;
        Tue, 10 Jan 2023 05:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iaT9LQ1txjWmxV1XSqA3EJtlgw8CwLxTrjASqWSS7ew=; b=epUV45aphPRps7u7Vq4Cq2vV62
        Mit3JVAAMWsoPGuvfc8UjBmHKZ1ppZrvqfZXJCvAPnuHAvP1Qrb4ehCWA7e+vCzpqZHMlWb9Hws8S
        A1f1dD49dUdh4aj0DW0R0Sfq69V/J5AzIofvjxjVU6NiOw6dKaZZUKctwR/ldOlGgUHa0l9O2da/T
        HdoM0Tgph2sBGPLtuwn+1HpFzLxbHFFj9xmtEFmxVNPeqvnWbZWGF8OJaITltqqa9KhZz2SpcaNCt
        Fp+x9zPIQx3XMNyPCjf2vKIkWdQPiKs619GLOCwidJ1JWPy1QJ3tJS9y0MJZDjixqlQeV3r5jy0VP
        SXHPpeUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFElc-003FE0-AE; Tue, 10 Jan 2023 13:34:16 +0000
Date:   Tue, 10 Jan 2023 13:34:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Message-ID: <Y71pWJ0JHwGrJ/iv@casper.infradead.org>
References: <20230108213305.GO1971568@dread.disaster.area>
 <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com>
 <20230109124642.1663842-1-agruenba@redhat.com>
 <Y70l9ZZXpERjPqFT@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y70l9ZZXpERjPqFT@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 12:46:45AM -0800, Christoph Hellwig wrote:
> On Mon, Jan 09, 2023 at 01:46:42PM +0100, Andreas Gruenbacher wrote:
> > We can handle that by adding a new IOMAP_NOCREATE iterator flag and
> > checking for that in iomap_get_folio().  Your patch then turns into
> > the below.
> 
> Exactly.  And as I already pointed out in reply to Dave's original
> patch what we really should be doing is returning an ERR_PTR from
> __filemap_get_folio instead of reverse-engineering the expected
> error code.

Ouch, we have a nasty problem.

If somebody passes FGP_ENTRY, we can return a shadow entry.  And the
encodings for shadow entries overlap with the encodings for ERR_PTR,
meaning that some shadow entries will look like errors.  The way I
solved this in the XArray code is by shifting the error values by
two bits and encoding errors as XA_ERROR(-ENOMEM) (for example).

I don't _object_ to introducing XA_ERROR() / xa_err() into the VFS,
but so far we haven't, and I'd like to make that decision intentionally.
