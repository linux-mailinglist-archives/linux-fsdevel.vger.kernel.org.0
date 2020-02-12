Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2A15A319
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 09:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgBLIRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 03:17:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37200 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgBLIRn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MY0ydPqw5aZvHUFOaxpb4KlvnSqokiIiIOtel5Vm7Ok=; b=Jk5E+XVml8BqecXyM/pxcgm3ZL
        scQ/7t2VG4af0E0RFCcCK3OIUqUIFhtZRY+cKRMBVCIP5AXNITp3zqcLLb0Wv9wQBmHqabnvgR19s
        LCEk97HW9qWhy4RvU62aOQYb+acqAnKQ7H2iIW2WBKJZTz+7IZx+eZ0Y/1AEo1eXQMOKt91CPHF9/
        aG/nrH73VV3LLjYbZBqw0kHaWflQC8Ftmf2xiciYXw6iHmho064778YPZPPmmlZM+98gOjknLxWWc
        YngzNbFEAJ+zsY7Dc4y1LlurrQBa85KwHVoQhshR1Cv/zPsBmi4h7++4Wba2YkJWS5fitINLhbhiE
        LT2r4iIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1nDK-00079o-PK; Wed, 12 Feb 2020 08:17:42 +0000
Date:   Wed, 12 Feb 2020 00:17:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/25] iomap: Support large pages in write paths
Message-ID: <20200212081742.GE24497@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-18-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:37PM -0800, Matthew Wilcox wrote:
> Also simplify the logic in iomap_do_writepage() for determining end of
> file.

>  	 * ---------------------------------^------------------|
>  	 */
>  	offset = i_size_read(inode);
> -	end_index = offset >> PAGE_SHIFT;
> -	if (page->index < end_index)
> -		end_offset = (loff_t)(page->index + 1) << PAGE_SHIFT;
> -	else {
> +	end_offset = file_offset_of_next_page(page);
> +
> +	if (end_offset > offset) {

Nit: can you drop the empty line here?  Maybe it is just a pet peeve
of mine, but I hate empty line between a variable assignment, and a
use that is directly related to it.

Also it might be worth to preload this as a separate patch as it
is a very nice but not completely obvious cleanup that deserves to
stand out.
