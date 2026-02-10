Return-Path: <linux-fsdevel+bounces-76801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EKlEGWEimmfLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 02:05:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E222115E91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 02:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C86B3302BB9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF072405ED;
	Tue, 10 Feb 2026 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tKAoZ0I+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD919EED3
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770685362; cv=none; b=OKR1D7ypGMp4D5z+ZSjtPaATelVkypfqmSJ5Y82xwnO/3dsTK2Gs4PFJw1SzVPJFb8chUE/bI8jVUZx250f7pXR2Y5RuDRhmTZCKSOLALRd5WLCaj5LQ4TTx0IexUL/OLpNY61ncHVJq6U7rTVezAsLRhWcurhGVXQpxxiWAs+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770685362; c=relaxed/simple;
	bh=adY1F0aEmWPJyEAo+VZceO3q+PDMZ4OUQugphhsRe5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOhtGEiOcQZnt+ytBKGL1TqM0tgcmnBxTOqLKcR00CINb4a1ZNIf8IJyWebtgTnZcKO5DauFrSaxFSlhQGkmdnx1hBOKfjCV1Gq0poeMGwk8zOFPwLKYz9/iQoGhpACJEoliVXX95FLX2lfvQliBMqrn7dYfgbElbRHq+zdjwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tKAoZ0I+; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7cfd2423793so209972a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 17:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770685359; x=1771290159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bGkXFj3gR8PqzaGTmMjqZRS1mvjHfrDAJviMTestCM8=;
        b=tKAoZ0I+0BKVSKCbvFe0cB+6m+vFx82nVySx8VhawOmAh94wYP+Dmux5vhqhDiCCqr
         USCPpzV6F9jT2fjwsO0piLKnOFnLrQHzuFyKwRtXWusccD4qWerCoxVTEu/skR9wT0W6
         MTzWKr0LGoNTjhq9PwDVcQ0GKwSb/0VcYbzsmB5z8IkiI4/SWU7GQNsWpWSp9F+CZhBx
         8aMOMYsRdz0Z0kztuHMX6ylYKzoH9AwVtmKVpgzHIfJWXOdTQxwycmPok7JDzUzbgw+Z
         ic/tBQefkqkTsaMfQor4gs23kHCJkglqZHmFBM0t5VSuYr7Y7Deqp5pEqltf8/cfsalC
         7CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770685359; x=1771290159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGkXFj3gR8PqzaGTmMjqZRS1mvjHfrDAJviMTestCM8=;
        b=rkOGVsmmC6YCh91ksB67tIV7muNmALfE16UIVRpyxKMlQWiXmolMpM7hOm6t8mNOSU
         3wxCnPJgL6TWvUMkDw9TWDwuCVjXICn4HFu1gZw6zFLJgh74GNV6uqeLZ6kHufmtjLzq
         IU5dldtqMtwds7uATRNL/5supUo7JvhD3uK6i3D9WCEtkaOnUpCERz3ylMK9tu8Y/OC8
         ZtDYdkb5B6Yu4nmBXysPHXaaoAkzZwWDZaSqAaIxhE4LfCnxBuBBqstz+Xibwt7Nee99
         Mgl99UKls2Q7Ax+8W7zH2/c2sIbAvvTYc/6h7dtkE+iQlHu5d+ctZH01f5YeUY7iceAO
         NrQA==
X-Forwarded-Encrypted: i=1; AJvYcCVEhufPfkmfOayeo2YLXoxcYsQeF/sd0jC7gUf9VUXla+rh06Iu1VZERcJ8XvWnq5MmF3jBOPgTh+yO14QQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8/wpWwCJT3MQaHWNraKuv5MBOj2C8JjdFbLgkQU9QD7vjPkgW
	3Hxii2ZYrAYahEABkt1qguyYVrwsHtpcUSSE0Obxkpn4QxTuMKiHCe3XSAYBDU769i8=
X-Gm-Gg: AZuq6aJeEjy/Scyf29N3DQzjhRmM5ZdJjO0eKP3KragnagCyx/SfecELMa2oAL7kwMR
	nL9PI/R/JkPXkjtJ8BfXdjWamettnQUtAZjes5GKG8OpFd8PLFFhnCjb3yui5Lf9qTNJjq7j5hn
	cKgOXc7km4PCImVwzzrWxkVuxiV5hx+s/ycfX6R7JWQYgevX0lram67+P2Q56LL7jvRM9h9Gfi6
	OU0+nS3bN0uogyBwxLMUMzvwGNEfYMG2vsJbxJwVutXEulqgDSNq30BJ4RVf54Htm5iVcKycLaj
	tJKH1jN5PF/NPtdr7uam4UTqFqXH10zBeNAoA6E3d4PRtO7aXQEh+oDqs/TaZgCTXjRaZgwNw+n
	UBt5+IC07Y4k4IV18mU6wE/Wvb1svxmN6hI3uNl1ADwTn19ZupPtENgiXTNrkJBasPJjAGlqBsE
	g9yqhfvf2VEyDHZQ/0SC5y6kukIN4+7dZohbksxkhkV8BDA/JncLn/XSL4DbI9Tvh04EC9W81iR
	YGlbv7V5w==
X-Received: by 2002:a05:6830:6ae9:b0:7cf:c69e:2a54 with SMTP id 46e09a7af769-7d46440da0cmr7261772a34.14.1770685359147;
        Mon, 09 Feb 2026 17:02:39 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d46470dfdfsm8534648a34.11.2026.02.09.17.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 17:02:38 -0800 (PST)
Message-ID: <31ad294f-8a73-4dd5-b303-addec950e96b@kernel.dk>
Date: Mon, 9 Feb 2026 18:02:37 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] io_uring/kbuf: add mmap support for
 kernel-managed buffer rings
To: Joanne Koong <joannelkoong@gmail.com>, io-uring@vger.kernel.org
Cc: csander@purestorage.com, krisman@suse.de, bernd@bsbernd.com,
 hch@infradead.org, asml.silence@gmail.com, linux-fsdevel@vger.kernel.org
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-5-joannelkoong@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260210002852.1394504-5-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76801-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[purestorage.com,suse.de,bsbernd.com,infradead.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E222115E91
X-Rspamd-Action: no action

On 2/9/26 5:28 PM, Joanne Koong wrote:
> Add support for mmapping kernel-managed buffer rings (kmbuf) to
> userspace, allowing applications to access the kernel-allocated buffers.
> 
> Similar to application-provided buffer rings (pbuf), kmbuf rings use the
> buffer group ID encoded in the mmap offset to identify which buffer ring
> to map. The implementation follows the same pattern as pbuf rings.
> 
> New mmap offset constants are introduced:
>   - IORING_OFF_KMBUF_RING (0x88000000): Base offset for kmbuf mappings
>   - IORING_OFF_KMBUF_SHIFT (16): Shift value to encode buffer group ID
> 
> The mmap offset encodes the bgid shifted by IORING_OFF_KMBUF_SHIFT.
> The io_buf_get_region() helper retrieves the appropriate region.
> 
> This allows userspace to mmap the kernel-allocated buffer region and
> access the buffers directly.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/uapi/linux/io_uring.h |  2 ++
>  io_uring/kbuf.c               | 11 +++++++++--
>  io_uring/kbuf.h               |  5 +++--
>  io_uring/memmap.c             |  5 ++++-
>  4 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index a0889c1744bd..42a2812c9922 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -545,6 +545,8 @@ struct io_uring_cqe {
>  #define IORING_OFF_SQES			0x10000000ULL
>  #define IORING_OFF_PBUF_RING		0x80000000ULL
>  #define IORING_OFF_PBUF_SHIFT		16
> +#define IORING_OFF_KMBUF_RING		0x88000000ULL
> +#define IORING_OFF_KMBUF_SHIFT		16
>  #define IORING_OFF_MMAP_MASK		0xf8000000ULL
>  
>  /*
> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> index 9bc36451d083..ccf5b213087b 100644
> --- a/io_uring/kbuf.c
> +++ b/io_uring/kbuf.c
> @@ -770,16 +770,23 @@ int io_register_pbuf_status(struct io_ring_ctx *ctx, void __user *arg)
>  	return 0;
>  }
>  
> -struct io_mapped_region *io_pbuf_get_region(struct io_ring_ctx *ctx,
> -					    unsigned int bgid)
> +struct io_mapped_region *io_buf_get_region(struct io_ring_ctx *ctx,
> +					   unsigned int bgid,
> +					   bool kernel_managed)
>  {
>  	struct io_buffer_list *bl;
> +	bool is_kernel_managed;
>  
>  	lockdep_assert_held(&ctx->mmap_lock);
>  
>  	bl = xa_load(&ctx->io_bl_xa, bgid);
>  	if (!bl || !(bl->flags & IOBL_BUF_RING))
>  		return NULL;
> +
> +	is_kernel_managed = !!(bl->flags & IOBL_KERNEL_MANAGED);
> +	if (is_kernel_managed != kernel_managed)
> +		return NULL;
> +
>  	return &bl->region;
>  }

For this, I think just add another helper - leave io_pbuf_get_region()
and add a bl->flags & IOBL_KERNEL_MANAGED error check in there, and
add a io_kbuf_get_region() or similar and have a !(bl->flags &
IOBL_KERNEL_MANAGED) error check in that one.

That's easier to read, and there's little reason to avoid duplicating
the xa_load() part.

Minor nit, but imho it's more readable that way.

-- 
Jens Axboe

