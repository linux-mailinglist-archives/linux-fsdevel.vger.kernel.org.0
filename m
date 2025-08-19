Return-Path: <linux-fsdevel+bounces-58288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29AAB2BEBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089DF3B2BB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73437279DAE;
	Tue, 19 Aug 2025 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgS0L4zx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29A41DC9B1
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598698; cv=none; b=MTsMNHlUp9xbAG1KZUtFDvYtMIf8jYRaCgjj3laBZQLMTyF4gLMO24iO9IaGLBbTjPhkkCv4wCWv2Y/gXk1EevWX00q7/iwwBddS24vEtv6FrmptUIRde+4F4ZgKzqCemc83Quc4e9ZaJOyPywJrE5sEy1Fe/F+9s7xmCMS+n+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598698; c=relaxed/simple;
	bh=8jPQ8SuUiHGbv8sclBt6iuZ21otowDo7kqfE6jsG/2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERLquL5kqrNax1RLPmi+rJC6IpXYEnTkbhbls6lWEsWAcj2wq5v0ZtqDhYGPGzRt0T38Chq4jsQdhuHWbB6EUnvIHr1fCht1Lkl242ftdvgYZRQKTrvqih6elu26fCihmpMdrMzapEBKpQH64NO3fqzqd2m/oPAhOH7f6UELrzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgS0L4zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F242DC4CEF1;
	Tue, 19 Aug 2025 10:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755598698;
	bh=8jPQ8SuUiHGbv8sclBt6iuZ21otowDo7kqfE6jsG/2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgS0L4zx9QNrMYAllIkbdjfPDdyRYnOwktHeZNHdXEwcF2heQo66hgseQew8Dyo5d
	 i811N03BDPpr4r/WdyX0j+/iJdtwd6cPPkoT5zFWzIjo2R8IOqoIY+masffV/86vU7
	 n1+d7PXqvk1XynNmYnUfaWwScO1X6Yq14oHa5mK/YUTbr4Dq7rq0rpDXUOgQ1TF1Qu
	 PeR1/92I65b0yqjS9oPDe3I66MWlAcj2RaY1vMEjsgeo8o1/imvKknRoBzCEHJhQO0
	 qBXWXliM7STxeQblPs988gau9cdrv25hJeR1L/9ajol53Mb9XSMrGzKL6TTcs//qpR
	 Oq7W4WRzKgJog==
Date: Tue, 19 Aug 2025 12:18:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, "Lai, Yi" <yi1.lai@linux.intel.com>, 
	Tycho Andersen <tycho@tycho.pizza>, Andrei Vagin <avagin@google.com>, 
	Pavel Tikhomirov <snorcht@gmail.com>
Subject: Re: [PATCH 1/4] fix the softlockups in attach_recursive_mnt()
Message-ID: <20250819-schuhe-entkernen-4c3cc119b141@brauner>
References: <20250815233316.GS222315@ZenIV>
 <20250815233414.GA2117906@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815233414.GA2117906@ZenIV>

On Sat, Aug 16, 2025 at 12:34:14AM +0100, Al Viro wrote:
> In case when we mounting something on top of a large stack of overmounts,
> all of them being peers of each other, we get quadratic time by the
> depth of overmount stack.  Easily fixed by doing commit_tree() before
> reparenting the overmount; simplifies commit_tree() as well - it doesn't
> need to skip the already mounted stuff that had been reparented on top
> of the new mounts.
> 
> Since we are holding mount_lock through both reparenting and call of
> commit_tree(), the order does not matter from the mount hash point
> of view.
> 
> Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
> Tested-by: "Lai, Yi" <yi1.lai@linux.intel.com>
> Fixes: 663206854f02 "copy_tree(): don't link the mounts via mnt_list"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

