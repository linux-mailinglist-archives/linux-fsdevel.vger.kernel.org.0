Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9BC67CA18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 12:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbjAZLg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 06:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbjAZLgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:36:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3265A81F;
        Thu, 26 Jan 2023 03:36:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9B7B921E18;
        Thu, 26 Jan 2023 11:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674733003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gZo/hipER5aaiyynJccvdQAIsKbKAOOGsG3+fBBawmI=;
        b=GvmnRp61CutRXZXP9y6Y6BQDkkDMw6NcrQVaYKa4NMurS1PRKjRQhhE4guzKDazs3hSxC+
        ndP4PVIKfMAayeZZIjnttkWxgXu7oylnqCEHS6M81GaNxm4cZeg+U7oiEy4cmMfqzRpFbi
        q2pQ2nSX4sjSphVHXuynlbtshf2DcWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674733003;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gZo/hipER5aaiyynJccvdQAIsKbKAOOGsG3+fBBawmI=;
        b=F2/XdjRoMb0rAEXTmbvKuoHDqhYzgQq+nMmEQiW29YDwXldUVDKOLo/j5aTRg747sKaZhV
        fYz+VdLei7U2jxAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85C91139B3;
        Thu, 26 Jan 2023 11:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4ySlIMtl0mO1IgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 26 Jan 2023 11:36:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DCD54A06B4; Thu, 26 Jan 2023 12:36:42 +0100 (CET)
Date:   Thu, 26 Jan 2023 12:36:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        neilb@suse.de, viro@zeniv.linux.org.uk, zohar@linux.ibm.com,
        xiubli@redhat.com, chuck.lever@oracle.com, lczerner@redhat.com,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Colin Walters <walters@verbum.org>
Subject: Re: [PATCH v8 RESEND 2/8] fs: clarify when the i_version counter
 must be updated
Message-ID: <20230126113642.eenghs2wvfrlnlak@quack3>
References: <20230124193025.185781-1-jlayton@kernel.org>
 <20230124193025.185781-3-jlayton@kernel.org>
 <20230125160625.zenzybjgie224jf6@quack3>
 <3c5cf7c7f9e206a3d7c4253de52015dda97ef41e.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c5cf7c7f9e206a3d7c4253de52015dda97ef41e.camel@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-01-23 05:54:16, Jeff Layton wrote:
> On Wed, 2023-01-25 at 17:06 +0100, Jan Kara wrote:
> > On Tue 24-01-23 14:30:19, Jeff Layton wrote:
> > > The i_version field in the kernel has had different semantics over
> > > the decades, but NFSv4 has certain expectations. Update the comments
> > > in iversion.h to describe when the i_version must change.
> > > 
> > > Cc: Colin Walters <walters@verbum.org>
> > > Cc: NeilBrown <neilb@suse.de>
> > > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > Looks good to me. But one note below:
> > 
> > > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > > index 6755d8b4f20b..fced8115a5f4 100644
> > > --- a/include/linux/iversion.h
> > > +++ b/include/linux/iversion.h
> > > @@ -9,8 +9,25 @@
> > >   * ---------------------------
> > >   * The change attribute (i_version) is mandated by NFSv4 and is mostly for
> > >   * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
> > > - * appear different to observers if there was a change to the inode's data or
> > > - * metadata since it was last queried.
> > > + * appear larger to observers if there was an explicit change to the inode's
> > > + * data or metadata since it was last queried.
> > > + *
> > > + * An explicit change is one that would ordinarily result in a change to the
> > > + * inode status change time (aka ctime). i_version must appear to change, even
> > > + * if the ctime does not (since the whole point is to avoid missing updates due
> > > + * to timestamp granularity). If POSIX or other relevant spec mandates that the
> > > + * ctime must change due to an operation, then the i_version counter must be
> > > + * incremented as well.
> > > + *
> > > + * Making the i_version update completely atomic with the operation itself would
> > > + * be prohibitively expensive. Traditionally the kernel has updated the times on
> > > + * directories after an operation that changes its contents. For regular files,
> > > + * the ctime is usually updated before the data is copied into the cache for a
> > > + * write. This means that there is a window of time when an observer can
> > > + * associate a new timestamp with old file contents. Since the purpose of the
> > > + * i_version is to allow for better cache coherency, the i_version must always
> > > + * be updated after the results of the operation are visible. Updating it before
> > > + * and after a change is also permitted.
> > 
> > This sounds good but it is not the case for any of the current filesystems, is
> > it? Perhaps the documentation should mention this so that people are not
> > confused?
> 
> Correct. Currently, all filesystems change the times and version before
> a write instead of after. I'm hoping that situation will change soon
> though, as I've been working on a patchset to fix this for tmpfs, ext4
> and btrfs.

That is good but we'll see how long it takes to get merged. AFAIR it is not
a complete nobrainer ;)

> If you still want to see something for this though, what would you
> suggest for verbiage?

Sure:

... the i_version must a be updated after the results of the operation are
visible (note that none of the filesystems currently do this, it is a work
in progress to fix this).

And once your patches are merged, you can also delete this note :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
