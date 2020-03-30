Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF52197E57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgC3O1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 10:27:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgC3O1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G9G7LXUIUcwm5Tey2Anco7zNrOhYjJba/HCYfMtgmfc=; b=EEG+NCB9bf6g+bxztsQWuzwanK
        xx5hayOTfnSr5WqzSxaQyPxs5W6FIzqAaRqjU2qY1MX0nxl0uITm3idHvPctjkq5bjdF0EAUSg3y+
        aUHdvE6Jvx3kN06bElUl0+Epxb9EMVeWDg2+lcBo+r6BbkFJbOra3KwuOgocEhCvTT9FTO6WoT2r7
        UzPEDpRgL/Ky1MqpLl/IaIacTzisCgr7XDGU7XtFho1uKIWB1Sn5a2pyLvXmC2DIo5K6pOKh7YsUt
        +F74TXPhii9BUVEaJLFudRo0MGXUfVCdUns3dtK0epemyBVjW+WXn9t9f+5yQVpIgz462gQ3DcoxS
        sZ3k16Tg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIvNc-0003i0-5J; Mon, 30 Mar 2020 14:27:08 +0000
Date:   Mon, 30 Mar 2020 07:27:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] XArray: internal node is a xa_node when it is bigger
 than XA_ZERO_ENTRY
Message-ID: <20200330142708.GC22483@bombadil.infradead.org>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-7-richard.weiyang@gmail.com>
 <20200330125006.GZ22483@bombadil.infradead.org>
 <20200330134519.ykdtqwqxjazqy3jm@master>
 <20200330134903.GB22483@bombadil.infradead.org>
 <20200330141350.ey77odenrbvixotb@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330141350.ey77odenrbvixotb@master>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 02:13:50PM +0000, Wei Yang wrote:
> On Mon, Mar 30, 2020 at 06:49:03AM -0700, Matthew Wilcox wrote:
> >On Mon, Mar 30, 2020 at 01:45:19PM +0000, Wei Yang wrote:
> >> On Mon, Mar 30, 2020 at 05:50:06AM -0700, Matthew Wilcox wrote:
> >> >On Mon, Mar 30, 2020 at 12:36:40PM +0000, Wei Yang wrote:
> >> >> As the comment mentioned, we reserved several ranges of internal node
> >> >> for tree maintenance, 0-62, 256, 257. This means a node bigger than
> >> >> XA_ZERO_ENTRY is a normal node.
> >> >> 
> >> >> The checked on XA_ZERO_ENTRY seems to be more meaningful.
> >> >
> >> >257-1023 are also reserved, they just aren't used yet.  XA_ZERO_ENTRY
> >> >is not guaranteed to be the largest reserved entry.
> >> 
> >> Then why we choose 4096?
> >
> >Because 4096 is the smallest page size supported by Linux, so we're
> >guaranteed that anything less than 4096 is not a valid pointer.
> 
> I found this in xarray.rst:
> 
>   Normal pointers may be stored in the XArray directly.  They must be 4-byte
>   aligned, which is true for any pointer returned from kmalloc() and
>   alloc_page().  It isn't true for arbitrary user-space pointers,
>   nor for function pointers.  You can store pointers to statically allocated
>   objects, as long as those objects have an alignment of at least 4.
> 
> So the document here is not correct?

Why do you say that?

(it is slightly out of date; the XArray actually supports storing unaligned
pointers now, but that's not relevant to this discussion)
