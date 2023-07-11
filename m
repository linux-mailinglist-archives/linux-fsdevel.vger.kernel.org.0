Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380DC74F94C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 22:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjGKUrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 16:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjGKUq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:46:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C01C19BE;
        Tue, 11 Jul 2023 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9g5scv8hIFZXb+DK9StTPf2rz5BCTsTPOwTWmyYsrV0=; b=rUAMsZdBXnF1KeVRZXnNDm+GZQ
        E7HSL4OIdIuFhhyYgjPG8QyuPJDyWL5SUI49OcGUwxb6Z5fpeelixbJiswvFfWXUYTHcBEJgqMQgN
        3TSGre6We8XWGgOzkjq+srYxRhcV7apzSp2FubWIXqk0DU6WCI2IMrK0CjNTotvMe36M7+m7yUI6k
        oTfvgJ/3sPgtLn8ffukbg55hN2TBXiYeIfJwg6mDN92GQSa8SYqYCZZpHm0FQ/MgoZdeOxhs+EUVX
        gFTcYBMW5i21nXtBKjuBCt1zPJ0Eig6WNa3Cv+RzFntRPFz/QHzc6/aDCZMS2zkGYr1VdDWz7gBFA
        n4gKi7bw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJKG1-00G2Zt-F1; Tue, 11 Jul 2023 20:46:49 +0000
Date:   Tue, 11 Jul 2023 21:46:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v4 2/9] iov_iter: Add copy_folio_from_iter_atomic()
Message-ID: <ZK2/ubktKtEQdBUD@casper.infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-3-willy@infradead.org>
 <ZKz3NP2/UNysc1+e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKz3NP2/UNysc1+e@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:31:16PM -0700, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 02:02:46PM +0100, Matthew Wilcox (Oracle) wrote:
> > Add a folio wrapper around copy_page_from_iter_atomic().
> 
> As mentioned in the previous patch it would probably be a lot more
> obvious if the folio version was the based implementation and the
> page variant the wrapper.  But I'm not going to delay the series for
> it.

My plan for that is:

 - Add copy_folio_from_iter() wrapper
 - Convert all users
 - Convert all users of copy_page_to_iter()
 - Convert copy_page_to_iter_nofault() to copy_folio_to_iter_nofault()
   (it has one user)
 - Convert page_copy_sane() to folio_copy_sane()

But this is pretty low priority compared to all the other page->folio
conversions that need to happen.  So many filesystems ...
