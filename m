Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C542609CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 07:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgIHFGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 01:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgIHFGr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 01:06:47 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 560F521532;
        Tue,  8 Sep 2020 05:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599541606;
        bh=3DP04OEzLdviCYiJO0RaRTgNNjkzg5OZ5+18OrNA5iQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y9UoCwUdSOf0QQ6LXFjjD+ND0SqibcbIwv4fgCuNvtyYfXcMyn8AcwdTgWMebCf0a
         N7vpZR5uAkrsGcj2vnBEtGIq2lpjmva9pDNBcXdc5USXkdsAcgUh1tZU3V0WF2MSsF
         rTCOm3xp2VIa++adTYxFeTksN6disozDiooASMjo=
Date:   Mon, 7 Sep 2020 22:06:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 14/18] ceph: add encrypted fname handling to
 ceph_mdsc_build_path
Message-ID: <20200908050643.GL68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-15-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160537.76663-15-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:05:33PM -0400, Jeff Layton wrote:
> Allow ceph_mdsc_build_path to encrypt and base64 encode the filename
> when the parent is encrypted and we're sending the path to the MDS.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/mds_client.c | 51 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index e3dc061252d4..26b43ae09823 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -11,6 +11,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/bits.h>
>  #include <linux/ktime.h>
> +#include <linux/base64_fname.h>
>  
>  #include "super.h"
>  #include "mds_client.h"
> @@ -2324,8 +2325,7 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
>   * Encode hidden .snap dirs as a double /, i.e.
>   *   foo/.snap/bar -> foo//bar
>   */
> -char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
> -			   int stop_on_nosnap)
> +char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase, int for_wire)
>  {
>  	struct dentry *cur;
>  	struct inode *inode;
> @@ -2347,30 +2347,59 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
>  	seq = read_seqbegin(&rename_lock);
>  	cur = dget(dentry);
>  	for (;;) {
> -		struct dentry *temp;
> +		struct dentry *parent;
>  
>  		spin_lock(&cur->d_lock);
>  		inode = d_inode(cur);
> +		parent = cur->d_parent;
>  		if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
>  			dout("build_path path+%d: %p SNAPDIR\n",
>  			     pos, cur);
> -		} else if (stop_on_nosnap && inode && dentry != cur &&
> -			   ceph_snap(inode) == CEPH_NOSNAP) {
> +			dget(parent);
> +			spin_unlock(&cur->d_lock);
> +		} else if (for_wire && inode && dentry != cur && ceph_snap(inode) == CEPH_NOSNAP) {
>  			spin_unlock(&cur->d_lock);
>  			pos++; /* get rid of any prepended '/' */
>  			break;
> -		} else {
> +		} else if (!for_wire || !IS_ENCRYPTED(d_inode(parent))) {
>  			pos -= cur->d_name.len;
>  			if (pos < 0) {
>  				spin_unlock(&cur->d_lock);
>  				break;
>  			}
>  			memcpy(path + pos, cur->d_name.name, cur->d_name.len);
> +			dget(parent);
> +			spin_unlock(&cur->d_lock);
> +		} else {
> +			int err;
> +			struct fscrypt_name fname = { };
> +			int len;
> +			char buf[BASE64_CHARS(NAME_MAX)];
> +
> +			dget(parent);
> +			spin_unlock(&cur->d_lock);
> +
> +			err = fscrypt_setup_filename(d_inode(parent), &cur->d_name, 1, &fname);

How are no-key filenames handled with ceph?  You're calling
fscrypt_setup_filename() with lookup=1, so it will give you back a no-key
filename if the directory's encryption key is unavailable.

> +			if (err) {
> +				dput(parent);
> +				dput(cur);
> +				return ERR_PTR(err);
> +			}
> +
> +			/* base64 encode the encrypted name */
> +			len = base64_encode_fname(fname.disk_name.name, fname.disk_name.len, buf);
> +			pos -= len;
> +			if (pos < 0) {
> +				dput(parent);
> +				fscrypt_free_filename(&fname);
> +				break;
> +			}
> +			memcpy(path + pos, buf, len);
> +			dout("non-ciphertext name = %.*s\n", len, buf);
> +			fscrypt_free_filename(&fname);

This would be easier to understand if the encryption and encoding logic was
moved into its own function.

- Eric
