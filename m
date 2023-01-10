Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3DF66449B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 16:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbjAJPZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 10:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbjAJPYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:24:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281918D5C4;
        Tue, 10 Jan 2023 07:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oNTdMR+VSzbfWekKWcdjtSu/K0LW9KTEw3USctOnxiU=; b=zDpFs6D6/Tjb+OJyb9xHVqz5ls
        pFBMbIHtHrX5PunG/rgPabqbdWsIp1KBDrf94nAwIf9VYD6FmA/1emyHb1r0sQyyYkWM/4hPMTuYH
        CjuTU2l4k73L7IxJXvEelJio32ymOa/d75HhexdbaH1Pm73qL+xhGiJHI9FGLfxoavkIFYh0jEdtH
        zdctHIHRZL2kUGScC6WtgGn7TciKAR23dSJH5DDLnVpfqgaSthQAGfeSBcaaTPNgZDREUasnqBkig
        kdHpEzl5txPM+j1xgPLyjr9/q0Y7/aL0jYStyfxdcapJzOIxqTOST0W0pqT6rhKzv6TlZxEw/VKXv
        9aVLJvpQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFGUF-007Yt2-4o; Tue, 10 Jan 2023 15:24:27 +0000
Date:   Tue, 10 Jan 2023 07:24:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Message-ID: <Y72DK9XuaJfN+ecj@infradead.org>
References: <20230108213305.GO1971568@dread.disaster.area>
 <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com>
 <20230109124642.1663842-1-agruenba@redhat.com>
 <Y70l9ZZXpERjPqFT@infradead.org>
 <Y71pWJ0JHwGrJ/iv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y71pWJ0JHwGrJ/iv@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:34:16PM +0000, Matthew Wilcox wrote:
> > Exactly.  And as I already pointed out in reply to Dave's original
> > patch what we really should be doing is returning an ERR_PTR from
> > __filemap_get_folio instead of reverse-engineering the expected
> > error code.
> 
> Ouch, we have a nasty problem.
> 
> If somebody passes FGP_ENTRY, we can return a shadow entry.  And the
> encodings for shadow entries overlap with the encodings for ERR_PTR,
> meaning that some shadow entries will look like errors.  The way I
> solved this in the XArray code is by shifting the error values by
> two bits and encoding errors as XA_ERROR(-ENOMEM) (for example).
> 
> I don't _object_ to introducing XA_ERROR() / xa_err() into the VFS,
> but so far we haven't, and I'd like to make that decision intentionally.

So what would be an alternative way to tell the callers why no folio
was found instead of trying to reverse engineer that?  Return an errno
and the folio by reference?  The would work, but the calling conventions
would be awful.
