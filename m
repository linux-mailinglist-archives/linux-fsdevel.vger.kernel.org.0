Return-Path: <linux-fsdevel+bounces-39043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D77A0BA09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A87168DA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1D322DFB9;
	Mon, 13 Jan 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXeSoBWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31222F856;
	Mon, 13 Jan 2025 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779144; cv=none; b=JmkfVvyZWQq8IqZ0y9e4F78ywFwD8IoeHyXdFwbaJ1p4tnuEVGgDsBi6RDk5PbHvG9oQ8xhPepoeL0CFcZLviyMYZM6B+I1OlTBtQ6qLTPPxvGXHkxEgJnZ7iNkJDCldSNqiVfEFCJ1JLp0VetJ01JksAhPek/KJ8ARzBriOJwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779144; c=relaxed/simple;
	bh=s9fjE9oDzT9N4h25eRsQKPTNrjHuh5bW5JSIu8HyW+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9o75wWJoUEbrcrZGgtkY4Ksvn2wahcbGWUanh6pU3d1mH3e3YugSSTE1VJc39SKTLQ+27zaIrxAvm0pdIRnb36f2TYbagiw2vYoeZzHDrext54I53gTLH9hAgcVFJr0KeUku8V/1oxE3U8aWuG52o6chOojHaPNXheDcPGvD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXeSoBWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2210C4CED6;
	Mon, 13 Jan 2025 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736779143;
	bh=s9fjE9oDzT9N4h25eRsQKPTNrjHuh5bW5JSIu8HyW+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXeSoBWBjwd/aSh2pdFN33d/KprLHIMdKdlJg5LrrII8c6eLTsgoQ2qp3g4Kp/PLP
	 mv1PqfYQyMRYGaY/yY8MSc9YG8yC/F7VbC9ANulHDGGPoLuz/4GKhPF7Da9357/BGf
	 1DTWTszySGEIv2rZJfBSDkzYyXKTwnHZ9H/9YLaNW9IGh3YWzGhd4ndkYsKV1I4WtD
	 PGnxdOmg/CQteUXmCYAOxsd85XapoNvJ8I5xWUr6a1GwtXV9l3M1u9sqU/+mC3Awwe
	 aFPxeXA9Hkbz/0uYegAD6Md5+gs/uKY1UBYBFIHvy6zfNYhnFcQvFfY4dPjzKzwA0U
	 OjAZOmBitC3CA==
Date: Mon, 13 Jan 2025 15:38:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kun Hu <huk23@m.fudan.edu.cn>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, jack@suse.cz
Cc: jlayton@redhat.com, tytso@mit.edu, adilger.kernel@dilger.ca, 
	david@fromorbit.com, bfields@redhat.com, viro@zeniv.linux.org.uk, 
	christian.brauner@ubuntu.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <20250113-herzhaft-desolat-e4d191b82bdf@brauner>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>

On Sun, Jan 12, 2025 at 06:00:24PM +0800, Kun Hu wrote:
> Hello,
> 
> When using our customized fuzzer tool to fuzz the latest Linux kernel, the following crash (43s)
> was triggered.

I think we need to come to an agreement at LSFMM or somewhere else that
we will by default ingore but reports from non-syzbot fuzzers. Because
we're all wasting time on them.

