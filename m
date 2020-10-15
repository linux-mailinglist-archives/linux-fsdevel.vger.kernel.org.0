Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAC28EF01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbgJOJCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 05:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgJOJCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:02:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC623C061755;
        Thu, 15 Oct 2020 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i5I/+cL4/3BlrD1oU/6ksmOSk/qvKfKsTAdChNORLE8=; b=TssziCuKhu+1FMQTF7TdAznCvs
        3wf31mB6br60aOA10fFjnjz4zucQawjaIVi98uQAWJL9cvAPmO0RKUN0GouLWSsCKTdUPVBNDFsoV
        Mrb0xKHkx5KR4TiHECNhtTiMIpRWqOvyG37o7YZ46NC49Q0H4l2nLmxuQ1H+5sXI87bLV4g7q0iCI
        aoXAla6IHi7PZ0gXRmx/1Oq0q50C+8whZA3Xn7UtIX1RuFhVZUcoBR/xTryh3MZKY2GykxNywq8Lk
        mgsPo2UmbVGDUTfrZAykSKaR2GERVG6hhr3SXMVN11kl7JWWBl894lOhZnBVM28hUwQeEtWELGDCv
        af1DTZLQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSz9m-0003Pp-UN; Thu, 15 Oct 2020 09:02:42 +0000
Date:   Thu, 15 Oct 2020 10:02:42 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 00/16] Allow readpage to return a locked page
Message-ID: <20201015090242.GA12879@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 09, 2020 at 03:30:48PM +0100, Matthew Wilcox (Oracle) wrote:
> Ideally all filesystems would return from ->readpage with the page
> Uptodate and Locked, but it's a bit painful to convert all the
> asynchronous readpage implementations to synchronous.  The first 14
> filesystems converted are already synchronous.  The last two patches
> convert iomap to synchronous readpage.

Is it really that bad?  It seems like a lot of the remainig file systems
use the generic mpage/buffer/nobh helpers.

But I guess this series is a good first step.
