Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA9747208
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 15:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGDNB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 09:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDNB2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:01:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B247E70;
        Tue,  4 Jul 2023 06:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB7CB6123B;
        Tue,  4 Jul 2023 13:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742B9C433C7;
        Tue,  4 Jul 2023 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688475686;
        bh=yuVUTIiWJvRuqLsHSpscA4HcEHnofJddkhC4EZDiI/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJAozGZgU7zK0v0m22vDyI067CtOJEBiLpimcGseXRbgL5Ki+dxgp9Gfzas3azDSL
         LeI7LOc/YBkMsV9L9+9X35uig0Sqhjq+0hxQL6gLp/hV38n9IJuw/XtnRI7Dm0mdXi
         PgP+2pBv4BsU3XsMIPULEX0NkdldzhSHgBWBmLRn/YmS+wDQrzAHqjR8uhmweuyWyb
         TvgzTeMMMI85MAu2tWOcj0ZdSbq/yOFu5/8s96hZUJfmjfQSE6sjeSa83rdCU9Jp8V
         GMF1ONjSuhUYFydXk9fWxZvna/WMS33xOrnk1uVNTGyKzL5fe7+jF4Yw2nOy11/lii
         y4esb91bLw2NA==
Date:   Tue, 4 Jul 2023 15:01:21 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Alexey Gladkov <legion@kernel.org>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v1] fs: Add kfuncs to handle idmapped mounts
Message-ID: <20230704-anrollen-beenden-9187c7b1b570@brauner>
References: <c35fbb4cb0a3a9b4653f9a032698469d94ca6e9c.1688123230.git.legion@kernel.org>
 <babdf7a8-9663-6d71-821a-34da2aff80e2@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <babdf7a8-9663-6d71-821a-34da2aff80e2@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 04, 2023 at 07:42:53PM +0800, Hou Tao wrote:
> Hi,
> 
> On 6/30/2023 7:08 PM, Alexey Gladkov wrote:
> > Since the introduction of idmapped mounts, file handling has become
> > somewhat more complicated. If the inode has been found through an
> > idmapped mount the idmap of the vfsmount must be used to get proper
> > i_uid / i_gid. This is important, for example, to correctly take into
> > account idmapped files when caching, LSM or for an audit.
> 
> Could you please add a bpf selftest for these newly added kfuncs ?
> >
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > ---
> >  fs/mnt_idmapping.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >
> > diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> > index 4905665c47d0..ba98ce26b883 100644
> > --- a/fs/mnt_idmapping.c
> > +++ b/fs/mnt_idmapping.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/mnt_idmapping.h>
> >  #include <linux/slab.h>
> >  #include <linux/user_namespace.h>
> > +#include <linux/bpf.h>
> >  
> >  #include "internal.h"
> >  
> > @@ -271,3 +272,71 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
> >  		kfree(idmap);
> >  	}
> >  }
> > +
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +		  "Global functions as their definitions will be in vmlinux BTF");
> > +
> > +/**
> > + * bpf_is_idmapped_mnt - check whether a mount is idmapped
> > + * @mnt: the mount to check
> > + *
> > + * Return: true if mount is mapped, false if not.
> > + */
> > +__bpf_kfunc bool bpf_is_idmapped_mnt(struct vfsmount *mnt)
> > +{
> > +	return is_idmapped_mnt(mnt);
> > +}
> > +
> > +/**
> > + * bpf_file_mnt_idmap - get file idmapping
> > + * @file: the file from which to get mapping
> > + *
> > + * Return: The idmap for the @file.
> > + */
> > +__bpf_kfunc struct mnt_idmap *bpf_file_mnt_idmap(struct file *file)
> > +{
> > +	return file_mnt_idmap(file);
> > +}
> 
> A dummy question here: the implementation of file_mnt_idmap() is
> file->f_path.mnt->mnt_idmap, so if the passed file is a BTF pointer, is
> there any reason why we could not do such dereference directly in bpf
> program ?
> > +
> > +/**
> > + * bpf_inode_into_vfs_ids - map an inode's i_uid and i_gid down according to an idmapping
> > + * @idmap: idmap of the mount the inode was found from
> > + * @inode: inode to map
> > + *
> > + * The inode's i_uid and i_gid mapped down according to @idmap. If the inode's
> > + * i_uid or i_gid has no mapping INVALID_VFSUID or INVALID_VFSGID is returned in
> > + * the corresponding position.
> > + *
> > + * Return: A 64-bit integer containing the current GID and UID, and created as
> > + * such: *gid* **<< 32 \|** *uid*.
> > + */
> > +__bpf_kfunc uint64_t bpf_inode_into_vfs_ids(struct mnt_idmap *idmap,
> > +		const struct inode *inode)
> > +{
> > +	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
> > +	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
> > +
> > +	return (u64) __vfsgid_val(vfsgid) << 32 |
> > +		     __vfsuid_val(vfsuid);
> > +}
> > +
> > +__diag_pop();
> > +
> > +BTF_SET8_START(idmap_btf_ids)
> > +BTF_ID_FLAGS(func, bpf_is_idmapped_mnt)
> > +BTF_ID_FLAGS(func, bpf_file_mnt_idmap)
> > +BTF_ID_FLAGS(func, bpf_inode_into_vfs_ids)
> > +BTF_SET8_END(idmap_btf_ids)
> > +
> > +static const struct btf_kfunc_id_set idmap_kfunc_set = {
> > +	.owner = THIS_MODULE,
> > +	.set   = &idmap_btf_ids,
> > +};
> > +
> > +static int __init bpf_idmap_kfunc_init(void)
> > +{
> > +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &idmap_kfunc_set);
> > +}
> > +
> Is BPF_PROG_TYPE_TRACING sufficient for your use case ? It seems
> BPF_PROG_TYPE_UNSPEC will make these kfuncs be available for all bpf
> program types.
> > +late_initcall(bpf_idmap_kfunc_init);
> 

I don't want any of these helpers as kfuncs as they are peeking deeply
into implementation details that we reserve to change. Specifically in
the light of:

    3. kfunc lifecycle expectations part b):

    "Unlike with regular kernel symbols, this is expected behavior for BPF
     symbols, and out-of-tree BPF programs that use kfuncs should be considered
     relevant to discussions and decisions around modifying and removing those
     kfuncs. The BPF community will take an active role in participating in
     upstream discussions when necessary to ensure that the perspectives of such
     users are taken into account."

That's too much stability for my taste for these helpers. The helpers
here exposed have been modified multiple times and once we wean off
idmapped mounts from user namespaces completely they will change again.
So I'm fine if they're traceable but not as kfuncs with any - even
minimal - stability guarantees.
