Return-Path: <linux-fsdevel+bounces-34626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA1C9C6CC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456DA1F212DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013CB1F77BF;
	Wed, 13 Nov 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq9vRBaL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633361FBCA6
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493362; cv=none; b=Lizfl5dGMLPewTB3lxM8NHpZ4922XE8aZfQ+nxGVUhrZq1XN+XmTyHak6mTOnXqSJ9zql4pIIIEhNw/pCViBVME0GsGvtIZ9bvN4gVrrmXjznA+12HD8xX3LD8IWQc4VjlUUmwr1V3IcMhLBRtm87Cr61T1z2V5a/dwOws14SAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493362; c=relaxed/simple;
	bh=Kim5jZZxicPAFldBrnQyDt/UDS+fKlnseh5reCbqStA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcfwYxl0JOobRnrS/G83iSZCRvvgmDY2oEYW9m5BGDlvWHvnSMNW/2dcRpNtQ4WnaoNzyTkV89bpuZeBOuI4HD/IU2gRaGuR2L45h7+LUNdy1AnsE1YzMwK69yPeRYpWTmD3c2ZsL9xui2OOYDJQPlNuS6aB2fj8AlywqXaMCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq9vRBaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB26AC4CECD;
	Wed, 13 Nov 2024 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731493362;
	bh=Kim5jZZxicPAFldBrnQyDt/UDS+fKlnseh5reCbqStA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tq9vRBaLRzBqGqpfOYNa7di+JXyg+JUUrJFEwNLZl/2I8h3ydOA7ryrdDOTgiYOJd
	 ZLK1M9gKfTpSyuUZHkqMOuV5ItKt6YTVhKmIx/HiUaq80FXBofQSV66e5Pu58xeILr
	 5rV4i0N2HrfRy4fwgGdswl81M3XsCyofwTIjyW4ApVdGjcNQxjlJKCRgtO0pPmU8GW
	 WtGG7Kh8Ab0LxQ/2Yyoe7kDaqGN/ONWzyNsmFm06kwRWoP3N0x/1JZF3/azRP2Kh8Y
	 W2Q43q9tMvBOnl/RHsrvnno1Jfnjd67YQWiRfz/1Tt2VPeXsh3nVxQ3QTXu2HRwnWo
	 9DwKa702wrv7w==
Date: Wed, 13 Nov 2024 11:22:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5/5] libfs: kill empty_dir_getattr()
Message-ID: <20241113-abspielen-gekracht-cc011e2bbe9b@brauner>
References: <20241112202118.GA3387508@ZenIV>
 <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
 <20241112202552.3393751-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112202552.3393751-5-viro@zeniv.linux.org.uk>

On Tue, Nov 12, 2024 at 08:25:52PM +0000, Al Viro wrote:
> It's used only to initialize ->getattr in one inode_operations instance
> (empty_dir_inode_operations) and its behaviour had always been equivalent
> to what we get with NULL ->getattr.
> 
> Just remove that initializer, along with empty_dir_getattr() itself.
> While we are at it, the same instance has ->permission initialized to
> generic_permission, which is what NULL ->permission ends up doing.
> Again, no point keeping it.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

