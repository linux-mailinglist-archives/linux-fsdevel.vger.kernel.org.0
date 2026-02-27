Return-Path: <linux-fsdevel+bounces-78713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPJsF+eHoWmVuAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 13:02:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B17A21B6E5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 13:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A6C5313C3B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 11:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD38362130;
	Fri, 27 Feb 2026 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qaYbLbkX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4433DEE2
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772193505; cv=pass; b=UgoDZVEgwkkAUvdr+3RKT7Iqq0pD3d2bsgFKPwkrMOi5OOLZLONzgePGSAPNdm/GoAgiIY/XXHpMN+ujQ1M3DPSnJCzreNT6irJwmo+n+J31DIZZi3v49j7Q3uuPrL54yVzynpNn8nlPpubxW4gu5x1O+B3QpOejqpmiQstW+1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772193505; c=relaxed/simple;
	bh=R5dd1agmI78MxO6Hwz8YIFtw3H/8rzajvPDjTpT+CV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIIhwji8xXAAhWCVRORN51uSgeg6Q9pG/wPXu9Y42S3GI9gJwMPPl0Ry2VS/eayzISJcSJIVM40RLUy6/ANQeIvqLHkUf+9yDd/U1+B0GO3/0VG4dBgQCfdC1gFaQYhwxr6Xc5WnZ09M9mCslquUushohtLfDcEjWQCpEBIChsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qaYbLbkX; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506cb1b63d0so24450711cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 03:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772193503; cv=none;
        d=google.com; s=arc-20240605;
        b=CVJjRmar5CCBy0tO6kNZhJTA62ki04XQYIczq01v/+06LWq13LCu4+Tjv0MDSP6Ew8
         z+fGMK94a3Yox75T/v1s+7PW5CNJzNBm/sWRjnCK2gtHnmhQeRXyLAKW2gWD8glaYfoA
         XVZ4mlbt82pi4zUKeD7Ba/2kgVO/i2ZrHSNi/12mAxaijO8FQpHskr/NAva+wl7iLYZ4
         hLNnA9aLC52+6XJArcgzZfCJWFJ0/7BZnq+OBq3sSmbiu197ZeXd+vlh3/o6op22h6gJ
         ahRIc7Cb5cMfJLTV99UH393O0VlL5NSAfA9jE6cI1i1w1bWlolS8lVkTsKDWP3gXJkLT
         bdfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R5dd1agmI78MxO6Hwz8YIFtw3H/8rzajvPDjTpT+CV8=;
        fh=Xw5oAZxMPBqokcr/FZprgD60FwJThLwoCGbe1s+gG/0=;
        b=VTXp4PHJRcfXz3fYj3vMw3rHkEAE1g9AfbRdbyynu4v6rf92i3IDrFIHHw7mxgm7Vm
         Qr8oUNL/Ozy1kM4UFjrwEWl20qGj5Cn8uNYyzZrqU4fsZo7MctvN9WHhRzAtg6arjO71
         sOjWG17AjmlMiI2iAvEhQAIjfkWFWBMqprxl24bERSXoy6Wlv+0I7qqwcP7G3A32T42r
         TKyrjM8JhRwYMfVhkaFAUeG9JJzpISYStPSLKOqAq+er7zJlSme8DQiECt68NyW/SQTU
         W29iRc4VAHw7OwuZFda3DZzk4U/k3fB983j9NWTXCMRmXacHOjkoPOj/xLD4wcHtTDVR
         LApw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772193503; x=1772798303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R5dd1agmI78MxO6Hwz8YIFtw3H/8rzajvPDjTpT+CV8=;
        b=qaYbLbkXHRgZbH3+Ab7Wf1C37bj70yzA21b8BmVVXIMSIDjXV4HArNdQjYHlTbmfxK
         iCsGhkxpVPCtzJ4yaWDpiLgl+l1t0SdXFKqGbN7ZUgbBY6DLBxVAih+ZH8vkyU9HfG3x
         ktiuyVFP0eJmco4Rdxko5SpBoXeSf565dg3GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772193503; x=1772798303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5dd1agmI78MxO6Hwz8YIFtw3H/8rzajvPDjTpT+CV8=;
        b=v5LfnQz34euX73nZ5R8lVxNvT62ROae73t9jJ7zqi1HlpNVqsQFz3nnbk/fxHREm4X
         609h6paLS3eIPDa/8f1AFq2tKTLEGB4zd8rswMV/K2FEThbV1ovf3rV208D3wjKhXGM6
         CJQqDJCW1FMZ54k+2yx2xaivyG4vsNBDaB5hDeelHq/ik53/jq6SQvJ255nOSLpSvnAy
         bt+ME0uXTQn/+40oUDz0KrNra/nIwaZ06VC3RjPTQjfjW+dSr3ejrVlTMa9DwfsmPiGY
         pIATBAizD4iziX60uTCgmLryL7Ow/gt7CMk5SPVEgHp5dkcmprN42TS5wZuH0motKMMn
         u60g==
X-Forwarded-Encrypted: i=1; AJvYcCWw7yycfOWr0YXQ+xSbCbAIT8POczbnk0MOCsxcYiS1P7tYlK6FoM4T05Zmdt5QVsk7HEKXKXxppce+FLIe@vger.kernel.org
X-Gm-Message-State: AOJu0YzfcOUsSYilDuRmDcmaNK5bSViLIMzbe51ryW/QcxjA/rpwavMu
	+oBfev8Z8Vhl+9wJuCbCjq7kYGXdPJkh+NFt2ByOwTnsUSkfraDJ7kqVGV2rW9/cp/y76+mdJya
	lYBbT2Yf1abL+lpvVz8/WeN4I685H4T/2ZOn1JVAsgw==
X-Gm-Gg: ATEYQzxjo7y8nNaScXdxCjhHUvn5vfCjHkV2SIbjGkTTPAXBzZXRGMILBOOL8jiVQzv
	hmT8cDEztzGxcMmtEGuQqvh9pm0u4VIwXSdByidjkzHu7fSl0ZZOtRPnNtaWtxRmQENAMxMftE9
	VQ+C+Gb/a3KTMxdxlUB3CrxjAEzKML5XrwemilOz2Aa5vs8NstbQCUgPEJAJk+ce4wvlNG6cWfl
	0oGFa7l6R8aKYmXR1oKnYJXojyybuchYS4cIGEpc7qCk6fM1+MEVzqyyhTPXlg+qk9AMwz9FluL
	zdTxIe027CV4J8oq
X-Received: by 2002:ac8:7fd5:0:b0:506:9fd8:f65e with SMTP id
 d75a77b69052e-507528a59bdmr29321471cf.60.1772193503535; Fri, 27 Feb 2026
 03:58:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
 <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com>
 <aaFyQX9ZI4KmqtFQ@fedora.fritz.box> <CAJfpegun=NNM099f6GC2_E2TbG0s936V_sW5SExt6mOEC0_WMQ@mail.gmail.com>
 <aaGA2YnQnlB27xAu@fedora.fritz.box>
In-Reply-To: <aaGA2YnQnlB27xAu@fedora.fritz.box>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 12:58:12 +0100
X-Gm-Features: AaiRm52u-zGSzU1RPSdRGQazupS8iyFLfte5Ps27Cl6ocmaVCn4hROhK2vflndE
Message-ID: <CAJfpegvPxgPs_AYhqUjgak_P9BLTKAjn9FLNO6pAtFjx-YyN1Q@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v6 1/3] fuse: add compound command to combine
 multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
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
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-78713-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,szeredi.hu:dkim,birthelmer.de:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B17A21B6E5E
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 at 12:37, Horst Birthelmer <horst@birthelmer.de> wrote:

> I naively thought that fuse_atomic_open() was actually there to do an atomic open ... ;-)

Yes, it helps with atomicity relative to operations on other clients
in a distributed fs.

For a local fs it does not make a difference in terms of correctness,
but with compounds it could improve performance compared to separate
lookup + mknod + open.

Thanks,
Miklos

