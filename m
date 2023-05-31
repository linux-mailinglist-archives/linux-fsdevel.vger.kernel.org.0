Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41A717A33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 10:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjEaIgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 04:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjEaIgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 04:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2BABE;
        Wed, 31 May 2023 01:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3A1C61E25;
        Wed, 31 May 2023 08:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE0BC433D2;
        Wed, 31 May 2023 08:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685522184;
        bh=dfvU4kUw5EN76TUpElGZGHji6GZvIh94B/6YrmFxRUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0MUr9cc5i+qnd3453aC2f4rDmt3KRqDBgCD5k8LjK+7PPfdcR9F5UAjoTrvEMMX/
         O43FjU3PK+uNvMl/iqfcohzVeg1mk2WwjAbUJnuzuqbtnlLlpq+vuUCuNtKMMVVgBG
         xv6LsueM0rBZGAbD4ROtYLT/4SkyShz+aMIeQIvpOhYSp59n9loLXNfACxzai+AFmg
         NaSZahqHeAS+DmRAf9mvM7EeEu7+TvQGKws/S3KLOxbaWeLePnrUUtoxKFo0TrFreB
         OTCuFbc5ZRe/HBz9wXdm1RrW49za8facTITxrEuSOyqvOitfz/T3w7uShK4OgoNxId
         PlM8jnbwkQxoA==
Date:   Wed, 31 May 2023 10:36:11 +0200
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
Message-ID: <20230531-endpreis-gepflanzt-80a5a4a9c8d6@brauner>
References: <20230505081200.254449-1-xiujianfeng@huawei.com>
 <20230515-nutzen-umgekehrt-eee629a0101e@brauner>
 <75b4746d-d41e-7c9f-4bb0-42a46bda7f17@digikod.net>
 <20230530-mietfrei-zynisch-8b63a8566f66@brauner>
 <20230530142826.GA9376@lst.de>
 <301a58de-e03f-02fd-57c5-1267876eb2df@schaufler-ca.com>
 <20230530-tumult-adrenalin-8d48cb35d506@brauner>
 <28f3ca55-29ea-4582-655d-2769881127ad@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28f3ca55-29ea-4582-655d-2769881127ad@schaufler-ca.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 03:15:01PM -0700, Casey Schaufler wrote:
> On 5/30/2023 9:01 AM, Christian Brauner wrote:
> > On Tue, May 30, 2023 at 07:55:17AM -0700, Casey Schaufler wrote:
> >> On 5/30/2023 7:28 AM, Christoph Hellwig wrote:
> >>> On Tue, May 30, 2023 at 03:58:35PM +0200, Christian Brauner wrote:
> >>>> The main concern which was expressed on other patchsets before is that
> >>>> modifying inode operations to take struct path is not the way to go.
> >>>> Passing struct path into individual filesystems is a clear layering
> >>>> violation for most inode operations, sometimes downright not feasible,
> >>>> and in general exposing struct vfsmount to filesystems is a hard no. At
> >>>> least as far as I'm concerned.
> >>> Agreed.  Passing struct path into random places is not how the VFS works.
> >>>
> >>>> So the best way to achieve the landlock goal might be to add new hooks
> >>> What is "the landlock goal", and why does it matter?
> >>>
> >>>> or not. And we keep adding new LSMs without deprecating older ones (A
> >>>> problem we also face in the fs layer.) and then they sit around but
> >>>> still need to be taken into account when doing changes.
> >>> Yes, I'm really worried about th amount of LSMs we have, and the weird
> >>> things they do.
> >> Which LSM(s) do you think ought to be deprecated? I only see one that I
> > I don't have a good insight into what LSMs are actively used or are
> > effectively unused but I would be curious to hear what LSMs are
> > considered actively used/maintained from the LSM maintainer's
> > perspective.
> 
> I'm not the LSM maintainer, but I've been working on the infrastructure
> for quite some time. All the existing LSMs save one can readily be associated
> with active systems, and the one that isn't is actively maintained. We have
> not gotten into the habit of accepting LSMs upstream that don't have a real
> world use.
> 
> >> might consider a candidate. As for weird behavior, that's what LSMs are
> >> for, and the really weird ones proposed (e.g. pathname character set limitations)
> > If this is effectively saying that LSMs are licensed to step outside the
> > rules of the subsystem they're a guest in then it seems unlikely
> > subsystems will be very excited to let new LSM changes go in important
> > codepaths going forward. In fact this seems like a good argument against
> > it.
> 
> This is an artifact of Linus' decision that security models should be
> supported as add-on modules. On the one hand, all that a subsystem maintainer
> needs to know about a security feature is what it needs in the way of hooks.
> On the other hand, the subsystem maintainer loses control over what kinds of
> things the security feature does with the available information. It's a
> tension that we've had to deal with since the Orange Book days of the late
> 1980's. The deal has always been:
> 
> 	You can have your security feature if:
> 	1. If I turn it off it has no performance impact
> 	2. I don't have to do anything to maintain it
> 	3. It doesn't interfere with any other system behavior
> 	4. You'll leave me alone
> 
> As a security developer from way back I would be delighted if maintainers of
> other subsystems took an active interest in some of what we've been trying
> to accomplish in the security space. If the VFS maintainers would like to
> see the LSM interfaces for file systems changed I, for one, would like very
> much to hear about what they'd prefer. 

What is important for us is that the security layer must understand and
accept that some things cannot be done the way it envisions them to be
done because it would involve design compromises in the fs layer that
the fs maintainers are unwilling to make. The idea to pass struct path
to almost every security hook is a good example.

If the project is feature parity between inode and path based LSMs then
it must be clear from the start that this won't be achieved at the cost
of mixing up the layer where only dentries and inodes are relevant and
the layer where struct paths are most relevant.

> 
> We do a lot of crazy things to avoid interfering with the subsystems we
> interact with. A closer developer relationship would be most welcome, so
> long as it helps us achieve or goals. We get a lot of complaints about how
> LSM feature perform, but no one wants to hear that a good deal of that comes
> about because of what has to be done in support of 1, 2 and 3 above. Sometimes
> we do stoopid things, but usually it's to avoid changes "outside our swim lane".

I personally am not opposed to comment on patches but they will
naturally have lower priority than other things.
