Return-Path: <linux-fsdevel+bounces-50303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F4ACAB58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C7C16F7DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A891DF721;
	Mon,  2 Jun 2025 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzhYaH/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996061DF27E;
	Mon,  2 Jun 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748856471; cv=none; b=QPwogplnswoybI23jAlww84dBpchpirCnqr8GVXacidlHbQi9aZnS25pxxxJNETdpuZ2qgELMsmwxx1rrwfJtig+WMotgWClBGDCdv/6N9AzmWxqQttWjijKVocTye+ml2Rcd+fKcJ2lA6HNSGZTYtNNy4sffRt1InmMRehz8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748856471; c=relaxed/simple;
	bh=fuCwrDtAeeNlLsohNw8BcfdoS4oZ78T7wzvlQFE7D0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f25p0zel2m95HM8+2TmwNoKVkEDBz9x6UPPC98XViJwD/CtcJdnogYXWufUUB5VQ13CxIm3V1JdJJH1dy+uX60KNajIqCzYEUhwLlA9rdRelsmVml2Pq15HZqNX7rewp1uAhCudriNbITwvU24Wz4yC265v7oDQiYgaep/syzaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzhYaH/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757C3C4CEEB;
	Mon,  2 Jun 2025 09:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748856471;
	bh=fuCwrDtAeeNlLsohNw8BcfdoS4oZ78T7wzvlQFE7D0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YzhYaH/6BwzleMGi0lwstDdyVBU5xie15ljOfvo26nuvV6dY52Y9mvgjMm7K7XEKd
	 F1kzZbI+zo8U2E4PvObvEvD6Ws2Yq1qFWVF18VFsjDOaYqu82cK5wUfIPhULPma/5c
	 rPduVNTPn8E/2XejcgTgzwIwTbpQxqCwfvy0wBDd/K/O2C6aflBtHUQrp723ig1NC7
	 M1krVNbsHu1prOYuWxbEGEeLf+V0ZbkCR9OIAmxPfpy2cm9U7wi/v3D2Hu/QhwOPup
	 RUHAIfhCsF/wl+v3Pg/K5p0AL9pcbhjQM+nmuFUXs+M57/w9K0crmGLJ3AXoT7/LvA
	 Wonq17PVLiysg==
Date: Mon, 2 Jun 2025 11:27:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250602-lustig-erkennbar-7ef28fa97e20@brauner>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV>
 <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <20250529173810.GJ2023217@ZenIV>
 <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>

On Thu, May 29, 2025 at 11:00:51AM -0700, Song Liu wrote:
> On Thu, May 29, 2025 at 10:38 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, May 29, 2025 at 09:53:21AM -0700, Song Liu wrote:
> >
> > > Current version of path iterator only supports walking towards the root,
> > > with helper path_parent. But the path iterator API can be extended
> > > to cover other use cases.
> >
> > Clarify the last part, please - call me paranoid, but that sounds like
> > a beginning of something that really should be discussed upfront.
> 
> We don't have any plan with future use cases yet. The only example
> I mentioned in the original version of the commit log is "walk the
> mount tree". IOW, it is similar to the current iterator, but skips non
> mount point iterations.
> 
> Since we call it "path iterator", it might make sense to add ways to
> iterate the VFS tree in different patterns. For example, we may

No, we're not adding a swiss-army knife for consumption by out-of-tree
code. I'm not opposed to adding a sane iterator for targeted use-cases
with a clear scope and internal API behavior as I've said multiple times
already on-list and in-person.

I will not merge anything that will endup exploding into some fancy
"walk subtrees in any order you want".

