Return-Path: <linux-fsdevel+bounces-58268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B2B2BBD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17135E49C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C892731159B;
	Tue, 19 Aug 2025 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGaOTeOv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E52D24A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592009; cv=none; b=as61LQVqXGn0sk5/U/o9gLXD3MgeJLp5sM1NYHXFZAN1Swq+xTfnq4YwssZqGfsYYyXEB7sKPZabqPGHtHddc1vWGwjuX7j7YW9WTKz7lq9QUxDzw1vX0h/MO1vus6SKGYKrOTdoTGL6oqZq0qcBPb4WeIxoCZ1hdv9vm3a6SNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592009; c=relaxed/simple;
	bh=nmnWoaa+srg/27QGdSKycia19G24zfT4q88QZFqFd/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKTfN8xsuG5ISh5P98kxCYmZHolTI2CkNBjjyiB27ygLC2cZXjKo95b+vRqB4S6lQMcg2IdG4c3EmfzD0dJSPt0s22KtGPaZLZowk86YyBNDlBAWmbFLWUSHIu3G521YcUhR+WdTnYT/XB0SMf2phKRBjOyej1JnYrSBXegpGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGaOTeOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73256C4CEF1;
	Tue, 19 Aug 2025 08:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755592009;
	bh=nmnWoaa+srg/27QGdSKycia19G24zfT4q88QZFqFd/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGaOTeOvyten/gsJsdA/ZOWgL4/ZGJ/V7wmuV4UjVAPELMcyPzqxnoe4ELyzao2vl
	 7parzdeR9+uidGAk05Z/OBypVr7svwtTEiUefVzTlbIy5bQG2V2t/hdZ5/zPs1KXkg
	 zgFLLMlmxR4sKaJgk/94OA/M86JaewmNyPsqMdh6JJIHtw/+Lldz1BHHJs8F2UvByr
	 zTCUYeU3yL3qbUtQb6QciKBTZtCawcsYYkMGcJVTcGIeVImTLMW3IqDg88q+o/kNNz
	 2+fjnUQpkvqMTu/Z98+sYgHwIMQ3k5SwQAQ7ZPxCUnj5c+J1xaYw8MQPOknii+Ktn/
	 /BEFE+kAMhxVg==
Date: Tue, 19 Aug 2025 10:26:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fuse: inode blocksize fixes for iomap integration
Message-ID: <20250819-inbegriff-titelbild-8c0421cf4bbd@brauner>
References: <20250815182539.556868-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815182539.556868-1-joannelkoong@gmail.com>

On Fri, Aug 15, 2025 at 11:25:37AM -0700, Joanne Koong wrote:
> These 2 patches are fixes for inode blocksize usage in fuse.
> The first is neededed to maintain current stat() behavior for clients in the
> case where fuse uses cached values for stat, and the second is needed for
> fuseblk filesystems as a workaround until fuse implements iomap for reads.
> 
> These patches are on top of Christian's vfs.fixes tree.

Thanks! This all looks straightforward to me.

