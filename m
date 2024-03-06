Return-Path: <linux-fsdevel+bounces-13725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A51B487320A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450BE1F21274
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1242B5F56F;
	Wed,  6 Mar 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGonEA5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4945E3BA;
	Wed,  6 Mar 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715369; cv=none; b=eWyvmJz3ZcU2eg/PT3L7FqeJoA8oKRjkVCUBk35Dw6Uqk9AajwGifwH5JQ0NOEMylj3/o90F5T0Zjn3jtUWeBKovgtNOdUxljJDhOlSo4njWVH0Z6cF04SINvpt4IQgnc6OFMNGQBjzPYIP8BS6Mf1978w7DV0o2Oa6wyLhWvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715369; c=relaxed/simple;
	bh=QOKzcGaxoayJK+y6t2yDmIoSrH7kB89P4UHloKQetx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFwMREwDnORtc2RyhSs1Dcfpb3ZSoezFvOQd96TZEqi0VgVIj9IsgMXEFdvKCP69QikFqWE3fNUkK8woctmZqWcNLYSV2zm6e2XdDRMxN05+Fl5yh0+lJkoSvB7IArlMF54JjAjCegYTZM3VT2Mu89KcofzR/nAFB2G2W69POxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGonEA5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36140C43399;
	Wed,  6 Mar 2024 08:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709715369;
	bh=QOKzcGaxoayJK+y6t2yDmIoSrH7kB89P4UHloKQetx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGonEA5lkR24gOeyMefEDDJrQQmyjeT/ueuU5tuDsLY2q9d8YsbYvVjfkqYPBI/na
	 nTofAqOC4gvqs93OLVMw/s6b27utCQ+xvSL68gJweD0ylZzC7J433uPVZwG6swOaGJ
	 TgZquvhSbT5IxBkV8itYpOsHigyOOiJY3UlE8PQVN6MVEWamLuc1InwXQV4PYBhu8U
	 XO98WbEu8DbZ0k+/Z2o/5+4lZr0hkNa44MZumsj85QmiZbwk+iRxHsO6fPe29eYYP8
	 ATGtT1Qj9FsC/kN3baeDvRK/GG/zeOZEmS3ON96TmpanVBP6H3Jv47KfoRURaXAEri
	 2Bw+ZXOBE3G0Q==
Date: Wed, 6 Mar 2024 09:56:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tong Tiangen <tongtiangen@huawei.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com, 
	Guohanjun <guohanjun@huawei.com>, David Howells <dhowells@redhat.com>, Al Viro <viro@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] coredump: get machine check errors early rather than
 during iov_iter
Message-ID: <20240306-ferngeblieben-helft-2cac76b1c99e@brauner>
References: <20240305133336.3804360-1-tongtiangen@huawei.com>
 <20240305-staatenlos-vergolden-5c67aef6e2bd@brauner>
 <db1a16d1-a4c2-4c47-9a84-65e174123078@kernel.dk>
 <CAHk-=wioxdFfY-kWwVs9RT9JTfYrMwqtX=LdJNMLiVSZm14SSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wioxdFfY-kWwVs9RT9JTfYrMwqtX=LdJNMLiVSZm14SSw@mail.gmail.com>

> Sending my changelog just in case somebody wants to mix-and-match the two.

Did that. Thanks!

