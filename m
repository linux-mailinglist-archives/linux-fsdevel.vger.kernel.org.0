Return-Path: <linux-fsdevel+bounces-57610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE7CB23CE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 02:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A113BA8DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 00:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F85C2C0F94;
	Wed, 13 Aug 2025 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cZbBypAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC1163;
	Wed, 13 Aug 2025 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043281; cv=none; b=mhkrT0POOITMy7Gu4PJVSFZIihL428GpZxf7fqHP1BFe1ZRHlKG+NOOl1PU3b3j/qKJIc8xgL9cC5E5D48ONBlBJTkZuDDUg4X5a86yewpb/5OEH6M9VLqjJ92rWeMwfxfPlU4D2GA8q+a5fu+hX/RpLciyDblC2MVfvK2TRBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043281; c=relaxed/simple;
	bh=j4r1hppquktqtYidrhW4W0wl7fe8offrZaopf6cG3G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhfPFzbd/82yY6tDiLtDkCoR7YhAWEwQrRxkDreopdzzoi0J1d4SylvlE5o7NqN3auxnljo8eqCfyHWmlhj72qisNVPuhDCpMMYThw/dyZDS0GEt7InEtiR8bjf0hsm3TXNvSlPAS4bcWMDa1WdRhGzCE0i8V3omEqwBZBEpvC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cZbBypAr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j4r1hppquktqtYidrhW4W0wl7fe8offrZaopf6cG3G0=; b=cZbBypArsAwEupU5gvJSbx81kI
	Qosd5QsgwcTBqjCvjrl9+522yt1DsRHkxW3rP4QAtNBLuPkNqySvn9xNhx4W8UKAuQRjCZFER9Q+q
	OU7f9ZV2fnoJgxNmuLvs+ROm2HQIttuS7sdzJM4TKl8JXUJt7kHFJ0HzLbIvH539ChpirDHa95hk0
	0jIldmck0numN0slLAIZ1NO2d/wYZ2QGgElgnPrudAOXVUCPogdbljQ+lo4cAZuF/fAYQ7+h58qa0
	Y+ivu7VmgfbRR4UATQ5PHl9u0DWkjAMVf4kUbfjIu4pzP85eSzA7U8m0V2v8gQf19C/Fc36DoyW7p
	DX85i4rQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulyvN-00000003Gyx-2z1h;
	Wed, 13 Aug 2025 00:01:01 +0000
Date: Wed, 13 Aug 2025 01:01:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] VFS: prepare for changes to directory locking
Message-ID: <20250813000101.GW222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-1-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 12:25:03PM +1000, NeilBrown wrote:
> This is the first of 3 sets of patches which, together, allow
> filesystems to opt-out of having the directory inode lock held over
> directory operations (except readdir).

[just a quick reply for now - I'm going to be away for about an hour,
then will review and reply]

