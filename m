Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E2E3BEA28
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 16:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhGGO7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 10:59:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39552 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhGGO7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:59:20 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D418222C9;
        Wed,  7 Jul 2021 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625669797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWAEaANJCor9YlEH49opkCvnBmAIArEUd8NKv+U+sMY=;
        b=XAGkRDyohwLceVwhig+V32Z7YyqrAirmJDiPqhvU0glhvtM54AYZ/RY4CMKk9mRfDoKw1l
        oiy0lQUURCmcOQgNl+lMHh630PlrUMnU/We5zbYLPDG/ECv2vriRXDzKQApxweRgvws8bQ
        NjRBPFVzpQ0W2sqdRXibiRsw20F/NS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625669797;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWAEaANJCor9YlEH49opkCvnBmAIArEUd8NKv+U+sMY=;
        b=nWZRkNi6Sh89Twx8TrmALp2XnCGFIM2eCOODgHnXDOTgEsL+VwBucGYky6cZMQtdjbCmQC
        VAo/Nkh6o3LRcrDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F172413645;
        Wed,  7 Jul 2021 14:56:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id O+UCOKTA5WCtLwAAGKfGzw
        (envelope-from <lhenriques@suse.de>); Wed, 07 Jul 2021 14:56:36 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 32267431;
        Wed, 7 Jul 2021 14:56:36 +0000 (UTC)
Date:   Wed, 7 Jul 2021 15:56:35 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [RFC PATCH v7 06/24] ceph: parse new fscrypt_auth and
 fscrypt_file fields in inode traces
Message-ID: <YOXAo8Q0GQoWaAQE@suse.de>
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-7-jlayton@kernel.org>
 <YOWGPv099N7EsMVA@suse.de>
 <14d96eb9-c9b5-d854-d87a-65c1ab3be57e@redhat.com>
 <d9a56cc0d568bbf59cc76ad618b4d0f92c021fed.camel@kernel.org>
 <YOW67YA8e6vivdkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YOW67YA8e6vivdkh@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 03:32:13PM +0100, Luis Henriques wrote:
> On Wed, Jul 07, 2021 at 08:19:25AM -0400, Jeff Layton wrote:
> > On Wed, 2021-07-07 at 19:19 +0800, Xiubo Li wrote:
> > > On 7/7/21 6:47 PM, Luis Henriques wrote:
> > > > On Fri, Jun 25, 2021 at 09:58:16AM -0400, Jeff Layton wrote:
> > > > > ...and store them in the ceph_inode_info.
> > > > > 
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >   fs/ceph/file.c       |  2 ++
> > > > >   fs/ceph/inode.c      | 18 ++++++++++++++++++
> > > > >   fs/ceph/mds_client.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> > > > >   fs/ceph/mds_client.h |  4 ++++
> > > > >   fs/ceph/super.h      |  6 ++++++
> > > > >   5 files changed, 74 insertions(+)
> > > > > 
> > > > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > > > index 2cda398ba64d..ea0e85075b7b 100644
> > > > > --- a/fs/ceph/file.c
> > > > > +++ b/fs/ceph/file.c
> > > > > @@ -592,6 +592,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
> > > > >   	iinfo.xattr_data = xattr_buf;
> > > > >   	memset(iinfo.xattr_data, 0, iinfo.xattr_len);
> > > > >   
> > > > > +	/* FIXME: set fscrypt_auth and fscrypt_file */
> > > > > +
> > > > >   	in.ino = cpu_to_le64(vino.ino);
> > > > >   	in.snapid = cpu_to_le64(CEPH_NOSNAP);
> > > > >   	in.version = cpu_to_le64(1);	// ???
> > > > > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > > > > index f62785e4dbcb..b620281ea65b 100644
> > > > > --- a/fs/ceph/inode.c
> > > > > +++ b/fs/ceph/inode.c
> > > > > @@ -611,6 +611,13 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
> > > > >   
> > > > >   	ci->i_meta_err = 0;
> > > > >   
> > > > > +#ifdef CONFIG_FS_ENCRYPTION
> > > > > +	ci->fscrypt_auth = NULL;
> > > > > +	ci->fscrypt_auth_len = 0;
> > > > > +	ci->fscrypt_file = NULL;
> > > > > +	ci->fscrypt_file_len = 0;
> > > > > +#endif
> > > > > +
> > > > >   	return &ci->vfs_inode;
> > > > >   }
> > > > >   
> > > > > @@ -619,6 +626,9 @@ void ceph_free_inode(struct inode *inode)
> > > > >   	struct ceph_inode_info *ci = ceph_inode(inode);
> > > > >   
> > > > >   	kfree(ci->i_symlink);
> > > > > +#ifdef CONFIG_FS_ENCRYPTION
> > > > > +	kfree(ci->fscrypt_auth);
> > > > > +#endif
> > > > >   	kmem_cache_free(ceph_inode_cachep, ci);
> > > > >   }
> > > > >   
> > > > > @@ -1021,6 +1031,14 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
> > > > >   		xattr_blob = NULL;
> > > > >   	}
> > > > >   
> > > > > +	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
> > > > > +		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
> > > > > +		ci->fscrypt_auth = iinfo->fscrypt_auth;
> > > > > +		iinfo->fscrypt_auth = NULL;
> > > > > +		iinfo->fscrypt_auth_len = 0;
> > > > > +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> > > > > +	}
> > > > I think we also need to free iinfo->fscrypt_auth here if ci->fscrypt_auth
> > > > is already set.  Something like:
> > > > 
> > > > 	if (iinfo->fscrypt_auth_len) {
> > > > 		if (!ci->fscrypt_auth) {
> > > > 			...
> > > > 		} else {
> > > > 			kfree(iinfo->fscrypt_auth);
> > > > 			iinfo->fscrypt_auth = NULL;
> > > > 		}
> > > > 	}
> > > > 
> > > IMO, this should be okay because it will be freed in 
> > > destroy_reply_info() when putting the request.
> > > 
> > > 
> > 
> > Yes. All of that should get cleaned up with the request.
> 
> Hmm... ok, so maybe I missed something because I *did* saw kmemleak
> complaining.  Maybe it was on the READDIR path.  /me goes look again.

Ah, that was indeed the problem.  So, here's a quick hack to fix
destroy_reply_info() so that it also frees the extra memory from READDIR:

@@ -686,12 +686,23 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 
 static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
 {
+	int i = 0;
+
 	kfree(info->diri.fscrypt_auth);
 	kfree(info->diri.fscrypt_file);
 	kfree(info->targeti.fscrypt_auth);
 	kfree(info->targeti.fscrypt_file);
 	if (!info->dir_entries)
 		return;
+
+	for (i = 0; i < info->dir_nr; i++) {
+		struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
+		if (rde->inode.fscrypt_auth_len)
+			kfree(rde->inode.fscrypt_auth);
+	}
+	       
 	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
 }
 

Cheers,
--
Luís
