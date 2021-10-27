Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA4843C345
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 08:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhJ0Gwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 02:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhJ0Gwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:52:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DDAC061570;
        Tue, 26 Oct 2021 23:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yjuWgGmhQsdJLTs6v2WuNddPxXE6Sp4DzBaIzpvmDxI=; b=C5iwMARf+IMLZdYCmk6ZUrqOkO
        8BwoK3oTNJDlvSjeimyONSspbVA1scvfDU+66PFDD3dLzT6NFr3opsayEOwR2nXD/UQNuiKmxo1Y8
        9VcCSxCnK4544hxrLn1Q+6+3xqaFirt088Fy912wVD5q14DRRDCT6srIfw1ruVTyctXhFZZhiFiiF
        v3k4kTFZf60t1bQi5bkepl9c7guEHtbzZrmP2UDqOqIcHSJmlbb9ssd+eqmErkz5Oam+1MMNKVMbU
        tl3E0Q/zIWt1tEbckfFO0WIFCqAS2kD/IXbdMRtpnXHodSv/GpTla3Ask2eTyW0X1NaJU8B3iaS/N
        JRm0MBZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfcl5-0043Vr-Rj; Wed, 27 Oct 2021 06:49:59 +0000
Date:   Tue, 26 Oct 2021 23:49:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
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
Message-ID: <YXj2lwrxRxHdr4hb@infradead.org>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 08:52:55PM +0000, Jane Chu wrote:
> Thanks - I try to be honest.  As far as I can tell, the argument
> about the flag is a philosophical argument between two views.
> One view assumes design based on perfect hardware, and media error
> belongs to the category of brokenness. Another view sees media
> error as a build-in hardware component and make design to include
> dealing with such errors.

No, I don't think so.  Bit errors do happen in all media, which is
why devices are built to handle them.  It is just the Intel-style
pmem interface to handle them which is completely broken.  

> errors in mind from start.  I guess I'm trying to articulate why
> it is acceptable to include the RWF_DATA_RECOVERY flag to the
> existing RWF_ flags. - this way, pwritev2 remain fast on fast path,
> and its slow path (w/ error clearing) is faster than other alternative.
> Other alternative being 1 system call to clear the poison, and
> another system call to run the fast pwrite for recovery, what
> happens if something happened in between?

Well, my point is doing recovery from bit errors is by definition not
the fast path.  Which is why I'd rather keep it away from the pmem
read/write fast path, which also happens to be the (much more important)
non-pmem read/write path.
