Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C636262FE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 16:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgIIOmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 10:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730140AbgIIMfl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:35:41 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EE8021941;
        Wed,  9 Sep 2020 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599654280;
        bh=2DbSBwKd5N1exdPp99yIXH8KFc5YWL59o2CAnXhlsOk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lGg22N3K6QxJIa+Cw6Xlj8g5/DnX3ir2eD1HyExWVWmzH8flSuAtHSPV/nzthIWU4
         dErrQgfz35IrL0XJG1wcpksxd8fUNj9ySukQt2ARAekI2OVNgfn79YeVmkQ3LFHLU3
         XINSI67UsKYac7Wp/QFqP8kZY54CnNFJdNwaH98A=
Message-ID: <fbf3c8cea47f021200937273fc810b1244e186a1.camel@kernel.org>
Subject: Re: [RFC PATCH v2 14/18] ceph: add encrypted fname handling to
 ceph_mdsc_build_path
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Date:   Wed, 09 Sep 2020 08:24:39 -0400
In-Reply-To: <20200908050643.GL68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-15-jlayton@kernel.org>
         <20200908050643.GL68127@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-07 at 22:06 -0700, Eric Biggers wrote:
> On Fri, Sep 04, 2020 at 12:05:33PM -0400, Jeff Layton wrote:
> > Allow ceph_mdsc_build_path to encrypt and base64 encode the filename
> > when the parent is encrypted and we're sending the path to the MDS.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/mds_client.c | 51 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 40 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index e3dc061252d4..26b43ae09823 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/ratelimit.h>
> >  #include <linux/bits.h>
> >  #include <linux/ktime.h>
> > +#include <linux/base64_fname.h>
> >  
> >  #include "super.h"
> >  #include "mds_client.h"
> > @@ -2324,8 +2325,7 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
> >   * Encode hidden .snap dirs as a double /, i.e.
> >   *   foo/.snap/bar -> foo//bar
> >   */
> > -char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
> > -			   int stop_on_nosnap)
> > +char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase, int for_wire)
> >  {
> >  	struct dentry *cur;
> >  	struct inode *inode;
> > @@ -2347,30 +2347,59 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
> >  	seq = read_seqbegin(&rename_lock);
> >  	cur = dget(dentry);
> >  	for (;;) {
> > -		struct dentry *temp;
> > +		struct dentry *parent;
> >  
> >  		spin_lock(&cur->d_lock);
> >  		inode = d_inode(cur);
> > +		parent = cur->d_parent;
> >  		if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
> >  			dout("build_path path+%d: %p SNAPDIR\n",
> >  			     pos, cur);
> > -		} else if (stop_on_nosnap && inode && dentry != cur &&
> > -			   ceph_snap(inode) == CEPH_NOSNAP) {
> > +			dget(parent);
> > +			spin_unlock(&cur->d_lock);
> > +		} else if (for_wire && inode && dentry != cur && ceph_snap(inode) == CEPH_NOSNAP) {
> >  			spin_unlock(&cur->d_lock);
> >  			pos++; /* get rid of any prepended '/' */
> >  			break;
> > -		} else {
> > +		} else if (!for_wire || !IS_ENCRYPTED(d_inode(parent))) {
> >  			pos -= cur->d_name.len;
> >  			if (pos < 0) {
> >  				spin_unlock(&cur->d_lock);
> >  				break;
> >  			}
> >  			memcpy(path + pos, cur->d_name.name, cur->d_name.len);
> > +			dget(parent);
> > +			spin_unlock(&cur->d_lock);
> > +		} else {
> > +			int err;
> > +			struct fscrypt_name fname = { };
> > +			int len;
> > +			char buf[BASE64_CHARS(NAME_MAX)];
> > +
> > +			dget(parent);
> > +			spin_unlock(&cur->d_lock);
> > +
> > +			err = fscrypt_setup_filename(d_inode(parent), &cur->d_name, 1, &fname);
> 
> How are no-key filenames handled with ceph?  You're calling
> fscrypt_setup_filename() with lookup=1, so it will give you back a no-key
> filename if the directory's encryption key is unavailable.
> 

Still TBD.

For now, I'm just ignoring long filenames. Eventually we'll need to
extend the MDS and protocol to handle the nokey names properly and this
code will need to be reworked.

I have this bug opened for tracking that work:

    https://tracker.ceph.com/issues/47162

 
> > +			if (err) {
> > +				dput(parent);
> > +				dput(cur);
> > +				return ERR_PTR(err);
> > +			}
> > +
> > +			/* base64 encode the encrypted name */
> > +			len = base64_encode_fname(fname.disk_name.name, fname.disk_name.len, buf);
> > +			pos -= len;
> > +			if (pos < 0) {
> > +				dput(parent);
> > +				fscrypt_free_filename(&fname);
> > +				break;
> > +			}
> > +			memcpy(path + pos, buf, len);
> > +			dout("non-ciphertext name = %.*s\n", len, buf);
> > +			fscrypt_free_filename(&fname);
> 
> This would be easier to understand if the encryption and encoding logic was
> moved into its own function.
> 


Agreed, though it's a little hard given the way this function is
structured. I'll see what I can do to clean it up though.

-- 
Jeff Layton <jlayton@kernel.org>

