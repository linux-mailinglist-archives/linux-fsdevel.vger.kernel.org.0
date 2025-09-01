Return-Path: <linux-fsdevel+bounces-59806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AC7B3E187
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230D83BD7BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3321E314B9A;
	Mon,  1 Sep 2025 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzM9VmQE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383BBA4A
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726130; cv=none; b=U93pX2zvInni1ke6lc55Iwde89t7NeBc4E0lVnJVUeXQcf6zgKmqf0usaBeJDN8dB6A/74CvDw3zrFuy2h9l20MdSZhyAo8b1iaRQ1oPD1epAKx/G5CrRZzunmxkiGIK6Fz1lA8NNcoVOk2ktkSyeUB6XwQCTLqxpFYd+5wUFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726130; c=relaxed/simple;
	bh=mW6BQ9E7dt8LtIuQZ4JTEJzPcsu6ovWX9eT+Pjl7104=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6lPrcT2uxkvhohUm0UziLSXRVf6YIpIJvpiS6SarYBsoKvsM7j5Ltlxt/kX5dtmJ9dvGLQUpdr2yMayK66cyIvftrfU92VM69/R+kX5L19bPkXOmgTkxE4+sBRGjLTEsQjmC3QalqKKw+X2ix+7kUmZsoMryDKk4W5GEDPGLKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzM9VmQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C04C4CEF0;
	Mon,  1 Sep 2025 11:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756726130;
	bh=mW6BQ9E7dt8LtIuQZ4JTEJzPcsu6ovWX9eT+Pjl7104=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzM9VmQEGmA367NYpLh0y/4WQmxy6/o2PJOZiYxiXgPL38RYnTk4NGKl7niuf9d1a
	 SxZlZ0qJwu0nelJfQthQxCVAc+12tu+jg96ky5IGIdgrjJ6TkKNj2FhnUxMzKZvZzZ
	 SKVeYHuCpgePMG0i9GuBaXnc1qYMSFr8wUXu7A4a2atlW5OdAED3kCs2Cu5Yz4Ye4J
	 YA1umyVhpE1hu5DjagoZ0N2RyZ0l0bngHQfO2970b0HrL1L1GDYglAnzc+jBkJQjem
	 zodztArHZG1y3PChGmkVAuxEVQBfF+pV8JDBZY/lIuiDiT974NxAioXOGkNgNomiqa
	 8RovAhSbInNGw==
Date: Mon, 1 Sep 2025 13:28:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 63/63] WRITE_HOLD machinery: no need for to bump
 mount_lock seqcount
Message-ID: <20250901-hartplatz-alufelgen-af35bc679ce6@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-63-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-63-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:08:06AM +0100, Al Viro wrote:
> ... neither for insertion into the list of instances, nor for
> mnt_{un,}hold_writers(), nor for mnt_get_write_access() deciding
> to be nice to RT during a busy-wait loop - all of that only needs
> the spinlock side of mount_lock.
> 
> IOW, it's mount_locked_reader, not mount_writer.
> 
> Clarify the comment re locking rules for mnt_unhold_writers() - it's
> not just that mount_lock needs to be held when calling that, it must
> have been held all along since the matching mnt_hold_writers().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

