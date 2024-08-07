Return-Path: <linux-fsdevel+bounces-25286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FCD94A638
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBCC1C229B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062311E3CB2;
	Wed,  7 Aug 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEr6vAi+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D141C8233;
	Wed,  7 Aug 2024 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027699; cv=none; b=liQOMyi0mrqtKtwWlN6NvAwNJRDlSHx0WsxEM93CIJO1spi2jMVvdQWZO2RjpNs1Vfi3nltw9OpHCEhIaeavc6hd2Tq/wQn0ILy9Rm9g3WdoBfipg9w+0cMpCcZJzZecLHgMoHFNxtyBV/ClSNaLUL85+ve4vKXUWiEp32JNrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027699; c=relaxed/simple;
	bh=PqKLjeX0WyVhfWqb4PFCPx+0v2ijySanvqqO9LIofso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhMkn93LZhixVnL5yEHsFPsNV+6VQQTZw19Bx5PeJ3u/jyN5Mu0AnHqX+3NblQW1j+lIBCznAv8LfMEaiSaLwXBerxDCTJJR45fqGvFbpQIOljPWX8V60YmPE2ha/7vtU622yd/45QKc63zGF1bPGT1wgUQYg1lP9CjXFOzzucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEr6vAi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF52BC32782;
	Wed,  7 Aug 2024 10:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027698;
	bh=PqKLjeX0WyVhfWqb4PFCPx+0v2ijySanvqqO9LIofso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEr6vAi+9TdnYzEL92dVa9JppLcxyLiyVCL/QqCY8AlLMOXagBwYFEXEbbxMMD3x1
	 v6KmGoUSOuWTAhf0JjKzOP7lIrZXprydnnT1I3Y1fzQpXHAwxJeyHqDyH95V+mdWRR
	 MnfvLFEzfkV0bV/OVEHERBvIuAiIaeQ41nkdFz+wr6Cs+PO8ivlyby3eI2HNgA/SUG
	 JaPhHcO81KaC62BfnCRpMHpwpLnBYaa2Ts/mEA0XiH725LroqeW2Wq09e9wFlZbVYJ
	 cARqMVlcaxli8Vslq+3YAqSXF3HZKypEPsw6iOKy6anLRm9SWD135QX0Fg4vUwwl3+
	 KcAKHuKNtc6ww==
Date: Wed, 7 Aug 2024 12:48:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 39/39] deal with the last remaing boolean uses of
 fd_file()
Message-ID: <20240807-trabant-erinnern-fb27f15591cc@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-39-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-39-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:25AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> [one added in fs/stat.c]
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

