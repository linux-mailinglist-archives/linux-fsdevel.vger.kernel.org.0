Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6E6604C26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 17:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiJSPvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiJSPup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97980153E24;
        Wed, 19 Oct 2022 08:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B60561846;
        Wed, 19 Oct 2022 15:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B874C433C1;
        Wed, 19 Oct 2022 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666194328;
        bh=Xth0BtK1NQ1Hk2Nxe9JXu1D9E0ErD3wODQtzBi2ym5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7NCLo3rLbHHL28m3K6awBgXXuVSRkVx/W/iNG72TgwHP/QGzlwE5aXWsyqVDL8a1
         wEVxfc5KbVlEy75SJuZbRbwsJMOnhIXDkwx1son+cOITqQlDQ0QvLnM/3vpOUpWxDb
         HbLPdNtqJWl5O8o1UbYh7zlAgnkN32FTKdxPKV6wyhB1WYcOsSnpdoj0ZTRn99gZMr
         iPhGYAE8dvgo6TX0YdBSx5q+k+NEbWsJ6hLnHxKQFgp4pZ3B6IICxoSEwrXnHdKp2B
         ZpdJhpUPWZk7qd6TWC3l1w3pOqDI5/xWccZqWU7R9AWYAYZ+3zLVIvBcRFWN20aSYA
         oDW8DAuiVCriw==
Date:   Wed, 19 Oct 2022 08:45:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, david@fromorbit.com,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org,
        fweimer@redhat.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 0/9] fs: clean up handling of i_version counter
Message-ID: <Y1AbmIYEhUwfFHDx@magnolia>
References: <20221017105709.10830-1-jlayton@kernel.org>
 <20221019111315.hpilifogyvf3bixh@wittgenstein>
 <2b167dd9bda17f1324e9c526d868cc0d995dc660.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b167dd9bda17f1324e9c526d868cc0d995dc660.camel@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:18:15AM -0400, Jeff Layton wrote:
> On Wed, 2022-10-19 at 13:13 +0200, Christian Brauner wrote:
> > On Mon, Oct 17, 2022 at 06:57:00AM -0400, Jeff Layton wrote:
> > > This patchset is intended to clean up the handling of the i_version
> > > counter by nfsd. Most of the changes are to internal interfaces.
> > > 
> > > This set is not intended to address crash resilience, or the fact that
> > > the counter is bumped before a change and not after. I intend to tackle
> > > those in follow-on patchsets.
> > > 
> > > My intention is to get this series included into linux-next soon, with
> > > an eye toward merging most of it during the v6.2 merge window. The last
> > > patch in the series is probably not suitable for merge as-is, at least
> > > until we sort out the semantics we want to present to userland for it.
> > 
> > Over the course of the series I struggled a bit - and sorry for losing
> > focus - with what i_version is supposed to represent for userspace. So I
> > would support not exposing it to userspace before that. But that
> > shouldn't affect your other changes iiuc.
> 
> Thanks Christian,
> 
> It has been a real struggle to nail this down, and yeah I too am not
> planning to expose this to userland until we have this much better
> defined. Patch #9 is just to give you an idea of what this would
> ultimately look like. I intend to re-post the first 8 patches with an
> eye toward merge in v6.2, once we've settled on the naming. On that
> note...
> 
> I believe you had mentioned that you didn't like STATX_CHANGE_ATTR for
> the name, and suggested STATX_I_VERSION (or something similar), which I
> later shortened to STATX_VERSION.
> 
> Dave C. objected to STATX_VERSION, as "version" fields in a struct
> usually refer to the version of the struct itself rather than the
> version of the thing it describes. It also sort of implies a monotonic
> counter, and I'm not ready to require that just yet.
> 
> What about STATX_CHANGE for the name (with corresponding names for the
> field and other flags)? That drops the redundant "_ATTR" postfix, while
> being sufficiently vague to allow for alternative implementations in the
> future.
> 
> Do you (or anyone else) have other suggestions for a name?

Welllll it's really a u32 whose value doesn't have any intrinsic meaning
other than "if (value_now != value_before) flush_cache();" right?
I think it really only tracks changes to file data, right?

STATX_CHANGE_COOKIE	(wait, does this cookie augment i_ctime?)

STATX_MOD_COOKIE	(...or just file modifications/i_mtime?)

STATX_MONITOR_COOKIE	(...what are we monitoring??)

STATX_MON_COOKIE

STATX_COOKIE_MON

STATX_COOKIE_MONSTER

There we go. ;)

In seriousness, I'd probably go with one of the first two.  I wouldn't
be opposed to the last one, either, but others may disagree. ;)

--D

> -- 
> Jeff Layton <jlayton@kernel.org>
