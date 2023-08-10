Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843EB777569
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 12:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjHJKIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 06:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjHJKIJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:08:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9BE10CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7589565736
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 10:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF93C433C7;
        Thu, 10 Aug 2023 10:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691662087;
        bh=hWvKN3wU8wjWbRwA95OgyxSzGrr+vZxnrxqzjfcVxqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQ3yqE7HC5zB5nzsSrxpfMxnCdqRhFx2hwtA53uvHkban4uSzCjrq0RZLZUL4aVw1
         VhffnZa67oKIrLiI27GZP6prFQZsQ96cEFY4RI9rrnwNv3VVub6nYRKF4UWnutTLsf
         tIFuXnc7Oyjlf55o5Hg7hsMB/q5O7rda0gxDzISvRecdd8eWuK8PV7gQb4bI+D6/Sy
         dyCQJ1tfUk8gn9Z/IHTTVlZQ3j13/2PqGQR+PDybqCwVP0tnA6M2kmFEi1AuDOvVLX
         U1JPUu7yGmwBabE8Fl3aLg+R5SCmhT8DB+hSWctIp4TBYPuOxB5csTLSvxK6POzzWd
         7queN6GPqqOFw==
Date:   Thu, 10 Aug 2023 12:07:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs 0/5] tmpfs: user xattrs and direct IO
Message-ID: <20230810-notwehr-denkbar-3be0cc53a87a@brauner>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
 <20230809-postkarten-zugute-3cde38456390@brauner>
 <20230809-leitgedanke-weltumsegelung-55042d9f7177@brauner>
 <cdedadf2-d199-1133-762f-a8fe166fb968@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdedadf2-d199-1133-762f-a8fe166fb968@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:50:39PM -0700, Hugh Dickins wrote:
> On Wed, 9 Aug 2023, Christian Brauner wrote:
> > On Wed, Aug 09, 2023 at 08:45:57AM +0200, Christian Brauner wrote:
> > > On Tue, Aug 08, 2023 at 09:28:08PM -0700, Hugh Dickins wrote:
> > > > This series enables and limits user extended attributes on tmpfs,
> > > > and independently provides a trivial direct IO stub for tmpfs.
> > > > 
> > > > It is here based on the vfs.tmpfs branch in vfs.git in next-20230808
> > > > but with a cherry-pick of v6.5-rc4's commit
> > > > 253e5df8b8f0 ("tmpfs: fix Documentation of noswap and huge mount options")
> > > > first: since the vfs.tmpfs branch is based on v6.5-rc1, but 3/5 in this
> > > > series updates tmpfs.rst in a way which depends on that commit.
> > > > 
> > > > IIUC the right thing to do would be to cherry-pick 253e5df8b8f0 into
> > > > vfs.tmpfs before applying this series.  I'm sorry that the series as
> > > > posted does not apply cleanly to any known tree! but I think posting
> > > > it against v6.5-rc5 or next-20230808 would be even less helpful.
> > > 
> > > No worries, I'll sort that out.
> > 
> > So, I hemmed and hawed but decided to rebase vfs.tmpfs onto v6.5-rc4
> > which includes that fix as cherry picking is odd.
> 
> Even better, thanks.
> 
> And big thank you to you and Jan and Carlos for the very quick and
> welcoming reviews.

Happy to.

> Needing "freed = 0" in shmem_evict_inode(), as reported by robot:

Fixed that.

> And I'll send a replacement for 4/5, the direct IO one, following

Ah great, thanks!
