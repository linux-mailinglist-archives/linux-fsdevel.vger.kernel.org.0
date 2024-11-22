Return-Path: <linux-fsdevel+bounces-35598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B5C9D6333
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 18:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1E5B22872
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7B841C72;
	Fri, 22 Nov 2024 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CzKMkrcE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6431C9DD8;
	Fri, 22 Nov 2024 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296845; cv=none; b=pu5paN+J5r73CHZqbsQbyP32SLUqrXnYiQQ0PqTWsau+oqiMjOrcE2cooyD3/gutLvOAye48DRtACV1TtU6EJxqDE8uC8QrcZFdKdgbmQLeU+N66z0NKXHxwGZRraa8biCReNxmBaWgDw5ciE09sqAIgr8IvilwGvbt6qlhVEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296845; c=relaxed/simple;
	bh=2sHi/a+0wuB3fqVGPacRh7HtzqPdmGXg+wZjiwrdo48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H8dnZqHRoecrnuoD1E6VjqkqJ+uzhtgv9HjQpPd5XWNvot1T/u/R2HleacFArLtaOvYkLniWQP1gJkhz1lwgPS7GkHxr3sc0ric0EjY6Mm1om8kb/WJWNheGFDlYTqMqkVLHE2Sn7XdsEhsVfRZCM2zW46SHS0Mws+9RvXVf7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CzKMkrcE; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EAE50403E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1732296842; bh=mGnMSq8J7sgcF7jpZFZz2wdJr2vNucWms4i6GJBNlr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CzKMkrcEB78tvbB+uNDHs6JKg5GQNVTEx1w2hx/9rV/OF9s318qZQFEzh5gEJ1i9J
	 xeeISVRGAI/t9weGAbhP0Ih4vdiWsI3OQNtbv0PkabR36nFYYTZ3min3X8noudj0er
	 E6wUPzaqmsNXvCisyLpCCgBExaBQ5BE6+X9TRVCF1ni2m5m3VD4HepkXeIfPZKagFu
	 m4o+GWOf7ONpauAy6knmowpDQ/PF/cpFzMTK1GSnykkxdAe0kD2J4iS2vkLZWOoDFR
	 eS1M66WYy2smr9XGJe+QJTZsrtUuHRsM8vMPeWwOBngiBaD9BgG+/2AStIeM1oC8tk
	 4KHMwCrcC+tKg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EAE50403E9;
	Fri, 22 Nov 2024 17:34:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>,
 autofs@vger.kernel.org, Alexander Aring <aahringo@redhat.com>, David
 Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, Eric Biggers
 <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 fsverity@lists.linux.dev, Mark Fasheh <mark@fasheh.com>, Joel Becker
 <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH] Documentation: filesystems: update filename extensions
In-Reply-To: <20241120055246.158368-1-rdunlap@infradead.org>
References: <20241120055246.158368-1-rdunlap@infradead.org>
Date: Fri, 22 Nov 2024 10:34:01 -0700
Message-ID: <874j3z41h2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Update references to most txt files to rst files.
> Update one reference to an md file to a rst file.
> Update one file path to its current location.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Ian Kent <raven@themaw.net>
> Cc: autofs@vger.kernel.org
> Cc: Alexander Aring <aahringo@redhat.com>
> Cc: David Teigland <teigland@redhat.com>
> Cc: gfs2@lists.linux.dev
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Theodore Y. Ts'o <tytso@mit.edu>
> Cc: fsverity@lists.linux.dev
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: ocfs2-devel@lists.linux.dev
> ---
>  Documentation/filesystems/autofs.rst                 |    2 +-
>  Documentation/filesystems/dlmfs.rst                  |    2 +-
>  Documentation/filesystems/fsverity.rst               |    2 +-
>  Documentation/filesystems/path-lookup.rst            |    2 +-
>  Documentation/filesystems/path-lookup.txt            |    2 +-
>  Documentation/filesystems/ramfs-rootfs-initramfs.rst |    2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

jon

