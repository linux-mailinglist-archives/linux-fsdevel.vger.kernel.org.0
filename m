Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AB75F89AA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Oct 2022 08:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJIGXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 02:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJIGXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 02:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE412B275
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Oct 2022 23:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665296612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZeEFM2g1KPCSHqVKEIXgHCa1SGCHP1tlBoS23cVoXoQ=;
        b=bM0p4Vz8w4piyVps0bLCWd25no6z6G2J61MOdbt1Y8MfmUcxCHn8xt+5MtfP79kMy6z0aM
        q2UEdEttEh1CozTH+uxrop2V5ilkjivzck1K05L9rZStEph3tSAeTdBLhtk8A9b0sOObZG
        Ib3Lpvx36rkxJP4k3RVBm+2Wjmc42kk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-21-h06Rz--bOy-rUtVuPfXNWw-1; Sun, 09 Oct 2022 02:23:30 -0400
X-MC-Unique: h06Rz--bOy-rUtVuPfXNWw-1
Received: by mail-pj1-f69.google.com with SMTP id mq15-20020a17090b380f00b0020ad26fa5edso7307821pjb.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Oct 2022 23:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeEFM2g1KPCSHqVKEIXgHCa1SGCHP1tlBoS23cVoXoQ=;
        b=IElwuimAmR7uc0YDiphGwrgFNA8lAre0gRoJK+6HWtuwzRT0/IcvY6rC+jl3RhOZML
         TmfYp/srg/ZAPEFVbrxNX2hfoLY7aGZWwilZYFqWuolCNMCnHWQikYiL7ElGZMdf2mg8
         H4txJtk3h/FjJpU6DXm/ckLjxjoGzYjs0IU6WZLZRGvi7ed2HvPOA9DsnETK7tkuNky0
         y+QKqTevhnWKghSZwu7UXXbQC6YiDPRMzWLiBgaAa3kgxBZ/irRNe1QDu87mHW1THSMq
         7DCOeN286j0hzlRiFyiwq28eXIbX2hVzCQje6BhqHv8QbMaO0HENdQkBzibEVbMvt5c/
         fWzA==
X-Gm-Message-State: ACrzQf1GtHjyEbZAeZSReTgVujivknvpDmmQRbvs/PVBJPaDzLIFdzIp
        lwur7kI6F4jfVr3FLj9KtKnGoLxrab+VzJ9tIOofbD8f7cjgw0AnB7eDVzp/yfQOan0zhZNV6hs
        nzoNAT64wilq5xilLlsw2ofC4ww==
X-Received: by 2002:a63:4a0f:0:b0:44e:4323:e884 with SMTP id x15-20020a634a0f000000b0044e4323e884mr11426594pga.225.1665296609604;
        Sat, 08 Oct 2022 23:23:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7xp0jYYr9UUcKpw1u8A7gU32yhxwFcwpyRvW1olwP3TFl33ABl90NqKJXeWXBAkcER/Mpt0g==
X-Received: by 2002:a63:4a0f:0:b0:44e:4323:e884 with SMTP id x15-20020a634a0f000000b0044e4323e884mr11426575pga.225.1665296609275;
        Sat, 08 Oct 2022 23:23:29 -0700 (PDT)
Received: from [10.72.12.247] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a2a4500b001f2ef3c7956sm6994409pjg.25.2022.10.08.23.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 23:23:28 -0700 (PDT)
Subject: Re: [PATCH] fs/ceph/super: add mount options "snapdir{mode,uid,gid}"
To:     Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com,
        jlayton@kernel.org, ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220927120857.639461-1-max.kellermann@ionos.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <88f8941f-82bf-5152-b49a-56cb2e465abb@redhat.com>
Date:   Sun, 9 Oct 2022 14:23:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220927120857.639461-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Max,

Sorry for late and just back from a long vocation.

On 27/09/2022 20:08, Max Kellermann wrote:
> By default, the ".snap" directory inherits the parent's permissions
> and ownership, which allows all users to create new cephfs snapshots
> in arbitrary directories they have write access on.
>
> In some environments, giving everybody this capability is not
> desirable, but there is currently no way to disallow only some users
> to create snapshots.  It is only possible to revoke the permission to
> the whole client (i.e. all users on the computer which mounts the
> cephfs).
>
> This patch allows overriding the permissions and ownership of all
> virtual ".snap" directories in a cephfs mount, which allows
> restricting (read and write) access to snapshots.
>
> For example, the mount options:
>
>   snapdirmode=0751,snapdiruid=0,snapdirgid=4
>
> ... allows only user "root" to create or delete snapshots, and group
> "adm" (gid=4) is allowed to get a list of snapshots.  All others are
> allowed to read the contents of existing snapshots (if they know the
> name).

I don't think this is a good place to implement this in client side. 
Should this be a feature in cephx.

With this for the same directories in different mounts will behave 
differently. Isn't that odd ?

-- Xiubo

> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   fs/ceph/inode.c |  7 ++++---
>   fs/ceph/super.c | 33 +++++++++++++++++++++++++++++++++
>   fs/ceph/super.h |  4 ++++
>   3 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 56c53ab3618e..0e9388af2821 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -80,6 +80,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>   	};
>   	struct inode *inode = ceph_get_inode(parent->i_sb, vino);
>   	struct ceph_inode_info *ci = ceph_inode(inode);
> +	struct ceph_mount_options *const fsopt = ceph_inode_to_client(parent)->mount_options;
>   
>   	if (IS_ERR(inode))
>   		return inode;
> @@ -96,9 +97,9 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>   		goto err;
>   	}
>   
> -	inode->i_mode = parent->i_mode;
> -	inode->i_uid = parent->i_uid;
> -	inode->i_gid = parent->i_gid;
> +	inode->i_mode = fsopt->snapdir_mode == (umode_t)-1 ? parent->i_mode : fsopt->snapdir_mode;
> +	inode->i_uid = uid_eq(fsopt->snapdir_uid, INVALID_UID) ? parent->i_uid : fsopt->snapdir_uid;
> +	inode->i_gid = gid_eq(fsopt->snapdir_gid, INVALID_GID) ? parent->i_gid : fsopt->snapdir_gid;
>   	inode->i_mtime = parent->i_mtime;
>   	inode->i_ctime = parent->i_ctime;
>   	inode->i_atime = parent->i_atime;
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 40140805bdcf..5e5713946f7b 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -143,6 +143,9 @@ enum {
>   	Opt_readdir_max_entries,
>   	Opt_readdir_max_bytes,
>   	Opt_congestion_kb,
> +	Opt_snapdirmode,
> +	Opt_snapdiruid,
> +	Opt_snapdirgid,
>   	/* int args above */
>   	Opt_snapdirname,
>   	Opt_mds_namespace,
> @@ -200,6 +203,9 @@ static const struct fs_parameter_spec ceph_mount_parameters[] = {
>   	fsparam_flag_no ("require_active_mds",		Opt_require_active_mds),
>   	fsparam_u32	("rsize",			Opt_rsize),
>   	fsparam_string	("snapdirname",			Opt_snapdirname),
> +	fsparam_u32oct	("snapdirmode",			Opt_snapdirmode),
> +	fsparam_u32	("snapdiruid",			Opt_snapdiruid),
> +	fsparam_u32	("snapdirgid",			Opt_snapdirgid),
>   	fsparam_string	("source",			Opt_source),
>   	fsparam_string	("mon_addr",			Opt_mon_addr),
>   	fsparam_u32	("wsize",			Opt_wsize),
> @@ -414,6 +420,22 @@ static int ceph_parse_mount_param(struct fs_context *fc,
>   		fsopt->snapdir_name = param->string;
>   		param->string = NULL;
>   		break;
> +	case Opt_snapdirmode:
> +		fsopt->snapdir_mode = result.uint_32;
> +		if (fsopt->snapdir_mode & ~0777)
> +			return invalfc(fc, "Invalid snapdirmode");
> +		fsopt->snapdir_mode |= S_IFDIR;
> +		break;
> +	case Opt_snapdiruid:
> +		fsopt->snapdir_uid = make_kuid(current_user_ns(), result.uint_32);
> +		if (!uid_valid(fsopt->snapdir_uid))
> +			return invalfc(fc, "Invalid snapdiruid");
> +		break;
> +	case Opt_snapdirgid:
> +		fsopt->snapdir_gid = make_kgid(current_user_ns(), result.uint_32);
> +		if (!gid_valid(fsopt->snapdir_gid))
> +			return invalfc(fc, "Invalid snapdirgid");
> +		break;
>   	case Opt_mds_namespace:
>   		if (!namespace_equals(fsopt, param->string, strlen(param->string)))
>   			return invalfc(fc, "Mismatching mds_namespace");
> @@ -734,6 +756,14 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
>   		seq_printf(m, ",readdir_max_bytes=%u", fsopt->max_readdir_bytes);
>   	if (strcmp(fsopt->snapdir_name, CEPH_SNAPDIRNAME_DEFAULT))
>   		seq_show_option(m, "snapdirname", fsopt->snapdir_name);
> +	if (fsopt->snapdir_mode != (umode_t)-1)
> +		seq_printf(m, ",snapdirmode=%o", fsopt->snapdir_mode);
> +	if (!uid_eq(fsopt->snapdir_uid, INVALID_UID))
> +		seq_printf(m, ",snapdiruid=%o",
> +			   from_kuid_munged(&init_user_ns, fsopt->snapdir_uid));
> +	if (!gid_eq(fsopt->snapdir_gid, INVALID_GID))
> +		seq_printf(m, ",snapdirgid=%o",
> +			   from_kgid_munged(&init_user_ns, fsopt->snapdir_gid));
>   
>   	return 0;
>   }
> @@ -1335,6 +1365,9 @@ static int ceph_init_fs_context(struct fs_context *fc)
>   	fsopt->wsize = CEPH_MAX_WRITE_SIZE;
>   	fsopt->rsize = CEPH_MAX_READ_SIZE;
>   	fsopt->rasize = CEPH_RASIZE_DEFAULT;
> +	fsopt->snapdir_mode = (umode_t)-1;
> +	fsopt->snapdir_uid = INVALID_UID;
> +	fsopt->snapdir_gid = INVALID_GID;
>   	fsopt->snapdir_name = kstrdup(CEPH_SNAPDIRNAME_DEFAULT, GFP_KERNEL);
>   	if (!fsopt->snapdir_name)
>   		goto nomem;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index d44a366b2f1b..3c930816078d 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -85,6 +85,10 @@ struct ceph_mount_options {
>   	unsigned int max_readdir;       /* max readdir result (entries) */
>   	unsigned int max_readdir_bytes; /* max readdir result (bytes) */
>   
> +	umode_t snapdir_mode;
> +	kuid_t snapdir_uid;
> +	kgid_t snapdir_gid;
> +
>   	bool new_dev_syntax;
>   
>   	/*

