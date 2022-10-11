Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7EB5FAF4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 11:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJKJ16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 05:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJKJ15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:27:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35798A7DC;
        Tue, 11 Oct 2022 02:27:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6F2801F86C;
        Tue, 11 Oct 2022 09:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665480471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3KWuadcCbjkIKE5D+KEHP1lPs4lQuCQ9jOaXl2urZ0=;
        b=0tQ/Mk9elHuyJv6phmf8ocIvyLSdRbPvwFPToR85Lm9nyyfcFt9XVk+stbM0xT5PX5p9LU
        /lzT9IJLK40J8mixwGz23jk0jM5bxLGucOsDuwt8pDpYoNeSBvRammasjF7EeplbH2Ijor
        GkET1Bs0U1kNOg19H1r43pEd7FsEUvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665480471;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3KWuadcCbjkIKE5D+KEHP1lPs4lQuCQ9jOaXl2urZ0=;
        b=4FpmrNIM6MJ9l6FhGuIXf8n8IAiNNZk53PunL4ysqYsd1IfMDACsj7TmZvYDHnl8XawzIt
        4Z9+hIJQcdYlrvBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E718813AAC;
        Tue, 11 Oct 2022 09:27:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id izr9NBY3RWMHeAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 11 Oct 2022 09:27:50 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id b68f64ba;
        Tue, 11 Oct 2022 09:28:48 +0000 (UTC)
Date:   Tue, 11 Oct 2022 10:28:48 +0100
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com,
        jlayton@kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ceph/super: add mount options "snapdir{mode,uid,gid}"
Message-ID: <Y0U3UAjugtpOlJqn@suse.de>
References: <20220927120857.639461-1-max.kellermann@ionos.com>
 <88f8941f-82bf-5152-b49a-56cb2e465abb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88f8941f-82bf-5152-b49a-56cb2e465abb@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 09, 2022 at 02:23:22PM +0800, Xiubo Li wrote:
> Hi Max,
> 
> Sorry for late and just back from a long vocation.
> 
> On 27/09/2022 20:08, Max Kellermann wrote:
> > By default, the ".snap" directory inherits the parent's permissions
> > and ownership, which allows all users to create new cephfs snapshots
> > in arbitrary directories they have write access on.
> > 
> > In some environments, giving everybody this capability is not
> > desirable, but there is currently no way to disallow only some users
> > to create snapshots.  It is only possible to revoke the permission to
> > the whole client (i.e. all users on the computer which mounts the
> > cephfs).
> > 
> > This patch allows overriding the permissions and ownership of all
> > virtual ".snap" directories in a cephfs mount, which allows
> > restricting (read and write) access to snapshots.
> > 
> > For example, the mount options:
> > 
> >   snapdirmode=0751,snapdiruid=0,snapdirgid=4
> > 
> > ... allows only user "root" to create or delete snapshots, and group
> > "adm" (gid=4) is allowed to get a list of snapshots.  All others are
> > allowed to read the contents of existing snapshots (if they know the
> > name).
> 
> I don't think this is a good place to implement this in client side. Should
> this be a feature in cephx.
> 
> With this for the same directories in different mounts will behave
> differently. Isn't that odd ?

I'm not really sure where (or how) exactly this feature should be
implemented, but I agree with Xiubo that this approach doesn't look
correct.  This would be yet another hack that can be easily circumvented
on the client side.  If this feature is really required, the restriction
should be imposed on the MDS side.

(However, IMHO the feature looks odd from the beginning: a user that owns
a directory and has 'rw' access to it but can't run a simple 'mkdir' is
probably breaking standards compliance even more.)

Cheers,
--
Luís

> 
> -- Xiubo
> 
> > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> > ---
> >   fs/ceph/inode.c |  7 ++++---
> >   fs/ceph/super.c | 33 +++++++++++++++++++++++++++++++++
> >   fs/ceph/super.h |  4 ++++
> >   3 files changed, 41 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index 56c53ab3618e..0e9388af2821 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -80,6 +80,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
> >   	};
> >   	struct inode *inode = ceph_get_inode(parent->i_sb, vino);
> >   	struct ceph_inode_info *ci = ceph_inode(inode);
> > +	struct ceph_mount_options *const fsopt = ceph_inode_to_client(parent)->mount_options;
> >   	if (IS_ERR(inode))
> >   		return inode;
> > @@ -96,9 +97,9 @@ struct inode *ceph_get_snapdir(struct inode *parent)
> >   		goto err;
> >   	}
> > -	inode->i_mode = parent->i_mode;
> > -	inode->i_uid = parent->i_uid;
> > -	inode->i_gid = parent->i_gid;
> > +	inode->i_mode = fsopt->snapdir_mode == (umode_t)-1 ? parent->i_mode : fsopt->snapdir_mode;
> > +	inode->i_uid = uid_eq(fsopt->snapdir_uid, INVALID_UID) ? parent->i_uid : fsopt->snapdir_uid;
> > +	inode->i_gid = gid_eq(fsopt->snapdir_gid, INVALID_GID) ? parent->i_gid : fsopt->snapdir_gid;
> >   	inode->i_mtime = parent->i_mtime;
> >   	inode->i_ctime = parent->i_ctime;
> >   	inode->i_atime = parent->i_atime;
> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index 40140805bdcf..5e5713946f7b 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -143,6 +143,9 @@ enum {
> >   	Opt_readdir_max_entries,
> >   	Opt_readdir_max_bytes,
> >   	Opt_congestion_kb,
> > +	Opt_snapdirmode,
> > +	Opt_snapdiruid,
> > +	Opt_snapdirgid,
> >   	/* int args above */
> >   	Opt_snapdirname,
> >   	Opt_mds_namespace,
> > @@ -200,6 +203,9 @@ static const struct fs_parameter_spec ceph_mount_parameters[] = {
> >   	fsparam_flag_no ("require_active_mds",		Opt_require_active_mds),
> >   	fsparam_u32	("rsize",			Opt_rsize),
> >   	fsparam_string	("snapdirname",			Opt_snapdirname),
> > +	fsparam_u32oct	("snapdirmode",			Opt_snapdirmode),
> > +	fsparam_u32	("snapdiruid",			Opt_snapdiruid),
> > +	fsparam_u32	("snapdirgid",			Opt_snapdirgid),
> >   	fsparam_string	("source",			Opt_source),
> >   	fsparam_string	("mon_addr",			Opt_mon_addr),
> >   	fsparam_u32	("wsize",			Opt_wsize),
> > @@ -414,6 +420,22 @@ static int ceph_parse_mount_param(struct fs_context *fc,
> >   		fsopt->snapdir_name = param->string;
> >   		param->string = NULL;
> >   		break;
> > +	case Opt_snapdirmode:
> > +		fsopt->snapdir_mode = result.uint_32;
> > +		if (fsopt->snapdir_mode & ~0777)
> > +			return invalfc(fc, "Invalid snapdirmode");
> > +		fsopt->snapdir_mode |= S_IFDIR;
> > +		break;
> > +	case Opt_snapdiruid:
> > +		fsopt->snapdir_uid = make_kuid(current_user_ns(), result.uint_32);
> > +		if (!uid_valid(fsopt->snapdir_uid))
> > +			return invalfc(fc, "Invalid snapdiruid");
> > +		break;
> > +	case Opt_snapdirgid:
> > +		fsopt->snapdir_gid = make_kgid(current_user_ns(), result.uint_32);
> > +		if (!gid_valid(fsopt->snapdir_gid))
> > +			return invalfc(fc, "Invalid snapdirgid");
> > +		break;
> >   	case Opt_mds_namespace:
> >   		if (!namespace_equals(fsopt, param->string, strlen(param->string)))
> >   			return invalfc(fc, "Mismatching mds_namespace");
> > @@ -734,6 +756,14 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
> >   		seq_printf(m, ",readdir_max_bytes=%u", fsopt->max_readdir_bytes);
> >   	if (strcmp(fsopt->snapdir_name, CEPH_SNAPDIRNAME_DEFAULT))
> >   		seq_show_option(m, "snapdirname", fsopt->snapdir_name);
> > +	if (fsopt->snapdir_mode != (umode_t)-1)
> > +		seq_printf(m, ",snapdirmode=%o", fsopt->snapdir_mode);
> > +	if (!uid_eq(fsopt->snapdir_uid, INVALID_UID))
> > +		seq_printf(m, ",snapdiruid=%o",
> > +			   from_kuid_munged(&init_user_ns, fsopt->snapdir_uid));
> > +	if (!gid_eq(fsopt->snapdir_gid, INVALID_GID))
> > +		seq_printf(m, ",snapdirgid=%o",
> > +			   from_kgid_munged(&init_user_ns, fsopt->snapdir_gid));
> >   	return 0;
> >   }
> > @@ -1335,6 +1365,9 @@ static int ceph_init_fs_context(struct fs_context *fc)
> >   	fsopt->wsize = CEPH_MAX_WRITE_SIZE;
> >   	fsopt->rsize = CEPH_MAX_READ_SIZE;
> >   	fsopt->rasize = CEPH_RASIZE_DEFAULT;
> > +	fsopt->snapdir_mode = (umode_t)-1;
> > +	fsopt->snapdir_uid = INVALID_UID;
> > +	fsopt->snapdir_gid = INVALID_GID;
> >   	fsopt->snapdir_name = kstrdup(CEPH_SNAPDIRNAME_DEFAULT, GFP_KERNEL);
> >   	if (!fsopt->snapdir_name)
> >   		goto nomem;
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index d44a366b2f1b..3c930816078d 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -85,6 +85,10 @@ struct ceph_mount_options {
> >   	unsigned int max_readdir;       /* max readdir result (entries) */
> >   	unsigned int max_readdir_bytes; /* max readdir result (bytes) */
> > +	umode_t snapdir_mode;
> > +	kuid_t snapdir_uid;
> > +	kgid_t snapdir_gid;
> > +
> >   	bool new_dev_syntax;
> >   	/*
> 
