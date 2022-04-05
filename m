Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD4B4F2135
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 06:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiDECSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 22:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDECSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:18:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB7017A599;
        Mon,  4 Apr 2022 18:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RQe/1RGyLtJutAfIYXbUCaVRkV5ue8WY6oN5rza5dGM=; b=DMG38J1E2P6kQfgNZCEepEnC0l
        BfkfspbskxZO/vvhafQL/m/VsO+CVwdVcxwhGTo0/TW1vYeg9l2ZYKAkSWjy7LFK+fkpZRlWI+KZV
        JJrcbErzQESO95G5fma4qmgh1T7qKpsoaTWeZQJG1f7jwAh9yL4QMQvEeKzVXSkS0YjBW05cqF96l
        KS29M0DxM0FIw4gZYZmD6wCEyzZ5dLseXO0MKzYyIHau8z30pnH/t5otixn3ekVyaD+a4oph1Fyo9
        +202fK51u+5r+F2IEt2amOyHkk8r+QN+nkeXygFHObiJD32Q9vkRkrosk/DSBifL2Ipp0Xu0l4vPT
        oehzjoaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbWsG-006CDX-VD; Tue, 05 Apr 2022 00:16:45 +0000
Date:   Tue, 5 Apr 2022 01:16:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        ziy@nvidia.com, tytso@mit.edu, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 0/8] Make khugepaged collapse readonly FS THP more
 consistent
Message-ID: <YkuKbMbSecBVsa1k@casper.infradead.org>
References: <20220404200250.321455-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404200250.321455-1-shy828301@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 04, 2022 at 01:02:42PM -0700, Yang Shi wrote:
> The readonly FS THP relies on khugepaged to collapse THP for suitable
> vmas.  But it is kind of "random luck" for khugepaged to see the
> readonly FS vmas (see report: https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/) since currently the vmas are registered to khugepaged when:

I still don't see the point.  The effort should be put into
supporting large folios, not in making this hack work better.
