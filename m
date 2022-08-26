Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B875A2358
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 10:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiHZImd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 04:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245175AbiHZImG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:42:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C41D5DD6
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 01:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C2306197E
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 08:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E58C433D6;
        Fri, 26 Aug 2022 08:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661503279;
        bh=rPExmExlQ8GYsnbGr3bH92fVjFEC79XswuktWc1aMuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f1VHQ3ef/TKR/HSxX881pSX074x3uMe5TPKfaCzg9jxhhx9ll6d7yfx6IzMd6JdQc
         FVcntQj7RtYqYk0m/ZmP7DnZJdCNqWuWYBVoTf6/yuG+2/3eh+FN3aroiOXdjjBO6h
         vAM1v8ijWh4CDJQ8P+0QvpNjCrmz3mB9L1HD+SXZyFvFDyKhhzMaryQVD3AaxuES1c
         3mq+3dolBvNYJyfLT0VdnpNJ3v+tWZUUrFow6tCg2UXIrWTzHBUI6+RHvQWeZ+c3Mi
         ExL6EZNWxRFDzUuD0RTE7eJ/2wmg38oX+iImgIFC8uXfBB9MeS7wDl6Pvbho4GL8Gv
         o6XAH+rI6YKCg==
Date:   Fri, 26 Aug 2022 10:41:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ntfs: fix acl handling
Message-ID: <20220826084114.b56i4rviljw7ap74@wittgenstein>
References: <20220720123252.686466-1-brauner@kernel.org>
 <20220818074729.u45tzc3lq7y6zibd@wittgenstein>
 <86ac0423-5e71-4768-a8f8-1ec2673cae5c@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86ac0423-5e71-4768-a8f8-1ec2673cae5c@paragon-software.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 22, 2022 at 08:40:32PM +0300, Konstantin Komarov wrote:
> 
> 
> On 8/18/22 10:47, Christian Brauner wrote:
> > On Wed, Jul 20, 2022 at 02:32:52PM +0200, Christian Brauner wrote:
> > > While looking at our current POSIX ACL handling in the context of some
> > > overlayfs work I went through a range of other filesystems checking how they
> > > handle them currently and encountered ntfs3.
> > > 
> > > The posic_acl_{from,to}_xattr() helpers always need to operate on the
> > > filesystem idmapping. Since ntfs3 can only be mounted in the initial user
> > > namespace the relevant idmapping is init_user_ns.
> > > 
> > > The posix_acl_{from,to}_xattr() helpers are concerned with translating between
> > > the kernel internal struct posix_acl{_entry} and the uapi struct
> > > posix_acl_xattr_{header,entry} and the kernel internal data structure is cached
> > > filesystem wide.
> > > 
> > > Additional idmappings such as the caller's idmapping or the mount's idmapping
> > > are handled higher up in the VFS. Individual filesystems usually do not need to
> > > concern themselves with these.
> > > 
> > > The posix_acl_valid() helper is concerned with checking whether the values in
> > > the kernel internal struct posix_acl can be represented in the filesystem's
> > > idmapping. IOW, if they can be written to disk. So this helper too needs to
> > > take the filesystem's idmapping.
> > > 
> > > Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
> > > Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > > Cc: ntfs3@lists.linux.dev
> > > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > ---
> > 
> > Somehow this patch fell through the cracks and this should really be
> > fixed. Do you plan on sending a PR for this soon or should I just send
> > it through my tree?
> > 
> 
> Thanks for catching this, I've missed this patch.
> I've run tests - everything seems to be fine.
> I've already sent PR for 6.0 and next PR will probably be sometime in September or later.
> Can you send it through your tree?

Thanks for your reply! I sent this through my tree.
Thanks!
Christian
