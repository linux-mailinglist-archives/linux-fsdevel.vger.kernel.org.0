Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980B772F9B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 11:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244238AbjFNJqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244234AbjFNJqQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB6B269E;
        Wed, 14 Jun 2023 02:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 183C263A37;
        Wed, 14 Jun 2023 09:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF80C433C0;
        Wed, 14 Jun 2023 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686735950;
        bh=bOUTEmQRNYc2XRJruJB03nYq61euHP/sjkiGBDp0jWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YagmxNqX4bkrWOB9BBQcotdoXxdLP0fEnyz9wXn8Sl7+EjU/LxuJDdp9uBB38g0YT
         mRxpCUyx9P6EIwxoACtoqJiSwoWqfAbU7UdZVVcdTSLc7F1aPshmkHgjI4E+Eus30y
         KepqggXk0js7bVCTE8quhjgSx70PCFTnpgQoTJU0SzXjUfKtWdByl13UOcfXTdTsKN
         3N1RD4YgTpBGTPj1vFue4yhScbXUY8z4yta5NFW094UZGmvAO96SvWQp1e+iQx9E7J
         aq9N5Z8k/eB5IE529DjlRUXFOVzfT3c+Ch0i+yrrhxr+i8q8T4XLKpTPuNWhenChf0
         moyzO6KNMk/zA==
Date:   Wed, 14 Jun 2023 11:45:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Gregory Farnum <gfarnum@redhat.com>,
        stgraber@ubuntu.com, linux-fsdevel@vger.kernel.org,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
Message-ID: <20230614-westseite-urlaub-7a5afcf0577a@brauner>
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com>
 <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner>
 <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com>
 <CAEivzxeZ6fDgYMnjk21qXYz13tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEivzxeZ6fDgYMnjk21qXYz13tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:46:02PM +0200, Aleksandr Mikhalitsyn wrote:
> On Tue, Jun 13, 2023 at 3:43 AM Xiubo Li <xiubli@redhat.com> wrote:
> >
> >
> > On 6/9/23 18:12, Aleksandr Mikhalitsyn wrote:
> > > On Fri, Jun 9, 2023 at 12:00 PM Christian Brauner <brauner@kernel.org> wrote:
> > >> On Fri, Jun 09, 2023 at 10:59:19AM +0200, Aleksandr Mikhalitsyn wrote:
> > >>> On Fri, Jun 9, 2023 at 3:57 AM Xiubo Li <xiubli@redhat.com> wrote:
> > >>>>
> > >>>> On 6/8/23 23:42, Alexander Mikhalitsyn wrote:
> > >>>>> Dear friends,
> > >>>>>
> > >>>>> This patchset was originally developed by Christian Brauner but I'll continue
> > >>>>> to push it forward. Christian allowed me to do that :)
> > >>>>>
> > >>>>> This feature is already actively used/tested with LXD/LXC project.
> > >>>>>
> > >>>>> Git tree (based on https://github.com/ceph/ceph-client.git master):
> > >>> Hi Xiubo!
> > >>>
> > >>>> Could you rebase these patches to 'testing' branch ?
> > >>> Will do in -v6.
> > >>>
> > >>>> And you still have missed several places, for example the following cases:
> > >>>>
> > >>>>
> > >>>>      1    269  fs/ceph/addr.c <<ceph_netfs_issue_op_inline>>
> > >>>>                req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR,
> > >>>> mode);
> > >>> +
> > >>>
> > >>>>      2    389  fs/ceph/dir.c <<ceph_readdir>>
> > >>>>                req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> > >>> +
> > >>>
> > >>>>      3    789  fs/ceph/dir.c <<ceph_lookup>>
> > >>>>                req = ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS);
> > >>> We don't have an idmapping passed to lookup from the VFS layer. As I
> > >>> mentioned before, it's just impossible now.
> > >> ->lookup() doesn't deal with idmappings and really can't otherwise you
> > >> risk ending up with inode aliasing which is really not something you
> > >> want. IOW, you can't fill in inode->i_{g,u}id based on a mount's
> > >> idmapping as inode->i_{g,u}id absolutely needs to be a filesystem wide
> > >> value. So better not even risk exposing the idmapping in there at all.
> > > Thanks for adding, Christian!
> > >
> > > I agree, every time when we use an idmapping we need to be careful with
> > > what we map. AFAIU, inode->i_{g,u}id should be based on the filesystem
> > > idmapping (not mount),
> > > but in this case, Xiubo want's current_fs{u,g}id to be mapped
> > > according to an idmapping.
> > > Anyway, it's impossible at now and IMHO, until we don't have any
> > > practical use case where
> > > UID/GID-based path restriction is used in combination with idmapped
> > > mounts it's not worth to
> > > make such big changes in the VFS layer.
> > >
> > > May be I'm not right, but it seems like UID/GID-based path restriction
> > > is not a widespread
> > > feature and I can hardly imagine it to be used with the container
> > > workloads (for instance),
> > > because it will require to always keep in sync MDS permissions
> > > configuration with the
> > > possible UID/GID ranges on the client. It looks like a nightmare for sysadmin.
> > > It is useful when cephfs is used as an external storage on the host, but if you
> > > share cephfs with a few containers with different user namespaces idmapping...
> >
> > Hmm, while this will break the MDS permission check in cephfs then in
> > lookup case. If we really couldn't support it we should make it to
> > escape the check anyway or some OPs may fail and won't work as expected.
> 
> Hi Xiubo!
> 
> Disabling UID/GID checks on the MDS side looks reasonable. IMHO the
> most important checks are:
> - open
> - mknod/mkdir/symlink/rename
> and for these checks we already have an idmapping.
> 
> Also, I want to add that it's a little bit unusual when permission
> checks are done against the caller UID/GID.

The server side permission checking based on the sender's fs{g,u}id is
rather esoteric imho. So I would just disable it for idmapped mounts.

> Usually, if we have opened a file descriptor and, for instance, passed
> this file descriptor through a unix socket then
> file descriptor holder will be able to use it in accordance with the
> flags (O_RDONLY, O_RDWR, ...).
> We also have ->f_cred on the struct file that contains credentials of
> the file opener and permission checks are usually done
> based on this. But in cephfs we are always using syscall caller's
> credentials. It makes cephfs file descriptor "not transferable"
> in terms of permission checks.

Yeah, that's another good point.
