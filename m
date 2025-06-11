Return-Path: <linux-fsdevel+bounces-51278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79193AD51C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC86917FDEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B3D262FC1;
	Wed, 11 Jun 2025 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnRoIsAo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEC220F2A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637616; cv=none; b=PypUIb5Ip4H7m2ogYMgad+sqq4UIMW1K3AJm8Ty70Qi2ASG9ATpYgJ7/Ak7h0En4s77A50ZgiLeXUgzNFtDI8bUEaVX+5iaUG4HgTty1F0NniU9G7vprD+1e7xMgtOIzs3cl+i60nmaQNZMlXKWGh1Wtr9gN42gj7sIhNH+R5Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637616; c=relaxed/simple;
	bh=dfRA8PtrP0E4Qsti+Ph7JGqUB63z7N96Z6ba/E4jIBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr0blIoErDjgqP4aeUxJRBkdSYPESZHC+xrlMRoCYZwk+QXvZo8U+sLzR/CrL4TgzsDdKEoA2XaJBfmNlULM6m5TJrZ5KpjYj6a0/8WXEsphYm4dXZp1V2S/cMa4+5IpkyCAEjqcC/2l9rHZE4vzaTn47cPj48k4yCE9UiTCO8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnRoIsAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FAEC4CEEE;
	Wed, 11 Jun 2025 10:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749637616;
	bh=dfRA8PtrP0E4Qsti+Ph7JGqUB63z7N96Z6ba/E4jIBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnRoIsAoCSeeioiS7heq7C4aZ10HadKPeIDkMbzdTtX4fxTcsK9EPxiNqWpGKrT6V
	 Cz6RQ6KenpQtWvAXHvpkymKnvSdlp0v57P514XzH6q0V4Wc53rVssDgtedLTO1GPne
	 6yNwhDOOoWTSNyuqzTMgLyXMtDz4/W7kJbxshGsAjC3dyf2znaUa+Uv71IXUIMqSiy
	 C8+JXPr5tOPV17fXU/Hxss4YRlhXqvR9C51uFw3a4O00aBo65iZ+ECJYyWmI5vkUZM
	 cutr6YzI+NAAcp3vnIzk6vLi7p37E6X23DFYkY/Tkq4jtc6bcDCHnb1zDPE8l47Qb3
	 RagWpmPNOqmSQ==
Date: Wed, 11 Jun 2025 12:26:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 02/26] constify mnt_has_parent()
Message-ID: <20250611-beginnen-reglementieren-4e38d40565d4@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-2-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:24AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

