Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539403CF9C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 14:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhGTMBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 08:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhGTMBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:01:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95248C061574;
        Tue, 20 Jul 2021 05:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mPQYZ33BlIlkd+dlj726EPZl7tWfypJs/9dI+fk9jOI=; b=LlZjdT2lJ7hqhYOLaFTHZ2MrNS
        yMAxfTels85yLjDevtVIPWJKxmWb0TnPovMeXl3bNFDJyNWgdud/36VM5HX+hr56ZUpIRljS0aRbK
        CrknnuUKOrkUlgxJtW493IFjzhrFKB6keI2eARUJED7Q40VWDG3kYlF/ULL3KXMlkJDWgFbTBv5w/
        zCNG4P1yyYS84/01BJ6h+bNiNthp01O0un6x2IVJSWvKZoHC/ldhiWqlXwGwNjkxpIecyJlI2tXcM
        68dgVdzH/DcivgBiFnfU1+sX6WbYMr2H5ej78YxBoDSMuO91zB4Idth48sMWQ+1rg+pgVVOvHgdgj
        Z7xO1+kQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5p3j-0086gc-Lf; Tue, 20 Jul 2021 12:41:23 +0000
Date:   Tue, 20 Jul 2021 13:41:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 000/138] Memory folios
Message-ID: <YPbEax52N7OBQCZp@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <YParbk8LxhrZMExc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YParbk8LxhrZMExc@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 01:54:38PM +0300, Mike Rapoport wrote:
> Most of the changelogs (at least at the first patches) mention reduction of
> the kernel size for your configuration on x86. I wonder, what happens if
> you build the kernel with "non-distro" configuration, e.g. defconfig or
> tiny.config?

I did an allnoconfig build and that reduced in size by ~2KiB.

> Also, what is the difference on !x86 builds?

I don't generally do non-x86 builds ... feel free to compare for
yourself!  I imagine it'll be 2-4 instructions per call to
compound_head().  ie something like:

	load page into reg S
	load reg S + 8 into reg T
	test bottom bit of reg T
	cond-move reg T - 1 to reg S
becomes
	load folio into reg S

the exact spelling of those instructions will vary from architecture to
architecture; some will take more instructions than others.  Possibly it
means we end up using one fewer register and so reducing the number of
registers spilled to the stack.  Probably not, though.
