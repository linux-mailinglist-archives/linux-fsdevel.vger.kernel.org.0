Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939A0729671
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbjFIKMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 06:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbjFIKLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:11:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24AA3ABF;
        Fri,  9 Jun 2023 03:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84E365641;
        Fri,  9 Jun 2023 09:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604A4C433D2;
        Fri,  9 Jun 2023 09:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686304798;
        bh=TyR2ZgQ9D2TM9D+v3ftEHKWW/b88EhSiiAosUtdWjBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9YsWR6tlq9FhM7v+GDCvH8TmFamLKBsjf2FFjLE+Gr3bwDaHFKWjc4SpMUCwOL3/
         Kj15EdB+920G+rCdFiCCxDoEkPtM6ItFmSLmvWmzXHP1RRKirPVI3gfPrgRuZ+5hwF
         OtRtajzg1TpWRdrQdpFsmGvw/Oa8osFCjOj6rgt0dWipRmsWmmwpozRRk2/W3QRYyO
         NpCw4Oa52vjn1qGq2sbuu9W/f8Nkz3OPEEGmf72Y+sZIqgbtgVoypoa/KhVRJU4rpB
         oKcmvvyHW0ye3lbrzxutRFs+qx/GV6GmPrqx9cTOpfx2mLsHiNlEkSdNGRJqQSuaVo
         qn/abFJxdPBXQ==
Date:   Fri, 9 Jun 2023 11:59:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Xiubo Li <xiubli@redhat.com>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
Message-ID: <20230609-alufolie-gezaubert-f18ef17cda12@brauner>
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com>
 <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:59:19AM +0200, Aleksandr Mikhalitsyn wrote:
> On Fri, Jun 9, 2023 at 3:57 AM Xiubo Li <xiubli@redhat.com> wrote:
> >
> >
> > On 6/8/23 23:42, Alexander Mikhalitsyn wrote:
> > > Dear friends,
> > >
> > > This patchset was originally developed by Christian Brauner but I'll continue
> > > to push it forward. Christian allowed me to do that :)
> > >
> > > This feature is already actively used/tested with LXD/LXC project.
> > >
> > > Git tree (based on https://github.com/ceph/ceph-client.git master):
> 
> Hi Xiubo!
> 
> >
> > Could you rebase these patches to 'testing' branch ?
> 
> Will do in -v6.
> 
> >
> > And you still have missed several places, for example the following cases:
> >
> >
> >     1    269  fs/ceph/addr.c <<ceph_netfs_issue_op_inline>>
> >               req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR,
> > mode);
> 
> +
> 
> >     2    389  fs/ceph/dir.c <<ceph_readdir>>
> >               req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> 
> +
> 
> >     3    789  fs/ceph/dir.c <<ceph_lookup>>
> >               req = ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS);
> 
> We don't have an idmapping passed to lookup from the VFS layer. As I
> mentioned before, it's just impossible now.

->lookup() doesn't deal with idmappings and really can't otherwise you
risk ending up with inode aliasing which is really not something you
want. IOW, you can't fill in inode->i_{g,u}id based on a mount's
idmapping as inode->i_{g,u}id absolutely needs to be a filesystem wide
value. So better not even risk exposing the idmapping in there at all.
