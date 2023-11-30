Return-Path: <linux-fsdevel+bounces-4423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3617FF658
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158742809A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C5954FB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/ylpSyc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB9524C9;
	Thu, 30 Nov 2023 15:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED53FC433C7;
	Thu, 30 Nov 2023 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701358597;
	bh=IuyTo/SqtMXTfOfDJB4gGYsTQYZhhJVyRktybDYXRIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/ylpSyc9vHCYJYK+PI9TH6o4AxCANtjq/SDm3RtWDQZJMymqlXqGtI6x1aMB+nXo
	 WN96cL2pW6gCjBvM5V2Yu39UXl85WEQo4uCLYALsmBBONAdr0uIFrzGRwF7FY/bZYd
	 RqjrYpP7XHCKvQWSOBmZTNIvnWaJrYPCRQwoNNgumOsi4UYuuXlWjfYGeuvdiJO+Lu
	 /Ft+F55LVl7YM+uIRFL/tDCuvDTf9i9etnhDGU7AmnVlqZkPidlAIkCWGqdYacdaAK
	 RO7YwB9+n7gRsChyBLHoRDaxmG3BhCPwiseVd1svwlCmEzsKiCg3LxWrE7Yq0SsHAI
	 huqcdUxGNgbRQ==
Date: Thu, 30 Nov 2023 09:36:35 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	James Morris <jmorris@namei.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 07/16] fs: add inode operations to get/set/remove fscaps
Message-ID: <ZWisA4miKciDEhE6@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>
 <CAOQ4uxiz+ng5qEY4qkE_q8Gv3jrd6b7mZnppkDoJthhD+Ud4Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiz+ng5qEY4qkE_q8Gv3jrd6b7mZnppkDoJthhD+Ud4Ow@mail.gmail.com>

On Thu, Nov 30, 2023 at 07:32:19AM +0200, Amir Goldstein wrote:
> On Wed, Nov 29, 2023 at 11:51 PM Seth Forshee (DigitalOcean)
> <sforshee@kernel.org> wrote:
> >
> > Add inode operations for getting, setting and removing filesystem
> > capabilities rather than passing around raw xattr data. This provides
> > better type safety for ids contained within xattrs.
> >
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  include/linux/fs.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 98b7a7a8c42e..a0a77f67b999 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2002,6 +2002,11 @@ struct inode_operations {
> >                                      int);
> >         int (*set_acl)(struct mnt_idmap *, struct dentry *,
> >                        struct posix_acl *, int);
> > +       int (*get_fscaps)(struct mnt_idmap *, struct dentry *,
> > +                         struct vfs_caps *);
> > +       int (*set_fscaps)(struct mnt_idmap *, struct dentry *,
> > +                         const struct vfs_caps *, int flags);
> > +       int (*remove_fscaps)(struct mnt_idmap *, struct dentry *);
> >         int (*fileattr_set)(struct mnt_idmap *idmap,
> >                             struct dentry *dentry, struct fileattr *fa);
> >         int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
> >
> 
> Please document in Documentation/filesystems/{vfs,locking}.rst

Done for v2.

