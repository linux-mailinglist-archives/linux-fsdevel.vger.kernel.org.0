Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4546B72B9AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 10:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjFLIEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 04:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjFLIDh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63607171A;
        Mon, 12 Jun 2023 01:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8285362093;
        Mon, 12 Jun 2023 08:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5B8C433D2;
        Mon, 12 Jun 2023 08:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686556903;
        bh=hxPvxOHDa6fxCy91GcLN9I96DKwv8hDqbcgrkKPGb4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2Jn0aTqVY+bMdoxeaCZP44Er2nBOJDPWKkIbvdSbG9jXlkjOMWKpA6/3JNHhK1k+
         JPgjBLYqmaVYUAjXMnvuSbm99FeAG5dveJvgaxJc9YN/jTFZSWSMGStRQUli9fN0UL
         IjnLT/TEM4VHpfiktTwwnVCM5ec49f2Vz2sfyARkMz3xD8a3NL8VvXeOV3Tz6aQ32y
         mQTH8jGxmHTNBIiamCtbpFCoOaPMnn59kuaKEE3a/sEQa3jXViWwzmytQ3LGQk5SGp
         3jeg3DGaQZNnrjzxTSoCRnhRoat7d6wWBY6NFT70abzMaNCQrwSmy4FDaXqINbRoN8
         NfinRbfyYTMZw==
Date:   Mon, 12 Jun 2023 10:01:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fs: use fake_file container for internal files
 with fake f_path
Message-ID: <20230612-abrutschen-genforschung-9a6ff6625e88@brauner>
References: <20230611194706.1583818-1-amir73il@gmail.com>
 <20230611194706.1583818-2-amir73il@gmail.com>
 <ZIai+UWrU9o2UVcJ@infradead.org>
 <CAOQ4uxj0WjQHNN6qHEnXfijYSoiaZkCucvNQYTL4LH0TPLt28A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj0WjQHNN6qHEnXfijYSoiaZkCucvNQYTL4LH0TPLt28A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:37:51AM +0300, Amir Goldstein wrote:
> On Mon, Jun 12, 2023 at 7:45 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sun, Jun 11, 2023 at 10:47:05PM +0300, Amir Goldstein wrote:
> > > Overlayfs and cachefiles use open_with_fake_path() to allocate internal
> > > files, where overlayfs also puts a "fake" path in f_path - a path which
> > > is not on the same fs as f_inode.
> >
> > But cachefs doesn't, so this needs a better explanation / documentation.
> >
> > > Allocate a container struct file_fake for those internal files, that
> > > is used to hold the fake path along with an optional real path.
> >
> > The idea looks sensible, but fake a is a really weird term here.
> > I know open_with_fake_path also uses it, but we really need to
> > come up with a better name, and also good documentation of the
> > concept here.
> >
> > > +/* Returns the real_path field that could be empty */
> > > +struct path *__f_real_path(struct file *f)
> > > +{
> > > +     struct file_fake *ff = file_fake(f);
> > > +
> > > +     if (f->f_mode & FMODE_FAKE_PATH)
> > > +             return &ff->real_path;
> > > +     else
> > > +             return &f->f_path;
> > > +}
> >
> > two of the three callers always have FMODE_FAKE_PATH set, so please
> > just drop this helper and open code it in the three callers.
> >
> 
> I wanted to keep the container opaque

This is preferable to me tbh to not leak this detail into callsites.
