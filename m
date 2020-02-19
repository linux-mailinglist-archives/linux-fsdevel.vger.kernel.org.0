Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B081644B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 13:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgBSM5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 07:57:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58916 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgBSM5W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:57:22 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j4OuQ-0005I0-25; Wed, 19 Feb 2020 12:56:58 +0000
Date:   Wed, 19 Feb 2020 13:56:57 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
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
Message-ID: <20200219125657.qzlj47rqfwdlmyzb@wittgenstein>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <20200218143411.2389182-16-christian.brauner@ubuntu.com>
 <20200218222631.GB9535@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200218222631.GB9535@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 02:26:31PM -0800, Christoph Hellwig wrote:
> On Tue, Feb 18, 2020 at 03:34:01PM +0100, Christian Brauner wrote:
> > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > index 249672bf54fe..ed6112c9b804 100644
> > --- a/fs/posix_acl.c
> > +++ b/fs/posix_acl.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/xattr.h>
> >  #include <linux/export.h>
> >  #include <linux/user_namespace.h>
> > +#include <linux/fsuidgid.h>
> >  
> >  static struct posix_acl **acl_by_type(struct inode *inode, int type)
> >  {
> > @@ -692,12 +693,12 @@ static void posix_acl_fix_xattr_userns(
> >  	for (end = entry + count; entry != end; entry++) {
> >  		switch(le16_to_cpu(entry->e_tag)) {
> >  		case ACL_USER:
> > -			uid = make_kuid(from, le32_to_cpu(entry->e_id));
> > -			entry->e_id = cpu_to_le32(from_kuid(to, uid));
> > +			uid = make_kfsuid(from, le32_to_cpu(entry->e_id));
> > +			entry->e_id = cpu_to_le32(from_kfsuid(to, uid));
> >  			break;
> >  		case ACL_GROUP:
> > -			gid = make_kgid(from, le32_to_cpu(entry->e_id));
> > -			entry->e_id = cpu_to_le32(from_kgid(to, gid));
> > +			gid = make_kfsgid(from, le32_to_cpu(entry->e_id));
> > +			entry->e_id = cpu_to_le32(from_kfsgid(to, gid));
> >  			break;
> 
> Before we touch this code any more it needs to move to the right place.
> Poking into ACLs from generic xattr code is a complete layering

git history shows that it was deliberately placed after the fs specific
xattr handlers have been called so individual filesystems don't need to
be aware of id mappings to make maintenance easier. Same goes for vfs
capabilities. Moving this down into individual filesystem seems like a
maintenance nightmare where now each individual filesystem will have to
remember to fixup their ids. For namespaced vfs caps which are handled
at the same level in setxattr() it will also mean breaking backwards
compatible translation from non-namespaced vfs caps aware userspace to
namespaced vfs-caps aware kernels.
