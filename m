Return-Path: <linux-fsdevel+bounces-25276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AC394A5E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7942814DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4E61E213D;
	Wed,  7 Aug 2024 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3msc63O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA21DD390;
	Wed,  7 Aug 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027260; cv=none; b=MHmVirMWbzp1jicg4tpoPEKteb9Rg5cBDZOZkJ70eQE7hwcv0cVN7SvtT3l0O2r+FljOLC/huMiE/pqMZbdzvrq+VUqqC2bH3KFR2qZt+283nMFlvNI33SZE8FArO0eTEOhwnAbspqoqu9O/J/XLnzogwW8C4KJpo71rlrYC0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027260; c=relaxed/simple;
	bh=oTeKY7+nz7Uj7OVqZUuSc1T771GWTbGu0t85yLZe5L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD46NTeqtB2OH93WCN5FN0Iw/CMasqgcmHtWZ/nVYn99+42Fv674T0EcUFomv+tOlj5N4gXoaLCRUikpsuNelEMqj7zOMd2uEupSjKvhxZgfwz1Ceg+LX9WmbFwdLgsnWA6u3lRO9GJGObZENVAf7km+DBy1wu/4TxYUXgT4IQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3msc63O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A14C4AF0B;
	Wed,  7 Aug 2024 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027259;
	bh=oTeKY7+nz7Uj7OVqZUuSc1T771GWTbGu0t85yLZe5L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3msc63OWCXjARlwfn0JQ33ORxblG6pBh71M5oqOt7s+pKMdXpLCFb72BxRQFLFg2
	 3UZGoExA/GiQO/DbslJhKHEY+2LOJEgivMspqfLbCXXI4d6FpOLbr+p3pKbCNBNQMy
	 eaminwe3xSQo9i/yWZzoB0N1mZMM9ox/PiDcKXenWxUtLKrjWSbHdF1gY+jZDwYdZE
	 kKL4lK/ucunh9RlwR3Wa95qWiHz0HzxZQRQI7szhdCiJFDLPKx+sGjgbwa/cGeMFxv
	 Otnwvf4Zu7/fgTw91P1/DaV2PHXDauzqFscweOZU1XVEBbDI9n4Yuoi3aqILscnUG7
	 grTEerAjee2gA==
Date: Wed, 7 Aug 2024 12:40:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 29/39] convert media_request_get_by_fd()
Message-ID: <20240807-barsch-koffein-20c2dae8c6a1@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-29-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-29-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:15AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> the only thing done after fdput() (in failure cases) is a printk; safely
> transposable with fdput()...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

