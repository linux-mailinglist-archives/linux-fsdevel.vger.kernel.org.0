Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BDA4CEA2D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 10:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiCFJ2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 04:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiCFJ2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 04:28:05 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3BE434B5;
        Sun,  6 Mar 2022 01:27:14 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40D9867373; Sun,  6 Mar 2022 10:27:10 +0100 (CET)
Date:   Sun, 6 Mar 2022 10:27:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH mmotm] tmpfs: do not allocate pages on read
Message-ID: <20220306092709.GA22883@lst.de>
References: <f9c2f38f-5eb8-5d30-40fa-93e88b5fbc51@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9c2f38f-5eb8-5d30-40fa-93e88b5fbc51@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 04, 2022 at 09:09:01PM -0800, Hugh Dickins wrote:
> It's not quite as simple as just removing the test (as Mikulas did):
> xfstests generic/013 hung because splice from tmpfs failed on page not
> up-to-date and page mapping unset.  That can be fixed just by marking
> the ZERO_PAGE as Uptodate, which of course it is; doing so here in
> shmem_file_read_iter() is distasteful, but seems to be the best way.

Shouldn't we set ZERO_PAGE uptodate during early init code as it, uh,
is per definition uptodate all the time?

> 
> My intention, though, was to stop using the ZERO_PAGE here altogether:
> surely iov_iter_zero() is better for this case?  Sadly not: it relies
> on clear_user(), and the x86 clear_user() is slower than its copy_user():
> https://lore.kernel.org/lkml/2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com/

Oh, that's sad as just using clear_user would be the right thing to
here.

> But while we are still using the ZERO_PAGE, let's stop dirtying its
> struct page cacheline with unnecessary get_page() and put_page().
> 
> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> Reported-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>

But except for maybe making sure that ZERO_PAGE is always marked
uptodate this does looks good to me.
