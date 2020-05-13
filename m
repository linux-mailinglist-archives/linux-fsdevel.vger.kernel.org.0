Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FEA1D0F15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 12:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbgEMKEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 06:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732894AbgEMKEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 06:04:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CC0C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3QBcfThUifKW+O+jbtg7hz+rX+dEa1RA5Uh8DWmrXHQ=; b=EOx/td4dKhIqVaIaMx65OS81PV
        2/CaeMBZi6u7XfQ9NvZoEs0gocri0VozrGSNgbIib+LTQXVhEtTK0pzsUEfRBf4HG/tgT5E+XwOsJ
        uq/Q8eunZizCv94GY9O9mX3beo1ySc+CaHmRD1n1WLDOBwA1CU/mNIFeWLIOdBlhxUaGDqATEVPmV
        I6qDlcD09MemXgKAycFGDi8/D/WFZ7QE18nKRioPc75obCl2BHi7jYPocDI60NLGVbvQAjOCsYSRl
        TuTqlnDLzHJj2N28HYsYW5TvieMiBhp/xhUW0Esd+xnSFqPH8YkHsTCaY8bFdYGxA7TiZ8HrWyCsX
        Ml5yx3BQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoFc-000332-Vh; Wed, 13 May 2020 10:04:32 +0000
Date:   Wed, 13 May 2020 03:04:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/12] f*xattr: allow O_PATH descriptors
Message-ID: <20200513100432.GC7720@infradead.org>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <20200505095915.11275-6-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505095915.11275-6-mszeredi@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Needs a Cc to linux-api and linux-man.

On Tue, May 05, 2020 at 11:59:08AM +0200, Miklos Szeredi wrote:
> This allows xattr ops on symlink/special files referenced by an O_PATH
> descriptor without having to play games with /proc/self/fd/NN (which
> doesn't work for symlinks anyway).

Do we even intent to support xattrs on say links?  They never wire up
->listxattr and would only get them through s_xattr.  I'm defintively
worried that this could break things without a very careful audit.
