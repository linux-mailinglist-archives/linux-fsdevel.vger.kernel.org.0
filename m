Return-Path: <linux-fsdevel+bounces-12679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2618626F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 20:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9111C20E07
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 19:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C7B487B3;
	Sat, 24 Feb 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNPU5Ydy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240A481D0
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708802391; cv=none; b=ptIJP/R2vMoPSQ2HWNvDOjfwqQ+QX6DXiygiUVUnzzNIQD9VBZ/X7HgtuQ16t8N6JmkXQSRIgdctk54QcaH7NnFmJkqU0jp+jb1g6d6gYPmvkUBVweC73gIOQQdDD/0c5emExlTrIX+A7pv67tHbpxxzPup5gnvu3r2HZIQslVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708802391; c=relaxed/simple;
	bh=8qI6kMofuoDMylB8v3IB0vNgh9WU8ioZXc4HQMRQFmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNGAIbJVFTE2OReT3M/+M6MuGTPBLKbWuap8YrhtdXlpjmflEFq+Lz2sprhtGBB/Qi3BvShHhMtof6knYPNIjGnkzPIp+ypaDtbCQYMbB6I+QxYjxmssv1H9AEtrUMvzYK0d/g1zadeHdk8HGBMQQvkHWAUBGvLz6nx0cVZqZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNPU5Ydy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF961C433C7;
	Sat, 24 Feb 2024 19:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708802391;
	bh=8qI6kMofuoDMylB8v3IB0vNgh9WU8ioZXc4HQMRQFmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNPU5YdyB7APWOHiYwE5scx5bju6J1zQsYg0xxbyQGaZHQD22gAlKL15HhGdd6E8r
	 GRICgZZ2bqwKwlGtJpcoMrI35Nu9jYq4fi7iyT/JypmrkecDBuqkNNe7BwSaSktM1H
	 7MJsUUzPuEewvLjPY4+CYwxXMJR2O+rCqx5pnnlRtSN6MCD7E6a783H1n1A5InFvn3
	 sNX4JujXSck5lCmmPzarbqaoth7lCbfkARaOBMjC6/DbI4lR9HSBgkOkAsXl3NcK6Z
	 IF3uuImD08EO4N9TByuixO695FGZ1IXAqxbSZPdfYnY3sWG7iOpeVgYRJoh7n5p1n7
	 x+1Pmf0ni1YWg==
Date: Sat, 24 Feb 2024 20:19:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
	Heiko Carstens <hca@linux.ibm.com>, Al Viro <viro@kernel.org>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240224-umwirbt-laube-e16410f60efe@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner>
 <20240223-schusselig-windschatten-a108c9034c5b@brauner>
 <CAHk-=wg0D8g_97_pakX-tC2DnANE-=6ZNY5bz=-hP+uHYyh4=g@mail.gmail.com>
 <20240224-westseite-haftzeit-721640a8700b@brauner>
 <CAHk-=wguw2UsVREQ8uR7gA1KF4satf2d+J9S1J6jJFngxM30rw@mail.gmail.com>
 <20240224-altgedienten-meerwasser-1fb9de8f4050@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240224-altgedienten-meerwasser-1fb9de8f4050@brauner>

> How does that sounds?

And fwiw, this is equivalent to what we do today.



