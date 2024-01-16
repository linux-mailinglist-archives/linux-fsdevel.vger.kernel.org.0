Return-Path: <linux-fsdevel+bounces-8084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E008E82F3E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 19:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EACD1F2492D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233E51CD34;
	Tue, 16 Jan 2024 18:14:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71EC1CD1B;
	Tue, 16 Jan 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428894; cv=none; b=ZfqtsQRWwya+Z2+qS/s+EGaj9rDgArS0orDtCPlhqrLju46chm7pYrX5+PFYAMRlYhPiUZjc+uzoSkz7Q3fWzosQWzeNvq0jhswXbluD6H9G65089sE+bU+0GJhGyY2yXOefz5fxmQNYBhnVFHXumTiOIA6AjhnGSyQ4wq/TecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428894; c=relaxed/simple;
	bh=3BToaKFk3KnZjrn90TN5qLLGbEKWkigMHIlmqqBzUV8=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=WkF39PjkI7J3E6ZOK5c5NcBT4iSmnVudL4YoywYxyF3xcFnKpDQY39PdO/0FyPVCI+pliYDfm/wo3EFZbG7QKGYdJNGLDBMnBp2xiq7YafaPNNwV3oV8zT+Tb/wQsV/D70D19s83WXZmreOlOQx0pvkarRjtDBxhzdvzvqrek30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B266C433C7;
	Tue, 16 Jan 2024 18:14:53 +0000 (UTC)
Date: Tue, 16 Jan 2024 13:16:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 kernel test robot <oliver.sang@intel.com>, Ajay Kaher <akaher@vmware.com>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] eventfs: Create dentries and inodes at dir open
Message-ID: <20240116131607.4b2664a9@gandalf.local.home>
In-Reply-To: <20240116131228.3ed23d37@gandalf.local.home>
References: <20240116114711.7e8637be@gandalf.local.home>
	<CAHk-=wjna5QYoWE+v3BWDwvs8N=QWjNN=EgxTN4dBbmySc-jcg@mail.gmail.com>
	<20240116131228.3ed23d37@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 13:12:28 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Maybe I can just use a hash to generate he inode numbers from the name?
> Hopefully there will be no collisions. Then I don't need the dentry
> creation at all.

Maybe I could use a hash of the address of the meta data to create the
inode number? That may be unique enough.

-- Steve

