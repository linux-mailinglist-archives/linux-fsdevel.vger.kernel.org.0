Return-Path: <linux-fsdevel+bounces-25353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2487194B0B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 21:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87DA1F2206C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 19:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAEF145333;
	Wed,  7 Aug 2024 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY65MnBb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66313F42D;
	Wed,  7 Aug 2024 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060395; cv=none; b=AGPjFfMTKKntGhkPQXNQ0qNG9QehvswTMYFdJAf9Z1mRTZV2TiZ5+dxqpwKBlAaDek9E8PzrD/0NsoRdgobrSdEflktaN5lPcUKtxdjzjwm83j8PTRxAdkbc0X1OyGRSd2qIEDmLxvup/ZmlWeMEq5IFg7D3Pq7GCiW7zKoAAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060395; c=relaxed/simple;
	bh=gMl+jZpyQUsWyUUeRFJYngzCNZ3NFMguEFr2ykho7Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXlQ++qpuJtLcmQW4ahmHZOwARSr7re3iue5q1OwTUS9XXzdrzl/d8Ao/iIdYSHmFwV5BXciXIGXKWoR+a8s5HLnTNGIucoan0YQiUEFQnRXZB6zkO25MOjJEqS8NOnHw4dJRmwPEKjmW7eyaZUnLiFwacOayvKfMx4mtwY0yzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY65MnBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96B3C32781;
	Wed,  7 Aug 2024 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723060395;
	bh=gMl+jZpyQUsWyUUeRFJYngzCNZ3NFMguEFr2ykho7Jc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PY65MnBbsldgSClCqFbIWxe1xU38a78olv9FlLuzKz7Cca9pygm7VRTZRlv82Jv9r
	 solfhciYnAW819rnM5iiQeEdHr1QxhdsAELiBYlomzpzscjsqibQpI4Nw/cyau+sp6
	 /NSrzC+bRrwuM+Gv1cluMyXWyLt+hHA9o1UFOu1Bp9J7iKuLacXX60mggavJ6HJpr6
	 nXlxlBhgcPgETUBxYazC0D5zRyhLSMbxbpgPhcVMUscgBiZdruGJYvawW1EcoH2xhu
	 l/nGm7L6yDsJcCPG8yAVf/HW2xWgBXzz2pp2pX5lJHWN0JWDR266rr4U1ptJI95+8J
	 a9bQjDaxWE6+A==
Message-ID: <0035d7a6-6a03-435c-a893-3a57a4319fd4@kernel.org>
Date: Wed, 7 Aug 2024 12:53:14 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] binfmt_flat: Fix corruption when not offsetting data
 start
To: Kees Cook <kees@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Stefan O'Rear <sorear@fastmail.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Greg Ungerer <gerg@linux-m68k.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Damien Le Moal <damien.lemoal@wdc.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240807195119.it.782-kees@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240807195119.it.782-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/08/07 12:51, Kees Cook wrote:
> Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start")
> introduced a RISC-V specific variant of the FLAT format which does
> not allocate any space for the (obsolete) array of shared library
> pointers. However, it did not disable the code which initializes the
> array, resulting in the corruption of sizeof(long) bytes before the DATA
> segment, generally the end of the TEXT segment.
> 
> Introduce MAX_SHARED_LIBS_UPDATE which depends on the state of
> CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET to guard the initialization of
> the shared library pointer region so that it will only be initialized
> if space is reserved for it.
> 
> Fixes: 04d82a6d0881 ("binfmt_flat: allow not offsetting data start")
> Co-developed-by: Stefan O'Rear <sorear@fastmail.com>
> Signed-off-by: Stefan O'Rear <sorear@fastmail.com>
> Signed-off-by: Kees Cook <kees@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


