Return-Path: <linux-fsdevel+bounces-18135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F18B5FFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B051C217A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA4C86AE2;
	Mon, 29 Apr 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1vaJMAky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1B8595F;
	Mon, 29 Apr 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411412; cv=none; b=aULhXVIjm7+J6ZbZlhyW1Nu8qN+mWAHMyl3u3Wcmne4jC9p7qrFfpwrbu82sjMSSPNgRD5phQe3YCQL5PGRHoWuOyVyBWFhJcRzPxEmFPwRg4lA8Qk5FSThKkNrqmYrC0H0i0JFMlNOxCWoa4dTHtc+nqBj6NJdiAFZERRXyq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411412; c=relaxed/simple;
	bh=c/zdxvS55JZPVf8d8w3oVUIUTtIn3jzMVQdAfaUaLj4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HrT4AvgF7mtYPyZMkGlG5Sy94q3zuI4CQP+IoqDmHb3GpkRuVXihcW/jVlSkMyDE4yq00ZyWBmycrRbsZhWOGbJWJVgK+5aPQUkYhtpJQWlxK/CyBkZzVZClF8TLqnzaVdSyRt3OeELzGJDLLwSf9eQ4pC2RwpG9doe+3HPJDH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1vaJMAky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0EAC113CD;
	Mon, 29 Apr 2024 17:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714411411;
	bh=c/zdxvS55JZPVf8d8w3oVUIUTtIn3jzMVQdAfaUaLj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1vaJMAkyI5thXlhnD85yA0+eOEQOpsb+p8fEyEc/QjMiMV/Z0A9KIl4da5rZMrelp
	 qW4JVR71b+8POkDCO/fndyy7YKm9UkHcPcP7mlu1F1ymBEosbpQ6KNHbf8z7BTtOuY
	 ccHOrscBm3tKzxHD558ZtnZb9gKdZN/M4YcFlb84=
Date: Mon, 29 Apr 2024 10:23:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Muhammad Usama Anjum
 <usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] fs/proc/task_mmu: Fix loss of young/dirty bits
 during pagemap scan
Message-Id: <20240429102329.164f500875c51eb0a6d14528@linux-foundation.org>
In-Reply-To: <a6656f48-da57-4bbd-849c-7f4e812a0092@arm.com>
References: <20240429114017.182570-1-ryan.roberts@arm.com>
	<a6656f48-da57-4bbd-849c-7f4e812a0092@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 16:55:07 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> > Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> I guess this should have cc'ed stable but I forgot to add it. Are you able to
> fix this up when you take it, Andrew, or do I need to repost?

I have made that change.

