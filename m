Return-Path: <linux-fsdevel+bounces-46414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F5AA88E8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 23:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D850D7A1807
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 21:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637DF1F542E;
	Mon, 14 Apr 2025 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sRNrxXLS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E791DEFDB;
	Mon, 14 Apr 2025 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667481; cv=none; b=E8wX6wugPdbIa56UKa/yAO51RQ0B8Z8393pkx4JDEoSgqBaF8eE65yyx+Tu9xcFAnKAE4WPuup1R+fEwE16RcQCeC6UPVms5RtyhWDvJPt31azh+1wEEbTqHQJ4uhknUISJoJpthbJkZpP/GzCkxXVhaor7J4Uu8jTvPBiUL41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667481; c=relaxed/simple;
	bh=0xMzsyY2JXDLInkHTH9D+2BI0tk5b90cP0/D78/nU2c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ORCi5u1yazoPoIdUynvuD974FgNJSc5NLuBX+1XsPfOp3e9+kWEN48+O+TJrvbUqvOYuR73zUkDIpFgxhFQWynqmEi9gOebLXoE/TefTSowoW82apUvmnK6Oc2mxJux0C1U5XnFJS9LIB/H4tpbl0JFs8LjHMOFUMQmahVSfQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sRNrxXLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6296C4CEE2;
	Mon, 14 Apr 2025 21:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744667481;
	bh=0xMzsyY2JXDLInkHTH9D+2BI0tk5b90cP0/D78/nU2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sRNrxXLSwHIVS5DpItwK4Yly0b9rEFBhYEDMCyhqiOkOYgkZ4jPeCrLQ/12An3uWF
	 O0pAOkXF7tBSkDX5tdLkQqvXGxk/k9UYzCNnLLJqAOtQi1KGW1NJ23ZWQgyGFOtRFc
	 L/Wgq9FtX9tAwlu057zJAMynqIgzW72i9kj7phJA=
Date: Mon, 14 Apr 2025 14:51:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>, Rafael Aquini <aquini@redhat.com>,
 gfs2@lists.linux.dev, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] writeback: Fix false warning in inode_to_wb()
Message-Id: <20250414145120.6051e4f77024660b43b72c8a@linux-foundation.org>
In-Reply-To: <20250412163914.3773459-3-agruenba@redhat.com>
References: <20250412163914.3773459-1-agruenba@redhat.com>
	<20250412163914.3773459-3-agruenba@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Apr 2025 18:39:12 +0200 Andreas Gruenbacher <agruenba@redhat.com> wrote:

> inode_to_wb() is used also for filesystems that don't support cgroup
> writeback. For these filesystems inode->i_wb is stable during the
> lifetime of the inode (it points to bdi->wb) and there's no need to hold
> locks protecting the inode->i_wb dereference. Improve the warning in
> inode_to_wb() to not trigger for these filesystems.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Yoo were on the patch delivery path so there should be a
signed-off-by:Andreas somewhere.  I made that change to the mm.git copy
of this patch.

