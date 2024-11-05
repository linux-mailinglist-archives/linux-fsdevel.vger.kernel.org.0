Return-Path: <linux-fsdevel+bounces-33643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB429BC21D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 01:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95630B21C7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 00:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED407182C5;
	Tue,  5 Nov 2024 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcaGSYNa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344E1FC3;
	Tue,  5 Nov 2024 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730767422; cv=none; b=KkSthpVUDLEKS57XJXq7G/KT0yPKV+gW72MDUL9T8BP3djD7JUChMrFng2qSbf/9b+rrPOgjRTXYK0mPqjlnUChclGlDe+P4jSQHXKVTAJPiMLOpjb6tP4VLl57eT7OvHkd83XbMbaJNvM4mRHognZIq52GOefop6hWJMOOaN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730767422; c=relaxed/simple;
	bh=rtb+HSUN07Y2JrY1lFnq7qn3Amt27M15GblKcS5xsQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cM8ygy6Njh2ckSjdtPYxKJ+7cwx3PFx2SVhyw283AhuWwoEywqi6+rmULnigID0CABLKxWOnNscAhOFfCOisICf9sK3YP+ikOhoioE13bwCsvF5AxCnYBJX0yer+MqejKGpm28IHwjSFK1YwixINMMpHXXJQpIqqhYoTmYJNqKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcaGSYNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB36C4CECE;
	Tue,  5 Nov 2024 00:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730767421;
	bh=rtb+HSUN07Y2JrY1lFnq7qn3Amt27M15GblKcS5xsQc=;
	h=Date:From:To:Cc:Subject:From;
	b=TcaGSYNaVaokvyWdzX4HBihcH5VX+0YgPZ+m+XQOY6xyXjn2+0HfsgtW2rJTg694J
	 K2/7CHI5AfRHMClCtzXIBEw3w77gyZAHevDZaiL8R7r1s2M6lj7+nTyCxAwdFJDUTh
	 QZbe1imDVinFKGqRkWzJpkx1/jE5FMyA1Q/1DkzStYSo0vxHCkm0Wk0e+5sxC10p5a
	 UXvfavSjExi00thJlLa1xbWZUrvLXLsYf2CJVv+HqD/g0QuXrmm45VXTDtQlnDKr3u
	 9IUrYtC5YjuM2um5hiBXIuC2eJJiZH6moNULByX11iVmcEJ+8Ha5VpkM/1p1B/hZFQ
	 4nkPS5FtgX3Fw==
Date: Mon, 4 Nov 2024 16:43:41 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	Catherine Hoang <catherine.hoang@oracle.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-block@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [ANNOUNCE] work tree for untorn filesystem writes
Message-ID: <20241105004341.GO21836@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

Nobody else has stepped up to do this, so I've created a work branch for
the fs side of untorn writes:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fs-atomic_2024-11-04

Can you all check this to make sure that I merged it correctly?  And
maybe go test this on your storage hardware? :)

If all goes well then I think the next step is to ask brauner very
nicely if he'd consider adding this to the vfs trees for 6.13.  If not
then I guess we can submit it ourselves, though we probably ought to ask
rothwell to add the branch to for-next asap.

PS: We're now past -rc6 so please reply quickly so that this doesn't
slip yet another cycle.

Catherine: John's on vacation all week, could you please send me the
latest versions of the xfs_io pwrite-atomic patch and the fstest for it?

--D

