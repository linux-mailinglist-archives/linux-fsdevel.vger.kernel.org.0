Return-Path: <linux-fsdevel+bounces-40398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E42A230EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 16:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43E1188919D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7F31E9B3A;
	Thu, 30 Jan 2025 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp8KzevS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3FD1E9B00
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738250238; cv=none; b=hJ3J/54DSSTYGacv+F055KrRpp4KaBjnfB4GgSdgONIFLvrTVvKP6o8/6MS9mLqeedH+sLa0Zrhkm9gLYBB7gwdjtlhK4NclaRCMtR3UAEhSL+1pI5sAqq36v3yuysQK1VZ5+BOxf9rUzuFlbIfU/dXREY3LD3mSpY8D4zu/z+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738250238; c=relaxed/simple;
	bh=ji7v6KCFRzb69sNC9C/TVWw79BECWIRnct2ui+4L9d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+zEPL01OiSQTM8HFbj7MW56vAvchPHJ1HG9HUhqbeO2r8xL7oupj9XU7N5evusCrQK9NTDssoUsK9DNNw7DOKe+DDqaGHS0xGS/+n9A4hq6i7AbSPDhtwxbcLNqZZs+FflLCJSd1C9tQPHjRKfgSERYqmURDKaqsYJhJSrkH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp8KzevS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22F7C4CEE0;
	Thu, 30 Jan 2025 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738250238;
	bh=ji7v6KCFRzb69sNC9C/TVWw79BECWIRnct2ui+4L9d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rp8KzevS+l1xHIr2Q8AvpAVG/tcFpvPUZ8MexSxLLeXyuymot38pFg3O8gh0CXoD9
	 5+J5r0YNV66ub8k+92VIqluvAExGY1Kznz+F0B3n/qDuTUTD+EVWR2WpLGQfmc2EQX
	 7d9TMjCHms/PRoreBDqYD7kXl3++AclQshYlisg9YHAsZsbn4MZrKnPCUOQQLYdY/u
	 gwZequuQWf7FoL7M+D6DKXoJDI9ihUygvVJ6J3x6So/cD9nfUZvQJQzkMZ6+w9Wiov
	 9CXB4TPHvI0seZgrzsTWlOna51a1PKVGkSNzbKDZ8UFP6Cj6L6rpEROjhxx0mtlKez
	 XAzxuezznOp7w==
Date: Thu, 30 Jan 2025 16:17:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Lennart Poettering <lennart@poettering.net>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 3/4] samples/vfs: check whether flag was raised
Message-ID: <20250130-anlegen-lohnkampf-cf37a585cbf9@brauner>
References: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org>
 <20250130-work-mnt_idmap-statmount-v1-3-d4ced5874e14@kernel.org>
 <CAJfpegsVCPfCn2DpM8iiYSS5DpMsLB8QBUCHecoj6s0Vxf4jzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsVCPfCn2DpM8iiYSS5DpMsLB8QBUCHecoj6s0Vxf4jzg@mail.gmail.com>

On Thu, Jan 30, 2025 at 09:45:50AM +0100, Miklos Szeredi wrote:
> On Thu, 30 Jan 2025 at 00:20, Christian Brauner <brauner@kernel.org> wrote:
> >
> > For string options the kernel will raise the corresponding flag only if
> > the string isn't empty. So check for the flag.
> 
> Hmm, seems like this is going to be a common mistake.

Probably.

> 
> How about just putting a nul char at sm->str, which will solve this
> once and for all (any unset str_ offset will point to this empty
> string)?

Agreed.

> 
> Then we can say that instead of checking the mask for a string it's
> okay to rely on it being empty by default.

Right, but I do prefer checking whether the flag is raised or not. But
we can just support both.

