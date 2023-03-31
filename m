Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD76D20F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 14:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjCaMyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 08:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCaMyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:54:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5CF199;
        Fri, 31 Mar 2023 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yeenr72+biii/gxq1Q+YDEgdmCOdBcLhSB08YsTUu+4=; b=cWuuNt3m2/7xaIpDp9GbqHfsJn
        /lptGcoV0wqRu41nyD9az7xdUuRHsgrDV9573SXFqElfIy1wjyd/TdCgBNU2rpuXQdRhNwzkJKyI1
        vU7pmWIKyi0+cGgvee7Ay3pKnZPtHniMQu3SlqrCaKw/ozat3iNr5M+QcMJT/migWIoZ7z99Va0A+
        LQ2gC/uT42y5Z8WLj2opMEIBevQMjZjNbiP49DfiZjoJBZ9ZFl3YVCtStLFCAui8J76Oi8k9FW68w
        DbwgUKhoGkZO0goGIlffRuckAhnykTFe0Zz5OKjPJ8QAx311Mr/l0Y/QMFwNBKXa7IF9Hxm5oudk3
        vC7EWnJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1piEGZ-00BQpk-1x; Fri, 31 Mar 2023 12:54:03 +0000
Date:   Fri, 31 Mar 2023 13:54:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: Re: Re: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for
 CXL
Message-ID: <ZCbX6+x1xJ0tnwLw@casper.infradead.org>
References: <ZB3ijJBf3SEF+Xl2@casper.infradead.org>
 <CGME20230331113715epcas2p13127b95af4000ec1ed96a2e9d89b7444@epcas2p1.samsung.com>
 <20230331113715.400135-1-ks0204.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331113715.400135-1-ks0204.kim@samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 08:37:15PM +0900, Kyungsan Kim wrote:
> >> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
> >
> >This sounds dangerously confused.  Do you want the EXMEM to be removable
> >or not?  If you do, then allocations from it have to be movable.  If
> >you don't, why go to all this trouble?
> 
> I'm sorry to make you confused. We will try more to clearly explain our thought.
> We think the CXL DRAM device should be removable along with HW pluggable nature.
> For MM point of view, we think a page of CXL DRAM can be both movable and unmovable. 
> An user or kernel context should be able to determine it. Thus, we think dedication on the ZONE_NORMAL or the ZONE_MOVABLE is not enough.

No, this is not the right approach.  If CXL is to be hot-pluggable,
then all CXL allocations must be movable.  If even one allocation on a
device is not movable, then the device cannot be removed.  ZONE_EXMEM
feels like a solution in search of a problem.
