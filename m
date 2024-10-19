Return-Path: <linux-fsdevel+bounces-32430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DCE9A4FDB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 18:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F4F1C259FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0A18E361;
	Sat, 19 Oct 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="sv2VGM39"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110D10E3;
	Sat, 19 Oct 2024 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355505; cv=none; b=YioA5biSZtlGnLbb8FCMHh89gX73WV8zCPf8zTyJ6+rh+biCeFje4RSznqoFtkkbcbmtjs99WSlMRlj/eYkBzny6qnrJZRvahxDFQLRMPWRraiMJNf+HTmWZ9U7nbAWUnhP6/8zpIgqrjUjzfH2AReAi4OcAySjVgV6rPEgFlX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355505; c=relaxed/simple;
	bh=bGQ6l3gd1wlwXvzvtjxQAsAk+OvHn/ryuoFhSXq2t0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fFmFNtkpy/IR+loHFZ2QHunZCq6syaRXZFwUlysY51ECaIrpJrKohD7cQyuJSiS6XATdfXCbA5cbt70EUpEWJqU/gSVx1ya9p3+O30gjRYkffWgzfN/IKZdljxfjHpsFVm+z7RCvmEnBwPOiE0dp4eKpNAHppj1AJoTdeC8+xU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=sv2VGM39; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B0E9342B3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729355501; bh=WDxADfReoLe67ZxoBdxB2RBOIZMEtqF+3tEF74+v2f8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sv2VGM39/oJiwBPdyQHHOLESCQSPRTIj8PegObGVtEi+IDDklqdK2mRj9ynU5y0mV
	 vQujMzXR4/8gGX4UdO+whCE+dNV5SV+N4ADXI6PHRgqyHiYNeJvKBLE6QjOzuNcJEA
	 kryGx88tLBc5wZofuAlFrHVapgvMo5pjg9yc4pBQVPCaLKeCOj9Muy/KSh395NEpPQ
	 VfJga7l4QmvjP1K+E74IcF6SwNMo7Twp8HgkffWDVKUZzSH0yYRmIha9eCCvF0DW2X
	 2D5BYKsTXI9OgeAXAd+/ldDJg9SJQUQrLVC9E3epzxqd3l9XbuCFNFJmnFdxZliP8L
	 mDZVtUeIFWFMQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B0E9342B3A;
	Sat, 19 Oct 2024 16:31:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: chenxiaosong@chenxiaosong.com, dhowells@redhat.com, jlayton@kernel.org,
 brauner@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, trondmy@kernel.org, anna@kernel.org,
 chuck.lever@oracle.com, neilb@suse.de, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: Re: [PATCH 0/3] Documentation: update nfs idmapper doc and fix
 compile issues
In-Reply-To: <20241019071539.125934-1-chenxiaosong@chenxiaosong.com>
References: <20241019071539.125934-1-chenxiaosong@chenxiaosong.com>
Date: Sat, 19 Oct 2024 10:31:40 -0600
Message-ID: <87jze4vytv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

chenxiaosong@chenxiaosong.com writes:

> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>
> Keep usage of `nfsidmap` consistent with nfsidmap manual.
>
> Additionally, fix compile error and warning when running `make htmldocs`.

These are logically separate patches and do not need to be grouped
together. Additionally...

> ChenXiaoSong (3):
>   Documentation: nfs: idmapper: keep consistent with nfsidmap manual
>   docs: filesystems: fix compile error in netfs_library.rst
>   tracing/Documentation: fix compile warning in debugging.rst
>
>  Documentation/admin-guide/nfs/nfs-idmapper.rst | 59 ++++++++++++++++++++++++++++++++---------------------------
>  Documentation/filesystems/netfs_library.rst    |  1 -

This is already fixed in linux-next

>  Documentation/trace/index.rst                  |  1 +

...as is this one.

Thanks,

jon

