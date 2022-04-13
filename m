Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704F64FFD76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 20:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiDMSJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 14:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiDMSJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:09:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7AD4C7A5;
        Wed, 13 Apr 2022 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RYArLPbSRQE8E13k3ycxmMoQnNRcq1Ic+NpsE4J+dOQ=; b=vMzaRyZmQeJIGHwv1m13Wm5unS
        s3ZTYmn9U4xKPzk44Q0g/u0dGqXES86OwZ1Ug1FlZ4Gg8SY/4PB8pK+ojDwrwQ+qfVTfcIdStZpCq
        dn32OxPcKjM/VvEY22ob50yqVN/B7Yow4fnHkU2iVyAgpCu1Fgh71ZP0IztEIy8ibfnA+6BL+YaKB
        8+UCXRFsHA1WTfOQRgoML1NAxOSqHgyOW8XqCLYRn+FtSosvkYfDg7Ji22uJvZt/yAJqLxEHNriiS
        YM1wYeGLasScQ4LaGKJ8/lstaGm1Jk1WfaXWuKJWpoPWU4bZl0nmuks4rHwfP57ywTk+ZF+jmaeJy
        78VBzJCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nehNW-00ESOu-K7; Wed, 13 Apr 2022 18:06:06 +0000
Date:   Wed, 13 Apr 2022 19:06:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Mark Hemment <markhemm@googlemail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Borislav Petkov <bp@alien8.de>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, viro@zeniv.linux.org.uk,
        x86@kernel.org
Subject: Re: making x86 clear_user not suck, was Re: [PATCH] tmpfs: fix
 regressions from wider use of ZERO_PAGE
Message-ID: <YlcRDrEGwEz1EymZ@casper.infradead.org>
References: <9a978571-8648-e830-5735-1f4748ce2e30@google.com>
 <20220409050638.GB17755@lst.de>
 <f73cfd56-35d2-53a3-3a59-4ff9495d7d34@google.com>
 <20220412045757.GA5131@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412045757.GA5131@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 12, 2022 at 06:57:57AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 08, 2022 at 11:08:29PM -0700, Hugh Dickins wrote:
> > > 
> > > Either way I'd rather do this optimization in iov_iter_zero rather
> > > than hiding it in tmpfs.
> > 
> > Let's see what others say.  I think we would all prefer clear_user() to be
> > enhanced, and hack around it neither here in tmpfs nor in iov_iter_zero().
> > But that careful work won't get done by magic, nor by me.
> 
> I agree with that.
> 
> > And iov_iter_zero() has to deal with a wider range of possibilities,
> > when pulling in cache lines of ZERO_PAGE(0) will be less advantageous,
> > than in tmpfs doing a large dd - the case I'm aiming not to regress here
> > (tmpfs has been copying ZERO_PAGE(0) like this for years).
> 
> Maybe.  OTOH I'd hate to have iov_iter_zero not used much because it
> sucks too much.
> 
> So how can we entice someone with the right knowledge to implement a
> decent clear_user for x86?

Apparently that already happened, but it needs finishing up:
https://lore.kernel.org/lkml/Yk9yBcj78mpXOOLL@zx2c4.com/
