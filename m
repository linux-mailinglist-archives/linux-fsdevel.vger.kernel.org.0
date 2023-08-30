Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D733778DAF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjH3SiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242801AbjH3Jny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:43:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E78B1A1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 02:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24CE662A14
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 09:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014C0C433C7;
        Wed, 30 Aug 2023 09:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693388630;
        bh=kew2MtvrUU8NG0tP8101UzbqZvNxXYuYbe17Ogh0Ctg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IuW5S+lhs/yHaMfXnMDcEEBLo66W7JSf0MyvLIdO4sXB4Kr2tdkGYqqLlASVw9iQq
         OQjSpihLE31q5PYyPQNW1SNr5UnLn6Y0gduI4KR+eE/naB+hv7vg0bp53BWnlby76H
         Qnsz3NX1u1cj7n1NOj2XZMBrtiBxCm7ZYqeA8KteKoSjSiTZYI5Qj1ayU+AoSIqIj0
         QFWwz+1S+MxVLgNlhlGGG5xHqH46xgG+hsCV1+Cnru2IihZ+Y1T/BVr95uw39pmkoc
         eMa7LHUkZQue7c976MSaTMPP0aRpfcNHyoYY43lRbJv/OQxKQ5yhGHC/Yi5/q2Erto
         cOW80mtUOTnxA==
Date:   Wed, 30 Aug 2023 11:43:46 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: export sget_dev()
Message-ID: <20230830-ohnedies-umland-fb2b1a45db10@brauner>
References: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
 <20230829-vfs-super-mtd-v1-1-fecb572e5df3@kernel.org>
 <20230830061409.GB17785@lst.de>
 <20230830-befanden-geahndet-2f084125d861@brauner>
 <20230830093851.uwdgpt645niysuji@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830093851.uwdgpt645niysuji@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:38:51AM +0200, Jan Kara wrote:
> On Wed 30-08-23 10:05:57, Christian Brauner wrote:
> > On Wed, Aug 30, 2023 at 08:14:09AM +0200, Christoph Hellwig wrote:
> > > > +struct super_block *sget_dev(struct fs_context *fc, dev_t dev)
> > > 
> > > A kerneldoc comment would probably be useful here.
> > 
> > Added the following in-treep:
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index 158e093f23c9..19fa906b118a 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -1388,6 +1388,26 @@ static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
> >                 s->s_dev == *(dev_t *)fc->sget_key;
> >  }
> > 
> > +/**
> > + * sget_dev - Find or create a superblock by device number
> > + * @fc:        Filesystem context.
> > + * @dev: device number
>       ^^^^^^ inconsistent indenting.

Fixed, thanks!

> 
> > + *
> > + * Find or create a superblock using the provided device number that
> > + * will be stored in fc->sget_key.
> > + *
> > + * If an extant superblock is matched, then that will be returned with
> > + * an elevated reference count that the caller must transfer or discard.
> > + *
> > + * If no match is made, a new superblock will be allocated and basic
> > + * initialisation will be performed (s_type, s_fs_info and s_id will be
> > + * set and the set() callback will be invoked), the superblock will be
>       ^^ I guess no point in talking about set() callback when sget_dev()
> has no callback specified. Rather you could mention s_dev as one of
> initialized fields.

Yeah, good point. Done.
