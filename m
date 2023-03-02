Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03E6A8C51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 23:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCBW4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 17:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCBW4g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:56:36 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD58A559DE;
        Thu,  2 Mar 2023 14:56:33 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 419E23F301;
        Thu,  2 Mar 2023 22:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677797788;
        bh=7bAi7GvlLZqPDpdIMXt0Yd4XZ6qIgEVOlEjLpx+UniI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=JF0zItZu8a/QA+CEzhwTb0M4jJwxjdquCHP+lb8lwhiseRuxzR9VRYQcjbxN0cEe+
         qpMubuEgJq7A9WgWbB6zgOLQmiINIic57ynnFeUgSvCLcaSpVRWhVs1LYZgR8+c0u4
         4KWrQCKMwTF88x75z/mwqtccDRh/bRWkB3VAy0yh8oGLxxsaubAcybs6qs2lguX0L4
         LuSMDcJ4GhQL+lnM9+88jmrIQ1ajtPOwfpYpMnmg5Q9o4jngcYL/gqSDtViaaWR+NW
         QYgrY1PTAGS0HHLxZYM+E9YEC4J36i31Sm+Q8e9V8CQ3fRQyyeQEzVY+BrGofC8oTj
         tVOvO6YAWFmvA==
Message-ID: <e97bf2c2-6879-de79-1e07-276bc2192d6e@canonical.com>
Date:   Thu, 2 Mar 2023 14:56:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 02/11] proc_sysctl: move helper which creates required
 subdirectories
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, ebiederm@xmission.com,
        keescook@chromium.org, yzaikin@google.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        ebiggers@kernel.org, tytso@mit.edu, guoren@kernel.org
Cc:     j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230302202826.776286-1-mcgrof@kernel.org>
 <20230302202826.776286-3-mcgrof@kernel.org>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230302202826.776286-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/2/23 12:28, Luis Chamberlain wrote:
> Move the code which creates the subdirectories for a ctl table
> into a helper routine so to make it easier to review. Document
> the goal.
> 
> This creates no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   fs/proc/proc_sysctl.c | 56 ++++++++++++++++++++++++-------------------
>   1 file changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 1df0beb50dbe..6b9b2694d430 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1283,6 +1283,35 @@ static int insert_links(struct ctl_table_header *head)
>   	return err;
>   }
>   
> +/* Find the directory for the ctl_table. If one is not found create it. */
> +static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
> +{
> +	const char *name, *nextname;
> +
> +	for (name = path; name; name = nextname) {
> +		int namelen;
> +		nextname = strchr(name, '/');
> +		if (nextname) {
> +			namelen = nextname - name;
> +			nextname++;
> +		} else {
> +			namelen = strlen(name);
> +		}
> +		if (namelen == 0)
> +			continue;
> +
> +		/*
> +		 * namelen ensures if name is "foo/bar/yay" only foo is
> +		 * registered first. We traverse as if using mkdir -p and
> +		 * return a ctl_dir for the last directory entry.
> +		 */
> +		dir = get_subdir(dir, name, namelen);
> +		if (IS_ERR(dir))
> +			break;
> +	}
> +	return dir;
> +}
> +
>   /**
>    * __register_sysctl_table - register a leaf sysctl table
>    * @set: Sysctl tree to register on
> @@ -1334,7 +1363,6 @@ struct ctl_table_header *__register_sysctl_table(
>   {
>   	struct ctl_table_root *root = set->dir.header.root;
>   	struct ctl_table_header *header;
> -	const char *name, *nextname;
>   	struct ctl_dir *dir;
>   	struct ctl_table *entry;
>   	struct ctl_node *node;
> @@ -1359,29 +1387,9 @@ struct ctl_table_header *__register_sysctl_table(
>   	dir->header.nreg++;
>   	spin_unlock(&sysctl_lock);
>   
> -	/* Find the directory for the ctl_table */
> -	for (name = path; name; name = nextname) {
> -		int namelen;
> -		nextname = strchr(name, '/');
> -		if (nextname) {
> -			namelen = nextname - name;
> -			nextname++;
> -		} else {
> -			namelen = strlen(name);
> -		}
> -		if (namelen == 0)
> -			continue;
> -
> -		/*
> -		 * namelen ensures if name is "foo/bar/yay" only foo is
> -		 * registered first. We traverse as if using mkdir -p and
> -		 * return a ctl_dir for the last directory entry.
> -		 */
> -		dir = get_subdir(dir, name, namelen);
> -		if (IS_ERR(dir))
> -			goto fail;
> -	}
> -
> +	dir = sysctl_mkdir_p(dir, path);
> +	if (IS_ERR(dir))
> +		goto fail;
>   	spin_lock(&sysctl_lock);
>   	if (insert_header(dir, header))
>   		goto fail_put_dir_locked;

