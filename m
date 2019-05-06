Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE7A14389
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 04:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfEFCuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 May 2019 22:50:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfEFCuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 May 2019 22:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SG/rqX2xe67P88isvEgP5AEb4JnGOKR0/Rffnrqoj/g=; b=WJA6/CXLEDQTYnpUBLJPsai+N
        tCWHQkJK/nOPhgE2J9w19yZr4RUhQO7/0/IwTJLqgCuTfCQxH/eHVPJvP7h6oWfBgSnv94QCp/vi6
        WJ6sBW/Rl/Xes4l/14jVYVmK2JA4L/i1D80nKfPHfqW4kC8N6waRFio0xrBSJWYq+hP9E/gFbmpbG
        rHpJpHJHk4eJ/X9W2Y37xIWjIUWUg1eht2Nec79WPL8CbqrcG8xT1wpRBJrBJnbSs2SbFquvdTSKv
        vyytHuXpCBy7svNsjBh0b+CuDVIdvLLpCXSrheUzo08JOd8t7aM0xWzJfIIMhfYt0GgkxPCEjKdRN
        UA++FiZxA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNThX-0000uE-3I; Mon, 06 May 2019 02:49:59 +0000
Date:   Sun, 5 May 2019 19:49:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Tamir Carmeli <carmeli.tamir@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Use list.h instead of file_system_type next
Message-ID: <20190506024958.GC16963@bombadil.infradead.org>
References: <20190504094549.10021-1-carmeli.tamir@gmail.com>
 <20190504094549.10021-2-carmeli.tamir@gmail.com>
 <20190504134503.GA16963@bombadil.infradead.org>
 <CAKxm1-H9cgym_RQ-oLcZWEPpyUf5NrZPt_Zu3U=mpU=E38SbvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxm1-H9cgym_RQ-oLcZWEPpyUf5NrZPt_Zu3U=mpU=E38SbvQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 05, 2019 at 09:25:21PM +0300, Tamir Carmeli wrote:
> I just found it weird that there is a proprietary implementation of a
> linked list while surely the kernel already offers well established
> data structures.

It's a singly linked list rather than a doubly linked list.

> IMO, the current code is a bit hard to understand, especially the
> addition of a new struct to the list in the line "*p = fs" after
> find_filesystem returned the last member.
> Correct, I'm not familiar with all the use cases of the code.

It looks like a fairly standard implementation of a singly-linked 
list in C to me.

> I'm not sure that XArray is a good choice since there is no notion of
> an index attached to the pointer, it's really just a linked list of
> pointers.

You don't need to attach an index to the pointer; you can just use
xa_alloc() to store it at the first available index.

