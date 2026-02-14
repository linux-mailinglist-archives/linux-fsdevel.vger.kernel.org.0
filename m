Return-Path: <linux-fsdevel+bounces-77228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMPYJgLikGlmdgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:58:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C44E013D384
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A66E302F3B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B022E5B19;
	Sat, 14 Feb 2026 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Of/Cpobc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713B23E32B
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771102577; cv=none; b=nmqcJLRL33xVPUj1m1S54kgjKYlSHcNci2+BokEsmOi2/se/qh82+pqurWgrdeMmlWnnxOdnPhZzXsK3HpJqmlV6hp8qD/GWcBbP+yDj2RxARgrKosO5IFv3aUscEWCH0MQ/hT63rwDdCd2E+grRV5QUGKAR6UpYIefkBhK2fDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771102577; c=relaxed/simple;
	bh=h6P5xznVIbtrkQIWUXaREkKf8IBGeM8PtnYOpbHTLBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZP4h6MgVUs65GZVokUYxQ5ZtHRnIa5U6cBXECNKwlS/2Ciml2CgnKlo9io3/MbMM3OhrbuqGtJabuJUAL7eq/khmf+W5Hf6MctJyfAox668gMtlOQ0AMVfH7nAdqLk6/YSk3oR1GsISL2bvDKu/toq5bV4pfRyQMNTv+2Mih58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Of/Cpobc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8fbe5719ceso231519766b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 12:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771102574; x=1771707374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JbvQMzer3/FUOLzQD0nRpytAmjKpWlv4HRm0x7BxSPk=;
        b=Of/CpobcogGxYrC62Vwga36HcIjNvUafoR5FbL52WmzB0M9Q26QUvPczbBzkePVea+
         5TQRIlv60zpawGytfR+TK/ZfvGs/tWhqBV1ptkFTOv/FlL9NMuEwWweFQd0GEopA21SV
         MiZvpILzMT2DYyUeYf1mJdauEaS7cJSa7uOig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771102574; x=1771707374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbvQMzer3/FUOLzQD0nRpytAmjKpWlv4HRm0x7BxSPk=;
        b=tpD/PUeSc1nnyVjij8sB6KuPbYcFTwgitQrIjtJZJzA2abtoWB8wkWTpVIDKhevmTo
         JBfOC0S3B/Y2hqxRoCFOXF88DmMWfcGJNmPG6GNZOOgky5IOrsga0AR2YgYlibY6kXr8
         d1sn1cT5jwS7TQ7fOy20cKUF/18SLGvKHreCgevPbRDabUj9aduXlvuajO0sjqyHHt7E
         O2ClJPljWTpagKPRB+ap4q8ZpVh1JsPtTZRbOkHqk43vPjdrQMXdamq1kEUrPxw5Qygy
         Ax60rTOK3IC1yXVlsTROHcPXxJx2bI3l3+yrqqGmAvEtqel8mfMdlGFw8hDVXEM+rUm8
         L6lw==
X-Forwarded-Encrypted: i=1; AJvYcCWGjFmRZr48mkZ3iwZdQGmRHo2NiqIq6hphKsh94cPMqw7QRSNQBq5yo/DWbrNOCYvyAebj1J1oUFck8xtu@vger.kernel.org
X-Gm-Message-State: AOJu0YynR+P9oEeSJU9TfNrQ68mw+wbe0ldG+hcNz9ir0rNsjHax96yF
	IAH44Y3JJAjnpM7wbDkNoBBofRwQm+/Kbn9cQr+0PxUluj2ND8rTCqMN9pqkkoHGvGynjVC8gcM
	mXCdGzQc=
X-Gm-Gg: AZuq6aKHSrUk7yIXlHIoRRPWUveyceZWpDDArgt+wYiwMYjO95GJBIQLCHQ5CYa2Koj
	e8Sh/Rzlu4EJbuezjRMGjgRdzFiOGOu+L/a42icflhZ6ho5zDweyIzjfEH8ZWCChVmlRYXvPZ4I
	AfP0F2CeCxBEj8aQZisc7jdFzXOAphLl/GLyX4Wynq0ajV3HT5T3XXnPCVyplNoKJVqUIPzAYBa
	Ne3OrGVOFsbv+cn2fuyhElcaRq3eEB2RrC/QNRwe4MDie+yiEGdDye4QoKPGPde6JxC2UQd6olF
	utItPjT4cg4TXD10O/yY2zx46eqThEfCZ06dSv5SB44KqpvoEv6yLI2alzEhNEyxOr2JPCLkYU8
	PcN3zE7XESvd2cHkjgA94zr3MBE5r5oQFurvL00/yr5i+ixXk8RFTMpj+8YfTX31AQyiuYyaGcl
	pp13IV7SYDnLsO2GNtqSOrHjCktGInobsrW5fWS79uE1LtNJ4tw3dT8NIzMO+ZvPTsN+lTosP2
X-Received: by 2002:a17:907:26c2:b0:b8e:fb1d:9eba with SMTP id a640c23a62f3a-b8fb4509ad1mr361218366b.54.1771102574005;
        Sat, 14 Feb 2026 12:56:14 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc762b672sm101475466b.41.2026.02.14.12.56.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 12:56:13 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8f92f3db6fso319210966b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 12:56:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/E5r5pJn00vQIbWii/6hZQRF2nHcM3YvYSArIqxdQId4EJpieyxditq438u7R/mjnXDg0HcYnbLfr5vcL@vger.kernel.org
X-Received: by 2002:a17:907:3fa4:b0:b87:2780:1b1e with SMTP id
 a640c23a62f3a-b8fb4485f66mr344808366b.41.1771102573559; Sat, 14 Feb 2026
 12:56:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214203311.9759-1-ebiggers@kernel.org> <20260214203311.9759-2-ebiggers@kernel.org>
 <CAHk-=wi60UWZ=kVayGKfrGURiX4aN6P4J_bNMOw_pSvUrxw1jw@mail.gmail.com> <20260214204833.GA10472@quark>
In-Reply-To: <20260214204833.GA10472@quark>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Feb 2026 12:55:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjiNgOopJgV9=apY8AzOBAqXi=xfWpzN-3dkhL=5_4UKg@mail.gmail.com>
X-Gm-Features: AaiRm51_6K5-2xlX2SS3HjfeJ2KHPjBlp8PFC1E0bbiJAg4nV-gV3EBEtvG_dBo
Message-ID: <CAHk-=wjiNgOopJgV9=apY8AzOBAqXi=xfWpzN-3dkhL=5_4UKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] f2fs: use fsverity_verify_blocks() instead of fsverity_verify_page()
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77228-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C44E013D384
X-Rspamd-Action: no action

On Sat, 14 Feb 2026 at 12:48, Eric Biggers <ebiggers@kernel.org> wrote:
>
> The reason I went with the direct conversion is that
> f2fs_verify_cluster() clearly assumes small folios already

... and that was exactly the same thinking that led to the other bug -
"it's fine when folios and pages are the same".

And then when the caller was then changed to know about large folios,
the code silently became buggy even when it visually *looked* right,
because the page-to-folio translation had cut corners.

           Linus

