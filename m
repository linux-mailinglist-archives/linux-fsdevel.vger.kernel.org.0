Return-Path: <linux-fsdevel+bounces-46869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D4AA95AC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 04:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFCF16E6E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D42184540;
	Tue, 22 Apr 2025 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Dp5csiEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E132C18A
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745287653; cv=none; b=W8Vh1MxmT8xrhv8VugqihgXq9ph3dR53Yl/qaPmeJWmwkf+qmAYUSI7OGnkb01I439XC7YAixm2lhdlzy4Hk/+Uwz7NmaouD+aaDMu68BTrjjxvJvdReAD67Btfh9qTJ6TRjKyYbF2mo/GMAeL0q6GqcvUrDFCU5qtqa+gK1N2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745287653; c=relaxed/simple;
	bh=+it0tfc7AnQySKCFBZqwwMnjVu8Qvf41rpTPp4vFMig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUKuGjqm3/EcLCyDLqrRMw0YXmK+loMwJFhofqQRjaazyz4d0YFw3+VwO9beW9ipSYHfi9Xw8pk5FLAfupw19AL0grNEFNdweaxmpI18nV8RXx/Xh0OuLY556uCYmuwkiAZfShxfTYZDASfO2uOMVIRdbTqV9Ksxdjcl2jRXMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Dp5csiEf; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745287641; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZYpjJ5a8R4k9VhpRXE1EQ96riSaDSkxwBk1QBvxB2fs=;
	b=Dp5csiEfoyrEzqh0CrsZXy6IwFb5EybR6SCkvWWN1jVbiqyi+suMHrlDIK4xiPmxJdgp0QFTbLQwKqGBnPMhjoqWdtQJLeBasK0/6D/Bz4pFgMSraVdEQzuBAAdIhjyFitBPrvHT6UNRQ96JIRHsuFjLY/crYVud1PHCMv6e+Bw=
Received: from 30.222.18.50(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WXjtiR4_1745287640 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Apr 2025 10:07:21 +0800
Message-ID: <0cdd1c6a-ad51-48c5-846e-f61b811fc7ad@linux.alibaba.com>
Date: Tue, 22 Apr 2025 10:07:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fuse: optimize struct fuse_conn fields
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
 kernel-team@meta.com
References: <20250418210617.734152-1-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20250418210617.734152-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/19/25 5:06 AM, Joanne Koong wrote:
> Use a bitfield for tracking initialized, blocked, aborted, and io_uring
> state of the fuse connection. Track connected state using a bool instead
> of an unsigned.
> 
> On a 64-bit system, this shaves off 16 bytes from the size of struct
> fuse_conn.
> 
> No functional changes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/fuse_i.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index b54f4f57789f..6aecada8aadd 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -690,24 +690,24 @@ struct fuse_conn {
>  	 * active_background, bg_queue, blocked */
>  	spinlock_t bg_lock;
>  
> -	/** Flag indicating that INIT reply has been received. Allocating
> -	 * any fuse request will be suspended until the flag is set */
> -	int initialized;
> -
> -	/** Flag indicating if connection is blocked.  This will be
> -	    the case before the INIT reply is received, and if there
> -	    are too many outstading backgrounds requests */
> -	int blocked;
> -
>  	/** waitq for blocked connection */
>  	wait_queue_head_t blocked_waitq;
>  
>  	/** Connection established, cleared on umount, connection
>  	    abort and device release */
> -	unsigned connected;
> +	bool connected;

Why not also convert connected to bitfield?


-- 
Thanks,
Jingbo

