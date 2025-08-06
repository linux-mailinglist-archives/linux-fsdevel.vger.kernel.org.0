Return-Path: <linux-fsdevel+bounces-56814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E251CB1C025
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 07:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 035437B0D54
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 05:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D620110B;
	Wed,  6 Aug 2025 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m6z/PmWV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCD915E97;
	Wed,  6 Aug 2025 05:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459880; cv=none; b=diVk2MW+WxPloCZ64v5HxvIHjzd7BFAoImxQ6h/Rg/ZNas7k40Ojtyn/83Nh47toU+yvDKW2G06w8YPtw1ZvKXRHAH00sxWZ4P/9uuFmcNmGIhKNq/q9wixVrsNkC1acxv6KxerUuP/EyV2n/6FJoFLcKhZt7289IL3ozoI4QoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459880; c=relaxed/simple;
	bh=b9vQBEGjjIj6W3GpSAfTfIPFn2Bv2lvFlhnuXlSDcDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZY7mqPnA3a05ZcEVybi0/1BN3n6aDucE4Q9wvNOPG+vor1IyuTZBRWrM842Z+VBmN77FS1LDIyEIXh1Y2aybnP7lI7licebsuH9WAGl1TrOca39MdTZkuOIFtr9Zx1PZFfp8Hrai2aPV4DDkEnLc+eRFJzastkrhdE6Ko04r6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=m6z/PmWV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hIPqd5cWs5HbBAHPrTJhdAwIWXUUNfMuyrvxyL8XD7w=; b=m6z/PmWVBvAZXmypedd/Z5xWRQ
	no7mtvBzrm0Z6V8qu67sfjuDzHurrnDFgXkpWM08KMDfuGCxOfeyCv/eYw1rNloTc7n+SlbH4gBXJ
	GEcg6guxcQyCcGt0r2HpRPW+oDdKcK46aQAoDhg2RP/kZPZBrD/xf8Ixe78N+N3HkU8iWKDTQEVuq
	sujm2dktxAgXLpAOXBDLEWm0yevVgmDkUt8cpTmnit7HuuIdfFypZbici9pJYB1Aw0yTkylA8j/11
	GUvQQ6QEKMO93MkYMsLirJ3h3NfSdz3tFneRLz8EMorZhudFjXjJsXRORxwhgSGzkoa6vDg4AmXTp
	bYti8rwA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujX9v-00000008rVV-0kB4;
	Wed, 06 Aug 2025 05:57:55 +0000
Date: Wed, 6 Aug 2025 06:57:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] fscontext: do not consume log entries for -EMSGSIZE
 case
Message-ID: <20250806055755.GF222315@ZenIV>
References: <20250806-fscontext-log-cleanups-v1-0-880597d42a5a@cyphar.com>
 <20250806-fscontext-log-cleanups-v1-1-880597d42a5a@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806-fscontext-log-cleanups-v1-1-880597d42a5a@cyphar.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 06, 2025 at 03:31:10PM +1000, Aleksa Sarai wrote:
> Userspace generally expects APIs that return EMSGSIZE to allow for them
> to adjust their buffer size and retry the operation. However, the
> fscontext log would previously clear the message even in the EMSGSIZE
> case.
> 
> Given that it is very cheap for us to check whether the buffer is too
> small before we remove the message from the ring buffer, let's just do
> that instead.
> 
> Fixes: 007ec26cdc9f ("vfs: Implement logging through fs_context")
> Cc: David Howells <dhowells@redhat.com>
> Cc: <stable@vger.kernel.org> # v5.2+
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  fs/fsopen.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 1aaf4cb2afb2..f5fdaa97965b 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -36,23 +36,25 @@ static ssize_t fscontext_read(struct file *file,
>  	if (ret < 0)
>  		return ret;
>  
> -	if (log->head == log->tail) {
> -		mutex_unlock(&fc->uapi_mutex);
> -		return -ENODATA;
> -	}
> +	ret = -ENODATA;
> +	if (log->head == log->tail)
> +		goto err_unlock_nomsg;
>  
>  	index = log->tail & (logsize - 1);
>  	p = log->buffer[index];
> +	n = strlen(p);
> +
> +	ret = -EMSGSIZE;
> +	if (n > len)
> +		goto err_unlock_nomsg;
> +

FWIW, I would rather turn that into a helper taking log and len and
returning p or ERR_PTR(...); something like

static inline const char *fetch_message(struct fc_log *log, size_t len,
					bool *need_free)
{
	int index = log->tail & (ARRAY_SIZE(log->buffer) - 1);
	const char *p = log->buffer[index];

	if (unlikely(log->head == log->tail))
		return ERR_PTR(-ENODATA);

	n = strlen(p);
	if (unlikely(n > len))
		return ERR_PTR(-EMSGSIZE);

	log->buffer[index] = NULL;
	*need_free = log->need_free & (1 << index);
	log->need_free &= ~(1 << index);
	log->tail++;

	return p;
}

with caller being

        ret = mutex_lock_interruptible(&fc->uapi_mutex);
	if (ret < 0)
		return ret;
	p = fetch_message(log, len, &need_free);
	mutex_unlock(&fc->uapi_mutex);
	if (IS_ERR(p))
		return PTR_ERR(p);
	n = strlen(p);
	if (copy_to_user(_buf, p, n))
		n = -EFAULT;
	if (need_free)
		kfree(p);
	return n;

and that's it.

