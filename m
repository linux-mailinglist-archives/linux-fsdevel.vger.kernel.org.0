Return-Path: <linux-fsdevel+bounces-47207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE1A9A661
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 10:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731D31B85DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D746122127D;
	Thu, 24 Apr 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKY11k6u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAA221276;
	Thu, 24 Apr 2025 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483941; cv=none; b=S/l0fludknIiR8tVi2fSfWGTzhnlmx2N0QlZC71qXEjXuzGmvyGUU11ALdpgFR27iwbLAbZpNyqoD+8d1E5CSKF7kKc1oQWRVTZ0wRQhFvSlkAsdi/IgVNTJ3RtTPSXMjfIncFo87ImBxygDPcUhEQEL7Xrf1bvew2H/h+QQQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483941; c=relaxed/simple;
	bh=PCC9EJ6KQRUdKxfOShP6zG8/IiBNAjnkcMqoQ/WHQ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5WqPDgm4djfidfBM+KRzYF4Zs32WpLtu9Ls/0hQy1fTknitVX6dYKe2e8TB5GmOUxoqaWIBX0oOVJeGi9JI66VczUAfhRG5nRDOEu6ChaEZn/kuKSgyzXcFCWn3DPk79I6yh6PG7v39T656QPfUBWpdQhjzay/Q2WBNuLoXHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKY11k6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF171C4CEE3;
	Thu, 24 Apr 2025 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745483940;
	bh=PCC9EJ6KQRUdKxfOShP6zG8/IiBNAjnkcMqoQ/WHQ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKY11k6uB5i2TVmjnefLWR7oL4+RiH4xlcfPYxLayivDd0lMWbPUrhvk3VUjVw8YS
	 xL8FXJyWSXje+AGUwjrJZWwufrOjeZBWxx6B6yeI37OeOUIJjSPfpAcN/J+clBfxft
	 vJcEG3YMiQ97aLRa4U5STBFQFayfv554gUpuV/g6rLOAKaHCVDTI24IKRbm9WNc4uS
	 QeRkNfAH2IPS1gO7EiQ/beqerouS1/YkeSHNlaJ0ASKPSiCuaUt7DnqLqrgjpGeLk8
	 K/3x97pslZJ7EWMwIo8POBJymSS8FP4Cx7fSkNaqfqPDGaMagCkECJSSnCKoF5QW51
	 sbXqxmgXJdh9Q==
Date: Thu, 24 Apr 2025 10:38:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	linux-nfs@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [RFC][PATCH] saner calling conventions for ->d_automount()
Message-ID: <20250424-gefroren-herzhaft-04d4f378b83c@brauner>
References: <20250424060845.GG2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424060845.GG2023217@ZenIV>

On Thu, Apr 24, 2025 at 07:08:45AM +0100, Al Viro wrote:
> Currently the calling conventions for ->d_automount() instances have
> an odd wart - returned new mount to be attached is expected to have
> refcount 2.
> 
> That kludge is intended to make sure that mark_mounts_for_expiry() called
> before we get around to attaching that new mount to the tree won't decide
> to take it out.  finish_automount() drops the extra reference after it's
> done with attaching mount to the tree - or drops the reference twice in
> case of error.  ->d_automount() instances have rather counterintuitive
> boilerplate in them.
> 
> There's a much simpler approach: have mark_mounts_for_expiry() skip the
> mounts that are yet to be mounted.  And to hell with grabbing/dropping
> those extra references.  Makes for simpler correctness analysis, at that...
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good!
Reviewed-by: Christian Brauner <brauner@kernel.org>

