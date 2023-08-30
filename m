Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC69078DAE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbjH3SiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbjH3Hvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EB012D
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 00:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3030D60BC3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 07:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ED4C433C7;
        Wed, 30 Aug 2023 07:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693381912;
        bh=xlEmr/yuZsJY9ofkrEANJIvbRZu2g9tn4/DEKXSc+cE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYZBT+LnaXrhkD6DAlwpYzcOkG1wx9BN0w0QFMdS7NZFif5UW+m6UQb23ck6otqjj
         ftmYGmHRSRdML3l+q1XDyjSOl5B9vPZh7PGecNALB8Hlt7K3aEmGS18a2PFoPUpoMh
         SUbYBE9oPaaEXMhiohPktHn7RjhNodaKLC7fk6IHFqayvo6BM98YpeMYaimEQlT2QV
         2OCOuLM6+Hq28iwCAWJITT6xfZgq0fWtvR2zX8XWb/ACoQRjDWWfC564xKh5wdlQU4
         /FmjR+x5SPridfPh32qQ8f2w8TLxX+c8WrUeWWurpGtL2MApVG/NqLYsnMqhFeVbDL
         qbB7H9gsH87Kg==
Date:   Wed, 30 Aug 2023 09:51:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     hch <hch@lst.de>
Cc:     Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs: export sget_dev()
Message-ID: <20230830-giftig-stechen-efe4b54b1599@brauner>
References: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
 <20230829-vfs-super-mtd-v1-1-fecb572e5df3@kernel.org>
 <20230829-alpinsport-abwerben-4c19ebb9a437@brauner>
 <340229452.1869458.1693328104443.JavaMail.zimbra@nod.at>
 <20230830061345.GA17785@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830061345.GA17785@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:13:45AM +0200, hch wrote:
> On Tue, Aug 29, 2023 at 06:55:04PM +0200, Richard Weinberger wrote:
> > What tree does this patch apply to? linux-next?
> > I gave it a quick try on Linus' tree but it failed too:
> > 
> > fs/super.c: In function ‘get_tree_bdev’:
> > fs/super.c:1293:19: error: ‘dev’ undeclared (first use in this function); did you mean ‘bdev’?
> >   s = sget_dev(fc, dev);
> >                    ^~~
> >                    bdev
> > fs/super.c:1293:19: note: each undeclared identifier is reported only once for each function it appears in
> 
> Should be against the latest Linus tree after the merge of the vfs
> branches yesterday.

I would suggest to just pull it from:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git b4/vfs-super-mtd
