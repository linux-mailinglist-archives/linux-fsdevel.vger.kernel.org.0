Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A39595FB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 17:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiHPPzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiHPPyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:54:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A12ED58;
        Tue, 16 Aug 2022 08:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33FE661138;
        Tue, 16 Aug 2022 15:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD68C433D6;
        Tue, 16 Aug 2022 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660665118;
        bh=YTxB1qQDthA0Qji7+SWwCk9ZE7GAlPwG4Zy7shc1zkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3YXgr5ozgiuShZM4c6NW+lf9bPSdarJdrYyMiGnr9MQD2R1VJeSx6GrRmDEThWE+
         rRoR3Od9F6NdexJ/V0UAKm0nLpSj2bMLSWng61OZNocG53jcwzhZeHcn6yi+CgllDH
         pPqbajiyrmhKgSN48AuyBDvgLgLnvuW1Bh5kxf6ry34hm9WnFoN4ziUjqNTj8SN/8A
         TR1gwTbfvgDFhELMEkrFG2pgr7ayH+5wOGt3/qdXHRZb99KjXu6HJqJZj0Au08IE4U
         yBd6QLSKQfw+7myMBzinhXnTFnVgeVxpuJQidHFsLdP240DUobPvgzz2KcmsNFXtNz
         1TgpHgzFUKSXg==
Date:   Tue, 16 Aug 2022 08:51:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        viro@zeniv.linux.org.uk, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org
Subject: Re: [PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
Message-ID: <Yvu9HsCgzwpEYhPc@magnolia>
References: <ef692314ada01fd2117b730ef0afae50102974f5.camel@kernel.org>
 <20220816134419.xra4krb3jwlm4npk@wittgenstein>
 <20220816132759.43248-1-jlayton@kernel.org>
 <20220816132759.43248-2-jlayton@kernel.org>
 <4066396.1660658141@warthog.procyon.org.uk>
 <12637.1660662903@warthog.procyon.org.uk>
 <83d07cc4f7fe2ca9976d3f418e5137f354e933a4.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d07cc4f7fe2ca9976d3f418e5137f354e933a4.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:32:24AM -0400, Jeff Layton wrote:
> On Tue, 2022-08-16 at 16:15 +0100, David Howells wrote:
> > Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > > I think we'll just have to ensure that before we expose this for any
> > > filesystem that it conforms to some minimum standards. i.e.: it must
> > > change if there are data or metadata changes to the inode, modulo atime
> > > changes due to reads on regular files or readdir on dirs.
> > > 
> > > The local filesystems, ceph and NFS should all be fine. I guess that
> > > just leaves AFS. If it can't guarantee that, then we might want to avoid
> > > exposing the counter for it.
> > 
> > AFS monotonically increments the counter on data changes; doesn't make any
> > change for metadata changes (other than the file size).
> > 
> > But you can't assume NFS works as per your suggestion as you don't know what's
> > backing it (it could be AFS, for example - there's a converter for that).
> > 
> 
> In that case, the NFS server must synthesize a proper change attr. The
> NFS spec mandates that it change on most metadata changes.
> 
> > Further, for ordinary disk filesystems, two data changes may get elided and
> > only increment the counter once.
> > 
> 
> Not a problem as long as nothing queried the counter in between the
> changes.
> 
> > And then there's mmap...
> > 
> 
> Not sure how that matters here.
> 
> > It might be better to reduce the scope of your definition and just say that it
> > must change if there's a data change and may also be changed if there's a
> > metadata change.
> > 
> 
> I'd prefer that we mandate that it change on metadata changes as well.

...in that case, why not leave the i_version bump in
xfs_trans_log_inode?  That will capture all changes to file data,
attribues, and metadata. ;)

--D

> That's what most of the in-kernel users want, and what most of the
> existing filesystems provide. If AFS can't give that guarantee then we
> can just omit exposing i_version on it.
> -- 
> Jeff Layton <jlayton@kernel.org>
