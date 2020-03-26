Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D07193F02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 13:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgCZMkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 08:40:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgCZMkt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:40:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E788FAC65;
        Thu, 26 Mar 2020 12:40:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 98D2F1E10FD; Thu, 26 Mar 2020 13:40:47 +0100 (CET)
Date:   Thu, 26 Mar 2020 13:40:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Use clear_bit_unlock_is_negative_byte for
 PageWriteback
Message-ID: <20200326124047.GA13756@quack2.suse.cz>
References: <20200326122429.20710-1-willy@infradead.org>
 <20200326122429.20710-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326122429.20710-3-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-03-20 05:24:29, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By moving PG_writeback down into the low bits of the page flags, we can
> use clear_bit_unlock_is_negative_byte() for writeback as well as the
> lock bit.  wake_up_page() then has no more callers.  Given the other
> code being executed between the clear and the test, this is not going
> to be as dramatic a win as it was for PageLocked, but symmetry between
> the two is nice and lets us remove some code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

The patch looks good to me. Just one nit:


> +	VM_BUG_ON_PAGE(!PageWriteback(page), page);
> +	if (__clear_page_writeback(page))
> +		wake_up_page_bit(page, PG_writeback);

Since __clear_page_writeback() isn't really prepared for PageWriteback()
not being set, can we move the VM_BUG_ON_PAGE() there? Otherwise feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
