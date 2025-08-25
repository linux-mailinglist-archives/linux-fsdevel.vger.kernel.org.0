Return-Path: <linux-fsdevel+bounces-59063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B07CB340BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91DED7AE2D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26158274FEF;
	Mon, 25 Aug 2025 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhOpcTUr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86087269AFB
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128638; cv=none; b=Y6hVUnZYb21gn7eDI0J+Kah7EII2VlF4kuh91TWI8a2fj4Du5w5P+NvjalvuKGZNGpEDeKX99FajHElv4p7R2/KhrrKIIUTJSrW8/UnnoaWAwll82Vcexm/qcGItUArEgmcPYBAAAXE0jzJEVHyiTW7LdNR1Z6Ri8dSxRjDdUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128638; c=relaxed/simple;
	bh=8SDhvx59CwXdqQ/nLH6J2gEA6M4i2MPGaRBjwQS43wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfYA24CLoFSWbgIsm7apBWxD/cg8EYMVUyl1oVLozQELF7IwsOwPAcc82HCXhoZ6AOvSSNK3AWzNx9a5RfgoQbZ5u2wPbEBO57vJ4CEwLdsjJxVhRxpUXd8jnBBq0XjUhwNiGTQmP4xwcjHdqSvSbRyLUrhU6kMn1AxU4oRmW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhOpcTUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F597C4CEED;
	Mon, 25 Aug 2025 13:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128638;
	bh=8SDhvx59CwXdqQ/nLH6J2gEA6M4i2MPGaRBjwQS43wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhOpcTUrjlZRdj/LSHUtIGSTpGDnn2SBrX5mrBCl+puZjdcS5Uzqx7WN4fWRe6oC6
	 xNa9ccdFpJ9nJiBk/D2BGQ1KOaLzK5rrUVAyTsD+0CQll1l6CzD5cpt94N67D6vai5
	 5m+FW9snNIhsQXXaBAPYnqYsPflUB7DhDLVj7q7267T0/UfcKkBaifDeRf4+gX3lID
	 Bq1DBzvitGKNEXmOoeALpx8pLn2RjEkWFmd7BW0FOHwsa/woyu+fgQrGgotlciHmti
	 SvTEYrqgfd6lbdDb1P27v6gS6gaD98Kzf9vuKvCfSAn1qps9uRgMLUBw7SUGR/JlS+
	 E1ob+fhKy8daw==
Date: Mon, 25 Aug 2025 15:30:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 42/52] do_new_mount{,_fc}(): constify struct path argument
Message-ID: <20250825-kauffreudig-kennung-7e71b94c9a13@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-42-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-42-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:45AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

