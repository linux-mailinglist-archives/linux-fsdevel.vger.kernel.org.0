Return-Path: <linux-fsdevel+bounces-66425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD26C1E8BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 07:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CA73BB429
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 06:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D132572E;
	Thu, 30 Oct 2025 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tHaRpogp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640142BE7CD;
	Thu, 30 Oct 2025 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761805465; cv=none; b=oLCn/Kr2YrvJ4FnHZ6YZLIbZlebu4HzhnYcp3Qv06dob64MJP4raW3OWQ38qONkAjz+58koFZo+EslfIttd58T8YYsvfgJzvxUmJGEynYZ4LZgf5Ybl4PQACPWSxiiMMWiARiLkl6ZGBt1L+a7MnFSjpplKjALtBytF2xzARNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761805465; c=relaxed/simple;
	bh=6ZbflJkG3X9g3r880e4radul4Mz1Y0GMGOn08GlO9cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA/7OWQULcVHKw7sLzF9IkJACvjmTr1dIjQM5ICebwTKr65jVnpYqrc5q6+XDuk/hFa3G1yjos/PeZzhMLW8O7WbOt7vow7zggS92M+PYeT4te0pgj4BKvsOFEdVwI5NW7T21EMGF6llNSwtFhjqRk6kzFOwXL6AluTqGCm87J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tHaRpogp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2o4fP7/qPdDmNhS4uzPUYDyvsGd6WoXP2VggTW0el8w=; b=tHaRpogpBdp7+I1+zeafpFRSxG
	kg3sb/+JxLgdtSbCLYvpOr2JnAkLeBr0wzwX/LPbhcAva+z1b24EhyCGgJg834obEFlob1H91ngo1
	GZOHv69SQnmSY8WG4Ji/OypavgrYdbO30JJEgAeyrnDDP+Lh2fbHLQtJCb5xTsMGOgUxDph260Dxl
	tyrD/uzNKb+ABW1iliV4CMVN3YyibSdIUzD+sKLaBOC9dK2NS21TwNqH1fpazGp4VS4/BHsODqU2z
	JaSkFiqJM5mTApgZB5+Ys023clXRczl9cOMvroMoFVrW2AYjpCivwOb0L8zYJdDXYHB/+UfqAK5JM
	gjX/mk+Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEM56-0000000909w-0QYX;
	Thu, 30 Oct 2025 06:24:20 +0000
Date: Thu, 30 Oct 2025 06:24:20 +0000
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
Subject: Re: [PATCH v4 12/14] ecryptfs: use new start_creating/start_removing
 APIs
Message-ID: <20251030062420.GX2441659@ZenIV>
References: <20251029234353.1321957-1-neilb@ownmail.net>
 <20251029234353.1321957-13-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029234353.1321957-13-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Oct 30, 2025 at 10:31:12AM +1100, NeilBrown wrote:

> +static struct dentry *ecryptfs_start_creating_dentry(struct dentry *dentry)
>  {
> -	struct dentry *lower_dir_dentry;
> +	struct dentry *parent = dget_parent(dentry->d_parent);

"Grab the reference to grandparent"?

