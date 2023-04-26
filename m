Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5903A6EF168
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbjDZJso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239464AbjDZJsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:48:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7641593;
        Wed, 26 Apr 2023 02:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1572762CAA;
        Wed, 26 Apr 2023 09:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36850C433D2;
        Wed, 26 Apr 2023 09:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682502521;
        bh=fKAn3JdJz49gxav6mu33xI+JofckAtfi3Qw86pQyVsI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MnriBQOsgstN1FHD7i/bvml1n93a5Q9WpM5q1PApF1KwiQ9ZETmc/XzUgNPJojGyi
         RzlzHFzgyaGQK3lRhSm/KIu7SRZx+yWVG4SMY1DVi6S/tr0f5DxvajgStflDZUkRlt
         EY+AVfZKNq9Rd+Hy4SJaH2EdTR6TlPDyweAxZhI9Sf0u5gt8sESBCMWEcqcYnVxzYl
         Uw/dw99iWYXuEam6NyMcON3IQ6TjyKMxAjRGEYGJ06nkqZKly0a6fRx9szLSjQWWrJ
         OLCJwPRLHOZ3HZ4sfiuaMUQ7OMUHmWBlTyfwtec7no4LFkCJidf3lGEILaToEnVzg8
         iqosu2u0Otc+Q==
Message-ID: <03e91ee4c56829995c08f4f8fb1052d3c6cc40c4.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] fs: add infrastructure for multigrain inode
 i_m/ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Wed, 26 Apr 2023 05:48:38 -0400
In-Reply-To: <20230426-bahnanlagen-ausmusterung-4877cbf40d4c@brauner>
References: <20230424151104.175456-1-jlayton@kernel.org>
         <20230424151104.175456-2-jlayton@kernel.org>
         <20230426-bahnanlagen-ausmusterung-4877cbf40d4c@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-04-26 at 09:07 +0200, Christian Brauner wrote:
> On Mon, Apr 24, 2023 at 11:11:02AM -0400, Jeff Layton wrote:
> > The VFS always uses coarse-grained timestamp updates for filling out th=
e
> > ctime and mtime after a change. This has the benefit of allowing
> > filesystems to optimize away a lot metaupdates, to around once per
> > jiffy, even when a file is under heavy writes.
> >=20
> > Unfortunately, this has always been an issue when we're exporting via
> > NFSv3, which relies on timestamps to validate caches. Even with NFSv4, =
a
> > lot of exported filesystems don't properly support a change attribute
> > and are subject to the same problems with timestamp granularity. Other
> > applications have similar issues (e.g backup applications).
> >=20
> > Switching to always using fine-grained timestamps would improve the
> > situation for NFS, but that becomes rather expensive, as the underlying
> > filesystem will have to log a lot more metadata updates.
> >=20
> > What we need is a way to only use fine-grained timestamps when they are
> > being actively queried:
> >=20
> > Whenever the mtime changes, the ctime must also change since we're
> > changing the metadata. When a superblock has a s_time_gran >1, we can
> > use the lowest-order bit of the inode->i_ctime as a flag to indicate
> > that the value has been queried. Then on the next write, we'll fetch a
> > fine-grained timestamp instead of the usual coarse-grained one.
> >=20
> > We could enable this for any filesystem that has a s_time_gran >1, but
> > for now, this patch adds a new SB_MULTIGRAIN_TS flag to allow filesyste=
ms
> > to opt-in to this behavior.
>=20
> Hm, the patch raises the flag in s_flags. Please at least move this to
> s_iflags as SB_I_MULTIGRAIN and treat this as an internal flag. There's
> no need to give the impression that this will become a mount option.
>=20
> Also, this looks like it's a filesystem property not a superblock
> property as the granularity isn't changeable. So shouldn't this be an
> FS_* flag instead?

It could be a per-sb thing if there was some filesystem that wanted to
do that, but I'm hoping that most will not want to do that.

My initial patches for this actually did use a FS_* flag, but I figured
that was one more pointer to chase when you wanted to check the flag.

I can change it back to that though. Let me know what you'd prefer.

--=20
Jeff Layton <jlayton@kernel.org>
