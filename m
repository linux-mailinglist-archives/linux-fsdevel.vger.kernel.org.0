Return-Path: <linux-fsdevel+bounces-52167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93205AE0058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90063AABA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9BC26562D;
	Thu, 19 Jun 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwI1tCtz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FFA3085A5;
	Thu, 19 Jun 2025 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322900; cv=none; b=jNslDwLqwiPaljFBP6phpqWkuuqWJ9rbYQSjIfIIMqUvQH2f/FSgjPCqnlWYqsSWNEVS9Qag3fgRY+S6ojkoULF3EXIEsA8XfOTQWgorimzjDtIaHw+iHKidh4fI517eWoZgxFLbIFP7T1OuIECrULn4pXP1ZAwfUrXBumdxPo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322900; c=relaxed/simple;
	bh=48BhRGPoPQC3ZkFsaCUupKaDvr/iXvVX4G/QDp4DAKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBetjvoe9BQyJxypKmC7JUWpYUxRBtuYVZimDpIQoy/kBh75JVyMrU5c/f8h9s6ayZgDC7aFS4tqCioFIp8GYCb5mhQYoyQJJQ+h7nvTzGXwRfOblAi+zsbUvMK9E08yrFl9KV7ZKAYE6eEwLw17b7s/6qYmzSaOSSM118wrouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwI1tCtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A52C4CEEA;
	Thu, 19 Jun 2025 08:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750322900;
	bh=48BhRGPoPQC3ZkFsaCUupKaDvr/iXvVX4G/QDp4DAKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwI1tCtzVaxcRAQ+91xU5Yw1D1P5yrJOQ1NmyJ1w4RJuBfuwYpXo5TpyixVWFqgmh
	 HMMOmlsLB++U7x1wCuApC2Z3C+zFZSAokbSkG2ha1zX3CBeP76mnO3hcCoowshVdTF
	 xv0qWAjQ7GTRisIXK5A/3Acc+CDMz9W49nN1oEfdDxcnekeK3MfICNEI+1xTEckG8g
	 lj1FmqG3xMwbKZ6Df6kQV5Fg1VEaR4d8MIEgBANFbghsnjmYz8DZnu09tg1G/tKlnY
	 T+YVwJD5SmL/rWD7pqSq+29q326punG6FW8MynVsf+Zn3jc9dylXtCA1Ofm+RnRmkX
	 Qmz25pxKQquJA==
Date: Thu, 19 Jun 2025 10:48:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, gregkh@linuxfoundation.org, daan.j.demeyer@gmail.com
Subject: Re: [PATCH bpf-next 0/4] Introduce bpf_kernfs_read_xattr
Message-ID: <20250619-zwirn-thunfisch-de6e4891a453@brauner>
References: <20250618233739.189106-1-song@kernel.org>
 <aFNdNv4Bvw6MwlaH@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFNdNv4Bvw6MwlaH@slm.duckdns.org>

On Wed, Jun 18, 2025 at 02:43:34PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jun 18, 2025 at 04:37:35PM -0700, Song Liu wrote:
> > Introduce a new kfunc bpf_kernfs_read_xattr, which can read xattr from
> > kernfs nodes (cgroupfs, for example). The primary users are LSMs, for
> > example, from systemd. sched_ext could also use xattrs on cgroupfs nodes.
> > However, this is not allowed yet, because bpf_kernfs_read_xattr is only
> > allowed from LSM hooks. The plan is to address sched_ext later (or in a
> > later revision of this set).
> 
> I don't think kernfs is the name we should be exposing to BPF users. This is
> an implementation detail which may change in the future. I'd rather make it
> a generic interface or a cgroup specific one. The name "kernfs" doesn't

cgroup specific, please. That's what I suggested to Daan. 

