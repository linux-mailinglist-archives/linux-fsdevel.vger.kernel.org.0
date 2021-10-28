Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2009A43E354
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 16:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhJ1OVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 10:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhJ1OVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:21:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB99C061570
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qBYvabBzUrmfcwMkMp4699k+QSkrdWrgSn+jwNNlusU=; b=4v86oPQHA1+wLH9XP+zcWkpp93
        oAH1vxjvEni54qeWnn+/zn48QkFsg4bbJslfbVuLu4fEUGx5htY+3Q95VHLqaAulTk4GaSmavoZAm
        n9DSeW2xE7pWwPFv5U7MwZY/G2Z0yl7VRpFKI2CMtd1wyM7UxocgU1Jkf7eBSeAn3tt1EX2K7+pYN
        noz/qV8RDFn5pcyR3xRkETbgdjDl3GqpZpdxfv7i7PBppF55ceIOmzRumGpE75wNyEPJUnDEh/iDJ
        28HpfCSvTjEgomNS8cMYpZCsFSp/CBN9zwqbdzJwVPg7m9lObrptct8ym6dIpW4CmSyrrB/mRz98C
        9P0pQQgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg6FJ-00868c-R8; Thu, 28 Oct 2021 14:19:09 +0000
Date:   Thu, 28 Oct 2021 07:19:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Chris Mason <clm@fb.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: mm: don't read i_size of inode unless we need it
Message-ID: <YXqxXXDYtKetgZY0@infradead.org>
References: <6b67981f-57d4-c80e-bc07-6020aa601381@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b67981f-57d4-c80e-bc07-6020aa601381@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Btw, given that you're micro-optimizing in this area:

block devices still use ->direct_IO in the I/O path.  It might make
sense to switch to the model of the file systems that use iomap where
we avoid that indirect call and can optimize the code for the direct
I/O fast path.  With that you woudn't even end up using this i_size_read
at all
