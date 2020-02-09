Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49FA15686A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2020 03:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgBICkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Feb 2020 21:40:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52937 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727559AbgBICkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Feb 2020 21:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581216020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzDNgMt0N2Sy/UKMxLpoURiDMIFc5sxmCdbhq0zZ1ws=;
        b=WF9xSVuo8vS82ybwDxfb6J9pRBx9m2u+ThDpMQ/onxYGW3KOSIbzhlAAhELlxRB3hi0N7z
        YTIAH5IPaTM28GJHN0mD6zNembmYgNQiIV9ABsl9OIQW2jkgNWcWtkF7esNtaaqUetnZho
        GeA1wPZLZrO9vn8JDiAFMnn0Z4gp50A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-367GgXrXOP6ZzaNIqb0BeQ-1; Sat, 08 Feb 2020 21:40:15 -0500
X-MC-Unique: 367GgXrXOP6ZzaNIqb0BeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69BA7800D54;
        Sun,  9 Feb 2020 02:40:14 +0000 (UTC)
Received: from [10.72.12.34] (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7D1A60BE2;
        Sun,  9 Feb 2020 02:40:11 +0000 (UTC)
Subject: Re: [PATCH] ceph: fix allocation under spinlock in mount option
 parsing
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        idryomov@gmail.com, viro@zeniv.linux.org.uk
References: <20200207214948.1073419-1-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <898afc40-88b9-f670-b7fd-a31bf03f7601@redhat.com>
Date:   Sun, 9 Feb 2020 10:40:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207214948.1073419-1-jlayton@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/2/8 5:49, Jeff Layton wrote:
> Al and syzbot reported that 4fbc0c711b24 (ceph: remove the extra slashes
> in the server path) had caused a regression where an allocation could be
> done under spinlock.
>
> Fix this by keeping a canonicalized version of the path in the mount
> options. Then we can simply compare those without making copies at all
> during the comparison.
>
> Fixes: 4fbc0c711b24 ("ceph: remove the extra slashes in the server path")
> Reported-by: syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/super.c | 170 ++++++++++++++++++++++--------------------------
>   fs/ceph/super.h |   1 +
>   2 files changed, 79 insertions(+), 92 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 5fa28e98d2b8..196d547c7054 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -208,6 +208,69 @@ struct ceph_parse_opts_ctx {
>   	struct ceph_mount_options	*opts;
>   };
>   
> +/**
> + * canonicalize_path - Remove the extra slashes in the server path
> + * @server_path: the server path and could be NULL
> + *
> + * Return NULL if the path is NULL or only consists of "/", or a string
> + * without any extra slashes including the leading slash(es) and the
> + * slash(es) at the end of the server path, such as:
> + * "//dir1////dir2///" --> "dir1/dir2"
> + */
> +static char *canonicalize_path(const char *server_path)
> +{
> +	const char *path = server_path;
> +	const char *cur, *end;
> +	char *buf, *p;
> +	int len;
> +
> +	/* remove all the leading slashes */
> +	while (*path == '/')
> +		path++;
> +
> +	/* if the server path only consists of slashes */
> +	if (*path == '\0')
> +		return NULL;
> +
> +	len = strlen(path);
> +
> +	buf = kmalloc(len + 1, GFP_KERNEL);
> +	if (!buf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	end = path + len;
> +	p = buf;
> +	do {
> +		cur = strchr(path, '/');
> +		if (!cur)
> +			cur = end;
> +
> +		len = cur - path;
> +
> +		/* including one '/' */
> +		if (cur != end)
> +			len += 1;
> +
> +		memcpy(p, path, len);
> +		p += len;
> +
> +		while (cur <= end && *cur == '/')
> +			cur++;
> +		path = cur;
> +	} while (path < end);
> +
> +	*p = '\0';
> +
> +	/*
> +	 * remove the last slash if there has and just to make sure that
> +	 * we will get something like "dir1/dir2"
> +	 */
> +	if (*(--p) == '/')
> +		*p = '\0';
> +
> +	return buf;
> +}
> +
>   /*
>    * Parse the source parameter.  Distinguish the server list from the path.
>    *
> @@ -230,15 +293,23 @@ static int ceph_parse_source(struct fs_parameter *param, struct fs_context *fc)
>   
>   	dev_name_end = strchr(dev_name, '/');
>   	if (dev_name_end) {
> -		kfree(fsopt->server_path);
>   
>   		/*
>   		 * The server_path will include the whole chars from userland
>   		 * including the leading '/'.
>   		 */
> +		kfree(fsopt->server_path);
>   		fsopt->server_path = kstrdup(dev_name_end, GFP_KERNEL);
>   		if (!fsopt->server_path)
>   			return -ENOMEM;
> +
> +		kfree(fsopt->canon_path);
> +		fsopt->canon_path = canonicalize_path(fsopt->server_path);
> +		if (fsopt->canon_path && IS_ERR(fsopt->canon_path)) {
> +			ret = PTR_ERR(fsopt->canon_path);
> +			fsopt->canon_path = NULL;
> +			return ret;
> +		}
>   	} else {
>   		dev_name_end = dev_name + strlen(dev_name);
>   	}
> @@ -447,6 +518,7 @@ static void destroy_mount_options(struct ceph_mount_options *args)
>   	kfree(args->snapdir_name);
>   	kfree(args->mds_namespace);
>   	kfree(args->server_path);
> +	kfree(args->canon_path);
>   	kfree(args->fscache_uniq);
>   	kfree(args);
>   }
> @@ -462,73 +534,6 @@ static int strcmp_null(const char *s1, const char *s2)
>   	return strcmp(s1, s2);
>   }
>   
> -/**
> - * path_remove_extra_slash - Remove the extra slashes in the server path
> - * @server_path: the server path and could be NULL
> - *
> - * Return NULL if the path is NULL or only consists of "/", or a string
> - * without any extra slashes including the leading slash(es) and the
> - * slash(es) at the end of the server path, such as:
> - * "//dir1////dir2///" --> "dir1/dir2"
> - */
> -static char *path_remove_extra_slash(const char *server_path)
> -{
> -	const char *path = server_path;
> -	const char *cur, *end;
> -	char *buf, *p;
> -	int len;
> -
> -	/* if the server path is omitted */
> -	if (!path)
> -		return NULL;
> -
> -	/* remove all the leading slashes */
> -	while (*path == '/')
> -		path++;
> -
> -	/* if the server path only consists of slashes */
> -	if (*path == '\0')
> -		return NULL;
> -
> -	len = strlen(path);
> -
> -	buf = kmalloc(len + 1, GFP_KERNEL);
> -	if (!buf)
> -		return ERR_PTR(-ENOMEM);
> -
> -	end = path + len;
> -	p = buf;
> -	do {
> -		cur = strchr(path, '/');
> -		if (!cur)
> -			cur = end;
> -
> -		len = cur - path;
> -
> -		/* including one '/' */
> -		if (cur != end)
> -			len += 1;
> -
> -		memcpy(p, path, len);
> -		p += len;
> -
> -		while (cur <= end && *cur == '/')
> -			cur++;
> -		path = cur;
> -	} while (path < end);
> -
> -	*p = '\0';
> -
> -	/*
> -	 * remove the last slash if there has and just to make sure that
> -	 * we will get something like "dir1/dir2"
> -	 */
> -	if (*(--p) == '/')
> -		*p = '\0';
> -
> -	return buf;
> -}
> -
>   static int compare_mount_options(struct ceph_mount_options *new_fsopt,
>   				 struct ceph_options *new_opt,
>   				 struct ceph_fs_client *fsc)
> @@ -536,7 +541,6 @@ static int compare_mount_options(struct ceph_mount_options *new_fsopt,
>   	struct ceph_mount_options *fsopt1 = new_fsopt;
>   	struct ceph_mount_options *fsopt2 = fsc->mount_options;
>   	int ofs = offsetof(struct ceph_mount_options, snapdir_name);
> -	char *p1, *p2;
>   	int ret;
>   
>   	ret = memcmp(fsopt1, fsopt2, ofs);
> @@ -546,21 +550,12 @@ static int compare_mount_options(struct ceph_mount_options *new_fsopt,
>   	ret = strcmp_null(fsopt1->snapdir_name, fsopt2->snapdir_name);
>   	if (ret)
>   		return ret;
> +
>   	ret = strcmp_null(fsopt1->mds_namespace, fsopt2->mds_namespace);
>   	if (ret)
>   		return ret;
>   
> -	p1 = path_remove_extra_slash(fsopt1->server_path);
> -	if (IS_ERR(p1))
> -		return PTR_ERR(p1);
> -	p2 = path_remove_extra_slash(fsopt2->server_path);
> -	if (IS_ERR(p2)) {
> -		kfree(p1);
> -		return PTR_ERR(p2);
> -	}
> -	ret = strcmp_null(p1, p2);
> -	kfree(p1);
> -	kfree(p2);
> +	ret = strcmp_null(fsopt1->canon_path, fsopt2->canon_path);
>   	if (ret)
>   		return ret;
>   
> @@ -963,7 +958,9 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
>   	mutex_lock(&fsc->client->mount_mutex);
>   
>   	if (!fsc->sb->s_root) {
> -		const char *path, *p;
> +		const char *path = fsc->mount_options->canon_path ?
> +					fsc->mount_options->canon_path : "";
> +
>   		err = __ceph_open_session(fsc->client, started);
>   		if (err < 0)
>   			goto out;
> @@ -975,22 +972,11 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
>   				goto out;
>   		}
>   
> -		p = path_remove_extra_slash(fsc->mount_options->server_path);
> -		if (IS_ERR(p)) {
> -			err = PTR_ERR(p);
> -			goto out;
> -		}
> -		/* if the server path is omitted or just consists of '/' */
> -		if (!p)
> -			path = "";
> -		else
> -			path = p;
>   		dout("mount opening path '%s'\n", path);
>   
>   		ceph_fs_debugfs_init(fsc);
>   
>   		root = open_root_dentry(fsc, path, started);
> -		kfree(p);
>   		if (IS_ERR(root)) {
>   			err = PTR_ERR(root);
>   			goto out;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index e8f891770f9d..70aa32cfb64d 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -94,6 +94,7 @@ struct ceph_mount_options {
>   	char *snapdir_name;   /* default ".snap" */
>   	char *mds_namespace;  /* default NULL */
>   	char *server_path;    /* default  "/" */
> +	char *canon_path;     /* default "/" */
>   	char *fscache_uniq;   /* default NULL */
>   };
>   

This looks good to me.

Thanks.

BRs



