Return-Path: <linux-fsdevel+bounces-76682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +dJoIHhpiWl08gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 05:58:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0A910BAE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 05:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C275130082A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 04:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7A92BEFEB;
	Mon,  9 Feb 2026 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2Ou/SDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E9AD5A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 04:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770613109; cv=none; b=gJQ25Nj8HPdosdUCl+CoOIkmIvrtC8pNmYZ1UuEL0pvVVNkGU2O1Hq8KIaaIIKo7CZPAPYLgMsJJcuA64URZ7HjbqNAA56HK6BhNQjOQagHhR2g9QldzGspGLw+61vI34/ZnhPKDwhtsApUFgPex0E1Evmc62k4LVJFMp1geO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770613109; c=relaxed/simple;
	bh=kBBRCIEGOxP71duR9Pdkyw6icI+O41FhThI+xmeNQyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DebXjtJclLFPzfhjq/q4zLmwTToQPaSoOVCQIq5XXild2k5Cj8u9bsxFDTCTVzKNce5vx0jOItpirBBEXIIw8qMQebPfS2RrWpTjb8d1auAbugKC7UZqo0lWOgDnS9VaZg29lXYv+Z3/K2A/FRj5Y+IxGjst9PJXmX8ZRBD1ao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2Ou/SDb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4362197d174so2273761f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Feb 2026 20:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770613107; x=1771217907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4peVNB+5ELYTcHmDpzvkLXgbTr9tYPUTjyVW9rxozv8=;
        b=M2Ou/SDb3JlBres7u+FI08FLc+5RxjpFScUBVas3Z156Gh+M9lam72UDYdTT64k1PC
         xj86hp28oMUOZbX4PAZwQJEUYvTVklybKdQkBRH87EvJDb9WZULF9o2jD3+KZ3Rtam4F
         1LR4475fCwXkLXu2nkzjwMj/kPKFSzIssS3GMqR1EIuM2WBgrEoRnI5iBtbBlvU/dkMJ
         As6zESs4jsjBLWTjSy+A2FwEi/dNINqf3gnYZtvTqW4pRwJJH4fF/e8E932IzGxjklgP
         5g/l2EUZcDXqUBIq6TxmqwPmIfpSauOQriCn7L5syZgD3/jWVyfPv5R9YU4d9PMIS/Jk
         T3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770613107; x=1771217907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4peVNB+5ELYTcHmDpzvkLXgbTr9tYPUTjyVW9rxozv8=;
        b=m/8zTxD+IO0kUzX9WwiQKwBR9/v14dtfZuQp3zXKR3bjtGqfjybLvI8LEYkCuO7gMA
         hAj7o3Q/VpAk4swLAj6/W02WnmsvoN3oti/iCe/ZGzkt3Zcc3hVidwCuNQCAhByvEpUY
         ChmCIFxaQ0C9YvP1jHJc1svG3vMNXTiPTtPU+VZlkfxLJYm3mVAC4j3G5ZC3GWtcnDqK
         /92VBHVXQ4MlnWsYP+ONPhdzfWepi3Gtkji6v1vNQlNFQ+5Vh9QLMqdY+HCJ5zABYIHr
         Stq/k/mO4j1NOrhxWHNAKrC6AqYxNx7kxm8G5f/kmIlG7A3/rFIkghSMlCOQTClvXk5M
         O52Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0yQVQJ/EFMkEuD/zcEpxlJQZnhz6eaZ4B7fkuMwA1TrVtxASkOL3hQDG1E70OSg9Q5oXoeNh3Oi9SN+o6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/jM4wGdntEOvpbNfAmcpMVaWKDvW8YMjBMscfw02MkyOIkPUC
	ktiXp7YIHkhO3gr9GbKUoHCmwEydtRzeetS97VfQh/ERa23mHRvkSM5e
X-Gm-Gg: AZuq6aL63H1fgCLzdQIcthAbEeksSeBTYw1woLvbNGbtZ/u7jqtmXef4BwOlPrKsASu
	9HKaRwkrYvdz9OonWEp6FqQ22s/59mnOUIa7Q06bPcDJDI2NRBj3oqv6+TRxYDh3mmDobYX7F7N
	XwMJvzphigGimOskSRx6VgvIpraTm/y1vaYlU++7RAf53q6odU8E6Sx7l9R+jy+BGGnrrn7tBC9
	ZACU2VKvz8kAfdoy2eoQo5BYu3slh4hvbrgduiuLnd0ry5sRjQlKsLKRj3s2nkB93rlAAcsR1b3
	xSX/wBjHuNk56gFAFliwrm2XmebT/Ncqyvg6h0htKJR+KhWi8dvWc5QHt9fqrW5nZdnxOl/Ufdy
	JmJYFkZ2R7WocwARb0de4DER56Mvd0XNC5R+B0D2m11Jmfxp5ctwyO+QW1E85nPcfT/4g69wExb
	ji80+Q3GiA4nZu1BEfD8Nrp30hXfUZZD6g7WuanhTITLNVGRk/ytiQQeg=
X-Received: by 2002:a05:6000:2889:b0:436:1a24:df81 with SMTP id ffacd0b85a97d-4362904b702mr13678811f8f.2.1770613106865;
        Sun, 08 Feb 2026 20:58:26 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376a78d796sm8070092f8f.20.2026.02.08.20.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 20:58:25 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 587D7BE2DE0; Mon, 09 Feb 2026 05:58:24 +0100 (CET)
Date: Mon, 9 Feb 2026 05:58:24 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: ANNOUNCE: nfs-utils-2.8.5 released.
Message-ID: <aYlpcPkq_glykQvJ@eldamar.lan>
References: <fdf3631f-e924-4e4c-bd9f-db5b40a90bfe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf3631f-e924-4e4c-bd9f-db5b40a90bfe@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76682-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,eldamar.lan:mid]
X-Rspamd-Queue-Id: EF0A910BAE1
X-Rspamd-Action: no action

Hi Steve,

On Mon, Feb 02, 2026 at 06:45:30AM -0500, Steve Dickson wrote:
> Hello,
> 
> This release contains the following:
> 
>     * Man page corrections
>     * min-threads parameter added to nfsdctl.
>     * systemd updates to rpc-statd-notify.
>     * blkmapd not built by default (--enable-blkmapd to re-enable)
>     * A number of other bug fixes.
> 
> The tarballs can be found in
>   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.5/
> or
>   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.5
> 
> The change log is in
>    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.5/2.8.5-Changelog
> or
>  http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.4/2.8.5-Changelog
> 
> 
> The git tree is at:
>    git://linux-nfs.org/~steved/nfs-utils

While 2.8.5 was released, I do not see yet a release commit and tag in
the git repository, is this correct?

Regards,
Salvatore

