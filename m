Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7413D72BABC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 10:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjFLIci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjFLIcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF21186;
        Mon, 12 Jun 2023 01:31:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18BDD62133;
        Mon, 12 Jun 2023 08:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B75C433EF;
        Mon, 12 Jun 2023 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686558685;
        bh=Qzj5qrWg7Q0xE/xizm8XgmY0Hk2e0pRBJ2VHc+oHCxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ai6Kvltr7dW+lbrF6sn1yAmTnTCT1W1N9IHnT6zaN/qrOST29U3udc040S/wQcjTz
         L8Wq3QTU0EJ47uJdme7Jt9wLDcCPGSvVkoEbky3dAbyx9ExsWDTNX9rpeok3AYtXtE
         ODewMPcJfVRkSoIcWcuxGcjzHf1/0LF+2sSoqyDZJyKrSdH4AfiGxevBKB1vqqMgTh
         OuDF/SAFnqQMKxd8TVEUE30DZNuUvLiEIHKCeE9+y4Xuq2p7o1j9k7xJzsue7b8s2L
         4dqaW3yJbGlQdlGbXLpLd0ToQN6QeCXEutTqEyeEMl50iWBrcvS2zywUj9aPKdYrBz
         4+Km8LVgrCm4w==
Date:   Mon, 12 Jun 2023 10:31:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fs: use fake_file container for internal files
 with fake f_path
Message-ID: <20230612-auffahren-episoden-4e35b8d1e71c@brauner>
References: <20230611194706.1583818-1-amir73il@gmail.com>
 <20230611194706.1583818-2-amir73il@gmail.com>
 <ZIai+UWrU9o2UVcJ@infradead.org>
 <20230612-erwarben-pflaumen-1916e266edf7@brauner>
 <CAOQ4uxi0o+OgVT_GSHQwkDtHBf+QoeAycb7pmhOq+2e9-cx+3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi0o+OgVT_GSHQwkDtHBf+QoeAycb7pmhOq+2e9-cx+3g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:28:23AM +0300, Amir Goldstein wrote:
> On Mon, Jun 12, 2023 at 11:07 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Sun, Jun 11, 2023 at 09:45:45PM -0700, Christoph Hellwig wrote:
> > > On Sun, Jun 11, 2023 at 10:47:05PM +0300, Amir Goldstein wrote:
> > > > Overlayfs and cachefiles use open_with_fake_path() to allocate internal
> > > > files, where overlayfs also puts a "fake" path in f_path - a path which
> > > > is not on the same fs as f_inode.
> > >
> > > But cachefs doesn't, so this needs a better explanation / documentation.
> > >
> > > > Allocate a container struct file_fake for those internal files, that
> > > > is used to hold the fake path along with an optional real path.
> > >
> > > The idea looks sensible, but fake a is a really weird term here.
> > > I know open_with_fake_path also uses it, but we really need to
> > > come up with a better name, and also good documentation of the
> > > concept here.
> >
> > It's basically a stack so I'd either use struct file_stack or
> > struct file_proxy; with a preference for the latter.
> 
> Let the bikeshedding begin :)
> 
> file_proxy too generic to my taste
> 
> How about:
> 
> /* File is embedded in backing_file object */
> #define FMODE_BACKING           ((__force fmode_t)0x2000000)

Yeah, that'd be ok with me.
