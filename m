Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF09482EDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 08:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiACHvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 02:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiACHvY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:51:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B0DC061761
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jan 2022 23:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N70+f5ukNUqMHlWzcDiVN5mc1EisTttVBGA9o2wFp4U=; b=tn1SzcMwXgNRLH/GY9jpXdR5+F
        i5YE+DmO7f2iHuc8ad+ltzpbS6aZa2l1E/hSi0hp3g0k/uVzDTefZWfLPBGPQJuEfi8Ez0xAhto7F
        7fcmRwTg8qc0xJ+bV7Y9iZSSYwg7gcY76oCKn11oiy+WQbG3ZdrbzxMmNLt2mjnmPbW5kgzYSnPm1
        jygxextSb4rq8tpCuW/sp83bLjYowg5UfJ+QcFK42OZlDXCbNa5+j85fxyoZ/jPTtLYj4VVReOLHY
        w0PnrGchNXx6Fhv80K+TxXNR/awtpOpqojgrjMLwgbaU8FbdLmVK4pfMYAnOlZRxLxpHpM1hQblm6
        wmBJkKqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4I7h-008X4P-IW; Mon, 03 Jan 2022 07:51:17 +0000
Date:   Sun, 2 Jan 2022 23:51:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next 1/3] truncate,shmem: Fix data loss when hole punched
 in folio
Message-ID: <YdKq9bOcZ0M30LZ8@infradead.org>
References: <43bf0e3-6ad8-9f67-7296-786c7b3b852f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43bf0e3-6ad8-9f67-7296-786c7b3b852f@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 02, 2022 at 05:32:28PM -0800, Hugh Dickins wrote:
>  
> +	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);

Should this move to the else branch?

Same for the other copy of this code.  Otherwise this looks sane.
