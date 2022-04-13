Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745AC4FFB87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiDMQnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiDMQny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:43:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B28864BEC;
        Wed, 13 Apr 2022 09:41:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D83DA68C7B; Wed, 13 Apr 2022 18:41:28 +0200 (CEST)
Date:   Wed, 13 Apr 2022 18:41:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Christoph Hellwig <hch@lst.de>,
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
        linux-stm32@st-md-mailman.stormreply.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] tmpfs: fix regressions from wider use of ZERO_PAGE
Message-ID: <20220413164128.GD31487@lst.de>
References: <9a978571-8648-e830-5735-1f4748ce2e30@google.com> <20220409050638.GB17755@lst.de> <f73cfd56-35d2-53a3-3a59-4ff9495d7d34@google.com> <20220412162221.7c55379548017bab61ea5103@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412162221.7c55379548017bab61ea5103@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 12, 2022 at 04:22:21PM -0700, Andrew Morton wrote:
> On Fri, 8 Apr 2022 23:08:29 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> 
> > > 
> > > Either way I'd rather do this optimization in iov_iter_zero rather
> > > than hiding it in tmpfs.
> > 
> > Let's see what others say.  I think we would all prefer clear_user() to be
> > enhanced, and hack around it neither here in tmpfs nor in iov_iter_zero().
> > But that careful work won't get done by magic, nor by me.
> > 
> > And iov_iter_zero() has to deal with a wider range of possibilities,
> > when pulling in cache lines of ZERO_PAGE(0) will be less advantageous,
> > than in tmpfs doing a large dd - the case I'm aiming not to regress here
> > (tmpfs has been copying ZERO_PAGE(0) like this for years).
> 
> We do need something to get 5.18 fixed.  Christoph, do you think we
> should proceed with this patch for 5.18?

Well, let's queue it up then.
