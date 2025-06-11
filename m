Return-Path: <linux-fsdevel+bounces-51300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6DDAD5376
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F326A1BC705C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2EF2E6113;
	Wed, 11 Jun 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeQu89Dy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA062E6111
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640188; cv=none; b=DCZ++mGgO5lbJOjdpsE6XgUiZWPaGxKmE6qKoPDsB1QBv2UBPeTILAq3mCktTJOMPbn94uTh/oFnKIpFxom4N38hPS4NDoF5kpliSvSNEetoprThJC9b0o/jGpwogBqTFW8F4A1KUUAZ4Mnsu5m5w/5LVPhRlVoQWaehYMbQJcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640188; c=relaxed/simple;
	bh=0LAFuEChDrdIWyBpwPaY5X1bwDVl2XSnwIk6cOqtI5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFvufBI0n4Kxz3N5Es/X30mTfcf3jVVF+bkllQunohpRkt9sxVA6Q4BNZOolVY8jVBGPHxU4OGqKC2Kq9on7LEA5H4JVFwkk6QTqNYzjYd6lw+dm2OGtsHK2Bb5mA9ihyIQGSl9BAMPtCgCi/m7m9HnT8sOZFWYL+KeIvBEDI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeQu89Dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEB1C4CEEE;
	Wed, 11 Jun 2025 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749640188;
	bh=0LAFuEChDrdIWyBpwPaY5X1bwDVl2XSnwIk6cOqtI5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeQu89DyQ+Z+lHFoqJDSTL04ijL5n8+IgoVnQp3NAnm86hAoQsMAPr20Ub8iS1EW/
	 Ex1xDrsEqmFOi8je0VvoWOWqd9hG4DC/Hy8Yv6vWkh9//wU4aLGBWs3On6puDbMZJ6
	 HyjzMjPQA5mVQXa8jYfdsq9t7N6wg2IoyDrDQRJEopj9tJ9+AXBw2T+j85mggDsMUq
	 EXzyERAKaFI0tNSDhYCIvHWMfJXvxX1GMoEKxxQKdS3xazgUW+qQ7MOFwO8kPcl8Ui
	 KSJPl55Ra5SSpaAsVfmf9zNRMaGvX4+HfMohUn46BEmmdeKzM44K5V2rj8BzV/40SJ
	 8T5jJXldshl5w==
Date: Wed, 11 Jun 2025 13:09:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 21/26] attach_recursive_mnt(): remove from expiry list on
 move
Message-ID: <20250611-taxifahrt-rederei-d16d75476445@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-21-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-21-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:43AM +0100, Al Viro wrote:
> ... rather than doing that in do_move_mount().  That's the main
> obstacle to moving the protection of ->mnt_expire from namespace_sem
> to mount_lock (spinlock-only), which would simplify several failure
> exits.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

