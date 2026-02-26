Return-Path: <linux-fsdevel+bounces-78446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A3GFJr9n2n3fAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:00:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B0C1A22DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B615B3080C30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 07:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACBF392807;
	Thu, 26 Feb 2026 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TMYYDIEH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE3392C3E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092718; cv=none; b=aHvzfbuIb9qWHyDysYHiGtjWmwrnWnEZCTAiediz4M1E3yhZsjMk5bSD9MfJpDUaLUABESnDnGd+hwXpxJIiaxy6lsWJxUilk80z7YjY6RZ3AYOBu0iAFqAdRIoIP18Pk9ENYMRqKUnDtNYnxexnWlYYMg94ftoq1uH+5ijVCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092718; c=relaxed/simple;
	bh=EWLxH83qNnDN4T6VeDaz8zy4WhWTxn76DHDOMhidy5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQ2DVM7/XjqjHSWAoX0EbDG9MlTDQx9TSx9i6N+Qc31lxnJ2Pqn6dKRL6Pyz3v4ihRhv8gOCn2osC2jwtT3MThdhgQa0qM/cbBezZHYA57BKX09zv2Hf/URbwUjT8IOtN5cWzOaoRJkTEEk6NNm1M/r3kJUkRnsLTnbmqKyLySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TMYYDIEH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43992e3f9b8so523585f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 23:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772092716; x=1772697516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sD6qKNXNuBEjqxXtt/5YnY5j89NAwzOwCU5i6ozZ/HQ=;
        b=TMYYDIEH1SG9Ux/r+b/1dMjzxjBBwHK3guQrm0uSLhUnUBTgwHZae491AHWvUngjEv
         yu+czT+OEmrsCxhsLOsftAlLYhlci/348KY02DCQHrWwXSQ8Ou/l/1cMFW0JvgunUydi
         A6r/HUVJ1kWEh5psZpk4+T4J1b1ZauFSpwXdO6fsZgagXw4gxZI7ibk+vi6CTW7rt1Un
         Y+XgKK2qvti36l9JSWSxL5aTDvG9XD41FC8HSDlWNiXUWhFziJJ8o/hJDQUB0gN/I5Bk
         BTk/3kePXCxTUiXGpP13S6+7beWYz3A2w04zkohc0vMRcoEG6igUACYzBwZzjMAPqY+K
         xNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092716; x=1772697516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sD6qKNXNuBEjqxXtt/5YnY5j89NAwzOwCU5i6ozZ/HQ=;
        b=DDw4BbOL/aQywwNEsE/gyb4aB0Vp3xc2e5E0wesKIZZK9hoDAVjjVJwX/rBhTLTia+
         QkJ8z8AwlfbymjlBLrll7JAcHad6GYEZYxoDkAzB4tTJh6VmZ542DFhJM14zens/XEBR
         7pFcEtq+9HOB8dJC3XgJ0dMBHD7MN5ymV5vrCK1OzuiZsP8THWJirSWbqPT5E4NyAiaU
         A1IV+aDJIuD0UIP9vDfGaIRhD60M19ZuGx0QI0Ur00Rbh2hUqaH1hot7ZNAFAkl6MWJ0
         zJ/3YgJKXGIAjSeMT9M5yaGFETbG2f/8bt+lXDupJITMOZ+e4mTk24bld8PZF0sYmC36
         lJiw==
X-Forwarded-Encrypted: i=1; AJvYcCUX9nP1+awevP+lxpsejirRX+EIJpCQOUknHjznajm2zXaIwYxrY1Ccq1hOMXiZaDu2JJsPb3YZD+Qd62wd@vger.kernel.org
X-Gm-Message-State: AOJu0YwXc8y17isCMI7MKYSM1Xs9PyCZrCg+5pj/AdoQB7e15lwwe2bD
	8u8c4vcGH7hlkCqIfZHJkfZsrb4/0qx6/TY7nJMVXLRLugabW64UYRe/gVPKHQ6mIVD/die272m
	0ZngZ
X-Gm-Gg: ATEYQzyaRA8rComwrpsUEh1xXhoNbfLTkekM+mH4AZ4oY6uUnEi11dY7TGnSOGfdhwQ
	6OjyM+Q9ipAH5KSO1mq6YvTuyOXwBm/bkgoWPTDeK6d7C9GZL0QdL1kaBw55iPjqtZgwvLj+S/H
	o972aiZtD3MvkFB9cP0at00LioetxETbJWbXZu4mRrZ+U8ykGzgDE6lo+s0AlLnepie+HJms9Tz
	B+T/gQdBqhNprAKKg/lVbPqw7wqZN4nOGXSd87nb9I1cKf9X6bdRhMwpQ65Yx4gAJhalMRNn3Wn
	xtyUrdZjdF5yunuDK6KmBAnraoi54YmUV8U2U7aMoCIEvhO+VJdRhi7VIkNGS0PCyLHL1naIvKk
	qe4t8P0K1Dl5LOrW8OxUjI8s+aNthSNwNsFbEdWNHoJtRdXEiir7lrJOUoLbmaDjU627baB2kh4
	AYPMG/YN7lISAtEXdi+QwS/wMPM8Nr2L0ZnqPRsmW1HpdB2vw=
X-Received: by 2002:a05:6000:2311:b0:439:8a9d:66fa with SMTP id ffacd0b85a97d-439942f2a52mr5792147f8f.42.1772092715708;
        Wed, 25 Feb 2026 23:58:35 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.67.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439927c3e01sm8315029f8f.11.2026.02.25.23.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 23:58:34 -0800 (PST)
Message-ID: <d05ab6b6-197d-462f-977c-b2d8d98e1f8a@suse.com>
Date: Thu, 26 Feb 2026 09:58:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] inotify: fix watch count leak when
 fsnotify_add_inode_mark_locked() fails
To: Chia-Ming Chang <chiamingc@synology.com>, jack@suse.cz
Cc: amir73il@gmail.com, serge@hallyn.com, ebiederm@xmission.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, robbieko <robbieko@synology.com>
References: <20260224093442.3076294-1-chiamingc@synology.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260224093442.3076294-1-chiamingc@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[gmail.com,hallyn.com,xmission.com,vger.kernel.org,synology.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78446-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nik.borisov@suse.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,synology.com:email]
X-Rspamd-Queue-Id: C3B0C1A22DA
X-Rspamd-Action: no action



On 24.02.26 г. 11:34 ч., Chia-Ming Chang wrote:
> When fsnotify_add_inode_mark_locked() fails in inotify_new_watch(),
> the error path calls inotify_remove_from_idr() but does not call
> dec_inotify_watches() to undo the preceding inc_inotify_watches().
> This leaks a watch count, and repeated failures can exhaust the
> max_user_watches limit with -ENOSPC even when no watches are active.
> 
> Prior to commit 1cce1eea0aff ("inotify: Convert to using per-namespace
> limits"), the watch count was incremented after fsnotify_add_mark_locked()
> succeeded, so this path was not affected. The conversion moved
> inc_inotify_watches() before the mark insertion without adding the
> corresponding rollback.
> 
> Add the missing dec_inotify_watches() call in the error path.
> 
> Fixes: 1cce1eea0aff ("inotify: Convert to using per-namespace limits")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chia-Ming Chang <chiamingc@synology.com>
> Signed-off-by: robbieko <robbieko@synology.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

> ---
>   fs/notify/inotify/inotify_user.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index b372fb2c56bd..0d813c52ff9c 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -621,6 +621,7 @@ static int inotify_new_watch(struct fsnotify_group *group,
>   	if (ret) {
>   		/* we failed to get on the inode, get off the idr */
>   		inotify_remove_from_idr(group, tmp_i_mark);
> +		dec_inotify_watches(group->inotify_data.ucounts);
>   		goto out_err;
>   	}
>   


