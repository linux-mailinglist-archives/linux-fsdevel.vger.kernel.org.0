Return-Path: <linux-fsdevel+bounces-24226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221EA93BD61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 09:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D637F283F2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 07:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E8E172763;
	Thu, 25 Jul 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4IrGD6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34272746C;
	Thu, 25 Jul 2024 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893916; cv=none; b=gjIbR7hYYtL9rtt/tLL+4orPKnb0LB3qrXoMZq47qVzMpqzJGqaAI4eXsotT5xo7L1L0eWHo5BhT5wQaHWO7gx2SQVgqMPEfoiIKrBD1/zSw93GK8fpmUdQS8FVb1qYqH4Rdfi/MsMFDE7royq8waJucP3qeL+A3I7UIjb0J0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893916; c=relaxed/simple;
	bh=wPMGUC0y/HMlSqSLaesKVHMHhjLlTuGqdZbSFVzzcIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LB1KOJBwONpk2xasXqP1ktAZHTdnWMJk53Uc8OVo5WiyNEqGObXWDg/w5qRuSn5I2M94qDjHrrZS78CuieWt8RaD++AEKVuSogcVW/UFIoDZWkiYjHpwEMx2LALU5GdL2zX6a/xmvMHy373eIK/5cnSnR3l32rptYF2k7vW+w+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4IrGD6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFA2C32786;
	Thu, 25 Jul 2024 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721893915;
	bh=wPMGUC0y/HMlSqSLaesKVHMHhjLlTuGqdZbSFVzzcIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4IrGD6ohbM8uQhHzUQWEng1h7ZBBptlUkAmSgw6NY/5GLfhUytkMitrN94kNnEgZ
	 hx3IfZe7TlbyPNf/9XhpO1CNfceLtIJcY5574Oopzw9muV/r6mdAgMTpIfWzxJdwIK
	 K1N5oePLg0VMer1FdktDdgbwUAg6pOrngr7gawdHOUuHKNUQXIX7VMr7PSM/cKak39
	 ox5lDiVvZHPg8WSKFeeqQENJnW2nzc6INaij/GF+d5Pl2ji8DN3ScPRQXuO3u8e/vz
	 q/1WWSn8cb4lSL7fYJ7u8I4X+aB1+VIbShrLDw0KqIr9JFTaN51YHjhey5CdVGta63
	 KL5AV/gi95qpg==
Date: Thu, 25 Jul 2024 00:51:53 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Yuvaraj Ranganathan <yrangana@qti.qualcomm.com>
Cc: "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Software encryption at fscrypt causing the filesystem access
 unresponsive
Message-ID: <20240725075153.GA160096@sol.localdomain>
References: <PH0PR02MB731916ECDB6C613665863B6CFFAA2@PH0PR02MB7319.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR02MB731916ECDB6C613665863B6CFFAA2@PH0PR02MB7319.namprd02.prod.outlook.com>

On Wed, Jul 24, 2024 at 02:21:26PM +0000, Yuvaraj Ranganathan wrote:
> [ 1694.987674] INFO: task kworker/u16:3:2154 blocked for more than 120 seconds.
> [ 1694.995628]       Tainted: G        W  O       6.6.33-debug #1
> [ 1695.002335] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1695.011094] task:kworker/u16:3   state:D stack:0     pid:2154  ppid:2      flags:0x00000208
> [ 1695.011097] Workqueue: writeback wb_workfn (flush-8:0)
> [ 1695.011101] Call trace:
> [ 1695.011102]  __switch_to+0xf0/0x16c
> [ 1695.011104]  __schedule+0x334/0x980
> [ 1695.011105]  schedule+0x5c/0xf8
> [ 1695.011107]  schedule_timeout+0x19c/0x1c0
> [ 1695.011110]  wait_for_completion+0x78/0x188
> [ 1695.011111]  fscrypt_crypt_block+0x218/0x25c
> [ 1695.011114]  fscrypt_encrypt_pagecache_blocks+0x104/0x1b4
> [ 1695.011117]  ext4_bio_write_folio+0x534/0x7a8
> [ 1695.011119]  mpage_submit_folio+0x70/0x98
> [ 1695.011120]  mpage_map_and_submit_buffers+0x158/0x2c8
> [ 1695.011122]  ext4_do_writepages+0x788/0xbfc
> [ 1695.011124]  ext4_writepages+0x7c/0xfc

I think this is the important part.  It's showing that the call into the crypto
API to actually encrypt the data is hanging.

What I suspect is that you are *not* actually using software encryption, but
rather a buggy driver for an off-CPU crypto accelerator.  This would happen if
your driver registers itself with the crypto API with a higher priority than the
software algorithm you intended to use.

To check what driver is being used, you can either check for a kernel log
message that looks like 'fscrypt: AES-256-XTS using implementation
"xts-aes-ce"', or check /proc/crypto for which xts(aes) algorithm has the
highest priority.

Which driver are you using, and is it upstream?

- Eric

