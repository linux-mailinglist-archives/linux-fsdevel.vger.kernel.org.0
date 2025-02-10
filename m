Return-Path: <linux-fsdevel+bounces-41416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E17A2F3F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F057A0F61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543B82566D6;
	Mon, 10 Feb 2025 16:45:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37532566C6;
	Mon, 10 Feb 2025 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205930; cv=none; b=Ddk/PoMUyf1pYY80l+7BS86IwmZPRfqDRk6GW0T9NsyCSj6Dg1z8TqXo/Sol7zJixTqDPtNAb3VreeaY2E2GjCPOLVR1MGoRvF9DVzoCm6eZI3ZXRFm99FbiLMPPTN6b6RlB3hSGcFsVHDgzGRtUQz1AW5S0U7nFbINRUzIGmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205930; c=relaxed/simple;
	bh=bF+4FoPgASdI1wrJVM4rNBQc3DuiC7mNwZcdUEgoPxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qf5iYPi/QQSuisssW5xjbZHe9VHkWTBFNR6/ZHf1G+mjWvc3NW80Y27xW0l67usdT4x36NVx/LMpikrLCGRurGlqht82bmLTgvrnlXE+YThNHjs9xE4VIjTofI7ttB+np4fMvp0wmSdEt7wnDWT2N2SAb69jxGZjhvkurrquyfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53627C4CED1;
	Mon, 10 Feb 2025 16:45:29 +0000 (UTC)
Date: Mon, 10 Feb 2025 11:45:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Reaver <me@davidreaver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, cocci@inria.fr, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] debugfs: Manual fixes for incomplete Coccinelle
 conversions
Message-ID: <20250210114531.20ea15cf@gandalf.local.home>
In-Reply-To: <20250210052039.144513-6-me@davidreaver.com>
References: <20250210052039.144513-1-me@davidreaver.com>
	<20250210052039.144513-6-me@davidreaver.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Feb 2025 21:20:25 -0800
David Reaver <me@davidreaver.com> wrote:

> --- a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
> @@ -9,6 +9,7 @@
>  #include <linux/file.h>
>  
>  struct intel_gt;
> +#define debugfs_node dentry
>  
>  #define __GT_DEBUGFS_ATTRIBUTE_FOPS(__name)				\
>  static const struct file_operations __name ## _fops = {			\

Why are you adding these defines?

All files should be just including <linux/debugfs.h>

so that they can use either "dentry" or "debugfs_node" while you do he
conversion.

Then the last patch should just modify debugfs and debugfs.h and no other
file should be touched.

I'll comment on the last patch to explain what I was expecting to be done
that should satisfy Al.

-- Steve

