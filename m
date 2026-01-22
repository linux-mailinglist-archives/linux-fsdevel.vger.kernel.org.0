Return-Path: <linux-fsdevel+bounces-75028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGTGD+cXcmksawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:28:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD8E66A13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55A5A90BCB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93F542B72E;
	Thu, 22 Jan 2026 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+IUwdvr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C85346AC0
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082770; cv=none; b=mOiFb3ruH5qVjetAElfXG/e8I6DwSA4YcAmAYhU7d5VHbKZ4gGj2iaf51wdViSWXWhxBsYeD7GboCWN2qL5BpHwOG61OjFEa1PInks5gwe55B2ehF5k0MApPXmlgywZrxgfWDtqAocxjOk9Osd0du7F3OvPu8Sauk9x4q/0NXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082770; c=relaxed/simple;
	bh=QW5GUjCn3hN08/OBQ1ZdE8ryQywoHVRE+EfMqHC0LRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORAGHhthtlZvUqG7sF2RvWr051CWNEYY9fX8JcmvCaQl8Q1jXyq2LeBTxamoTveH7jEuzR9gRtQpb+aAoNXwlZ27spPKoZcXNFy8kx20aZJIqFlJFdg7HGsAKHIbbEpldh437FbRw5GidOj494IxDoV1GDe/bWTC/ZGOt71zUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+IUwdvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3514C4AF0B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769082769;
	bh=QW5GUjCn3hN08/OBQ1ZdE8ryQywoHVRE+EfMqHC0LRQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z+IUwdvrbPv1Lbz/LHZS6h9th+g1vDGOdGxL8p6VvN4uAkPnJAxMFMWC2Xw/Ofxqs
	 XCfm7I6giVNJTM+sCUjgwWHjVfKp6ad3ajitspAdpVmi08K9P85t0sAG36XxrbzNFQ
	 LYBurURZW7bxXTZPss7OOIs3J+HFcfZ9R4Fvt/aaA/PzL+0kGsFGcDF9OG+gB0PKsr
	 B5h2oaAqvVgTuoZ9MvgeI/15UtW52W2YEG2mbRXZJG5CrtTC84Ul2G/F+++ZvWgocW
	 d8RIKQDf7M3WSjnNkOBrtz3KvzuZnqQXBzQ8CdVDenANv0u2nR255dYzf1tUge+obN
	 GQrTXnrrML34A==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8718187eb6so125397166b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 03:52:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVspfF+Sk4nK0RDA3eYIoINdjzGuDP+TRu/8TnHG0PW86G4gjixA3HDjShZJW4eo1Fut2vtAHOtUbxSIwg@vger.kernel.org
X-Gm-Message-State: AOJu0YypPe+caNoHf+NUky5i5Q/O65LUp0CpNWcwhMWq0BtMmdvbCNw0
	h0+fPs6Jc4XRCMROCHToytCD59qe7zg9lJ3gRNhBBZQjzRLfyIMj+AGO4iT7DS+CQ1rNOiDMF0V
	+l6bQ9SXemB+GIDtXpnPuSZXZbIbCFzw=
X-Received: by 2002:a17:907:1c20:b0:b87:1d30:7ee with SMTP id
 a640c23a62f3a-b8793245526mr1901571466b.32.1769082768298; Thu, 22 Jan 2026
 03:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122000451.160907-1-william.hansen.baird@gmail.com> <20260122000451.160907-2-william.hansen.baird@gmail.com>
In-Reply-To: <20260122000451.160907-2-william.hansen.baird@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Jan 2026 20:52:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8LPeh7g_yUe4FMWXB3sezJRQWx_q+29rA6TgvR_TV+pQ@mail.gmail.com>
X-Gm-Features: AZwV_QiRxzl807UqpOSr3zjEGHUciT4lkipFSMgUWdP2FN7O3PxCDdEwr9wJHo0
Message-ID: <CAKYAXd8LPeh7g_yUe4FMWXB3sezJRQWx_q+29rA6TgvR_TV+pQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] exfat: add blank line after declarations
To: William Hansen-Baird <william.hansen.baird@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75028-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9DD8E66A13
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 9:05=E2=80=AFAM William Hansen-Baird
<william.hansen.baird@gmail.com> wrote:
>
> Add a blank line after variable declarations in fatent.c and file.c.
> This improves readability and makes code style more consistent
> across the exfat subsystem.
>
> Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
Applied it to #dev.
Thanks!

