Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED88B2DD259
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 14:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgLQNnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 08:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgLQNnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:43:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F71C06138C;
        Thu, 17 Dec 2020 05:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/8lQifGcjmxPMERF4ubMZzEbBgP5tWrAqrwbgQG01/Q=; b=Tv+BEuMqTd/K8WVZLQxLEiXPdc
        CbKWGO9BGErSn3G2Jeh+1mBevLNLruQHGH3OzLxjSBBNIUm1jtVC2/mQqJsVp1lCuO3q2HnOBFuOe
        ee1MfduWiDzTiTOMQsdlsoSzRpQN9PO0lMThLySdyOv6HkbS+kn77PnocNCBPDXIbxwJcFRHdG0au
        JYPaUNktkRHv+oCpEwJvMRbIFmBygMOhkPKuoNzeDQ4OS5IV7qAZ4odKbRf525DB+duDogeNqUGl2
        Y0adOedGYl8Z6f/I2TAjvwDcV3a57S3lny6A4G3AjEc0/pHUJvXCNWKsKBK+2jc9uN8WY0kp0Col6
        B9LozgGg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kptYT-0006kd-IQ; Thu, 17 Dec 2020 13:42:53 +0000
Date:   Thu, 17 Dec 2020 13:42:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/25] btrfs: Use readahead_batch_length
Message-ID: <20201217134253.GE15600@casper.infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
 <20201216182335.27227-19-willy@infradead.org>
 <a5b979d7-1086-fe6c-6e82-f20ecb56d24c@nvidia.com>
 <20201217121246.GD15600@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217121246.GD15600@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 12:12:46PM +0000, Matthew Wilcox wrote:
> ehh ... probably an off-by-one.  Does subtracting 1 from contig_end fix it?
> I'll spool up a test VM shortly and try it out.

Yes, this fixed it:

-               u64 contig_end = contig_start + readahead_batch_length(rac);
+               u64 contig_end = contig_start + readahead_batch_length(rac) - 1;

