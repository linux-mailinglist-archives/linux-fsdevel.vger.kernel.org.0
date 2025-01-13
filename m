Return-Path: <linux-fsdevel+bounces-39049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0D7A0BAD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B028167F00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C437622DF94;
	Mon, 13 Jan 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOaUlLAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F122C9FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780188; cv=none; b=osf6WfBIoM3pQlsgtsyiRHKa9lD6DDaWEJ1yLAxmrViGdD8xtthsvzcjaeCPCBhvjYiPRqnu8svrnmfZEUwY3bK5ixrxNe90jtuyHzqzQLvWDqCVdD3FOv4p2cD5CBiLAzF1w+a+A9frK1l6WHrm9kWuoZOqvR5E03/6qZQXQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780188; c=relaxed/simple;
	bh=cYGWqj4YgEI6NMlJHRb1Vl7rhhmdXb4Zd3EZvhD7W40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzTXOALkKFRaufaLtvb+R0p5IyWbxB696UKolgMDwBaDtnPNszbIqgXf47lMC11MhCzLro6rSCW/OmsWkcXfX1QpyJEpkZ4tgLrCYk4kvo5hkmYg87Cdx6oSiDS/0rQZwMa8tVJ7igGhb/jxpAZ++LYrqhwhboWFl9j9ZSKqCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOaUlLAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FF0C4CED6;
	Mon, 13 Jan 2025 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736780187;
	bh=cYGWqj4YgEI6NMlJHRb1Vl7rhhmdXb4Zd3EZvhD7W40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOaUlLATKrZgzMFbrw/9XeXGH/q6nS4f1zBSVqN3ZadwhM4WLXX+iWbhLwDaa8dU0
	 uKRJwho1PZCeoKGdb0j+1VTObf5CYIl1qN9A7gOqr9OGPxM0ULkgdPw040nTaC5h+P
	 OE7AXayxaTZvu9vwigmPkY8R/TyNDJaQqH901qPTpei8uDfKWDKMU/OaWy9YKRy7MC
	 Utt8bdyUaoXnzAgeQsj9vwEquJOApcG/Gi5etLCV/Dxw0nhncapcps03vA1TJ6IYOv
	 8FPWF0I3s9zPeEsBLcjivfCT8L6XltgbI1Flr7i57eOWaJsuQd7BHtyPCXtsiJ4X92
	 tOnaEvY2FS4Gw==
Date: Mon, 13 Jan 2025 15:56:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 05/21] debugfs: allow to store an additional opaque
 pointer at file creation
Message-ID: <20250113-jawohl-bieder-bfb9a645bb38@brauner>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
 <20250112080705.141166-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250112080705.141166-5-viro@zeniv.linux.org.uk>

On Sun, Jan 12, 2025 at 08:06:49AM +0000, Al Viro wrote:
> Set by debugfs_create_file_aux(name, mode, parent, data, aux, fops).
> Plain debugfs_create_file() has it set to NULL.
> Accessed by debugfs_get_aux(file).
> 
> Convenience macros for numeric opaque data - debugfs_create_file_aux_num
> and debugfs_get_aux_num, resp.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

