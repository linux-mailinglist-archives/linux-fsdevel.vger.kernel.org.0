Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9016258756
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 07:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgIAFVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 01:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIAFVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:21:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9565BC061290;
        Mon, 31 Aug 2020 22:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EzqIhDH/cS54YzDgua0GxgVXInNJr6f5YbW8VLVuLQQ=; b=Fu+IsqQ1R5N7FaDD2KFtevAcvx
        JiqK2dJ8/zNpFi0T9iIrf3fOp+S9ygP0UnlFSvtH7EQUKtNBSMoYtwukPB577hxGKJroHZ/FKXtVl
        1CTKfTd2D08X+WENY4ZSR+ffF8UX/l1192EwNmeiROvtG2kWjkSYS+GTtQVEBFfctB0DTIqPGS1Og
        D0lfMu8ZifSEn7y1/2tXjQafrDY4fK8iW88BFOHPyOILKZanfowaclsqOwT3yLvSLTVFFjKtIZ93b
        QK69UKpP+aFBt/s1FZC3QLDHJlO/6Cc381Sjt8eLeO+Zn7XirlZtufDPK6AY2HmbEYMqc25bjJmJv
        fOY4yrvg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCyjX-0006ea-Dj; Tue, 01 Sep 2020 05:21:27 +0000
Date:   Tue, 1 Sep 2020 06:21:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     darrick.wong@oracle.com, hch@infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iomap: fix WARN_ON_ONCE() from unprivileged users
Message-ID: <20200901052127.GA24560@infradead.org>
References: <20200831182353.14593-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831182353.14593-1-cai@lca.pw>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 02:23:53PM -0400, Qian Cai wrote:
> It is trivial to trigger a WARN_ON_ONCE(1) in iomap_dio_actor() by
> unprivileged users which would taint the kernel, or worse - panic if
> panic_on_warn or panic_on_taint is set. Hence, just convert it to
> pr_warn_ratelimited() to let users know their workloads are racing.
> Thank Dave Chinner for the initial analysis of the racing reproducers.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
