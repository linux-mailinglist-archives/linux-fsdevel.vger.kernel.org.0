Return-Path: <linux-fsdevel+bounces-43876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797E8A5EDFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D15189E593
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DEC260A3B;
	Thu, 13 Mar 2025 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2lW2Di4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335B41C6A
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854403; cv=none; b=LbuGc4NulY2Ffjg0nyfVh8t6XQDdTIVVYvdEDMga1AY7oh4PH5tDfMH5OrpFEiJImh1f9XyNwaiWmRL+9PZxYowXqAzB7QyV/P8K2lIvxOefyLwxWm6ha412i+Bj6p2LOh8eIUOeQzY80DSBXjB1mgx/lfDJ91+qfd8FtxP5UsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854403; c=relaxed/simple;
	bh=RkjUHYQt9oYOeICSHm0UffwyjfkR4DIxUYy1AeuFDp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9wTToJHil0YxcXQWiGJ3bOjsHg+TuPbp7uqNW6YLbRVapP46nQQPQxBou94cCyUCw6TsjUw1OBmgNwMUeeYeuVPK0r2HwNvnrQzeyLAuabSNnkH138A5UGD95nVH0rX6h34CGsC2GBD9puzI6xQBnODa4z4hEEUVCUk7PHVHCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2lW2Di4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBDAC4CEEA;
	Thu, 13 Mar 2025 08:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741854402;
	bh=RkjUHYQt9oYOeICSHm0UffwyjfkR4DIxUYy1AeuFDp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2lW2Di4PKJfvtctKVCWjvynCN9luGhvjFRP1nNTUY+8mzjYQXS7VMVOdisFxaHf/
	 QaipGbZ0C2n0999fGxUwjuFiOPEd0er44K8ZoeHJcJSSY0rLzjByx+D8nY8snQV1wC
	 UokOqVBRfsbUaQGsr4VOe7zyFnqbeIjlq/X1VKWrkRH1mfbX0aZpINwd9XCLOKe/tz
	 BBFxPfzqqfuhblleERtv5+nqZ6EsAXebjKm2ds6tlAWYGPt/pZK8w+Tv2LFnz6D5ZN
	 kziQBIsjt+vzPp/3T6PwnQMqUfGKpb0mEyj4kI4z185QAVsnbxEokQg5IOsNMpa/Dh
	 F8eCfGo7mZ3wA==
Date: Thu, 13 Mar 2025 09:26:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/4] spufs: fix a leak on spufs_new_file() failure
Message-ID: <20250313-tilgen-fundamental-1b86d4cbc3e1@brauner>
References: <20250313042702.GU2023217@ZenIV>
 <20250313042815.GA2123707@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313042815.GA2123707@ZenIV>

On Thu, Mar 13, 2025 at 04:28:15AM +0000, Al Viro wrote:
> It's called from spufs_fill_dir(), and caller of that will do
> spufs_rmdir() in case of failure.  That does remove everything
> we'd managed to create, but... the problem dentry is still
> negative.  IOW, it needs to be explicitly dropped.
> 
> Fixes: 3f51dd91c807 "[PATCH] spufs: fix spufs_fill_dir error path"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

