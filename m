Return-Path: <linux-fsdevel+bounces-75588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKrkNH+NeGmqqwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 11:03:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D00925F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 11:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B8633020A66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 09:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1A7339B45;
	Tue, 27 Jan 2026 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NcfOqBWe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0518E3382D2
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507893; cv=pass; b=IuLsq4GcpbhyIMbe7qAhsY0j9U7P02psBpF86DBUF/W5OqrikN0eA17k6Y5OSKNVp/OXyqgtlORpyiDUnJkRd8+VmX7fe0eof/Ae1FJ4mbwT0Verx5TrSUdmweh3lAelJgB5zt89ATVBotI9gYnidlLtbCTcwUdtx9LAFlDwV5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507893; c=relaxed/simple;
	bh=go/+qf/8SPy2Nxx6skpbP6WqbE6jsiLexSsjRT4p33A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMcR/DKNNJQmNx1dPvetq7fk/2+c+0750a65lm7i86W4n2HBnlJNpYLYpeKDLxeu1/jkzLW401o3eA3buWaQAwUv/RX58PU6FZtmBuD59/QM7a2LJN5L5HHqJlDsMDjGoytFE3hdYnbqNlxhjlpOmABGb7HuOKGRzTDPCbyc5H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NcfOqBWe; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88888c41a13so68500756d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 01:58:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769507891; cv=none;
        d=google.com; s=arc-20240605;
        b=eWphABZBWfEsUmXDayE2uYnKO6xcc3lwSFhZMH9lvlpkYOFhsXPp4q5OLe6mlU8Idk
         yjdcAqnd1UKO4A0LUzkIgfdAa42b32eSpFcaAIFMsm8bCiy07/qLsbJsWpY1J1gSKIHb
         wawKYd4Eq0SW2UihzFoDQ2z22g4xtCKPuoHfA5zqFiN/GDY+5+LYuOJF3ncc5QGJRt0w
         OJ5a7RFYBwRUBrTOB0g7mp5tzUSKeM99YOObFO6lrlsr4hvpvxygGj1qZOuxjMs+JL7t
         asVYchkc12GVbRt5z4/6eqdFBzxLd1dFALdA77xLsmpqUgLyaHPu1RFwEYKg5L74jB0l
         7ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=go/+qf/8SPy2Nxx6skpbP6WqbE6jsiLexSsjRT4p33A=;
        fh=hQoZ1k+GIS+8pUMypyKf/kWdNTGtDjxnInDuDkps0K4=;
        b=QdW4WWcbVVi0ZwJ/CxJaPlAe/NKHRBDPKNzhrWoSiUfpRHmpLfeeMdUgWoJrj3MdED
         teCjCdurm7nYJ4/OhGbZHhduG8jIhtghmAmWWzlX0p7qF62S+YHJ1gRc7AjEgdYG5OBu
         kRMs3eDFFWPlJ8ViLnXbGpqYbZQVcTclbPFIwSvcF7BElkvxIEY/5hlUlAkm6ZI0fyL8
         Cu+GhyUxabx7WxoeZXIqtG2FRbmytZyD2KiW5JesnhtObLbEN4OwFvuI11FbUwszqbCe
         uMWQkLiR8N8QR1OYsaxfxDjhAdp610l6aMplM8Bkt1HlnlR2Pzj3C+xYx+weS+ut8lfZ
         3CQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1769507891; x=1770112691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=go/+qf/8SPy2Nxx6skpbP6WqbE6jsiLexSsjRT4p33A=;
        b=NcfOqBWeG2k1KxlBiKvBmhervVk5tfofMr6BeKRYZH/+UYWR6ql2k9PTXpSnD1RjpM
         KkRbmgJy21vNMrL3hwTKi9urIXUfY1PUlH8yAB4pb7aPXAs/iq2LZcXrclKh+3sVkJcU
         f2DFIQzGiENVLVbOpa6zI5vbhdZZY9DbQGFR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769507891; x=1770112691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=go/+qf/8SPy2Nxx6skpbP6WqbE6jsiLexSsjRT4p33A=;
        b=cZc5ozm0k5VPH9SuEja9N5WCj+aUCp3sb9c52XpTIutM1FcyzDSYRkc1rrFpaRnCcn
         wvgHUIJ67qAcpxDO8K9+VVCLNPSGlZ7TqBkcsr3jPyxWJxQYcCnY/0K/BYSqxl4jHXwK
         aBKx5JyTGS+1cMz0JMnxyPLx+D6zWvDPCuuDW62ySEdfH2UVVCQbj7PWJHg4K4N0OcWG
         W2lFJ0GOtVOaBToqjuLDFAz9Bnuef7lP2raq5Vxk55T7WEPVFcXybBTmckntT1MW8MTs
         Akz9WsDxkWY6qOys9snMX2vn9/qpZH505W0/HFrGzeU4v4CMA+ILj63boHCapWb+1IOJ
         LwnQ==
X-Gm-Message-State: AOJu0Yz5HsSasdowU0W9xaGHxz9UWs2dGt5pLWcP1so+57WFS/nVWgY0
	bogivJ8F4qwbusejlmwG389K8x0EpTw2HHmSc4noTSk7u57GWNq2xbxoYniLGRJh2YSmSRmMrT1
	YwUpvB1XkbgbxHZwgR0leikKHBFTBIx6FHAZPhncTyA==
X-Gm-Gg: AZuq6aLdc4bI2Yse+KdPNFHw/qSP9/xR0iyi4k7lPNswjGr9GowXT+kXQzgBoZAp4b0
	6Lg97apRwCkqQyq1deQYW4u1dECciMYsFC/G+imHvppcQA+ETjWk5mrqW1pE9g6GawQynNVucgv
	3jKOPEJ3TLMARFRqDvytiSrdWemtGeLnk/1LmeSdK2Pi2w4IP529xUo4oIzp6INC6VLHnlrsxYI
	tZu6O5jORvwbRao0QYFkxvAEKZBozevm2+66/L6Y6wa7zjEHFqOSmHDuMwbDLewgDRKmMU=
X-Received: by 2002:a05:6214:2527:b0:894:79da:c489 with SMTP id
 6a1803df08f44-894cc93ef24mr13506016d6.58.1769507890758; Tue, 27 Jan 2026
 01:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251225111156.47987-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20251225111156.47987-1-zhangtianci.1997@bytedance.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 27 Jan 2026 10:57:59 +0100
X-Gm-Features: AZwV_Qj73OfEhieymnWm8Rx5z4Vb_Bk42KAxItZWUPlwMPON1jduNyPuQ9LlCs4
Message-ID: <CAJfpegsnLAAnpxw+sJ9tcf5dLfcyK3mX0Jg7+XuM2Yk7Dfk8kw@mail.gmail.com>
Subject: Re: [PATCH] fuse: set ff->flock only on success
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com, Li Yichao <liyichao.1@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75588-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:dkim,mail.gmail.com:mid,bytedance.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39D00925F4
X-Rspamd-Action: no action

On Thu, 25 Dec 2025 at 12:12, Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> If FUSE_SETLK fails (e.g., due to EWOULDBLOCK), we shall not set
> FUSE_RELEASE_FLOCK_UNLOCK in fuse_file_release().

It's not clear if this is an optimization, a correctness fix or neither?

Thanks,
Miklos

