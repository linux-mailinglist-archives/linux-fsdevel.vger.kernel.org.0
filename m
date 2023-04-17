Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E116E4272
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 10:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjDQIW3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 04:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjDQIWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:22:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D889198B;
        Mon, 17 Apr 2023 01:22:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39DF262000;
        Mon, 17 Apr 2023 08:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC1AC433EF;
        Mon, 17 Apr 2023 08:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681719733;
        bh=MIG8Wmkr3JxNCkp7vK6igu8UUGrt17VNwrJGqRM2cyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdTbC/T5GadLou6Ias/lEIjL8gz3DcneQQK0tHfCCvZ3IVLeOOhgDxF3w6pxtfoK9
         2GaXcPVp8U7SvxikBXiexyx63Hfha9cMs4OGGnyOmkF3572cZgdSd5hXf4sthe7RjL
         GFMIJtAMOGrzEs+VJ0GpkuVNj2i7k+SbHD/4NZ4oQTdzmvqFsjJN2gVQ3COEhDa4Bn
         XXv7XrGgOjVF9u2SwtA6WckCUOC6+XJc6Gt/0l4HNruvaxF2FeDkP0yl0PqPACzCgt
         sTq6GyfD2bIcl8bJO6KgSF9lvPIQwDA6eioV9OkgKeYMy8PHnXziTV4XIUh8ihZg1T
         TYtSoKFd5QawA==
Date:   Mon, 17 Apr 2023 10:22:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeffrey Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Message-ID: <20230417-schmecken-gurken-d477ec6d3331@brauner>
References: <20230414024312.GF3390869@ZenIV>
 <2631cb9c05087ddd917679b7cebc58cb42cd2de6.camel@kernel.org>
 <20230414-sowas-unmittelbar-67fdae9ca5cd@brauner>
 <9192A185-03BF-4062-B12F-E7EF52578014@hammerspace.com>
 <20230414-leiht-lektion-18f5a7a38306@brauner>
 <91D4AC04-A016-48A9-8E3A-BBB6C38E8C4B@hammerspace.com>
 <4F4F5C98-AA06-40FB-AE51-79E860CD1D76@hammerspace.com>
 <20230414162253.GL3390869@ZenIV>
 <E746F6B4-779A-4184-A2A7-5879E3D3DAEE@hammerspace.com>
 <6F3DB6E1-F104-492B-9AF1-5AEC8C27D267@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6F3DB6E1-F104-492B-9AF1-5AEC8C27D267@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 03:01:01PM -0400, Benjamin Coddington wrote:
> On 14 Apr 2023, at 12:41, Trond Myklebust wrote:
> >
> > I mean both cases. Doing a lazy umount with a hard mounted filesystem is a risk sport: if the server does become permanently borked, you can fill up your page cache with stuff that can’t be evicted. Most users don’t realise this, so they get confused when it happens (particularly since the filesystem is out-of-sight and hence out-of-mind).
> 
> I've been pecking away at a sysfs knob for this case.  Seemed a clearer path to destruction.
> 
> >>
> >> Note, BTW, that hard vs. soft is a property of fs instance; if you have
> >> it present elsewhere in the mount tree, flipping it would affect all
> >> such places.  I don't see any good way to make it a per-mount thing, TBH…
> >
> >
> > The main use case is for when the server is permanently down, so normally it shouldn’t be a problem with flipping the mode on all instances.
> 
> Is there another case?  Because, if so..
> 
> > That said, it might be nice to make it per-mountpoint at some time.
> > We do have the ability to declare individual RPC calls to time out,
> > so it’s doable at the RPC level. All we would really need is the
> > ability to store a per-vfsmount flag.

I would very much like to avoid having filesystem specific data in
struct vfsmount. That sounds like a maintenance nightmare going forward.
Mount structures should remain pure vfs constructs that only carry
generic properties imho.

> 
> .. maybe vfsmount's mnt_root d_fsdata?

I don't think that would work without having access to the vfsmount.
