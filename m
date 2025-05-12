Return-Path: <linux-fsdevel+bounces-48728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C53BEAB33C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E80189196A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DEF25B1F0;
	Mon, 12 May 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKKlu05D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF024E4A9
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042396; cv=none; b=o70stKdI581X6NdfO+q2ojzgXMiu4FZ7WXRv6P+cnsOX+wZ1EwHOZRXA0eNCmtvmLtkHM1ER8dcKtX8L88MDcPzx1dir9TOPm6u7vzgUtahmNypj7iLBNgo8HX2AoWBFxb7Et9aa6KN+qq3qFDm6JHnGMDRlTmFQfNQQshdN/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042396; c=relaxed/simple;
	bh=bam2/qaoJ1FobsY8aUZDuxwfWvAfeaXY0wbN28IBAl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqzUs0s33qegEUoRZknfYJKKaH3BBQJYNyusGvMKXEzw67WtIxaLe7T8j5POd0nqlHQuz9Kmxg0ACW8Wnk4iXmKNlg8O3bJ+3D0HwNFJYpVNQkwr1KqX46Lkj8MSdIZWMatpY/DKkfVR9kstWXcby5AvNQzNhrt17s/4lZZdXik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKKlu05D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFC7C4CEED;
	Mon, 12 May 2025 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747042394;
	bh=bam2/qaoJ1FobsY8aUZDuxwfWvAfeaXY0wbN28IBAl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKKlu05D9XFCisvm30zwO/OlTS9asAERStnIvW8dfzz7lsQ+gx1Fkq4Yv8kNDOhLA
	 OvYpc0KNJ6XcTeMxb4yh9YTJU9K0Q9o4N+chaTswNLWxj5E83MHa+DbYPv6TLIg7or
	 QGqdFyjNNpV2imzACUeY8XGTtE1mKuwywvetrV1hSgO+Xs0z9O/fi9P2ZrVAw2M79o
	 ftWclr05GSjvVMUBnpG4nRZpr6r1D3FP9V/v6y9Txu8tRH5TTuRVTuSONi+rTrkKji
	 jan2w3u0MSqVQUuNdy5OYuTsMu5fqSgS1sIDCC13l34kPyl8yZJmF24uQHfoH3EfBT
	 4paupcsNDFzFQ==
Date: Mon, 12 May 2025 11:33:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] selftests/fs/mount-notify: add a test variant
 running inside userns
Message-ID: <20250512-anbauen-kribbeln-fd38812a1e5d@brauner>
References: <20250509133240.529330-1-amir73il@gmail.com>
 <20250509133240.529330-9-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509133240.529330-9-amir73il@gmail.com>

On Fri, May 09, 2025 at 03:32:40PM +0200, Amir Goldstein wrote:
> unshare userns in addition to mntns and verify that:
> 
> 1. watching tmpfs mounted inside userns is allowed with any mark type
> 2. watching orig root with filesystem mark type is not allowed
> 3. watching mntns of orig userns is not allowed
> 4. watching mntns in userns where fanotify_init was called is allowed
> 
> mount events are only tested with the last case of mntns mark.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

