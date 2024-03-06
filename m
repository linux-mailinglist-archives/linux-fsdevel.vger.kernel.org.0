Return-Path: <linux-fsdevel+bounces-13824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F51987421D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 22:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED621F24CC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 21:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7724C1B7E5;
	Wed,  6 Mar 2024 21:42:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214621A58E
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761342; cv=none; b=XXe1BoEn9CPx1aMwECYZq3ip3OKBkn5cGGzJAFlDdRfTKZ7MUs7/DfvBO5/IhRl/b0iyJ4R81NRid4JN6LavmfboCve32pkT2rdjlFHU8xGxwjI28onU7co1W76w7jy+HG/5oqlxT/RgagecERWTx6BZZk5pqLnZxWF8E0uglZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761342; c=relaxed/simple;
	bh=0GgN0ouBpXwrcHO0GIwMzGjWY6bvfU0xZiosIAzaFK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTgqHZAk/KA2T4H4hXt2yzsAlIxZzmew0pQPQIMb0H2OuMLXFmzgw2YCZwdjbL4GKr+j96/nVYhlOPBIg0G3c1Mebw2uAaPoxEIuSVPK4D7ni7PzhLDouLKmvTByNz77UOWIHgEt6POx4PllwHs/RvJ22QxjgkQnsO8w8reDRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36ABC433F1;
	Wed,  6 Mar 2024 21:42:20 +0000 (UTC)
Date: Wed, 6 Mar 2024 16:44:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Eric Sandeen <sandeen@redhat.com> (by way of Steven Rostedt
 <rostedt@goodmis.org>)
Cc: linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Bill O'Donnell
 <billodo@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/2] vfs: Convert tracefs to use the new mount API
Message-ID: <20240306164413.2ef1f697@gandalf.local.home>
In-Reply-To: <536e99d3-345c-448b-adee-a21389d7ab4b@redhat.com>
References: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
	<536e99d3-345c-448b-adee-a21389d7ab4b@redhat.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Mar 2024 17:09:30 -0600
Eric Sandeen <sandeen@redhat.com> (by way of Steven Rostedt <rostedt@goodmis.org>) wrote:

> From: David Howells <dhowells@redhat.com>
> 
> Convert the tracefs filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
> 
> See Documentation/filesystems/mount_api.txt for more information.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Co-developed-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> [sandeen: forward port to modern kernel, fix remounting]
> cc: Steven Rostedt <rostedt@goodmis.org>
> cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>

I applied this and ran it through all my tests and it passed.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

