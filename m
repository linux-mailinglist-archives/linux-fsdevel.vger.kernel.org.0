Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BEB70DCDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbjEWMqR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjEWMqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:46:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20C1DB;
        Tue, 23 May 2023 05:46:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F71C22A61;
        Tue, 23 May 2023 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684845969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D2nL3xyYPlMdtq9qs01YJNIyc/qfR7bb6+Vphl3LLao=;
        b=eOBxwWMb3EwllwDof3+xAu6djq6MmFwQorTzrxkBCEBmVr+ed4A3SGo6BLOuvPawqLNp8j
        +bLaynXcHXPaZ9hduIypIgdVXKOOjv8BKzR99NWAl5wWqkzGRzyyxyXBxy11ZGUNQ/XV9i
        1RTWYrBE9v44zs3IXsZc7kq0jspZ7uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684845969;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D2nL3xyYPlMdtq9qs01YJNIyc/qfR7bb6+Vphl3LLao=;
        b=s3H7NU7JGOmO3C7j1CKkYSeoBVTvMWjfTQOo/Ja+pc5RBlLw2VM4u3aqEqD6VQCd6TXpp1
        Fz805agjqIxvCfCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF2EC13A10;
        Tue, 23 May 2023 12:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IkZuNpC1bGSyMgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 May 2023 12:46:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 92B3CA075D; Tue, 23 May 2023 14:46:06 +0200 (CEST)
Date:   Tue, 23 May 2023 14:46:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
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
Message-ID: <20230523124606.bkkhwi6b67ieeygl@quack3>
References: <20230518114742.128950-1-jlayton@kernel.org>
 <20230518114742.128950-3-jlayton@kernel.org>
 <20230523100240.mgeu4y46friv7hau@quack3>
 <bf0065f2c9895edb66faeacc6cf77bd257088348.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf0065f2c9895edb66faeacc6cf77bd257088348.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 23-05-23 06:40:08, Jeff Layton wrote:
> On Tue, 2023-05-23 at 12:02 +0200, Jan Kara wrote:
> > On Thu 18-05-23 07:47:35, Jeff Layton wrote:
> > > The VFS always uses coarse-grained timestamp updates for filling out the
> > > ctime and mtime after a change. This has the benefit of allowing
> > > filesystems to optimize away a lot metadata updates, down to around 1
> > > per jiffy, even when a file is under heavy writes.
> > > 
> > > Unfortunately, this has always been an issue when we're exporting via
> > > NFSv3, which relies on timestamps to validate caches. Even with NFSv4, a
> > > lot of exported filesystems don't properly support a change attribute
> > > and are subject to the same problems with timestamp granularity. Other
> > > applications have similar issues (e.g backup applications).
> > > 
> > > Switching to always using fine-grained timestamps would improve the
> > > situation, but that becomes rather expensive, as the underlying
> > > filesystem will have to log a lot more metadata updates.
> > > 
> > > What we need is a way to only use fine-grained timestamps when they are
> > > being actively queried.
> > > 
> > > The kernel always stores normalized ctime values, so only the first 30
> > > bits of the tv_nsec field are ever used. Whenever the mtime changes, the
> > > ctime must also change.
> > > 
> > > Use the 31st bit of the ctime tv_nsec field to indicate that something
> > > has queried the inode for the i_mtime or i_ctime. When this flag is set,
> > > on the next timestamp update, the kernel can fetch a fine-grained
> > > timestamp instead of the usual coarse-grained one.
> > > 
> > > This patch adds the infrastructure this scheme. Filesytems can opt
> > > into it by setting the FS_MULTIGRAIN_TS flag in the fstype.
> > > 
> > > Later patches will convert individual filesystems over to use it.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > So there are two things I dislike about this series because I think they
> > are fragile:
> > 
> > 1) If we have a filesystem supporting multigrain ts and someone
> > accidentally directly uses the value of inode->i_ctime, he can get bogus
> > value (with QUERIED flag). This mistake is very easy to do. So I think we
> > should rename i_ctime to something like __i_ctime and always use accessor
> > function for it.
> > 
> 
> We could do this, but it'll be quite invasive. We'd have to change any
> place that touches i_ctime (and there are a lot of them), even on
> filesystems that are not being converted.

Yes, that's why I suggested Coccinelle to deal with this.

> > 2) As I already commented in a previous version of the series, the scheme
> > with just one flag for both ctime and mtime and flag getting cleared in
> > current_time() relies on the fact that filesystems always do an equivalent
> > of:
> > 
> > 	inode->i_mtime = inode->i_ctime = current_time();
> > 
> > Otherwise we can do coarse grained update where we should have done a fine
> > grained one. Filesystems often update timestamps like this but not
> > universally. Grepping shows some instances where only inode->i_mtime is set
> > from current_time() e.g. in autofs or bfs. Again a mistake that is rather
> > easy to make and results in subtle issues. I think this would be also
> > nicely solved by renaming i_ctime to __i_ctime and using a function to set
> > ctime. Mtime could then be updated with inode->i_mtime = ctime_peek().
> >
> > I understand this is quite some churn but a very mechanical one that could
> > be just done with Coccinelle and a few manual fixups. So IMHO it is worth
> > the more robust result.
> 
> AFAICT, under POSIX, you must _always_ set the ctime when you set the
> mtime, but the reverse is not true. That's why keeping the flag in the
> ctime makes sense. If we're updating the mtime, then we necessarily must
> update the ctime.

Yes, but technically speaking:

	inode->i_mtime = current_time();
	inode->i_ctime = current_time();

follows these requirements but is broken with your changes in unobvious
way. And if mtime update is hidden in some function or condition, it is not
even that suboptimal coding pattern.

> > > +}
> > > +
> > > +/**
> > > + * ctime_peek - peek at (but don't query) the ctime
> > > + * @inode: inode to fetch the ctime from
> > > + *
> > > + * Grab the current ctime from the inode, sans I_CTIME_QUERIED flag. For
> > > + * use by internal consumers that don't require a fine-grained update on
> > > + * the next change.
> > > + *
> > > + * This is safe to call regardless of whether the underlying filesystem
> > > + * is using multigrain timestamps.
> > > + */
> > > +static inline struct timespec64 ctime_peek(const struct inode *inode)
> > > +{
> > > +	struct timespec64 ctime;
> > > +
> > > +	ctime.tv_sec = inode->i_ctime.tv_sec;
> > > +	ctime.tv_nsec = ctime_nsec_peek(inode);
> > > +
> > > +	return ctime;
> > > +}
> > 
> > Given this is in a header that gets included in a lot of places, maybe we
> > should call it like inode_ctime_peek() or inode_ctime_get() to reduce
> > chances of a name clash?
> 
> I'd be fine with that, but "ctime" sort of implies inode->i_ctime to me.
> We don't really use that nomenclature elsewhere.

Yes, I don't insist here but we do have 'ctime' e.g. in IPC code
(sem_ctime, shm_ctime, msg_ctime), we have ctime in md layer, ctime(3) is
also a glibc function. So it is not *completely* impossible the clash
happens but we can deal with it when it happens.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
