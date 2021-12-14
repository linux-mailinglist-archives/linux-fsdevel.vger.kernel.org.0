Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9704746AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 16:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhLNPki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 10:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhLNPkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:40:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ACCC061574;
        Tue, 14 Dec 2021 07:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DP7R5DQlRBuwKxAcekVF/e0Cj/7RMiSBN5vbq+wyWeY=; b=nQRaDyHAbRjSXMilHileHFVTOl
        W98orjLaE9WRiJVUXJ3wC7zh8okI+Go27Xp/k7uI0yz+mZEIkFbRyxVl4DSS1ZG0Mp+awPJpMYfHY
        LXkzmSK29bKyxXz/n/qTmaZNjtI7DFhl7Bh4qM7+VLJLF2YUsggkl7zC2d0JsM3amVPnA9ay1PL3v
        91gTgh3+rzRVae1v90xpW3ySE43cn3ukT+pWG2PimwNctXf9yrrxnNCEJhFigoti3TDq8iOzDmreM
        jok5306ShlfiSR9NmhONLA+t6CpLjNbnPj51Kl1eIQ5AwpC1CRl6DaI84ZWWZ9T8gObaGjiR7kQRA
        nPSSWXqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mx9uu-00Ej1C-74; Tue, 14 Dec 2021 15:40:36 +0000
Date:   Tue, 14 Dec 2021 07:40:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v8 1/9] dax: Use percpu rwsem for dax_{read,write}_lock()
Message-ID: <Ybi69MCK5sP4ebwG@infradead.org>
References: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
 <20211202084856.1285285-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202084856.1285285-2-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:48:48PM +0800, Shiyang Ruan wrote:
> In order to introduce dax holder registration, we need a write lock for
> dax.  Change the current lock to percpu_rw_semaphore and introduce a
> write lock for registration.

Why do we need to change the existing, global locking for that?

What is the impact of this to benchmarks?  Also if we stop using srcu
protection, we should be able to get rid of grace periods or RCU frees.
