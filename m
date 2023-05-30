Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B8371688D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 18:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjE3QC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 12:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjE3QCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 12:02:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830B5188;
        Tue, 30 May 2023 09:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE42E61E32;
        Tue, 30 May 2023 16:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81848C433D2;
        Tue, 30 May 2023 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685462519;
        bh=+bjafflQkeGR0pj0+9Bhf6+uOuRDMWm4LCaEU7oL4w0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLaTmgKr9+qOi4tzVuxg+TXb+MUGtQm7dHTrbVzElWgKQyLB4yL5GjduODeFwRiOu
         Z/KbTROKs6gwvjktFWLm+DRnfyvGl9LTyL1jLsCJuUcwkddIxWa28IRFVdUB4mzHIc
         ZIcKKI8sh6HsrQRBikCHvASIM1PBETBZ7XBXwUkiDGchVhpuNNcCgqYfC08Sw14KZN
         J3FBIe+2O0JrexwQZbteEyl5Y1EvTCK0ovYPa5m9Wq+LR+BL0VbYMte2EVnFOh7pjt
         vMCw9rDFL12RPrANGQ46P+uvqgCVwG7jGeAYU8SwL5GbXZS8i15QKkNMxcFQvwzrXA
         B9MAgoVoJO94w==
Date:   Tue, 30 May 2023 18:01:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, code@tyhicks.com,
        hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
        sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        chuck.lever@oracle.com, jlayton@kernel.org, miklos@szeredi.hu,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        dchinner@redhat.com, john.johansen@canonical.com,
        mcgrof@kernel.org, mortonm@chromium.org, fred@cloudflare.com,
        mpe@ellerman.id.au, nathanl@linux.ibm.com, gnoack3000@gmail.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        wangweiyang2@huawei.com
Subject: Re: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
Message-ID: <20230530-tumult-adrenalin-8d48cb35d506@brauner>
References: <20230505081200.254449-1-xiujianfeng@huawei.com>
 <20230515-nutzen-umgekehrt-eee629a0101e@brauner>
 <75b4746d-d41e-7c9f-4bb0-42a46bda7f17@digikod.net>
 <20230530-mietfrei-zynisch-8b63a8566f66@brauner>
 <20230530142826.GA9376@lst.de>
 <301a58de-e03f-02fd-57c5-1267876eb2df@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <301a58de-e03f-02fd-57c5-1267876eb2df@schaufler-ca.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 07:55:17AM -0700, Casey Schaufler wrote:
> On 5/30/2023 7:28 AM, Christoph Hellwig wrote:
> > On Tue, May 30, 2023 at 03:58:35PM +0200, Christian Brauner wrote:
> >> The main concern which was expressed on other patchsets before is that
> >> modifying inode operations to take struct path is not the way to go.
> >> Passing struct path into individual filesystems is a clear layering
> >> violation for most inode operations, sometimes downright not feasible,
> >> and in general exposing struct vfsmount to filesystems is a hard no. At
> >> least as far as I'm concerned.
> > Agreed.  Passing struct path into random places is not how the VFS works.
> >
> >> So the best way to achieve the landlock goal might be to add new hooks
> > What is "the landlock goal", and why does it matter?
> >
> >> or not. And we keep adding new LSMs without deprecating older ones (A
> >> problem we also face in the fs layer.) and then they sit around but
> >> still need to be taken into account when doing changes.
> > Yes, I'm really worried about th amount of LSMs we have, and the weird
> > things they do.
> 
> Which LSM(s) do you think ought to be deprecated? I only see one that I

I don't have a good insight into what LSMs are actively used or are
effectively unused but I would be curious to hear what LSMs are
considered actively used/maintained from the LSM maintainer's
perspective.

> might consider a candidate. As for weird behavior, that's what LSMs are
> for, and the really weird ones proposed (e.g. pathname character set limitations)

If this is effectively saying that LSMs are licensed to step outside the
rules of the subsystem they're a guest in then it seems unlikely
subsystems will be very excited to let new LSM changes go in important
codepaths going forward. In fact this seems like a good argument against
it.
