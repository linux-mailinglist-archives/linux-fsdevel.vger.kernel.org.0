Return-Path: <linux-fsdevel+bounces-76798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG8BEsWCimlaLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:58:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4F6115D85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56C1A3072796
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA2225783C;
	Tue, 10 Feb 2026 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EcjjyNhA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6EF1F1315
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684825; cv=none; b=Md4H4SWxxbcpMhvEMzdTKqxYFqYiq5n0+eQdszb7SStvCu3Xb2CDxYEvPX63TEVIJ/Ga3IytLGYZm97/LvL6OsdYo5bfg/G9FJojvh/Hz9a7LnQktCfgZZbTYfi939WFGWo5NKGZXsSlBv8M43VG8VGM5xsCHzoC+I6zF0wxYKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684825; c=relaxed/simple;
	bh=LB9zEvEB+ynNPeCvwTzUUk7JmE6gVdYQxyNkqD/lPMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXggqnV5IEAO9c4FTG8MzIVKMc8cqPZyr4caDkuNeFrVBDs0sEkR09PgALFM6XQqGLUIBFoTR1GSPH2OCIvn6BStTS8ilSF1sac06Kdt4rd0AjxKDgZ4iFRY3AAjQSwwtM4vF8gvIqs/41H1d62Onjv1MtpKh1iNGzt8jWy8W64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EcjjyNhA; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6610d479194so1115420eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770684821; x=1771289621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQccP/Mbg8NNjwWXj0FJQEuTH8jSeIJyh7Be+EtY1kE=;
        b=EcjjyNhADepzJDv8tqXw5u/tG3YcW4ceFY7j03WCfzAVNoVHZlAoEdKbuIvZGzlYBe
         U9/qILDXFDx+dEK0noVwfLanFoWBBmQCih6OXowEnLNoRtGuifigJTrUEEFusAIwxyjO
         oiHm51XiicPfJanOJpBjYD2HIqwJtgR8zY0hVafcY1aKUFqnY6kWv6gDoa01i4knRXd7
         BRKOdSWbYVRuWoyYWvUvM7Rw5jKbla5+5LkoF7AawLHMknpy6uiBEqmm+5KLPWPTNmV7
         BVYU+I2+/tkD4T0cWeO9nz6X5eeCGni3KV6E7/shJbMlBaar6Mw6VSlZmUkFOdQeo7Gp
         dmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770684821; x=1771289621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQccP/Mbg8NNjwWXj0FJQEuTH8jSeIJyh7Be+EtY1kE=;
        b=wnUeENROSdNbP5YuMPMPtYglMp4ATxYeQ+2UHXpZsK23QqEpW9OOt534ZQGjVlH/ru
         G6l4pnvg4iTplaxupoJBT/IlPxrvSLKx4MHrtk9Va54mJ82YzB7Lp9rsOPlgWdXoOSZy
         CN5QSfOWAibWU6VYM6N0m9Dx2pXgWMUsVJj+vLUHtPO3EsaJ+jZB2c2j4dpNaY7EH0hh
         fcNqVBq5VFe71H9hLy4L24O7bkeVRNNV9bAiaZ7+16ULzg5ohnu1M3kMUc1LhX3fKcAa
         8OqMrCBrkBFFwA2kYio3Hi0nvOy0l1FMNaGCLZJMfd9BzGII7J5X1r9PChVzWhd6ISKc
         aA5w==
X-Forwarded-Encrypted: i=1; AJvYcCWZoexiituwB/Scrz8plGsFS5dwEsbdbwb+9TkZmnnK8eSLZKJDVG5KKI4HiI/WrjHvzGgXBHVEGt5ASplj@vger.kernel.org
X-Gm-Message-State: AOJu0YxpO+pBTrQ/XcDpq9r+vQscFIG9xHIwJEesRsyEXYS9BnJE1jaP
	T0Ofd3xZQqGik4cXHukOIRMpOCL/NCi63sVqpM+k+6kYc2fI20tcOLiKx9yrgAP67CzBQ+geI/x
	Xiaxhjrk=
X-Gm-Gg: AZuq6aIrCr5uOvZzgpMGQRfa4K1DdnR02sxeTjHBGiwJXfcZI0+4PYx/Bhj+a0CpQl+
	p3N+1C55GymaHlmgxvZqi3HysbFe8nR0CXPss+cTh6QJ7hq0E4RDWgD9KRbp/WcgqA4OFl7aQpb
	88kkNB7wA79X39EPridw/Zdkx1AssqdO9QDFO/okm0YHGs33LUsYGH/tPqSr9oSlks27YK64h+J
	KT+LqIprAhgyUVWK1q5YgOuZnxil6Pp/f03IGn5o9tZXYRQRVJsvMHGfeNwRgpPnqPgh8ogaXEj
	8yzV29UP+LTOvgkKbatqCLbzQplOmMGYv27Efd2bZJKIvAJLZoV+tE6W/XLt8UJbsJ12U+c2r/C
	1D+WLCM2wDHjIwsH0GnXDZ+AWhuAPKW1nCogJjPLDikvL1UtJAUsMVHSy1+Dr+P6Bv/ZsTjOmE6
	qVPkoA+vZMFHjdgAt3CjUqBgvrAA+/bOcxU8gmJrC0OsdP6USPmJ0zbxIs6Hk6XYxC21SwAQ==
X-Received: by 2002:a05:6820:6ae6:b0:663:84d:396e with SMTP id 006d021491bc7-66d0c853ffbmr6786969eaf.62.1770684821412;
        Mon, 09 Feb 2026 16:53:41 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d3b2a75d4sm6649413eaf.15.2026.02.09.16.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 16:53:40 -0800 (PST)
Message-ID: <4e12c801-4d3e-4c49-9a6d-6faba5e05063@kernel.dk>
Date: Mon, 9 Feb 2026 17:53:39 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/11] io_uring/kbuf: return buffer id in buffer
 selection
To: Joanne Koong <joannelkoong@gmail.com>, io-uring@vger.kernel.org
Cc: csander@purestorage.com, krisman@suse.de, bernd@bsbernd.com,
 hch@infradead.org, asml.silence@gmail.com, linux-fsdevel@vger.kernel.org
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-11-joannelkoong@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260210002852.1394504-11-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76798-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[purestorage.com,suse.de,bsbernd.com,infradead.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid]
X-Rspamd-Queue-Id: BE4F6115D85
X-Rspamd-Action: no action

On 2/9/26 5:28 PM, Joanne Koong wrote:
> Return the id of the selected buffer in io_buffer_select(). This is
> needed for kernel-managed buffer rings to later recycle the selected
> buffer.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/io_uring/cmd.h   | 2 +-
>  include/linux/io_uring_types.h | 2 ++
>  io_uring/kbuf.c                | 7 +++++--
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index d4b5943bdeb1..94df2bdebe77 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -71,7 +71,7 @@ void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd);
>  
>  /*
>   * Select a buffer from the provided buffer group for multishot uring_cmd.
> - * Returns the selected buffer address and size.
> + * Returns the selected buffer address, size, and id.
>   */
>  struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucmd,
>  					    unsigned buf_group, size_t *len,
> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
> index 36cc2e0346d9..5a56bb341337 100644
> --- a/include/linux/io_uring_types.h
> +++ b/include/linux/io_uring_types.h
> @@ -100,6 +100,8 @@ struct io_br_sel {
>  		void *kaddr;
>  	};
>  	ssize_t val;
> +	/* id of the selected buffer */
> +	unsigned buf_id;
>  };

I'm probably missing something here, but why can't the caller just use
req->buf_index for this?

-- 
Jens Axboe

