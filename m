Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68A811A19B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 03:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfLKCtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 21:49:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLKCtA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:49:00 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0DF7205ED;
        Wed, 11 Dec 2019 02:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576032540;
        bh=yqkl8TN0O59NwfZP2OD2c0ghY0r4F9Diq35NeQInRfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6Mbhyj+zaSmcMmFEcvuAbn1RXZr+9mfbi1gq5t+KWhaDMkXHPd4QmJPAy6aAUcrj
         2rSpBj0soqrTUIN01JzV7gVd2iu0r43RuzzHf62jss0Iw3umpotijYsugx3sPQ+ltC
         4KFA6yIXyUlcDslwsYyBzYXbhBt4f/wF3+Zd9F6U=
Date:   Tue, 10 Dec 2019 18:48:58 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] fs: introduce is_dot_or_dotdot helper for cleanup
Message-ID: <20191211024858.GB732@sol.localdomain>
References: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:20:01AM +0800, Tiezhu Yang wrote:
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 7fe7b87..0fd9315 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -92,4 +92,14 @@ retry_estale(const long error, const unsigned int flags)
>  	return error == -ESTALE && !(flags & LOOKUP_REVAL);
>  }
>  
> +static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> +{
> +	if (unlikely(name[0] == '.')) {
> +		if (len == 1 || (len == 2 && name[1] == '.'))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  #endif /* _LINUX_NAMEI_H */

I had suggested adding a len >= 1 check to handle the empty name case correctly.
What I had in mind was

static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
{
	if (len >= 1 && unlikely(name[0] == '.')) {
		if (len < 2 || (len == 2 && name[1] == '.'))
			return true;
	}

	return false;
}

As is, you're proposing that it always dereference the first byte even when
len=0, which seems like a bad idea for a shared helper function.  Did you check
whether it's okay for all the existing callers?  fscrypt_fname_disk_to_usr() is
called from 6 places, did you check all of them?

How about keeping the existing optimized code for the hot path in fs/namei.c
(i.e. not using the helper function), while having the helper function do the
extra check to handle len=0 correctly?

- Eric
