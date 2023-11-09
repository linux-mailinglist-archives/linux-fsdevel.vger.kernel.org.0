Return-Path: <linux-fsdevel+bounces-2459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F57E624F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 03:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F581B20E7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 02:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63085251;
	Thu,  9 Nov 2023 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="g9WBIAzl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344F17DB
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 02:40:52 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE669D58;
	Wed,  8 Nov 2023 18:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Izao/Oe+Ice4rRrR6YJ3TmwlziZFsjKfxkPlLCNcxEQ=; b=g9WBIAzllpcaX36dpcCIkUQK8F
	80fXUqCocLHtK5v+rogT6VaUEzZ1B2nyEpE4rBgHXpD4Xy626GyoqEscanpv+NcM75R9EX8q83Ku2
	1735AL5tu/RnF4KYtssAIOFkkusA/iXTLdiyXDzbW93SqXDd/+xVNKmK0jbo9pLCfW8Aj14IR27CD
	IVX8AOdCRxrGc6N631v11HKixnSsUbkb6jZULNK7g86gaU06xL+cqM89WQt0WgHPpsfjqWndk2BJA
	lU2x1WDnggBwROvBmGH7pYBpZo+eHmRy/fslh6Onj27rT/5Bfdr5ueUoZagsRxO8EG8TJuNgqBTwE
	3Q6LmhDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0uxz-00DI50-0y;
	Thu, 09 Nov 2023 02:40:23 +0000
Date: Thu, 9 Nov 2023 02:40:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: WoZ1zh1 <wozizhi@huawei.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
	jlayton@kernel.org, dchinner@redhat.com, cyphar@cyphar.com,
	shr@devkernel.io, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH -next V2] proc: support file->f_pos checking in mem_lseek
Message-ID: <20231109024023.GZ1957730@ZenIV>
References: <20231109102658.2075547-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109102658.2075547-1-wozizhi@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 09, 2023 at 06:26:58PM +0800, WoZ1zh1 wrote:
> In mem_lseek, file->f_pos may overflow. And it's not a problem that
> mem_open set file mode with FMODE_UNSIGNED_OFFSET(memory_lseek). However,
> another file use mem_lseek do lseek can have not FMODE_UNSIGNED_OFFSET
> (kpageflags_proc_ops/proc_pagemap_operations...), so in order to prevent
> file->f_pos updated to an abnormal number, fix it by checking overflow and
> FMODE_UNSIGNED_OFFSET.

Umm...  Is there any reasons why all of those shouldn't get FMODE_UNSIGNED_OFFSET
as well?

