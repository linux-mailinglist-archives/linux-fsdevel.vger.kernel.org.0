Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925B56057CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 08:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJTG64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 02:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJTG63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:58:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C51213F8;
        Wed, 19 Oct 2022 23:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C48DB8269E;
        Thu, 20 Oct 2022 06:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0324FC433D6;
        Thu, 20 Oct 2022 06:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666249101;
        bh=gNWZd5H40IPgVGZtl+34qVIwNzNQ+boUybOYzZCAgH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilVIxiQjJQomaVAaYb2QTy49mE/zcyOh4m9FDwj28sXrvFedTs9NPcRvXaDnBJ4GI
         Cxiq4jfsTaOztspnUUhrsob2ezKk2aFEvWRHyIbwWELRzQNDdNehXcSHglRFoSSvoA
         QWaukBX4ZTDqDQYxWT0lu5W5gQcaWpS1mdZkTP5XxKuhrWGLgsFM3a9FxoOs1wKHRb
         Ngxs0n8pnaFx960AnjSxzERziXAxNZ2dbbuWsetzbTbrTw5Lx9YGXaBkUwE3xCqkNz
         S48IGWFFRptH4hn4lDmITsVuYGdPWvaofNFG49lm0nORJW+RMbde8MAqIjySLo392Q
         M1/RaSEr5AmLg==
Date:   Thu, 20 Oct 2022 08:58:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, david@fromorbit.com,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org,
        fweimer@redhat.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 0/9] fs: clean up handling of i_version counter
Message-ID: <20221020065813.sdnrerbrvi75xlkp@wittgenstein>
References: <20221017105709.10830-1-jlayton@kernel.org>
 <20221019111315.hpilifogyvf3bixh@wittgenstein>
 <2b167dd9bda17f1324e9c526d868cc0d995dc660.camel@kernel.org>
 <Y1AbmIYEhUwfFHDx@magnolia>
 <3fa8e13be8d75e694e8360a8e9552a92a4c14803.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fa8e13be8d75e694e8360a8e9552a92a4c14803.camel@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 04:36:47PM -0400, Jeff Layton wrote:
> On Wed, 2022-10-19 at 08:45 -0700, Darrick J. Wong wrote:
> > On Wed, Oct 19, 2022 at 08:18:15AM -0400, Jeff Layton wrote:
> > > On Wed, 2022-10-19 at 13:13 +0200, Christian Brauner wrote:
> > > > On Mon, Oct 17, 2022 at 06:57:00AM -0400, Jeff Layton wrote:
> > > > > This patchset is intended to clean up the handling of the i_version
> > > > > counter by nfsd. Most of the changes are to internal interfaces.
> > > > > 
> > > > > This set is not intended to address crash resilience, or the fact that
> > > > > the counter is bumped before a change and not after. I intend to tackle
> > > > > those in follow-on patchsets.
> > > > > 
> > > > > My intention is to get this series included into linux-next soon, with
> > > > > an eye toward merging most of it during the v6.2 merge window. The last
> > > > > patch in the series is probably not suitable for merge as-is, at least
> > > > > until we sort out the semantics we want to present to userland for it.
> > > > 
> > > > Over the course of the series I struggled a bit - and sorry for losing
> > > > focus - with what i_version is supposed to represent for userspace. So I
> > > > would support not exposing it to userspace before that. But that
> > > > shouldn't affect your other changes iiuc.
> > > 
> > > Thanks Christian,
> > > 
> > > It has been a real struggle to nail this down, and yeah I too am not
> > > planning to expose this to userland until we have this much better
> > > defined. Patch #9 is just to give you an idea of what this would
> > > ultimately look like. I intend to re-post the first 8 patches with an
> > > eye toward merge in v6.2, once we've settled on the naming. On that
> > > note...
> > > 
> > > I believe you had mentioned that you didn't like STATX_CHANGE_ATTR for
> > > the name, and suggested STATX_I_VERSION (or something similar), which I
> > > later shortened to STATX_VERSION.
> > > 
> > > Dave C. objected to STATX_VERSION, as "version" fields in a struct
> > > usually refer to the version of the struct itself rather than the
> > > version of the thing it describes. It also sort of implies a monotonic
> > > counter, and I'm not ready to require that just yet.
> > > 
> > > What about STATX_CHANGE for the name (with corresponding names for the
> > > field and other flags)? That drops the redundant "_ATTR" postfix, while
> > > being sufficiently vague to allow for alternative implementations in the
> > > future.
> > > 
> > > Do you (or anyone else) have other suggestions for a name?
> > 
> > Welllll it's really a u32 whose value doesn't have any intrinsic meaning
> > other than "if (value_now != value_before) flush_cache();" right?
> > I think it really only tracks changes to file data, right?
> > 
> 
> It's a u64, but yeah, you're not supposed to assign any intrinsic
> meaning to the value itself.
> 
> > STATX_CHANGE_COOKIE	(wait, does this cookie augment i_ctime?)
> > 
> > STATX_MOD_COOKIE	(...or just file modifications/i_mtime?)
> > 
> > STATX_MONITOR_COOKIE	(...what are we monitoring??)
> > 
> > STATX_MON_COOKIE
> > 
> > STATX_COOKIE_MON
> > 
> > STATX_COOKIE_MONSTER
> > 
> > There we go. ;)
> > 
> > In seriousness, I'd probably go with one of the first two.  I wouldn't
> > be opposed to the last one, either, but others may disagree. ;)
> > 
> > --D
> > 
> > 
> 
> STATX_CHANGE_COOKIE is probably the best one. I'll plan to go with that
> unless someone has a better idea. Thanks for the suggestions!

Sounds fine to me.
