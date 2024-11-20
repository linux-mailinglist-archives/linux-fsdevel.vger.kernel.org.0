Return-Path: <linux-fsdevel+bounces-35308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 358579D3973
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05BAB25683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0206519E7E2;
	Wed, 20 Nov 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5QnYvOs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F917F7;
	Wed, 20 Nov 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101003; cv=none; b=CDAJMsOalV4m7SNSoDeO6PCbM+e4PTK+feha8s9bMJn25skuA4dMwEtnUGpkSLInkgnSBIokopu1V/8So6JCTvW5XbtSXn7533DX1aKNuoF+kqEsF1EKpvpLDnmseaFijoDw3ZEy+oejUPAgl5vjiB8nRFkMkWt8V7FU0hHnSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101003; c=relaxed/simple;
	bh=FATPL58fF9smkslXlfFSmLHtTXJdJAoN6rcIHdBGZWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZFg5vpJpbrNArTMwFKu2LlW9ivu5VMr3LDpzsbVcVcU6ldqWB4u8BM9FNaD+LmKs4/OlJ+NV78DX5efSB2d5EJPySilT+6oDvuSZhT9bhqmyEwA043RghCUJMxfcTG6FsIBh5lGyBoi1aoe+o3WE76qX4aGgHZ/M6zLT7ZVh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5QnYvOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E8FC4CECD;
	Wed, 20 Nov 2024 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732101002;
	bh=FATPL58fF9smkslXlfFSmLHtTXJdJAoN6rcIHdBGZWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5QnYvOs4Ytu34Xv3MRDUqQniGnlfAI+gZPSpGKB4l86otbSHY8R5+B0lVxpLS86+
	 nnlDtPUPEEaYS48QwnOsF9G6pjMFyZ3FQh3Mn2wna/CFRq0HahKRUnzT2jjz4MLtJh
	 t5qtr30A4IgOasp/SrCufN1BiyXHCRAs3uJ/YtE7SBHWynFnzfmUQn++NQ4NpY7ux3
	 qYvxbltLxUKnsibFHSoBsccyaH/lEDUQrpJu0O0kJUdDw934Ih5YkvS4UojJq9FJq9
	 IWoIS4pvobC+q3QSXwYfe07r8HOkZc2FBXGaZoGnSYvR7tRoxpABwcy71kmZATDoBB
	 +fLKe6QuqkoIg==
Date: Wed, 20 Nov 2024 12:09:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission
 events
Message-ID: <20241120-banditen-nimmersatt-e53c268d893a@brauner>
References: <cover.1731433903.git.josef@toxicpanda.com>
 <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>

> But if anybody is really worried about running out of f_mode bits, we
> could almost certainly turn the existing
> 
>         unsigned int f_flags;
> 
> into a bitfield, and make it be something like
> 
>         unsigned int f_flags:26, f_special:6;

I just saw this now. Two points I would like to keep you to keep mind.

I've already mentiond that I've freed up 5 fmode bits so it's not that
we're in immediate danger of running out. Especially since I added
f_ops_flags which contains all flags that are static, i.e., never change
and can simply live in the file operations struct and aren't that
performance sensitive.

I shrunk struct file to three cachelines. And in fact, we have 8 bytes
to use left since I removed f_version. So it really wouldn't be a
problem to simply add a separate u32 f_special member into struct file
without growing it and still leaving a 4 byte hole if it ever comes to
that.

