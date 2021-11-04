Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D899D445019
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 09:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhKDIYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 04:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDIYg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:24:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FE3C061714;
        Thu,  4 Nov 2021 01:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NUHSkPZKdCeYjtK4gysRgJLuWX7RQNT/5Sx0eDpMchA=; b=4xLVQ8osQ9u7MwgQvsr3sqrJeD
        9TeLt91+NwT0iLut4BXjRJBcxw0lMeMSqiRjYh4XgkE1PQrRNl08jVT9JyFpmlQhBpgZwpNzC7xMI
        hiC6iZUM3mkSSQST7ZxjYHy/5jXDxo6QvvmqFEvKsvTfyAex0tERVVtpRaOXUU61g/oG5RkjZoFeB
        TZrKDRAjsajsqkt0olW0LX+JQ39We/7NFqZyULyX2fndDMXdWifE2lk1vC5WUjxhfmhGKc/1zjGn3
        QYyApkpEieQ+jUMzVI3qcKfDa/jRt9Z2WGjepJzjmpfamFUU+6n6un4hPFOb/Yv5OXa76e+SB76Db
        LPxk7IwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miY00-008HaJ-Ih; Thu, 04 Nov 2021 08:21:28 +0000
Date:   Thu, 4 Nov 2021 01:21:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with
 RWF_RECOVERY_DATA flag
Message-ID: <YYOYCMqc5kOoRvcE@infradead.org>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org>
 <20211028002451.GB2237511@magnolia>
 <YYDYUCCiEPXhZEw0@infradead.org>
 <dfca8558-ad70-41d5-1131-63db66b70542@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfca8558-ad70-41d5-1131-63db66b70542@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 06:09:57PM +0000, Jane Chu wrote:
> This is clearer, I've looked at your 'dax-devirtualize' patch which 
> removes pmem_copy_to/from_iter, and as you mentioned before,
> a separate API for poison-clearing is needed. So how about I go ahead
> rebase my earlier patch
>  
> https://lore.kernel.org/lkml/20210914233132.3680546-2-jane.chu@oracle.com/
> on 'dax-devirtualize', provide dm support for clear-poison?
> That way, the non-dax 99% of the pwrite use-cases aren't impacted at all
> and we resolve the urgent pmem poison-clearing issue?

FYI, I really do like the in-kernel interface in that series.  And
now that we discussed all the effects I also think that automatically
doing the clear on EIO is a good idea.

I'll go back to the series and will reply with a few nitpicks.
