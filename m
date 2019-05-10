Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF21A215
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 19:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfEJRCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 13:02:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfEJRCu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 13:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IziTW291S7TLrX5c1nQ0BR6rD/rA9YRqzUixUHiWrsw=; b=hU+E15ucag7QN44PBHizLVV+U
        YXBduJaryBgxzFbdCxi9XhgPyJRVvEzVMQ/L5/jwaE4UEAkz6dSTizK6H0XZ9BbixaAny2raeA0PM
        GZYiMpAozs0jHE1ySlNQIY5IG9iXJwSy9pKxHAJt+HnwZLcQMvSbogXQfrPr9LJSsj1ZSbpCzIhUU
        yXlcyUMdz1fK5kA9fkEB2DIbEofpBepyZE1ld9ii5xkEKJ4mzvbRujLu74uneoNe0SJGdG4GRhCpX
        Mr0/e16oFwaTFLjYwBe4LBu+3c2VCErCTZxx3WbSij1Vo7+HWzZaAT7zHUz0EXtqOOb47KJ2SrKwB
        7t+EeHnRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hP8v3-00075G-R8; Fri, 10 May 2019 17:02:49 +0000
Date:   Fri, 10 May 2019 10:02:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, prakash.v@samsung.com,
        anshul@samsung.com
Subject: Re: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
Message-ID: <20190510170249.GA26907@infradead.org>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I think this fundamentally goes in the wrong direction.  We explicitly
designed the block layer infrastructure around life time hints and
not the not fish not flesh streams interface, which causes all kinds
of problems.

Including the one this model causes on at least some SSDs where you
now statically allocate resources to a stream that is now not globally
available.  All for the little log with very short date lifetime that
any half decent hot/cold partitioning algorithm in the SSD should be
able to detect.
