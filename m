Return-Path: <linux-fsdevel+bounces-9027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A0F83D204
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 02:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC101F262CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 01:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADDB4C9F;
	Fri, 26 Jan 2024 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U/eTjQB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A11C11
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232244; cv=none; b=ZEjFYwwnrVr9g8k9JC09IUMJ/eAlb1OP57nqUxL9bUTVkYCoyLpvu4V1XxGd6/a3ngyLHuyCniSRdwOS3uzU/wxbCgm28Xv6DHTeB4W2+38AkrPPSV/ZQm8D9bOJK8NZ2gAULGCcCyUPa0SoYzTWBftEEdFek6gBW1T/TbB9q34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232244; c=relaxed/simple;
	bh=oSGq9uwyg+B2ll9QSLTEjxJ24HB6EzkDLtQtu6dCAs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmRxceNXUx64trRj+/pgjFMnub8r9WAJT5zvvvy6cg3lChedjTeB3YcR0srVvMVOUCGU8QB+5UgZqGCPyuwAbhIs0jyKjaxyk/+B1FoM6tB1aNwUVDNvPMMsfaTeSbmCypz2ZpuNkUFsAwMGL2ARC9XD0lSpEAXsJ1ljG8FxaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U/eTjQB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7670C433F1;
	Fri, 26 Jan 2024 01:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706232243;
	bh=oSGq9uwyg+B2ll9QSLTEjxJ24HB6EzkDLtQtu6dCAs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/eTjQB5b7iuivW+i7VgtzksfSlY6pzNQjsiGdDkJlLBruHJgCReRnGYZHQjXYeEU
	 c+ipLy8FZ0ycVR1us1JOl2Dqkxvcjt4whxVWgx5KsSt42q+XUy2Hs4l5qmK+THCA5Y
	 8wgxQSsE5tvxNCHi8UcvJtlQBHjHyjH6AOg032AI=
Date: Thu, 25 Jan 2024 17:24:03 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
Message-ID: <2024012522-shorten-deviator-9f45@gregkh>
References: <20240125104822.04a5ad44@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125104822.04a5ad44@gandalf.local.home>

On Thu, Jan 25, 2024 at 10:48:22AM -0500, Steven Rostedt wrote:
> Now that I have finished the eventfs file system, I would like to present a
> proposal to make a more generic interface that the rest of tracefs and even
> debugfs could use that wouldn't rely on dentry as the main handle.

You mean like kernfs does for you today?  :)

thanks,

greg k-h

