Return-Path: <linux-fsdevel+bounces-35788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748FF9D8550
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 13:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6251692CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2E191499;
	Mon, 25 Nov 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq3Ax0Ix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BD1552E3;
	Mon, 25 Nov 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537249; cv=none; b=lOsGc/oCnWgYbXKFTZIXseS6hNauTHnNRbECtI9lcdZDq2GxTq0bNlOYupM4Su9FGheKTvVqWZsyIEhl9YQmF7WtGelwGe/LmowgHEcJFkA1PUfwnDRRMR/VqUMPresM3eCpawLUfdj1yD6jfuMRe1c+R57w9xQe+RBmkuRCV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537249; c=relaxed/simple;
	bh=zf36PKbSDKogaaNy+/27WO9B5XfGKYZc6KeVxcE1eL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFVybZEVYjrBaA7RnPQt2nzMcZGMUP3N81+ypqmiu/pbJyN+AXbi8o9zKTvo1xK7g43dh2ffDyPj8TzbheCeEwU37Y9C3tNdEfQHqdTqAAxkOeCnZdIZa992nWpyKbGmYJuvMy3b1k+k4f9AYNY6+GWBRGgZz284z9VXsmVVmB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq3Ax0Ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C285C4CECE;
	Mon, 25 Nov 2024 12:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732537249;
	bh=zf36PKbSDKogaaNy+/27WO9B5XfGKYZc6KeVxcE1eL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nq3Ax0Ix09pavfZaL84YwIyTZbspqn1m44vPLSXHmY9kICNLAqBjEk7r79u/Ph1gF
	 RDS7UUulx7WdBtmQq3hj0hrPPO7l/VmZYDjBbzZSbrPIOo2d9i+YinY0t0/tnxgz63
	 x5TMzOmBgofQykOPrNDesbxVkrJdy0si+E59sgqDAk8E+bbSIS9cihIB4ssJ0xD0JN
	 yocenSfUMbLtowAQQ6kdCcP3HMw0dBet5Lw6YsKoXx8YxN/+XAMBa+9WzX0bLwXyRq
	 gJrfmO4FeikYsYkQagNOcxlGmu0TMqrvjHwBiD1tmR9YpZVS4wu+0pNQ/QG/UkaSbZ
	 gw994oCgK3PAQ==
Date: Mon, 25 Nov 2024 13:20:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	21371365@buaa.edu.cn
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
Message-ID: <20241125-bedacht-finte-f2ecdca1591f@brauner>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV>
 <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>

> So I mention the "rename and extend i_size_seqcount" as a solution
> that I suspect might be acceptable if somebody has the motivation and
> energy, but honestly I also think "nobody can be bothered" is
> acceptable in practice.

I've said it before but I'm strongly on the "let's not care" side of
this rather than complicating this code unnecessarily for some weird
corner case. So I'd be pretty reluctant to exited about patches for
this...

