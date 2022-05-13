Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F930526CE4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 00:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiEMWUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 18:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiEMWUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 18:20:22 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3882C3669D;
        Fri, 13 May 2022 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+B8hb9e2gtOkqrHauSeLAH8CyEzCEmPRm5zx2raskjg=; b=ATUWltMrrYVrS2nC/JSpc5/Vtl
        h12Gl8W63A/UgWc+Jz9X1R8j3VIPSF6koItgl33F/gqiJLKOicEZqW8XBJmJv2GqYjKaV1GKpbcaL
        W2e6gPALdAzgbQLbXAXSg8Ry3mJikU65VpTEGkgvhbziZaylwOOo40dDV5Jlta2FiX+snWkXXpUP4
        7tXxcwmxpNjCZlqwlF+QaUvQgrdOdtgn+FYelofHxYrDnfoIau4S0OJvzGhlu81p1PklmTXCCVSSH
        YdMJPs9azzRKVvQgUpjBcMNvMd6JZ9rs0Pz6Wpwtxui4D0i0hti+Ig8Mk997V0JrFHvAGa9nCRv6n
        lU5SLkYg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npddy-00Eiwm-DT; Fri, 13 May 2022 22:20:18 +0000
Date:   Fri, 13 May 2022 22:20:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/8] NFSD: Instantiate a struct file when creating a
 regular NFSv4 file
Message-ID: <Yn7ZooZbccSrAru0@zeniv-ca.linux.org.uk>
References: <165247056822.6691.9087206893184705325.stgit@bazille.1015granger.net>
 <165247081391.6691.14842389384935416109.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165247081391.6691.14842389384935416109.stgit@bazille.1015granger.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 03:40:13PM -0400, Chuck Lever wrote:

> +/**
> + * dentry_create - Create and open a file
> + * @path: path to create
> + * @flags: O_ flags
> + * @mode: mode bits for new file
> + * @cred: credentials to use
> + *
> + * Caller must hold the parent directory's lock, and have prepared
> + * a negative dentry, placed in @path->dentry, for the new file.
> + *
> + * On success, returns a "struct file *". Otherwise a ERR_PTR
> + * is returned.
> + */
> +struct file *dentry_create(const struct path *path, int flags, umode_t mode,
> +			   const struct cred *cred)
> +{
> +	struct dentry *parent;
> +	struct file *f;
> +	int error;
> +
> +	validate_creds(cred);
> +	f = alloc_empty_file(flags, cred);
> +	if (IS_ERR(f))
> +		return f;
> +
> +	parent = dget_parent(path->dentry);
> +	error = vfs_create(mnt_user_ns(path->mnt), d_inode(parent),
> +			   path->dentry, mode, true);
> +	dput(parent);

Yuck.  dget_parent() is not entirely without valid uses, but this isn't
one.  It's for the cases when parent is *not* stable and you need to grab
what had been the parent at some point (even though it might not be the
parent anymore by the time dget_parent() returns).  Here you seriously
depend upon it remaining the parent of that sucker all the way through -
otherwise vfs_create() would break.  And you really, really depend upon
its survival - the caller is holding it locked, so they would better
have it pinned.

So this dget_parent() (and dput()) is pointless and confusing;
path->dentry->d_parent would suffice.  And document that path->dentry
must not be root and that its parent should match path->mnt.

> +	if (error) {
> +		fput(f);
> +		return ERR_PTR(error);
> +	}
> +
> +	error = vfs_open(path, f);
> +	if (error) {
> +		fput(f);
> +		return ERR_PTR(error);
> +	}
> +
> +	return f;

FWIW, I'd rather have it done as
	error = vfs_create(...);
	if (!error)
		error = vfs_open(path, f);

	if (unlikely(error)) {
		fput(f);
		return ERR_PTR(error);
	}
	return f;
