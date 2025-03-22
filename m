Return-Path: <linux-fsdevel+bounces-44747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218C1A6C6A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 01:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB4E3AEC41
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 00:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F115234;
	Sat, 22 Mar 2025 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MrzpIxk5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F61FC3;
	Sat, 22 Mar 2025 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742603247; cv=none; b=O7zx/tZocuU8LCPISDk5AhRWuliIgOpochY42IVaPZSLrRtOg+OfeL0bCc/kAYB6SQb2VxZ0kCaPZgfBs04RtyalGvpYTScRPoK2pgLFhFy36fCYpsFvS5AVh/QmTYpM/4y5k6ThW0+hR4uXYDifuJLtGr04ANdZFCk0Eb72Vgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742603247; c=relaxed/simple;
	bh=DrlCH/iqHTEpFQKgA/k9tNIYbEIxWdNnYd18HL0MgrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VchMRm50LdcNBPlNSR6f/mdWWpEq6hRmfN7GLT637NsbBYVX1ZWeLUTkCclS84vyvuHY8xze3qo7+F1b+2qKo/nKVMV9Q2B7XLV8GjQQxe5d5x1igLOh59Wcvzd6ugAyeNbXO0jOrosahO+rdMfRhQJJ5nzfy5qeMBeft3GzwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MrzpIxk5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6RcqxdhK4NkqWrwbthS7JFj+tnwiFnWkiu0VDGcpYi4=; b=MrzpIxk5R2ZUlhwuk0T29nzgGL
	Ol7c8OeagDLEvy/MsscjiFPPBEEdVLTlrM0zP1H4ApYBuUFcUmKN4+imBzMlvz9NXd4H5ke3Nu0vO
	BYB2i2iP9WXuBEpNhjUnAsnCQIuX9UTjJFABlF2/28/rpi6JokFdazrmU39f/fG/KSHaU4P69wvtI
	YH+GhMZhcq3P8CUJs7BpaFM9RLiKvefBGwTpogLiR6jEbjCXc2rHOUA9IQVxRH/BDoMG9ZfM7EWbC
	otrdyhvVuauKvB76tjNjsfcUqzDqUXqa0uYxEbM2f7/mjpMB07ipsv3f41UZLeFZfrW3R6QlzZ7fv
	Xst0QPeg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tvmhr-0000000BBMu-21PF;
	Sat, 22 Mar 2025 00:27:19 +0000
Date: Sat, 22 Mar 2025 00:27:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] VFS: improve interface for lookup_one functions
Message-ID: <20250322002719.GC2023217@ZenIV>
References: <20250319031545.2999807-1-neil@brown.name>
 <20250319031545.2999807-2-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319031545.2999807-2-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Mar 19, 2025 at 02:01:32PM +1100, NeilBrown wrote:

> -struct dentry *lookup_one(struct mnt_idmap *idmap, const char *name,
> -			  struct dentry *base, int len)
> +struct dentry *lookup_one(struct mnt_idmap *idmap, struct qstr name,
> +			  struct dentry *base)

>  {
>  	struct dentry *dentry;
>  	struct qstr this;
> @@ -2942,7 +2940,7 @@ struct dentry *lookup_one(struct mnt_idmap *idmap, const char *name,
>  
>  	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
>  
> -	err = lookup_one_common(idmap, name, base, len, &this);
> +	err = lookup_one_common(idmap, name.name, base, name.len, &this);

No.  Just look at what lookup_one_common() is doing as the first step.

        this->name = name;
	this->len = len;

You copy your argument's fields to corresponding fields of *&this.  It might make
sense to pass a qstr, but not like that - just pass a _pointer_ to struct qstr instead.

Have lookup_one_common() do this:

static int lookup_one_common(struct mnt_idmap *idmap,
                             struct qstr *this, struct dentry *base)
{
	const unsigned char *name = this->name;
	int len = this->len;
        if (!len)
                return -EACCES;

        this->hash = full_name_hash(base, name, len);
        if (is_dot_dotdot(name, len))
                return -EACCES;

        while (len--) {
                unsigned int c = *name++;
                if (c == '/' || c == '\0')
                        return -EACCES;
        }
        /*
         * See if the low-level filesystem might want
         * to use its own hash..
         */
        if (base->d_flags & DCACHE_OP_HASH) {
                int err = base->d_op->d_hash(base, this);
                if (err < 0)
                        return err;
        }

        return inode_permission(idmap, base->d_inode, MAY_EXEC);
}

and adjust the callers; e.g.
struct dentry *lookup_one(struct mnt_idmap *idmap, struct qstr *this,
			  struct dentry *base)
{
        struct dentry *dentry;
        int err;

        WARN_ON_ONCE(!inode_is_locked(base->d_inode));

        err = lookup_one_common(idmap, this, base);
        if (err)
                return ERR_PTR(err);

        dentry = lookup_dcache(this, base, 0);
        return dentry ? dentry : __lookup_slow(this, base, 0);
}

with callers passing idmap, &QSTR_LEN(name, len), base instead of
idmap, name, base, len.  lookup_one_common() looks at the fields
separately; its callers do not.

