Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BD14FCE5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 06:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347271AbiDLFAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 01:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241228AbiDLFAT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:00:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11AA33EAF;
        Mon, 11 Apr 2022 21:58:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4103168AA6; Tue, 12 Apr 2022 06:57:58 +0200 (CEST)
Date:   Tue, 12 Apr 2022 06:57:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
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
Subject: making x86 clear_user not suck, was Re: [PATCH] tmpfs: fix
 regressions from wider use of ZERO_PAGE
Message-ID: <20220412045757.GA5131@lst.de>
References: <9a978571-8648-e830-5735-1f4748ce2e30@google.com> <20220409050638.GB17755@lst.de> <f73cfd56-35d2-53a3-3a59-4ff9495d7d34@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f73cfd56-35d2-53a3-3a59-4ff9495d7d34@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 11:08:29PM -0700, Hugh Dickins wrote:
> > 
> > Either way I'd rather do this optimization in iov_iter_zero rather
> > than hiding it in tmpfs.
> 
> Let's see what others say.  I think we would all prefer clear_user() to be
> enhanced, and hack around it neither here in tmpfs nor in iov_iter_zero().
> But that careful work won't get done by magic, nor by me.

I agree with that.

> And iov_iter_zero() has to deal with a wider range of possibilities,
> when pulling in cache lines of ZERO_PAGE(0) will be less advantageous,
> than in tmpfs doing a large dd - the case I'm aiming not to regress here
> (tmpfs has been copying ZERO_PAGE(0) like this for years).

Maybe.  OTOH I'd hate to have iov_iter_zero not used much because it
sucks too much.

So how can we entice someone with the right knowledge to implement a
decent clear_user for x86?
