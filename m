Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E017263A9E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 20:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfGISMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 14:12:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbfGISMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P3ueQUk39Urdy4H2eQrfPhbl/wBSlhVIMCyj0GFHQ3c=; b=LeK6mb/2lX2jD4f4OVt1EtZ9s
        PFTiVizZAQT7u6kxeK6WDTahsbWjRypnfE1k6MBRB0LKya1sTBW9E6AAY/aUFBN+gz7wwAtQlUQYC
        d+kF3wgpRs1q2KMes4A7YaRRGHXBz5IyWTebQ9ez83YxftjI5NdduB/qWFfwhgXjwexXkBRj1PRKv
        ws0isAuG4vUNmQhRNBgQ4gpWMXrw+W6TFKBQsAivzbi0SQgvHoQrbfUjd/mB+UcNfghiNKJr6ghQc
        UttXZDiNLqPHYKvJuPjtZNcyNlk0jE99yohzc3OGjnIOJwMVeLkbURUo/JJnFgDN9sDhEQVWY0jU5
        sKniPs0Nw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkub8-0004b0-EC; Tue, 09 Jul 2019 18:12:14 +0000
Date:   Tue, 9 Jul 2019 11:12:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] iomap: regroup code by functional area
Message-ID: <20190709181214.GA31130@infradead.org>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
 <20190708184652.GB20670@infradead.org>
 <20190709164952.GT1404256@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709164952.GT1404256@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I looked over it and while some of the small files seem very tiny
they are reasonably split.

What rather annoys me is the page.c/read.c/write.c split.  All these
really belong mostly together, except maybe the super highlevel
write code that then either calls into the buffer_head vs iomap_page
based code.  By keeping them together we can eliminate most of
iomap_internal.h and once the writeback code moves also keep
iomap_page private to that bigger read.c file.

A few other minor notes:

 - I think iomap_sector() should move to linux/iomap.h as an inline
   helper.
 - iomap_actor_t / iomap_apply should probaby just move to linux/iomap.h
   as well, which would avoid needing the awkward subdir include in
   dax.c
 - some of the copyrights for the small files seem totally wrong.
   e.g. all the swapfile code was written by you, so it should not have
   my or rh copyright notices on it
