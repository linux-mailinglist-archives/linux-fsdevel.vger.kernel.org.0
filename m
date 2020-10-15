Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE9228EF8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 11:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbgJOJrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 05:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388789AbgJOJrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:47:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B217BC061755;
        Thu, 15 Oct 2020 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nw0A5cwFjJlH+kEnsKYF/IGID7fdcc4saoL5ENJHEUE=; b=p6k3WfZCMs4kOTPtJFhU1a5mnR
        pfLSxdJ95hOEZ6u34BqecV0XjgWvS0PVipInxOT7fmY1RcEe3hN27Cv3yxzsbnr/mXdsdt6BHX4RN
        +edJOzbGx6HQbYOvmojnkJm1UXgcM1k8hC8JdKE99BQGBMlxDIHqncOBD3l4zAW7C9Xlw2EWdP302
        8iY+Y6jFsICewY0BYT2oUPKW1qXdGb6Q54ReVqYKn8OwlFuYAz7wAijxRaHOhrM7qRwAj7lxsI7VL
        q4opkagwzUPTpiNFmN6wZNQvoVD7xSg+y5kjjdspb1qLXZlLt7bBEI6+A4PtzOxHWJoek4QG+b5/r
        l1weic0A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSzqe-0005zi-2P; Thu, 15 Oct 2020 09:47:00 +0000
Date:   Thu, 15 Oct 2020 10:47:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: use page dirty state to seek data over
 unwritten extents
Message-ID: <20201015094700.GB21420@infradead.org>
References: <20201012140350.950064-1-bfoster@redhat.com>
 <20201012140350.950064-2-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012140350.950064-2-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I don't think we can solve this properly.  Due to the racyness we can
always err one side.  The beauty of treating all the uptodate pages
as present data is that we err on the safe side, as applications
expect holes to never have data, while "data" could always be zeroed.
