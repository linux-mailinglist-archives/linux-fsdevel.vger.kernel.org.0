Return-Path: <linux-fsdevel+bounces-57629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D03B23FBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A73564239
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697E28DF34;
	Wed, 13 Aug 2025 04:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fXl1pxUq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88D322E;
	Wed, 13 Aug 2025 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059805; cv=none; b=GcaHme9XgPmY+doOwNCnDjv8LDnDsioUZMwehekunTQkso0ZAboe4nX1BPP3XTfgUw6lPmSSVWfy8iL+6OqqWZ1yY55aYEf/cURmR4Cu4+/pzGCg0DSWRMNLXqFHBxjskY+BawEiVrzP7GVw9/yZdbEOl1hq5M3sPt/tIWhG1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059805; c=relaxed/simple;
	bh=V/zrVpiwIgI5Rc5VbGatDXAdC0iqPQlPJkXXUZr+VIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjTkNv1013UHvKp53FOunw0XW0cIQl7r/Oekr73/EAd11qigF9UfNdG+TErobvg20MLtAFh5SZdOonxmaTrkVhEUAJToOZm/FGVG2UDTL2HBXzU26J8MLZN/I1d3B2kK6HOhIfi9eJ8ebXbKlkRP4ZAfAjwt2eTIaEq4WHe25NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fXl1pxUq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u67lLptIlOEVkxY+UQlg96GCCWG+NT0y06EWpooB788=; b=fXl1pxUqejYMr0pZigsVgjV9dO
	UVRUzITj4tWVCcrNPDrkv4fTBmHF5mrwx5dch9Q+Ly2ivOfzIAFPHMN7920ewFr+J1eIX/OzkFBmK
	Hkjt7ZZC2jPRWuF/98XqkLo0757agn67cEXeqZP2Hch2garqdZZZX3PMzDoRGIObmtAGoM9478kxa
	6esiN9Rhmuto6ThcBOjGN922Nic67jJ05CTrlwOIjQPch+Xb9Sh1Al2CrP+iAsOGCZxAv9IfanyyS
	hOqkxPjiR4r4598Kg1FaoBYFzrtKo3QyBiuefL1CG4Ljecm6yZ11F86Xu7Ho9Vo1ICMHc8yI83LFJ
	CwF4v1sw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3E3-00000005em9-26h8;
	Wed, 13 Aug 2025 04:36:35 +0000
Date: Wed, 13 Aug 2025 05:36:35 +0100
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
Subject: Re: [PATCH 06/11] VFS: unify old_mnt_idmap and new_mnt_idmap in
 renamedata
Message-ID: <20250813043635.GC222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-7-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-7-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 12:25:09PM +1000, NeilBrown wrote:
> A rename can only rename with a single mount.  Callers of vfs_rename()
> must and do ensure this is the case.
> 
> So there is no point in having two mnt_idmaps in renamedata as they are
> always the same.  Only of of them is passed to ->rename in any case.
> 
> This patch replaces both with a single "mnt_idmap" and changes all
> callers.

Looks sane and IMO should be reordered in front of the queue.

