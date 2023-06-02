Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A197202A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 15:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjFBNIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 09:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjFBNIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:08:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0311B5;
        Fri,  2 Jun 2023 06:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C13864FEA;
        Fri,  2 Jun 2023 13:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B0CC433EF;
        Fri,  2 Jun 2023 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685711318;
        bh=+5NWmYoE8e23yNOkxJ6IgsXXJ3ODw1tmKSxVbVjjL1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8ZJuKg+gowDufcF9Pwgj2XHVx1ltXoIAVEuJynjtF/x4EBxGYfIgq8jQ3/ruS1w4
         CFPoxFuaQvs85a3VyOQHGAaeRn74qa4P8IGFiQXs6O5v+MOF6/RYwyn0ChTPPmgiOq
         1Mk00KnRMkeiy/o+nwR/ioM2Vrjs9CXp9LZFDr7STWggzGltH77mf4fatVbGuv5G/d
         SUX4wctdYGQMfmDSmx3vZE8VnewPUJBxAG/UyG5OFVf1t3KHlAiyBwpgTFxYTM9pWb
         S4KCh8V5MOrvxyhm2Lk6ttQuwW/agksLMzdr3yk5Vg2/j40wQJzmLHJfzpu7SZ/pFA
         oRoZwS1DNiVcg==
Date:   Fri, 2 Jun 2023 15:08:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Xiubo Li <xiubli@redhat.com>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] ceph: allow idmapped setattr inode op
Message-ID: <20230602-behoben-tauglich-b6ecd903f2a9@brauner>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
 <20230524153316.476973-11-aleksandr.mikhalitsyn@canonical.com>
 <b3b1b8dc-9903-c4ff-0a63-9a31a311ff0b@redhat.com>
 <CAEivzxfxug8kb7_SzJGvEZMcYwGM8uW25gKa_osFqUCpF_+Lhg@mail.gmail.com>
 <20230602-vorzeichen-praktikum-f17931692301@brauner>
 <CAEivzxcwTbOUrT2ha8fR=wy-bU1+ZppapnMsqVXBXAc+C0gwhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEivzxcwTbOUrT2ha8fR=wy-bU1+ZppapnMsqVXBXAc+C0gwhw@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 03:05:50PM +0200, Aleksandr Mikhalitsyn wrote:
> On Fri, Jun 2, 2023 at 2:54 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Jun 02, 2023 at 02:45:30PM +0200, Aleksandr Mikhalitsyn wrote:
> > > On Fri, Jun 2, 2023 at 3:30 AM Xiubo Li <xiubli@redhat.com> wrote:
> > > >
> > > >
> > > > On 5/24/23 23:33, Alexander Mikhalitsyn wrote:
> > > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > >
> > > > > Enable __ceph_setattr() to handle idmapped mounts. This is just a matter
> > > > > of passing down the mount's idmapping.
> > > > >
> > > > > Cc: Jeff Layton <jlayton@kernel.org>
> > > > > Cc: Ilya Dryomov <idryomov@gmail.com>
> > > > > Cc: ceph-devel@vger.kernel.org
> > > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > > > > ---
> > > > >   fs/ceph/inode.c | 11 +++++++++--
> > > > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > > > > index 37e1cbfc7c89..f1f934439be0 100644
> > > > > --- a/fs/ceph/inode.c
> > > > > +++ b/fs/ceph/inode.c
> > > > > @@ -2050,6 +2050,13 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
> > > > >
> > > > >       dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
> > > > >
> > > > > +     /*
> > > > > +      * The attr->ia_{g,u}id members contain the target {g,u}id we're
> >
> > This is now obsolete... In earlier imlementations attr->ia_{g,u}id was
> > used and contained the filesystem wide value, not the idmapped mount
> > value.
> >
> > However, this was misleading and we changed that in commit b27c82e12965
> > ("attr: port attribute changes to new types") and introduced dedicated
> > new types into struct iattr->ia_vfs{g,u}id. So the you need to use
> > attr->ia_vfs{g,u}id as documented in include/linux/fs.h and you need to
> > transform them into filesystem wide values and then to raw values you
> > send over the wire.
> >
> > Alex should be able to figure this out though.
> 
> Hi Christian,
> 
> Thanks for pointing this out. Unfortunately I wasn't able to notice
> that. I'll take a look closer and fix that.

Just to clarify: I wasn't trying to imply that you should've figured
this out on your own. I was just trying to say that you should be able
figure out the exact details how to implement this in ceph after I told
you about the attr->ia_vfs{g,u}id change.
