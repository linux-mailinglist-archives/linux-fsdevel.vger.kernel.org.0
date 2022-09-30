Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE81F5F0CC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiI3NvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 09:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiI3NvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A12FC299;
        Fri, 30 Sep 2022 06:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0896B82779;
        Fri, 30 Sep 2022 13:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA452C433D6;
        Fri, 30 Sep 2022 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664545868;
        bh=FKGI5Jtkk9yY3yifYXhU4241raI1fXZgZRGMNusaNDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1fbLEDZ/DYcyyaTqFeOAp4xWpnZFcizQwaa4j3XJDe7J/I2YpLzgxZynNFkTAzaJ
         UOxrRyyYqsPzzJ7e8/sbrCkG6Xwss7ZmIeu6fSxUSyQKmZIxTTQsttcyBSWEghyMkV
         lLk+p5f8YbIrgqDzZoPWSSRiGlk34LSMJKVbvQENcSWQDJbfaTvshw+r6y+08808OZ
         SWudBfakg6WEcdPaxPHv9Oazl4a8/WztJDWCtlvuCEDBEN3QJIz1tdNGT40e4LfPnU
         RsCc45TvtxCwCgD3O0sLISvV4Ya3G4QAHOo+WGfFLI+r+FKOr5sduCMeghGW4LtdV+
         8DRsocvo2ZG1Q==
Date:   Fri, 30 Sep 2022 15:51:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
Message-ID: <20220930135103.p6ab22yxkxl6yd2r@wittgenstein>
References: <20220929153041.500115-1-brauner@kernel.org>
 <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
 <20220930090949.cl3ajz7r4ub6jrae@wittgenstein>
 <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
 <20220930100557.7hqjrz77s3wcbrxx@wittgenstein>
 <CAJfpegvJUSowMaS7s_vLWvznLmfpkEfbvZbb_Vo-H8VewucByA@mail.gmail.com>
 <20220930124948.2mhh4bsojrlqbsmu@wittgenstein>
 <CAJfpegtyboFs35Qy67iuKNVEV75924Pdqejh9QZR1R4OB4WkAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtyboFs35Qy67iuKNVEV75924Pdqejh9QZR1R4OB4WkAQ@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 03:01:22PM +0200, Miklos Szeredi wrote:
> On Fri, 30 Sept 2022 at 14:49, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Sep 30, 2022 at 02:24:33PM +0200, Miklos Szeredi wrote:
> 
> > > Maybe adding the check to ovl_get_acl() is the right way to go, but
> > > I'm a little afraid of a performance regression.  Will look into that.
> >
> > Ok, sounds good. I can probably consolidate the two versions but retain
> > the difference in permission checking or would you prefer I leave them
> > distinct for now?
> 
> No, please consolidate them.  That's a good first step.

Ok, will do.

> 
> > > So this patchset nicely reveals how acl retrieval could be done two
> > > ways, and how overlayfs employed both for different purposes.  But
> > > what would be even nicer if there was just one way to retrieve the acl
> > > and overlayfs and cifs be moved over to that.
> >
> > I think this is a good long term goal to have. We're certainly not done
> > with improving things after this work. Sometimes it just takes a little
> > time to phase out legacy baggage as we all are well aware.
> 
> But then which is legacy?  The old .get_acl() or the new .get_acl()?
> My impression is that it's the new one.   But in that case the big
> renaming patch doesn't make any sense.

Since "legacy" would mean "the older one" it wasn't the best term here.
It'll come down to which one we will be able to remove. I'm exploring
both options. If you want to make the removal of the renaming a hard
requirement for being ok with this series I can reverse the renaming.
(Note that Christoph had requested consistent naming for get and set acl.)
