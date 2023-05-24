Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D6B70F83D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 16:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbjEXOGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 10:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjEXOGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 10:06:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2201A12E;
        Wed, 24 May 2023 07:06:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C8C8A21F4E;
        Wed, 24 May 2023 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684937208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=azT27sC/5HTwO4nU9zsSaao85zwwW02tSeq2dW23Krg=;
        b=136QS7Xfzz9r+qA9sTqqoNuM+ieaF3gAsVs/IDBTYV85Ew3uOaZORt3nCSiy2XHisRlLOs
        +f4vSs9WxdHk2VAvvxfKkJyLGdY1KNRZNeMPaT9FUvF6w5G5dnyoc0uUpzm2mKStQU0K0J
        r13YosXfojPGfiReeQmGV7blcm1n5yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684937208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=azT27sC/5HTwO4nU9zsSaao85zwwW02tSeq2dW23Krg=;
        b=xsuPNPHOf7SJ+YkB9ofJh6U4v4iBITW4Kf4YujiVY9tReOJkmpM8RtYbgJ+ZJ+0Ny/Otau
        c8LFKH0wTFyBKIBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA0AA13425;
        Wed, 24 May 2023 14:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i6RiLfgZbmQPHQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 24 May 2023 14:06:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 50CBFA075C; Wed, 24 May 2023 16:06:48 +0200 (CEST)
Date:   Wed, 24 May 2023 16:06:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] fanotify: support reporting non-decodeable file
 handles
Message-ID: <20230524140648.u6pexxspze7pz63z@quack3>
References: <ca02955f-1877-4fde-b453-3c1d22794740@kili.mountain>
 <CAOQ4uxi6ST19WGkZiM=ewoK_9o-7DHvZcAc3v2c5GrqSFf0WDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi6ST19WGkZiM=ewoK_9o-7DHvZcAc3v2c5GrqSFf0WDQ@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 24-05-23 11:38:17, Amir Goldstein wrote:
> On Wed, May 24, 2023 at 9:34 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Hello Amir Goldstein,
> >
> > The patch 7ba39960c7f3: "fanotify: support reporting non-decodeable
> > file handles" from May 2, 2023, leads to the following Smatch static
> > checker warning:
> >
> >         fs/notify/fanotify/fanotify.c:451 fanotify_encode_fh()
> >         warn: assigning signed to unsigned: 'fh->type = type' 's32min-(-1),1-254,256-s32max'
> >
> > (unpublished garbage Smatch check).
> >
> > fs/notify/fanotify/fanotify.c
> >     403 static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
> >     404                               unsigned int fh_len, unsigned int *hash,
> >     405                               gfp_t gfp)
> >     406 {
> >     407         int dwords, type = 0;
> >     408         char *ext_buf = NULL;
> >     409         void *buf = fh->buf;
> >     410         int err;
> >     411
> >     412         fh->type = FILEID_ROOT;
> >     413         fh->len = 0;
> >     414         fh->flags = 0;
> >     415
> >     416         /*
> >     417          * Invalid FHs are used by FAN_FS_ERROR for errors not
> >     418          * linked to any inode. The f_handle won't be reported
> >     419          * back to userspace.
> >     420          */
> >     421         if (!inode)
> >     422                 goto out;
> >     423
> >     424         /*
> >     425          * !gpf means preallocated variable size fh, but fh_len could
> >     426          * be zero in that case if encoding fh len failed.
> >     427          */
> >     428         err = -ENOENT;
> >     429         if (fh_len < 4 || WARN_ON_ONCE(fh_len % 4) || fh_len > MAX_HANDLE_SZ)
> >     430                 goto out_err;
> >     431
> >     432         /* No external buffer in a variable size allocated fh */
> >     433         if (gfp && fh_len > FANOTIFY_INLINE_FH_LEN) {
> >     434                 /* Treat failure to allocate fh as failure to encode fh */
> >     435                 err = -ENOMEM;
> >     436                 ext_buf = kmalloc(fh_len, gfp);
> >     437                 if (!ext_buf)
> >     438                         goto out_err;
> >     439
> >     440                 *fanotify_fh_ext_buf_ptr(fh) = ext_buf;
> >     441                 buf = ext_buf;
> >     442                 fh->flags |= FANOTIFY_FH_FLAG_EXT_BUF;
> >     443         }
> >     444
> >     445         dwords = fh_len >> 2;
> >     446         type = exportfs_encode_fid(inode, buf, &dwords);
> >     447         err = -EINVAL;
> >     448         if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> >
> > exportfs_encode_fid() can return negative errors.  Do we need to check
> > if (!type etc?
> 
> Well, it is true that exportfs_encode_fid() can return a negative value
> in principle, as did exportfs_encode_fh() before it, if there was a
> filesystem implementation of ->encode_fh() that returned a negative
> value.  AFAIK, there currently is no such implementation in-tree,
> otherwise current upstream code would have been buggy.

Yes, I've checked and all ->encode_fh() implementations return
FILEID_INVALID in case of problems (which are basically always only
problems with not enough space in the handle buffer).

> Patch 2/4 adds a new possible -EOPNOTSUPP return value from
> exportfs_encode_inode_fh() and even goes further to add a kerndoc:
>  * Returns an enum fid_type or a negative errno.
> But this new return value is not possible from exportfs_encode_fid()
> that is used here and in {fa,i}notify_fdinfo().
> 
> All the rest of the callers (nfsd, overlayfs, name_to_hanle_at) already
> check this same EOPNOTSUPP condition before calling, but there is
> no guarantee that this will not change in the future.
> 
> All the callers mentioned above check the unexpected return value differently:
> nfsd: only type == FILEID_INVALID
> fdinfo: type < 0 || type == FILEID_INVALID
> fanotify: !type || type == FILEID_INVALID
> overlayfs: type < 0 || type == FILEID_INVALID
> name_to_hanle_at: (retval == FILEID_INVALID) || (retval == -ENOSPC))
>                 /* As per old exportfs_encode_fh documentation
>                  * we could return ENOSPC to indicate overflow
>                  * But file system returned 255 always. So handle
>                  * both the values
>                  */
> 
> So he have a bit of a mess.

Yeah, it's a bit messy. When checking ->encode_fh() implementations I've
also noticed quite some callers use explicit numbers and not FILEID_*
enums. This is not directly related to the problem at hand but I'm voicing
it in case someone looks for an easy cleanup project :)

> How should we clean it up?
> 
> Option #1: Change encode_fh to return unsigned and replace that new
>                   EOPNOTSUPP with FILEID_INVALID
> Option #2: change all callers to check negative return value
> 
> I am in favor of option #2.
> Shall I send a patch?

When we have two different error conditions (out of buffer space, encoding
handles unsupported), I agree it makes sense to be able to differentiate
them in exportfs_encode_fh() return value. However then it would make sense
to properly return -ENOSPC instead of FILEID_INVALID (as it is strange to
have two different ways of indicating error) which means touching like 16
different .encode_fh implementations. Not too bad but a bit tedious...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
