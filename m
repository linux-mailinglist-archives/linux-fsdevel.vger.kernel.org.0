Return-Path: <linux-fsdevel+bounces-8153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7788305ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 13:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F53289E90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 12:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8AB1EA90;
	Wed, 17 Jan 2024 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZm/mRIW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F71DFDF;
	Wed, 17 Jan 2024 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495739; cv=none; b=PlmxOk15Ed/FIT/UcXFw89roYHS+6e9mUlaQNXvwuj5v6KnFmTuX3wfk6g6wo3wzEEK9fiJsnWR0+m4rPC8wLNBYN5LycCB1JtVCS2+5aTyk/uvyX9F1YGEfDMlhmFAkutWkE+ovZi6p4rBKsCjeYmmaObk5+jlOE6GWpqlRgCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495739; c=relaxed/simple;
	bh=wejZpnzi/xwTeuwzEhPmR77lS9Cix9wdR/4gBE+QuZs=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=eXr7Z1TN/jPqN0wWCzE/HecgmOCy4cUHyCTnjuc5je0RkRqhu2vtMGhXfcjvnvSfnHuZQRzpqt7HY10UTcVmnhcib359wr1vmNZoVU2xslyKZ/klQ1Tj4eLZxBjhU45a2ePH4TK2mFv0Bldlwd48s4NHNImy9ELmxVB05rFJzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZm/mRIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30278C433F1;
	Wed, 17 Jan 2024 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705495738;
	bh=wejZpnzi/xwTeuwzEhPmR77lS9Cix9wdR/4gBE+QuZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZm/mRIWdMskF94PCgIsY7p9+Sc6+On2KL0u/wosBIwSUloPXk49taQQPNw9fwRvS
	 joMbL9QNr9G2yHgrD0aMpr95fwC5klEyHkGUTsnETHnKZQt4DpSauAdVY4VETJFseQ
	 1LEaR8YI2DbtwqY2whquDY7wU4WtcW0kXMUy4B9Rc51jx1EYHddsbFzFVFyGyMqNeU
	 A6/sbvWc4u7yx34KP8osvXNwud8ROvCqmvNqUyslQ1iXbu3GtBIqshmwH7Du4VjQ6E
	 aABO+5cGSxZ/8kywXYgkHAsVsKfNlzOBCHaxpvE5hWi2vhnOzf1X+H3yegq8x4Ko3y
	 Joa6J3TeBXRRg==
Date: Wed, 17 Jan 2024 13:48:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Jan Kara <jack@suse.cz>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] filelock: split struct file_lock into file_lock
 and file_lease structs
Message-ID: <20240117-wichtel-rennmaschine-d2d9174192be@brauner>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>

> I'd like to have this considered for inclusion in v6.9. Christian, would
> you be amenable to shepherding this into mainline (assuming there are no
> major objections, of course)?

Yes, of course I will be happy to.

