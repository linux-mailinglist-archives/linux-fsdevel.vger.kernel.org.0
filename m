Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14E4163616
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 23:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgBRW0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 17:26:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgBRW0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eHa75jjK7tbUuErtO3G7nDpZI0D8u2i7RzDZ3Fa/mSQ=; b=dS5irFAO/VhYF4UgVQoLT0B9O6
        MPBORZ5xrN/aS26lKpicm7lsfmaZEgK7qANlYypTZI/HpdFjldeBJ4aM0/EnZAA3dj8Vwu+qQid+r
        FPq1TmKLYaDObZEBGGMF1Pre4M7hYA2wZnviMARe43CWRTOzm4OD1DK3DFT2hNuqQKcILTTWOrT/p
        pHACZcmDalugA5C0kKEPIDuKQeTySqkBFM7N/17CrsZOtcfqDWEhfoBTYdi0Rdxb1c/y41yFrpImK
        LtOG+hBNetGPMvosrbIR3WVLMWVdbz6tkMHUtl3eI/LPdNifpqQGPcHDkKcSQk+jGtYdGOpUi7hvM
        4ujvVuSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4BK3-0003xA-Uu; Tue, 18 Feb 2020 22:26:31 +0000
Date:   Tue, 18 Feb 2020 14:26:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 15/25] posix_acl: handle fsid mappings
Message-ID: <20200218222631.GB9535@infradead.org>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <20200218143411.2389182-16-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218143411.2389182-16-christian.brauner@ubuntu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 03:34:01PM +0100, Christian Brauner wrote:
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 249672bf54fe..ed6112c9b804 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -22,6 +22,7 @@
>  #include <linux/xattr.h>
>  #include <linux/export.h>
>  #include <linux/user_namespace.h>
> +#include <linux/fsuidgid.h>
>  
>  static struct posix_acl **acl_by_type(struct inode *inode, int type)
>  {
> @@ -692,12 +693,12 @@ static void posix_acl_fix_xattr_userns(
>  	for (end = entry + count; entry != end; entry++) {
>  		switch(le16_to_cpu(entry->e_tag)) {
>  		case ACL_USER:
> -			uid = make_kuid(from, le32_to_cpu(entry->e_id));
> -			entry->e_id = cpu_to_le32(from_kuid(to, uid));
> +			uid = make_kfsuid(from, le32_to_cpu(entry->e_id));
> +			entry->e_id = cpu_to_le32(from_kfsuid(to, uid));
>  			break;
>  		case ACL_GROUP:
> -			gid = make_kgid(from, le32_to_cpu(entry->e_id));
> -			entry->e_id = cpu_to_le32(from_kgid(to, gid));
> +			gid = make_kfsgid(from, le32_to_cpu(entry->e_id));
> +			entry->e_id = cpu_to_le32(from_kfsgid(to, gid));
>  			break;

Before we touch this code any more it needs to move to the right place.
Poking into ACLs from generic xattr code is a complete layering
violation, and all this needs to be moved so that it is called by
the actual handlers called from the file systems.
