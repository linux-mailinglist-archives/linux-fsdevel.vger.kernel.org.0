Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1BF3B6430
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhF1PGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 11:06:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236827AbhF1PCx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624892427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYIioG++QRuHj5/A/t8rYhiPdsWtXhKaqCTP+4SdbRk=;
        b=VBacZZaNgbG/OAEpL/h918/28tt6t42wCAKQRnktzSzy0f0puAyBSl+VzgHgtGn9mZeXtB
        oNCF3H9Jgbqe7Ep8sKilRpwf8YfvpPXWFywuo+mqr6qDxS4Q+E+VcJfIfX4dGgYlDmDHaP
        vOsO39EgzqBPixKrm+CsJPIzaAWZL/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-saQIyEbDOPSFz7mRdJqEaQ-1; Mon, 28 Jun 2021 11:00:26 -0400
X-MC-Unique: saQIyEbDOPSFz7mRdJqEaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEF5C10B7472;
        Mon, 28 Jun 2021 15:00:24 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-225.rdu2.redhat.com [10.10.115.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DCB760875;
        Mon, 28 Jun 2021 15:00:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AE8AB22054F; Mon, 28 Jun 2021 11:00:20 -0400 (EDT)
Date:   Mon, 28 Jun 2021 11:00:20 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        berrange@redhat.com, oliver.sang@intel.com
Subject: Re: [PATCH 1/1] xattr: Allow user.* xattr on symlink/special files
 with CAP_SYS_RESOURCE
Message-ID: <20210628150020.GD1803896@redhat.com>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
 <20210625191229.1752531-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625191229.1752531-2-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 03:12:29PM -0400, Vivek Goyal wrote:
> As of now user.* xattrs are allowed only on regular files and directories.
> And in case of directories if sticky bit is set, then it is allowed
> only if caller is owner or has CAP_FOWNER.
> 
> "man xattr" suggests that primary reason behind this restrcition is that
> users can set unlimited amount of "user.*" xattrs on symlinks and special
> files and bypass quota checks. Following is from man page.
> 
> "These differences would allow users to consume filesystem resources  in
>  a  way not controllable by disk quotas for group or world writable spe‐
>  cial files and directories"
> 
> Capability CAP_SYS_RESOURCE allows for overriding disk quota limits. If
> being able to bypass quota is primary reason behind these restrictions,
> can we relax these restrictions if caller has CAP_SYS_RESOURCE.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Got an email from intel kernel test robot that xfstest generic/062 breaks
due to this change.

I think I will have to fix the test case because test is working with
previous behvior where "user.*" xattr will not be permitted on
non-regular/non-dir file. 

Thanks
Vivek

> ---
>  fs/xattr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 5c8c5175b385..10bb918029dd 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -124,7 +124,8 @@ xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
>  	 * extended attributes. For sticky directories, only the owner and
>  	 * privileged users can write attributes.
>  	 */
> -	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
> +	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
> +	    !capable(CAP_SYS_RESOURCE)) {
>  		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
>  			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
>  		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
> -- 
> 2.25.4
> 

