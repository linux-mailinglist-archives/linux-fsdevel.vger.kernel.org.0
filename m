Return-Path: <linux-fsdevel+bounces-22929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B521923CB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 13:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054631F2696D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 11:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8049016D4CB;
	Tue,  2 Jul 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTbXXDXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAC15CD60;
	Tue,  2 Jul 2024 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920595; cv=none; b=ayPLbPTMImuEJ/B2gOaMMFYkHjtyXHdxoBnAFk32eFFibQv+9yUF+CElnUxyo10A5ftth8F5WIG14wFgR/WdA8RTyUWu42WNKs8zm9IcbH5QyHfdGGRiGhP9sfyrAruObC53ep9rhWJjQp+/slm+2KJZGZ3o+wYOIrcrUrSIX8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920595; c=relaxed/simple;
	bh=MHo+EcPeKT7BzC5eQamoItTx5w8rdsZYQvEej5xDL4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuF0NkXSbJlycKX2AjXrk/jb1J3W+SXugtnH4YcsGRD8o5ksugyNZhbXrX4u0xTgoOcn/yFqNh2NBtzmOzCCNFnGfPR8cGByBKk7HTiFp+JHx1uIZi0cbEPQMe8LZdKIPG1ZVzOQfuo/iSc+2hzOKapzLeTzpaTThzPTtNIApRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTbXXDXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2DDC4AF0C;
	Tue,  2 Jul 2024 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719920595;
	bh=MHo+EcPeKT7BzC5eQamoItTx5w8rdsZYQvEej5xDL4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTbXXDXHSmgFeEdF76gZ4e16GaGorYF29q1T+tDZix+ek2IFPAl2sKW8AIOghAAoD
	 sLWtpbhluEuxdyZBnSYWB6XU4oX3q7K2nuGJFmkmIul3mPB/XhA6TcQ8oCnvSLdGz6
	 IcHRJ9Sw3HYTX51xVl5F4i7xSqQtVBzh4JqdVoJveXP4S3Y7azTQnfqLotqOaB9RoH
	 rNBRGkKj4i448pRS75HwAzlR07HhP6VgoV1eQWHUYLzSIyWfA7hhabK9Jr5KxuhXi/
	 WPcalCFGdPpybnf0BDYXZL9pOfCstwGVLik3I8M15yRllcVQqRSo/zzjcuoV/A9v2Z
	 HSYEmobWubGOw==
Date: Tue, 2 Jul 2024 13:42:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Chandan Babu R <chandan.babu@oracle.com>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 01/10] fs: turn inode ctime fields into a single ktime_t
Message-ID: <20240702-obigen-boxte-267c97f21bba@brauner>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
 <20240626-mgtime-v1-1-a189352d0f8f@kernel.org>
 <20240701224941.GE612460@frogsfrogsfrogs>
 <3042db2f803fbc711575ec4f1c4a273912a50904.camel@kernel.org>
 <ZoOuSxRlvEQ5rOqn@infradead.org>
 <d91a29f0e600793917b73ac23175e02dafd56beb.camel@kernel.org>
 <20240702101902.qcx73xgae2sqoso7@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240702101902.qcx73xgae2sqoso7@quack3>

> if the
> kernel silently tries to accept and fixup the breakage, it is nice in the
> short term (no complaining users) but it tends to get ugly in the long term
> (where tend people come up with nasty cases where it was wrong to fix it
> up).

Yeah, very much agree. It works for simple APIs sometimes but it's
certainly not something we should just do for filesystems with actual
on-disk format.

