Return-Path: <linux-fsdevel+bounces-52143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFD8ADFA59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 02:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D81189FA1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE8155A59;
	Thu, 19 Jun 2025 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hop02Pwa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD12110;
	Thu, 19 Jun 2025 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750293816; cv=none; b=jdk3vA/uRUvdChxUw2PfqT7jvtJLhC9kb0qetIAUQa+fCjQCWZS9L+K9Y5sAgb8rDPRaFQBXGjzW1q41RYjEqivlhCG1t2g0zsUqHB6NS9+HMhuo9P5qqpsco4gvJuY1MoSWLahR6NO8uHCo0pNtw2L4YnyIaQ5YfRQsPVgMu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750293816; c=relaxed/simple;
	bh=M+aQ4uVYvU10F4gbFw08dWri1Ncv/UDrlH7UcglAFRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulpzwUNLDZFyICYw43lKZVzyvm+Dq1YZpZvfUm30HPo+EGy6bXejmcXqk2pjxlsjAWH7u4hVtbxpdq5ToRi3r5O0qJ2mj8uE7smVcyTx+anCzu3SD2vfnjr2d456+T62N0lGgpLSN5L4xIp359ImPT0KnNeGHvmcuu/F+wdL7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hop02Pwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81D8C4CEE7;
	Thu, 19 Jun 2025 00:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750293815;
	bh=M+aQ4uVYvU10F4gbFw08dWri1Ncv/UDrlH7UcglAFRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hop02PwabyWEchz1nQDouR7SRVN7lVTzEnaIcQhj8pBQoJG1p1rLDatkwb3hZQG9F
	 6hYClGtHQ3zk4JjC2p8/hxDCnXIx0tztgyPOi0jMPtINnFgMJiUTRRO3/KxRFKp7Tz
	 LOFDtjEI1w9NBlrITTLcNGk2yNxEjAxa+gwM767/3vr6EA5PP7wwyVrlqlkVwUQfnr
	 feFVUdh1FzYzZAdqzdsdTI7HXrcvPar54a7R5YCg3ed7HSlOZUT+FwY8+jr0Xfhbbq
	 ZMNge6NEMfUE6E+93DwusJITeN5NN8RBKRTRiPWKqaSd9sdzqq8mQh/NLDTxWCxYKm
	 at+9J/T6UZrBg==
Date: Wed, 18 Jun 2025 14:43:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com,
	gregkh@linuxfoundation.org, daan.j.demeyer@gmail.com
Subject: Re: [PATCH bpf-next 0/4] Introduce bpf_kernfs_read_xattr
Message-ID: <aFNdNv4Bvw6MwlaH@slm.duckdns.org>
References: <20250618233739.189106-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618233739.189106-1-song@kernel.org>

Hello,

On Wed, Jun 18, 2025 at 04:37:35PM -0700, Song Liu wrote:
> Introduce a new kfunc bpf_kernfs_read_xattr, which can read xattr from
> kernfs nodes (cgroupfs, for example). The primary users are LSMs, for
> example, from systemd. sched_ext could also use xattrs on cgroupfs nodes.
> However, this is not allowed yet, because bpf_kernfs_read_xattr is only
> allowed from LSM hooks. The plan is to address sched_ext later (or in a
> later revision of this set).

I don't think kernfs is the name we should be exposing to BPF users. This is
an implementation detail which may change in the future. I'd rather make it
a generic interface or a cgroup specific one. The name "kernfs" doesn't
really mean much outside kernel code that's using them.

Thanks.

-- 
tejun

