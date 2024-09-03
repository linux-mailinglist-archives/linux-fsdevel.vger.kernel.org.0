Return-Path: <linux-fsdevel+bounces-28361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1F1969C34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603E41F24140
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5D21A42DF;
	Tue,  3 Sep 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gKOAHiKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C961A42C2
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363728; cv=none; b=MqgM4mAOzwzyvsv3L4lr5LoQDgnJUk+rLBwYbDcCK87jt0PO+xLHFF8ZMhMu5PO6IpoXyBooiq7APWjXWjTZVUL1o+IDIysZvBiyoh3YcZP+fh2/0D1brR02QblBs2TsDWQ5zXTSwkD1wVlqNY7sYw89JSDx3SyjUxxrZW7d2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363728; c=relaxed/simple;
	bh=e6pTgwoO6d0zsvht0XdWQe5baWFg+LRWuD9+jzB8cJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezE5I/QBUtM0xSvq8+iwFLDHXl+i7ZhFnz89bfkwuC1zC70dSiE+AwFhZOI12lBA15yVN+hDcoNorvNmxt/nnPzQwveWzXG5F6dpfTY4zEGPmh34OUY+gbPdS1+EytpH2yCPbh3AV/a1YNExGUQTBqtn14cDy5uGPi6ExKLJYlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gKOAHiKu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 483BfYcr027588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 07:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725363697; bh=iPRB6Gjttbol0VPss5oDVUKbvsURabvFSdzfOBAOXLU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gKOAHiKukciM+tUHrN97FNg0iXtWFrqusqNTFuReprnTbms3cz90E20lbdF37oP8U
	 7CT6koE9sbMCV3f8g6Qbaqtzcd7kLTQWFA9D7ZRKDrkXAGLQ4LdwQUlPHHGmaYsYEN
	 pqFXmP3GubHDmDbKllEt5g3ro+SGet4fsDTn2jNrPd0im83A+cr+/LE5Vd6eUWWd98
	 dzJI4rZOFlIEuJncqq/5UKbTzWQw89O49UWBQ1SwkDr7Jz8PaRRCepDKDlDjLwfsrz
	 Nms759MQBFA/mn50xfBuUCtzZdXZMG6SMT/RT4hM+uTlEw+X9C8GQhcyyejwncQzYO
	 J/qr5fgrWF6KQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 81CD915C02C4; Tue, 03 Sep 2024 07:41:34 -0400 (EDT)
Date: Tue, 3 Sep 2024 07:41:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        krisman@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        Daniel Rosenberg <drosen@google.com>, smcv@collabora.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 4/8] unicode: Recreate utf8_parse_version()
Message-ID: <20240903114134.GD1002375@mit.edu>
References: <20240902225511.757831-1-andrealmeid@igalia.com>
 <20240902225511.757831-5-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902225511.757831-5-andrealmeid@igalia.com>

On Mon, Sep 02, 2024 at 07:55:06PM -0300, André Almeida wrote:
> All filesystems that currently support UTF-8 casefold can fetch the
> UTF-8 version from the filesystem metadata stored on disk. They can get
> the data stored and directly match it to a integer, so they can skip the
> string parsing step, which motivated the removal of this function in the
> first place.
> 
> However, for tmpfs, the only way to tell the kernel which UTF-8 version
> we are about to use is via mount options, using a string. Re-introduce
> utf8_parse_version() to be used by tmpfs.
> 
> This version differs from the original by skipping the intermediate step
> of copying the version string to an auxiliary string before calling
> match_token(). This versions calls match_token() in the argument string.
> 
> utf8_parse_version() was created by 9d53690f0d4 ("unicode: implement
> higher level API for string handling") and later removed by 49bd03cc7e9
> ("unicode: pass a UNICODE_AGE() tripple to utf8_load").
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

