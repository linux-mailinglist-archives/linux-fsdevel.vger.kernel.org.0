Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E8B747DE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 09:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjGEHJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 03:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjGEHJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:09:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B4C195;
        Wed,  5 Jul 2023 00:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F14B36143A;
        Wed,  5 Jul 2023 07:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00057C433C8;
        Wed,  5 Jul 2023 07:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688540939;
        bh=OzfmgDFtXJCKbJ5VtxUn1n2vz3F/TIx9jNO3WUb6xxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JICvmyve75o3h7NDZxOYzIfAhgkRR9zSTOSPyfCq5AvB6CzfcoETKMvjHfmQRVLoB
         P6YuAW+Dqo1AotnqIZO7PKevdJHPSocc53AvfxMd7AaBlisZJa24KA7jcbUL2OyvPo
         dnc0Ho1eC/LrKWj7zgkTOVNKoZ+jGy2UVFgMJMKT1Z2dFfjNanO8FHagNUGgVGTNTp
         Kxlt+8dDf3ZYF2+GojSIlg5zbf/ykKL4OO9NMXl2fMGWW2PcOQNk31ntntp2GQH9Jl
         0D58njpBHN4A7fG1eSxGqF3KN2VMcDjoGMmgvOCjdhqP6NO+JlLHY3cNMvHLfXYftN
         4ZB/Z4AWN/qIQ==
Date:   Wed, 5 Jul 2023 09:08:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     reiserfs-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        butt3rflyh4ck <butterflyhuangxx@gmail.com>
Subject: Re: [PATCH] reiserfs: Check the return value from __getblk()
Message-ID: <20230705-gecheckt-unzumutbar-4010ffac4ea7@brauner>
References: <ZJ32+b+3O8Z6cuRo@casper.infradead.org>
 <20230630-kerbholz-koiteich-a7395bc04eae@brauner>
 <ZKRptMjtL6X74X1B@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKRptMjtL6X74X1B@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 04, 2023 at 07:49:24PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 30, 2023 at 11:03:05AM +0200, Christian Brauner wrote:
> > From: Matthew Wilcox <willy@infradead.org>
> > 
> > On Thu, 29 Jun 2023 23:26:17 +0200, Matthew Wilcox wrote:
> > > __getblk() can return a NULL pointer if we run out of memory or if
> > > we try to access beyond the end of the device; check it and handle it
> > > appropriately.
> > > 
> > > [...]
> > 
> > Willy's original commit with message id
> > <20230605142335.2883264-1-willy@infradead.org> didn't show up on lore.
> > Might be because reiserfs-devel isn't a list tracked by lore; not sure.
> > So I grabbed this from somewhere else.
> > 
> > In any case, I picked this up now.
> > 
> > ---
> > 
> > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs.misc branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> 
> Acked-by: Edward Shishkin <edward.shishkin@gmail.com>
> 
> was added in a response to the original, FYI

Thank you! I've updated the patch trailer accordingly.
