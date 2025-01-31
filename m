Return-Path: <linux-fsdevel+bounces-40466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E25A2396D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 06:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14F5167E68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 05:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED5E1487D1;
	Fri, 31 Jan 2025 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VEKQLkPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF392BB15;
	Fri, 31 Jan 2025 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738302758; cv=none; b=Ohp25FwGWzQE3W0Bd1pWU52sDjbhA2k5uUUnoQbqOzG/zutFQwfU7fL9RCuClv3l9aXzFZojJNo/+dbNHo/Vq1v8mXqnprZAYR7VMav9u0IoR/q2mzoaquPm1BWzSwswI9nDBV+ivJJMdy6KLxaY/tAG/vyKHfAWSt9g7qAe/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738302758; c=relaxed/simple;
	bh=jsAufOypY4+CND/oEdprhwzj0AePJlafWUKjr3HHNUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJE43qyHt/GrWk8WCVU+H3559KbT8qoVC0DgYsN14pEdH/dhgUa7F7n38TAhCr1bLQtfGmeteBFLNKBmxd6ymdIyDE5J6d+w2e3Y/6niTr86y0lwtDel3DQDNxzPJCDt7TWHFbg8fn8BEagzzTkB+9vsGqA7p2lKOg5CP79brvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VEKQLkPM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YP7Ph251aPlz8ytKTvX8+YWjsU796xkIpvw7rMOPVoM=; b=VEKQLkPM+28nERb05FgDMiZ9t0
	Vq9jD6kOUwNCScSLNf7ys9OrwYSkclFy73YinxXmMGm5QO4QZ85nevcKGzo4rHnq/tjXoU/A+ch9K
	jCl7fwagIWsjNVAWSxOsHotmLJviLqbs6q+MgSMr3DEux1ycgXD1FbMFv/aUVOLuBEM+CrG/CwqAi
	NJFaOPJ9zW7gz+edxpaaLSfRNkQ64Vnw4A2OhPtFQ8gtdWTOHmI5Ru98clp5XgOXDjhgLAg7t3u6m
	NtKmtpvFvLSr6wosHF3NffNo6Vt3QsxUugl3dIZJ9ihko+uq62Vq24a/xNkiHJ2hMjZbvkomQpIJW
	NvH+piUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdjx5-0000000Ggqn-22av;
	Fri, 31 Jan 2025 05:52:27 +0000
Date: Fri, 31 Jan 2025 05:52:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Juntong Deng <juntong.deng@outlook.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com,
	snorcht@gmail.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Introduce task_file open-coded
 iterator kfuncs
Message-ID: <20250131055227.GU1977892@ZenIV>
References: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50802EA81C89D22791CCF09099EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20250130-hautklinik-quizsendung-d36d8146bc7b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130-hautklinik-quizsendung-d36d8146bc7b@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 30, 2025 at 05:04:42PM +0100, Christian Brauner wrote:

> I'm also not at all swayed by the fact that this is coming out of an
> effort to move CRIU into bpf just to make things easier. Not a selling
> point as we do have CRIU and I don't think we need to now put more CRIU
> related stuff into the kernel.
> 
> So this will not get an ACK from me. I'm putting Al and Linus here as
> well as they might have opinions on this and might disagree with me.

Strongly seconded.  While we are at it, one thing I really hate about
BPF access to descriptor tables is the idiotic idea of using descriptor
table as private data structure.  Sure, when talking to userland it's
perfectly fine to stash your object into descriptor table and use
descriptors for marshalling that.  Doing that kernel-side is inherently
racy, especially if you end up assuming that underlying object won't
go away until your skel_closenz() - or that it will go away as soon
as that thing is called.  And judging by experience with regular
kernel code, that's an assumption that gets made again and again;
see anon_inode_getfile() callers that used to be anon_inode_getfd() -
a lot of those appeared while whacking those moles...

