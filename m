Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B8E6DDD4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 16:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjDKOJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 10:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjDKOIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:08:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8450D359D;
        Tue, 11 Apr 2023 07:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20ABB624C2;
        Tue, 11 Apr 2023 14:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB463C433EF;
        Tue, 11 Apr 2023 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681222131;
        bh=1wTmbDFMmZMHkjXWXCkKRvh7H1u8fZyis15UjyxfO04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jvr7LGbPu0Hjg/6fhItPXnVsmIPdZ4C0Zl7PSo4Y8DfX7Ue+CGX1k24T7+l1dBbK/
         hqsGYn+bDNthjyxTyv1vfJHsQff2DALRhPpY11G5gcYPelbwdBGVCy/NSL5I9E8vh3
         eurt5MGGZfTARqEjkQ5owsv5rzYQky1d5g80gSzM04Smp+apH0Q2GKvMGOmP/CI70/
         9DzW9LwWWSKtJsBrGbOr6U8xhm+v8alYhNgmrg5Pw2pap4CQ6aNQuYJ6E1H0DnZ2T7
         aowEs5t2cuszJgaI2Z9A5CHEstRcA+EgcGuppzTEHknB2PwoQllEPaR2oWZ5efFuCE
         IP+a7u6XGOQ8w==
Date:   Tue, 11 Apr 2023 16:08:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Message-ID: <20230411-abartig-relikt-9785cfe2b604@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
 <20230409-genick-pelikan-a1c534c2a3c1@brauner>
 <b2591695afc11a8924a56865c5cd2d59e125413c.camel@kernel.org>
 <20230411-umgewandelt-gastgewerbe-870e4170781c@brauner>
 <8f5cc243398d5bae731a26e674bdeff465da3968.camel@kernel.org>
 <20230411-holzbalken-stuben-6cea8b722a1b@brauner>
 <b137033f3cd971b0cfc71045cab63440dfe9c7f8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b137033f3cd971b0cfc71045cab63440dfe9c7f8.camel@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:13:15AM -0400, Jeff Layton wrote:
> On Tue, 2023-04-11 at 11:49 +0200, Christian Brauner wrote:
> > 
> > > 
> > > > Afaict, filesystems that persist i_version to disk automatically raise
> > > > SB_I_VERSION. I would guess that it be considered a bug if a filesystem
> > > > would persist i_version to disk and not raise SB_I_VERSION. If so IMA
> > > > should probably be made to check for IS_I_VERSION() and it will probably
> > > > get that by switching to vfs_getattr_nosec().
> > > 
> > > Not quite. SB_I_VERSION tells the vfs that the filesystem wants the
> > > kernel to manage the increment of the i_version for it. The filesystem
> > > is still responsible for persisting that value to disk (if appropriate).
> > 
> > Yes, sure it's the filesystems responsibility to persist it to disk or
> > not. What I tried to ask was that when a filesystem does persist
> > i_version to disk then would it be legal to mount it without
> > SB_I_VERSION (because ext2/ext3 did use to have that mount option)? If
> > it would then the filesystem would probably need to take care to leave
> > the i_version field in struct inode uninitialized to avoid confusion or
> > would that just work? (Mere curiosity, don't feel obligated to go into
> > detail here. I don't want to hog your time.)
> > 
> 
> In modern kernels, not setting SB_I_VERSION would mainly have the effect
> of stopping increments of i_version field on write. It would also mean
> that the STATX_CHANGE_COOKIE is not automatically reported via getattr.

Ah, good.

> 
> You probably wouldn't want to mount the fs without SB_I_VERSION set. The
> missing increments could trick an observer into believing that nothing
> had changed in the file across mounts when it actually had.

Yeah, that's what I thought and that would potentially be an attack on
IMA which is why I asked.

Thanks!
Christian
