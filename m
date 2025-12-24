Return-Path: <linux-fsdevel+bounces-72061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A44D2CDC4C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 14:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AD82300CCD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366C730B519;
	Wed, 24 Dec 2025 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVdOQZRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9376986348;
	Wed, 24 Dec 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581280; cv=none; b=t6hqUl5RmTRv1ERRc1nnutVBQ5/O7LItDT4qlB4r6XBkMTCxsCDUrht6u05Bgv38fFi7V7pthFjh99DYv6Ua/7RunpA1QWO3OHIFZj4IUhuK6dEIhNNoB4MkLxJZPa0IS/dcZVkQr+MTHPjKHsW8QtuOC4qnYpA4uuVxNW0J4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581280; c=relaxed/simple;
	bh=gllI/iW13EaG200GvGKp4IX8tqHRo7m9nSExqpndb0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McC1BMNvd+FB4r7jwuF0vNCpZIpHnFCkPU6tTKCg0YtOaYqUSB1QgKV2KL8ffDF6yw2VZ1EEeDngGKIr237Vm2Ecu6b8UohJQKm6jMHSLusrvLGXE6h+qvJkif9YVTzuFVMrUZtdEmcSUFDDRIpH9MxxKN0SgNHEBq7E8k0psTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVdOQZRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1848CC4CEFB;
	Wed, 24 Dec 2025 13:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766581280;
	bh=gllI/iW13EaG200GvGKp4IX8tqHRo7m9nSExqpndb0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVdOQZRQrcWD7rLjcLNkRTpUPILJm7bhoGYUXABGYpYQQJRZtKUScRRTwNVTQAK8O
	 hy9E4QvgBDe7T/DvGkrSiJ96NsCs9N/3OUOxYgwC4wldl36dfJpYz8FAPlCOdtuvHd
	 /xtnJNh3M1U3cLOBTF3++/1L8Asqgk0KYfFF9MZNhFuXEHX5A26yzzjKQPnFZIQoy/
	 DNWZJN+qfyvN4ct8uX5Kln6WKIn5IUYrOLsj6ySEwKfrV6rKNC1toGBZAmhkEWhDyr
	 rX2tdFS0Y8RcWguMg+PlYZisLGye327hbP+ciVWvhkgD0zXkr5qbxhuAsSc3Lg/qEf
	 Jl+sKz3xRBzIg==
Date: Wed, 24 Dec 2025 14:01:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matteo Croce <technoboy85@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix overflow check in rw_verify_area()
Message-ID: <20251224-abnormal-speichel-bf5e39f87d49@brauner>
References: <20251219125250.65245-1-teknoraver@meta.com>
 <CAFnufp2YtYGioCtFyTpNufh2Kc3=8HRrpfTdsF9pZ6O0aCkSdA@mail.gmail.com>
 <CAFnufp1LcTCLtCrd=iLxD7DPaOouov=BW=Scj_yXJ+Pn96RKLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFnufp1LcTCLtCrd=iLxD7DPaOouov=BW=Scj_yXJ+Pn96RKLQ@mail.gmail.com>

> Following a discussion on the coreutils mailing list[1] I think that
> this should be fixed differently.
> I'll be back with a v2.

Ok.

