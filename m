Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927774900DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 05:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiAQEkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 23:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiAQEkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:40:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0721C061574;
        Sun, 16 Jan 2022 20:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uR8uodyrCDk4BZAzJIFK2uL40QezGKhhsTM0fjhGqBA=; b=XaGX4PUAsNwC+GX21L2mOSsd5j
        l6sXSsu40ncOTZXWtkuTJcyWBEO3Z4W15v/kMSQxToYd4Or8X/HBzM7DQZVcdogS2IbZiove5JSG7
        hrfM+X3wmhNsJawL69MAD9VgyAEjfu+buOArRCEIN0/KBiLdP4WZZcYO/8iKgMCDkTWdZVU6deFJa
        2GQa2387O+6CrFQKRUm4clJJ7K2IbURfhRjQ+aGniaBj8DBIZ27rJ5wX04qP9d5Lanf7gaju5lvJe
        jmB93yn4pjMY+nXv5cS2ImHrYix6wLBl8gK2ox8QscqxBILXz9TjQiyvXbVlCceSb3957wBZ6X6aZ
        sLVOZokw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9Jon-007khC-Kq; Mon, 17 Jan 2022 04:40:33 +0000
Date:   Mon, 17 Jan 2022 04:40:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH 09/12] mm/readahead: Align file mappings for non-DAX
Message-ID: <YeTzQU+JR43x6kha@casper.infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
 <20220116121822.1727633-10-willy@infradead.org>
 <d4ac99a0-6c45-e81b-c08a-56083c4cdd6e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ac99a0-6c45-e81b-c08a-56083c4cdd6e@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 11:17:55AM +0800, Rongwei Wang wrote:
> It seems this patch will make all file mappings align with PMD_SIZE?

Only those which are big enough.  See __thp_get_unmapped_area():

        if (off_end <= off_align || (off_end - off_align) < size)
                return 0;

> And
> support realize all file THP, not only executable file THP?

Executables are not the only files which benefit from being mapped
to an aligned address.  If you can use a PMD to map a font file,
for example, that's valuable.

