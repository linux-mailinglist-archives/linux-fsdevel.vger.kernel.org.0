Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27BB70DAAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 12:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbjEWKiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 06:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjEWKiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 06:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A03FD;
        Tue, 23 May 2023 03:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C49D62ECC;
        Tue, 23 May 2023 10:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494EBC433D2;
        Tue, 23 May 2023 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684838300;
        bh=iccCfOHrskC0H4R3YMclbxF6J/FZ+5JAYqkJc7wrxX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HkbPfWqjMihgGRsu8YoEmd77NAWKV8nH70aM7Bd21uX6286VtZDB6cVtmOaHHtFNu
         4wBSvOCc5KAfCQKZZn6M5T4YYMKfdDE72HkPYwwfVhRxchw2y158osOL/GlsyxPK/u
         Ij5K+u9pT1Lu/cwQf0Qyz2NMGOaPoHgufrvXrbSADcKafQJwkoAcIwy5zwnbsjg2Ph
         /M0cBnzrV4NeVcQ2Dsaybc2KXIlzl1N4g8doRumHeW0rV5iZ/kE5eH+sa7phuDUg5q
         Rhd1WMuZim5ovKWxHDwCf+3M5e81vP4rq2OLmfOyhQSgOHqbq/Fb8iBomvshVEMBtr
         pvWYXXjvWfxFA==
Date:   Tue, 23 May 2023 12:38:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH v4 2/9] fs: add infrastructure for multigrain inode
 i_m/ctime
Message-ID: <20230523-bekochen-makaber-6edbaa685390@brauner>
References: <20230518114742.128950-1-jlayton@kernel.org>
 <20230518114742.128950-3-jlayton@kernel.org>
 <20230523100240.mgeu4y46friv7hau@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230523100240.mgeu4y46friv7hau@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 12:02:40PM +0200, Jan Kara wrote:
> On Thu 18-05-23 07:47:35, Jeff Layton wrote:
> > The VFS always uses coarse-grained timestamp updates for filling out the
> > ctime and mtime after a change. This has the benefit of allowing
> > filesystems to optimize away a lot metadata updates, down to around 1
> > per jiffy, even when a file is under heavy writes.
> > 
> > Unfortunately, this has always been an issue when we're exporting via
> > NFSv3, which relies on timestamps to validate caches. Even with NFSv4, a
> > lot of exported filesystems don't properly support a change attribute
> > and are subject to the same problems with timestamp granularity. Other
> > applications have similar issues (e.g backup applications).
> > 
> > Switching to always using fine-grained timestamps would improve the
> > situation, but that becomes rather expensive, as the underlying
> > filesystem will have to log a lot more metadata updates.
> > 
> > What we need is a way to only use fine-grained timestamps when they are
> > being actively queried.
> > 
> > The kernel always stores normalized ctime values, so only the first 30
> > bits of the tv_nsec field are ever used. Whenever the mtime changes, the
> > ctime must also change.
> > 
> > Use the 31st bit of the ctime tv_nsec field to indicate that something
> > has queried the inode for the i_mtime or i_ctime. When this flag is set,
> > on the next timestamp update, the kernel can fetch a fine-grained
> > timestamp instead of the usual coarse-grained one.
> > 
> > This patch adds the infrastructure this scheme. Filesytems can opt
> > into it by setting the FS_MULTIGRAIN_TS flag in the fstype.
> > 
> > Later patches will convert individual filesystems over to use it.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> So there are two things I dislike about this series because I think they
> are fragile:
> 
> 1) If we have a filesystem supporting multigrain ts and someone
> accidentally directly uses the value of inode->i_ctime, he can get bogus
> value (with QUERIED flag). This mistake is very easy to do. So I think we
> should rename i_ctime to something like __i_ctime and always use accessor
> function for it.
> 
> 2) As I already commented in a previous version of the series, the scheme
> with just one flag for both ctime and mtime and flag getting cleared in
> current_time() relies on the fact that filesystems always do an equivalent
> of:
> 
> 	inode->i_mtime = inode->i_ctime = current_time();
> 
> Otherwise we can do coarse grained update where we should have done a fine
> grained one. Filesystems often update timestamps like this but not
> universally. Grepping shows some instances where only inode->i_mtime is set
> from current_time() e.g. in autofs or bfs. Again a mistake that is rather
> easy to make and results in subtle issues. I think this would be also
> nicely solved by renaming i_ctime to __i_ctime and using a function to set
> ctime. Mtime could then be updated with inode->i_mtime = ctime_peek().
> 
> I understand this is quite some churn but a very mechanical one that could
> be just done with Coccinelle and a few manual fixups. So IMHO it is worth
> the more robust result.

Yeah, these are all good points.

> 
> Some more nits below.
> 
> > +/**
> > + * current_mg_time - Return FS time (possibly fine-grained)
> > + * @inode: inode.
> > + *
> > + * Return the current time truncated to the time granularity supported by
> > + * the fs, as suitable for a ctime/mtime change. If the ctime is flagged
> > + * as having been QUERIED, get a fine-grained timestamp.
> > + */
> 
> The comment should also mention that QUERIED flag is cleared from the ctime.
> 
> > +static struct timespec64 current_mg_time(struct inode *inode)
> > +{
> > +	struct timespec64 now;
> > +	atomic_long_t *pnsec = (atomic_long_t *)&inode->i_ctime.tv_nsec;
> > +	long nsec = atomic_long_fetch_andnot(I_CTIME_QUERIED, pnsec);
> > +
> > +	if (nsec & I_CTIME_QUERIED) {
> > +		ktime_get_real_ts64(&now);
> > +	} else {
> > +		struct timespec64 ctime;
> > +
> > +		ktime_get_coarse_real_ts64(&now);
> > +
> > +		/*
> > +		 * If we've recently fetched a fine-grained timestamp
> > +		 * then the coarse-grained one may still be earlier than the
> > +		 * existing one. Just keep the existing ctime if so.
> > +		 */
> > +		ctime = ctime_peek(inode);
> > +		if (timespec64_compare(&ctime, &now) > 0)
> > +			now = ctime;
> > +	}
> > +
> > +	return now;
> > +}
> > +
> 
> ...
> 
> > +/**
> > + * ctime_nsec_peek - peek at (but don't query) the ctime tv_nsec field
> > + * @inode: inode to fetch the ctime from
> > + *
> > + * Grab the current ctime tv_nsec field from the inode, mask off the
> > + * I_CTIME_QUERIED flag and return it. This is mostly intended for use by
> > + * internal consumers of the ctime that aren't concerned with ensuring a
> > + * fine-grained update on the next change (e.g. when preparing to store
> > + * the value in the backing store for later retrieval).
> > + *
> > + * This is safe to call regardless of whether the underlying filesystem
> > + * is using multigrain timestamps.
> > + */
> > +static inline long ctime_nsec_peek(const struct inode *inode)
> > +{
> > +	return inode->i_ctime.tv_nsec &~ I_CTIME_QUERIED;
> 
> This is somewhat unusual spacing. I'd use:
> 
> 	inode->i_ctime.tv_nsec & ~I_CTIME_QUERIED
> 
> > +}
> > +
> > +/**
> > + * ctime_peek - peek at (but don't query) the ctime
> > + * @inode: inode to fetch the ctime from
> > + *
> > + * Grab the current ctime from the inode, sans I_CTIME_QUERIED flag. For
> > + * use by internal consumers that don't require a fine-grained update on
> > + * the next change.
> > + *
> > + * This is safe to call regardless of whether the underlying filesystem
> > + * is using multigrain timestamps.
> > + */
> > +static inline struct timespec64 ctime_peek(const struct inode *inode)
> > +{
> > +	struct timespec64 ctime;
> > +
> > +	ctime.tv_sec = inode->i_ctime.tv_sec;
> > +	ctime.tv_nsec = ctime_nsec_peek(inode);
> > +
> > +	return ctime;
> > +}
> 
> Given this is in a header that gets included in a lot of places, maybe we
> should call it like inode_ctime_peek() or inode_ctime_get() to reduce
> chances of a name clash?

I think I mentioned this in an earlier comment. Independent of this
series, it would be kinda nice if we could start moving stuff out of
fs.h so we end up with a finer grained split of fs.h.
