Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978601C199C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 17:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgEAPew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 11:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbgEAPev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 11:34:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE1DC061A0C;
        Fri,  1 May 2020 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mudZdXlZw0GqaEzMjWKagRGi8BzWBpEPB67/0nKPQCE=; b=V1ckzZTyhF0Af9GOzBVyjPKNdH
        +EXNeBP0j1l2zsqxQ+FKSH3n4/Yje91cltc6Amc42qiW5sWBsTAK+0Trn5rjABL6hwDqVkUkZ10wl
        yLlB0dDOxxaiWd6kdwT3hMEHxSQNeJSoiBVN7c+NlHEYrjtApDvis7Bfkdtyh5kQLh8q7FPEIx5pm
        OrIMZ3FTohSfzir/oNk9z7+Zrwwn9uI0412k2RFxsgOCgSAB8pmoimyCpVCu2qwUt8YSzlxkbpwdR
        BnzmtosWaG2uOEh5hPD5XE98kV/mk53VO0b5fSnuSN8Skyu2QIEZWRaktnwq0cfHGCaSCddLuk8wv
        Hqhl00yw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUXgF-0003f0-Nf; Fri, 01 May 2020 15:34:23 +0000
Date:   Fri, 1 May 2020 08:34:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, rostedt@goodmis.org,
        mingo@redhat.com, jack@suse.cz, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] blktrace: break out of blktrace setup on
 concurrent calls
Message-ID: <20200501153423.GA12469@infradead.org>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-6-mcgrof@kernel.org>
 <20200429094937.GB2081185@kroah.com>
 <20200501150626.GM11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501150626.GM11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 03:06:26PM +0000, Luis Chamberlain wrote:
> > You have access to a block device here, please use dev_warn() instead
> > here for that, that makes it obvious as to what device a "concurrent
> > blktrace" was attempted for.
> 
> The block device may be empty, one example is for scsi-generic, but I'll
> use buts->name.

Is blktrace on /dev/sg something we intentionally support, or just by
some accident of history?  Given all the pains it causes I'd be tempted
to just remove the support and see if anyone screams.
