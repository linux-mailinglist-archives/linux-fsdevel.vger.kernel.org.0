Return-Path: <linux-fsdevel+bounces-53877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D0DAF858B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 04:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F6487B72EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 02:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86771DF756;
	Fri,  4 Jul 2025 02:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Zk1/cAcz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936CD1DEFE6;
	Fri,  4 Jul 2025 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751595782; cv=none; b=UXah4U+ggNkkuWiJTvRWJqn5OzkYTxQbU4UZqB83vqVOCmbIfh3zPnXDKoOxh2W+58rmbu+CuSJ7GHazYkcqhf+rs3mg2gs5vvPIDx99BlVVMwx16r8/Tc0VKepqE3JEa5D8Z0Cfmc4E/0h9LGuhCZKIJXcaAhWF4h6ys3NfN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751595782; c=relaxed/simple;
	bh=NrZ6/n/m2RAIwTTigBPlAbOSlc5v7pLbg0aCDmq5uTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DM7AgDmUktRzpit7miOnxTXu0q3Q3bC97yw+MG0lcBt9gHbTzwjnxdXugY8HGxMLwVrZEG6Yt8lviGDbxhJhdlm0uKWGBvBOy5ewMMkBdMBViwajCwZvVoeoeRnWRMAwNsUus+M8S72K0r7SBlfZLRCxLyxLxYi+6YXri5UsHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Zk1/cAcz; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 94C73403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1751595779; bh=EyHqlu7/tN57sl37w/zvbLqmOB4xScOYcUGZ/nzC8pQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Zk1/cAczr8eb9rgp19HkWsINbT80BzbE/D/Vo3y/yvL7TcsNmbcCXdRT1kAl7/AkN
	 wHkrix8QyP0aoa7T2upud9TXoHAoX49Nm0RrVMm57DWl4uKVfivY3s05PUczKxq9qz
	 9MlhDpXBGVChB8J9ixjEGX+x68JmFTs1KgjuWhaaP4zHEkGff8t2JsT7N3dMsDmHFZ
	 COa4bDgcELMQdBDXuLIeFgLKq2uqq15bZUkWH3UAXChaky1HIUHun6EKm4Wu2RoYUQ
	 iUaVcFYZYG4qVnZf/m3zjhTRQklrXTkw6a85fg5rfvjI7U8p7bGEDQArGZqxwfFsVw
	 Y48dbgcURvI5g==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 94C73403E1;
	Fri,  4 Jul 2025 02:22:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, John Groves <John@groves.net>, Dan
 Williams <dan.j.williams@intel.com>, Miklos Szeredi <miklos@szeredb.hu>,
 Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Matthew
 Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 "Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, Aravind
 Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 18/18] famfs_fuse: Add documentation
In-Reply-To: <aGcf4AhEZTJXbEg3@archie.me>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-19-john@groves.net> <aGcf4AhEZTJXbEg3@archie.me>
Date: Thu, 03 Jul 2025 20:22:58 -0600
Message-ID: <87ecuwk83h.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Thu, Jul 03, 2025 at 01:50:32PM -0500, John Groves wrote:
>> +Requirements 3 and 4 are handled by the user space components, and are
>> +largely orthogonal to the functionality of the famfs kernel module.
>> +
>> +Requirements 3 and 4 cannot be met by conventional fs-dax file systems
>
> "Such requirements, however, cannot be met by ..."

Bagas.  Stop.

John has written documentation, that is great.  Do not add needless
friction to this process.  Seriously.

Why do I have to keep telling you this?

jon

