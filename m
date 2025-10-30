Return-Path: <linux-fsdevel+bounces-66423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F759C1E858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 07:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A881894891
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 06:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F4832E68E;
	Thu, 30 Oct 2025 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Xo7Ax7AU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7F632D0CB;
	Thu, 30 Oct 2025 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804733; cv=none; b=eAA0/u55WpYBLjvO8OMC/G6254Vf5RV9oL4gZuw78wLg/3coxYkRX8Ql88LwkZT8I6hV93T11dQStEMslC0DZvhivKeV65mZh2mr4nvXtzi2XzQ9j/84lXFcghf/xX6W+LOulY3r0lAfPwaf8JhN/EYlop4hpG6K+MvWjjZcIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804733; c=relaxed/simple;
	bh=EsXrQ5IQO5LjXAeM0LF7jgld/4t6zHLfvBf4hCIbEvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE6Bxc0+dv1vwESWaq5iDplKwRcUzh7VXCYvRyYYIrfhSEAmYUTI2B788DYTbgxPLpOlBotEIPRfnbRvFwnuRK1Uzh+JczYr88j3H+iwNyHNX1z5wut2Hqv0FjN9mK0xFMYLdkx2pv0qw1pUbxhSYsO5OWD51N27YDCSH/tdTLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Xo7Ax7AU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/BmhCV9rufXAtrnr0u46O1gC0ARwDi4lOsr3KRQzWXw=; b=Xo7Ax7AUQLBRpnVcsg4UXARQGf
	5w0Iik69yaZ4Le7AglC8QGef3ZBFVj8U7bvF9q9ur+IB+Am1L4iy5hnLR0GyLMhAfs7FkNCE2H8Dq
	kPPTfYYZXLldubyx0stjT/2ubwKlE9tCCpusXWwnNFL6EJ2G/7KG/cqxAxakqv333VlIQ7fKMFTiN
	T7rEH+ctrmUJbjA6/7sR/WC5LCLfEke2JlfcZZqg05BKbK25ynix5CA5RWfjY0LaLXT8G9Tpn/Uxq
	Zy+XQtMNlg7buCLCb90waCIosH0GoJT+YDoq1PKAhmzVenYp/WUdZ7KF13dNI+zd4eLiPwBXPQp4U
	jujpQofw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vELt9-00000008mUB-2sjF;
	Thu, 30 Oct 2025 06:11:59 +0000
Date: Thu, 30 Oct 2025 06:11:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v4 07/14] VFS: introduce start_removing_dentry()
Message-ID: <20251030061159.GV2441659@ZenIV>
References: <20251029234353.1321957-1-neilb@ownmail.net>
 <20251029234353.1321957-8-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029234353.1321957-8-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Oct 30, 2025 at 10:31:07AM +1100, NeilBrown wrote:

> @@ -428,11 +429,14 @@ static bool cachefiles_invalidate_cookie(struct fscache_cookie *cookie)
>  		if (!old_tmpfile) {
>  			struct cachefiles_volume *volume = object->volume;
>  			struct dentry *fan = volume->fanout[(u8)cookie->key_hash];
> -
> -			inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
> -			cachefiles_bury_object(volume->cache, object, fan,
> -					       old_file->f_path.dentry,
> -					       FSCACHE_OBJECT_INVALIDATED);
> +			struct dentry *obj;
> +
> +			obj = start_removing_dentry(fan, old_file->f_path.dentry);
> +			if (!IS_ERR(obj))
> +				cachefiles_bury_object(volume->cache, object,
> +						       fan, obj,
> +						       FSCACHE_OBJECT_INVALIDATED);
> +			end_removing(obj);

Huh?  Where did you change cachefiles_bury_object to *not* unlock the parent?
Not in this commit, AFAICS, and that means at least a bisection hazard around
here...

Confused...

