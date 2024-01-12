Return-Path: <linux-fsdevel+bounces-7862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF65582BC9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 10:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843371F235FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 09:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33325675B;
	Fri, 12 Jan 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZYCAQk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811155C32;
	Fri, 12 Jan 2024 09:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60CFC433C7;
	Fri, 12 Jan 2024 09:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705050027;
	bh=YI2MBsGksfRvnck5eV3vj+iBhMjVRTG567aWxvxO1vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MZYCAQk37wO6ZueXyiyiwNC/hJzSFL59QVVW2pn5cRRvl0tcHlLZpzGb67EdFcAlo
	 qxPJdtyLF0tTjxhY9mE4S186QOwLe3hkJpsNE1K7SC6Y0lkjeTeLRKkfz0ZWe/BIV/
	 O79g6u9D5mhM0Hr1p6/zkOViOhMIm6hNh//LD9MdEvktxArHXnPUrrJR7jmzit2l6M
	 SunzVoZKI+gvSPCtKvvt0hC7lD5Ywq4jROHNIJm8btr491PobAK57fbdrmhGMJ2/0G
	 v/87qWM40Yu2KGq83Vhoig6wPcg48lLqakR4CxABfd36OPhLcn7sLss+H3Xq2YcflV
	 VFRD9igaSjSlw==
Date: Fri, 12 Jan 2024 10:00:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
Message-ID: <20240112-stilbruch-wildwasser-f5b4323410ba@brauner>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-6-mszeredi@redhat.com>
 <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
 <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
 <2f595f28-7fcd-4196-a0b1-6598781530b9@roeck-us.net>
 <CAHk-=wjh6Cypo8WC-McXgSzCaou3UXccxB+7PVeSuGR8AjCphg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjh6Cypo8WC-McXgSzCaou3UXccxB+7PVeSuGR8AjCphg@mail.gmail.com>

> NOTE! ENTIRELY untested, but that naming and lack of argument sanity

Thanks for catching that. I've slightly tweaked the attached patch and
put it into vfs.fixes at [1]. There's a fsnotify performance regression
fix for io_uring in there as well. I plan to get both to you Saturday
CET. Let us know if there's any additional issues.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.fixes

