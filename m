Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C7C60C4D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiJYHQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 03:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJYHQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:16:11 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B81DA5F
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 00:16:04 -0700 (PDT)
Received: from [10.155.150.56] (unknown [213.29.99.90])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D3AED422ED;
        Tue, 25 Oct 2022 07:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666682163;
        bh=doHklInntPjmGc+BN41sPQIttemhDY+xl3azOxz6jYc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=NYP3IS+thPINFP4ozFrtQfE829SrRmsFEQroOWB6prhheHxSpwcQpOs7L7mC/wZE6
         t2mBAunU1KgcEIcPWR16LWxkc4M/9t2MZNx41RmLO+tUInCci45cjPhXYLOceP22IZ
         1hAxkU00eTDMUpMFPg04/6YlxiAeta0yp+L3skCQAVtUyAa2+IR+QASILmM/H91AyK
         476eyXkjNiUSnyVdGH2iWoxsc/ZfBRdktlhH7o4XEKnC3Y/q8tkNztOzodx2ce0lhi
         pcONFr1Z764V1qj6Y3uLAmZZyJOCe6OWNP0H4mSjArg8fVJAT6fMkRbhiP3z+0xp5W
         +HYc2Fid6wpVQ==
Message-ID: <5ae36c94-18dd-2f7a-b5f4-3c2122415dc7@canonical.com>
Date:   Tue, 25 Oct 2022 00:16:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [apparmor] [PATCH 4/8] apparmor: use type safe idmapping helpers
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Cc:     apparmor@lists.ubuntu.com, Al Viro <viro@zeniv.linux.org.uk>
References: <20221024111249.477648-1-brauner@kernel.org>
 <20221024111249.477648-5-brauner@kernel.org>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221024111249.477648-5-brauner@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/24/22 04:12, Christian Brauner wrote:
> We already ported most parts and filesystems over for v6.0 to the new
> vfs{g,u}id_t type and associated helpers for v6.0. Convert the remaining
> places so we can remove all the old helpers.
> This is a non-functional change.
> 
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
> 
> Notes:
> 
>   security/apparmor/domain.c |  8 ++++----
>   security/apparmor/file.c   |  4 +++-
>   security/apparmor/lsm.c    | 24 ++++++++++++++++--------
>   3 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 91689d34d281..7bafb4c4767c 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -859,10 +859,10 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
>   	const char *info = NULL;
>   	int error = 0;
>   	bool unsafe = false;
> -	kuid_t i_uid = i_uid_into_mnt(file_mnt_user_ns(bprm->file),
> -				      file_inode(bprm->file));
> +	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_user_ns(bprm->file),
> +					    file_inode(bprm->file));
>   	struct path_cond cond = {
> -		i_uid,
> +		vfsuid_into_kuid(vfsuid),
>   		file_inode(bprm->file)->i_mode
>   	};
>   
> @@ -970,7 +970,7 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
>   	error = fn_for_each(label, profile,
>   			aa_audit_file(profile, &nullperms, OP_EXEC, MAY_EXEC,
>   				      bprm->filename, NULL, new,
> -				      i_uid, info, error));
> +				      vfsuid_into_kuid(vfsuid), info, error));
>   	aa_put_label(new);
>   	goto done;
>   }
> diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> index e1b7e93602e4..d43679894d23 100644
> --- a/security/apparmor/file.c
> +++ b/security/apparmor/file.c
> @@ -510,8 +510,10 @@ static int __file_path_perm(const char *op, struct aa_label *label,
>   {
>   	struct aa_profile *profile;
>   	struct aa_perms perms = {};
> +	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_user_ns(file),
> +					    file_inode(file));
>   	struct path_cond cond = {
> -		.uid = i_uid_into_mnt(file_mnt_user_ns(file), file_inode(file)),
> +		.uid = vfsuid_into_kuid(vfsuid),
>   		.mode = file_inode(file)->i_mode
>   	};
>   	char *buffer;
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index f56070270c69..cab55e25b4e3 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -225,8 +225,10 @@ static int common_perm(const char *op, const struct path *path, u32 mask,
>   static int common_perm_cond(const char *op, const struct path *path, u32 mask)
>   {
>   	struct user_namespace *mnt_userns = mnt_user_ns(path->mnt);
> +	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns,
> +					    d_backing_inode(path->dentry));
>   	struct path_cond cond = {
> -		i_uid_into_mnt(mnt_userns, d_backing_inode(path->dentry)),
> +		vfsuid_into_kuid(vfsuid),
>   		d_backing_inode(path->dentry)->i_mode
>   	};
>   
> @@ -270,11 +272,12 @@ static int common_perm_rm(const char *op, const struct path *dir,
>   	struct inode *inode = d_backing_inode(dentry);
>   	struct user_namespace *mnt_userns = mnt_user_ns(dir->mnt);
>   	struct path_cond cond = { };
> +	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
>   
>   	if (!inode || !path_mediated_fs(dentry))
>   		return 0;
>   
> -	cond.uid = i_uid_into_mnt(mnt_userns, inode);
> +	cond.uid = vfsuid_into_kuid(vfsuid);
>   	cond.mode = inode->i_mode;
>   
>   	return common_perm_dir_dentry(op, dir, dentry, mask, &cond);
> @@ -368,20 +371,23 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
>   	label = begin_current_label_crit_section();
>   	if (!unconfined(label)) {
>   		struct user_namespace *mnt_userns = mnt_user_ns(old_dir->mnt);
> +		vfsuid_t vfsuid;
>   		struct path old_path = { .mnt = old_dir->mnt,
>   					 .dentry = old_dentry };
>   		struct path new_path = { .mnt = new_dir->mnt,
>   					 .dentry = new_dentry };
>   		struct path_cond cond = {
> -			i_uid_into_mnt(mnt_userns, d_backing_inode(old_dentry)),
> -			d_backing_inode(old_dentry)->i_mode
> +			.mode = d_backing_inode(old_dentry)->i_mode
>   		};
> +		vfsuid = i_uid_into_vfsuid(mnt_userns, d_backing_inode(old_dentry));
> +		cond.uid = vfsuid_into_kuid(vfsuid);
>   
>   		if (flags & RENAME_EXCHANGE) {
>   			struct path_cond cond_exchange = {
> -				i_uid_into_mnt(mnt_userns, d_backing_inode(new_dentry)),
> -				d_backing_inode(new_dentry)->i_mode
> +				.mode = d_backing_inode(new_dentry)->i_mode,
>   			};
> +			vfsuid = i_uid_into_vfsuid(mnt_userns, d_backing_inode(old_dentry));
> +			cond_exchange.uid = vfsuid_into_kuid(vfsuid);
>   
>   			error = aa_path_perm(OP_RENAME_SRC, label, &new_path, 0,
>   					     MAY_READ | AA_MAY_GETATTR | MAY_WRITE |
> @@ -447,10 +453,12 @@ static int apparmor_file_open(struct file *file)
>   	if (!unconfined(label)) {
>   		struct user_namespace *mnt_userns = file_mnt_user_ns(file);
>   		struct inode *inode = file_inode(file);
> +		vfsuid_t vfsuid;
>   		struct path_cond cond = {
> -			i_uid_into_mnt(mnt_userns, inode),
> -			inode->i_mode
> +			.mode = inode->i_mode,
>   		};
> +		vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
> +		cond.uid = vfsuid_into_kuid(vfsuid);
>   
>   		error = aa_path_perm(OP_OPEN, label, &file->f_path, 0,
>   				     aa_map_file_to_perms(file), &cond);

