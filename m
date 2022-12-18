Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BB365044E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 19:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiLRS3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 13:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiLRS3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 13:29:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D8BE0D;
        Sun, 18 Dec 2022 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QHxCpl9hSA5ThyPhmLxPcSgWkJDOiughbSZ1LxLOjvI=; b=AM8b4Z0OmheYiQi/balspbtUoJ
        rWuu21SuCIrDlcx9M/kqYV5qKjdtE6AXTcKV6ggklkGyPuCmHYOvNP28lnrODtOMgqutkAjhMQUWv
        Ux/p1Hx1Bs50324WDHQRCiBzXye9eP/EtNl4xeMhZkr1J1cTPmQlByN/9k12x7F0ujlPs4lpyBJCV
        VUU608eRX/Ghdpy5Y8UqL97cpfoVt4kc+PLpGvsCLHZBplQ5R6ZCieEYlTj8fsH5HyqHAO4oyJ5f4
        F58mRmz3w3hgOreF5sDBWTRjp4Jerir8XSsZXwk+chV51daZfv78mDrTwSiKZ7Iq3VfGALbcbOv7l
        YSo6AnFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6xwn-00006Q-Ci; Sun, 18 Dec 2022 17:59:37 +0000
Date:   Sun, 18 Dec 2022 17:59:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, reiserfs-devel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/8] Convert reiserfs from b_page to b_folio
Message-ID: <Y59VCfAXmg1jow2o@casper.infradead.org>
References: <20221216205348.3781217-1-willy@infradead.org>
 <11295613.F0gNSz5aLb@suse>
 <Y55TTKG2tgWL7UsQ@iweiny-mobl>
 <3515948.LM0AJKV5NW@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3515948.LM0AJKV5NW@suse>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 18, 2022 at 09:09:56AM +0100, Fabio M. De Francesco wrote:
> It all started when months ago I saw a patch from Matthew about the conversion 
> from kmap_local_page() to kmap_local_folio() in ext2_get_page().
> 
> Here I wanted to comment on the xfstests failures but, when I read patch 2/8 
> of this series and saw kmap() converted to kmap_local_folio(), I thought to 
> also use this opportunity to ask about why and when kmap_local_folio() should 
> be preferred over kmap_local_page().
> 
> Obviously, I have nothing against these conversions. I would only like to 
> understand what are the reasons behind the preference for the folio function.

I should probably update this, but here's a good start on folio vs page:
https://lore.kernel.org/linux-fsdevel/YvV1KTyzZ+Jrtj9x@casper.infradead.org/

> Mine is a general question about design, necessity, opportunity: what were the 
> reasons why, in the above-mentioned cases, the use of kmap_local_folio() has 
> been preferred over kmap_local_page()? 
> 
> I saw that this series is about converting from b_page to b_folio, therefore 
> kmap_local_folio() is the obvious choice here.
> 
> But my mind went back again to ext2_get_page :-)
> 
> It looks to me that ext2_get_page() was working properly with 
> kmap_local_page() (since you made the conversion from kmap()). Therefore I 
> could not understand why it is preferred to call read_mapping_folio() to get a 
> folio and then map a page of that folio with kmap_local_folio(). 
> 
> I used to think that read_mapping_page() + kmap_local_page() was all we 
> needed. ATM I have not enough knowledge of VFS/filesystems to understand on my 
> own what we gain from the other way to local map pages.    

read_mapping_page() is scheduled for removal.  All callers need to be
converted to read_mapping_folio() (or another variant if preferable).
I don't mind following along behind your conversions to kmap_local_page()
and converting them to kmap_local_folio(), but if I can go straight from
kmap() / kmap_atomic() to kmap_local_folio(), then I'll do that.

Eventually, kmap_local_page() will _probably_ disappear.  ext2_get_page()
is really only partially converted, and you can see that by the way it
calls ext2_check_page() instead of ext2_check_folio().  I have a design
in place for ext2_check_folio() that handles mapping large folios,
but it isn't on the top of my pile right now.

> I'd really like to work on converting fs/ufs to folios but you know that I'll 
> have enough time to work on other projects only starting by the end of 
> January. 
> 
> AFAIK this task has mainly got to do with the conversions of the address space 
> operations (correct?). I know too little to be able to estimate how much time 
> it takes but I'm pretty sure it needs more than I currently can set aside.
> 
> Instead I could easily devolve the time it is needed for making the  
> memcpy_{to|from}_folio() helpers you talked about in a patch of this series, 
> unless you or Matthew prefer to do yourselves. Please let me know.

I've been wondering about a memcpy_(to|from)_folio() helper too, but I
haven't read Ira's message about it yet.  I'll comment over there.
