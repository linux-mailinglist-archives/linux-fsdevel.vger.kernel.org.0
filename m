Return-Path: <linux-fsdevel+bounces-79559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOKdIH8iqmnMLwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:40:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3C5219E47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 375B4303FFF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 00:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4132DE702;
	Fri,  6 Mar 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKkm3pnq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8732D876B
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 00:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757622; cv=none; b=kkljQDHTAq242iYob0KOdaLwMO9ICSeYf7b6Hb182/nP6dwFjG1lASoiK/gw+0EwPSMxDiynPygq8C8HC96umWZN//v8OwXwPRWBqNfejnULltWW7Zc3tYDE4v+c+AYa5ogUnzFbrJVUPTF1E7uvEZhATxcnBaWt6hRDrXSxxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757622; c=relaxed/simple;
	bh=jGeYHXh3LlQv45gi9ZQhGp4yio/AGub7iPItilfYkQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5D3UqdF/01ZxYwOiSx9xmKFj0Q6cpwgzceDODoHOgma6hrolWiArIFU/eaMPOyQSPGNYFqUGAwx85diQH5cgmvgq/Ab4M8ZOjKwmva1Qeqbvsmk9lBCJ/PFAlv71p9s23IonPcqT+Rr15apMQS+IghyhRRjKa1v5WmrTqxs36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKkm3pnq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82418b0178cso4867225b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 16:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757620; x=1773362420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vwm3wwvpSH+RZbikS9WmeaWeWABu5ZF4Jeo4IRWuDNQ=;
        b=SKkm3pnqrONZcf3GIeifQ7+UrEb7eTV+U5vW/z38cm3jO5qEj04huTGCMu/OK1yk8I
         SQtI1MNtP4k9YMJ2K0vgOvoScrWY3xdhc7vvjbevVLEPc5LmRDU4FJxm8U0tumeLDtcn
         FRL1k6XITPzcUPaes6TXcI9sgb4Cv0JwngTmh6rlSNuR602spK/R+dyDz2nF+7OaR1iD
         9RUYEGJj8/jKlllfBtMOtXJXLASerAJItIhHRLVvB6P7RaHo4uDbDhKy9UcAXTjWOwr/
         9uE0hwFdw4ZIhYItwESX7Ytvko7MXMllqf7B/RExJgxpSFfBy8UUYjjOkdCYDn7a25JV
         GNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757620; x=1773362420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vwm3wwvpSH+RZbikS9WmeaWeWABu5ZF4Jeo4IRWuDNQ=;
        b=xPnsuqSOPQaj+AYytTHUXc27AGGPy5sZMNdh3I8QfZn5WTCyqgKtmfpPtr97DUqbRE
         WwzqemlD/Riq8ueqmk4aD3IHpkidz7/UPhjtPgxsN0eJF9jFL3pDaL2cITFU/S1v8qSO
         GVTUEzFC5qhyJIcKroM3iYcMhQKFVe74Isbe1Mcs53me2PDex0XEDqENZ4F5WrxsVhmm
         ZPvfancBjixd5yNhYyXmMhn49tZbzhopAg3vm+s0krmz0ChZ/WXlWjgeWs3UUPss3DQr
         r1+aZcZUkrENtYZsnErvW+avzkGmAKvfihPPwBOu1ZxB6axMreNE6PZpS20jQumT2dpK
         V3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlhb6YAUq6vi2jyoOLilQvwOJo366HRuVWNC/XREiNtTd4eTx35aYB3V8MMXRJskzW1bzhH4IZ2X5DGrYt@vger.kernel.org
X-Gm-Message-State: AOJu0YztTqXWA2A1Avq4MMP1kTq7g8uY7mCj3aSSYPMh05aojZgmpB8j
	jKesqAQha7xUextAu5mAde+KeEpds9nCtRDQ7NT7VkCooye/vvZ9Rnmz
X-Gm-Gg: ATEYQzz54npWVlBPL5Wpg6WGfo21h5TX3Sw9O/570nDNfqueXOpTkp+7zXpFLg5Lbew
	Y2hCbwh6hJvLOP1LXB3ds4iYORm2rh+WKySisavWPLVC4MuWsqK/tOHVAZ2FvqxzOzrWKDmJtet
	Y5klc9r0f5rYq+G9134UuswJ0P0trZGgpo7eeyb9DFtn3VhEDI88urXyW/5odV3cmjktoaY8GT3
	E+xBPPB5Me5II1HOxqD4reZtl2lvVQz2cYZ1q93KtDHqH3OQmZXfCMzretV7uYC3OLJAoct/E9l
	Xi3pJ2nndT3BEx9ZaM/Nzm29JQuHY879RX2dsOSm53o6s7s7zw/C7SkOqNko4enE5UQTeROer5o
	YejbtLbTldByzUpsSFkSosqGs+Rxy1Ejy5r2YqOA9GQPsm0K5RxoabPluZUujtO91Oc6VeDQAaD
	+zYzgdTcJpG8PXKw==
X-Received: by 2002:a05:6a00:9510:b0:81a:883d:cd05 with SMTP id d2e1a72fcca58-829a30d0307mr163580b3a.64.1772757620313;
        Thu, 05 Mar 2026 16:40:20 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01080fsm22107684b3a.46.2026.03.05.16.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:40:19 -0800 (PST)
Date: Fri, 6 Mar 2026 09:40:17 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: "hch@infradead.org" <hch@infradead.org>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cheol.lee@lge.com" <cheol.lee@lge.com>
Subject: Re: [PATCH] hfsplus: limit sb_maxbytes to partition size
Message-ID: <aaoicV1cxDCfKpbO@hyunchul-PC02>
References: <20260303082807.750679-1-hyc.lee@gmail.com>
 <aaguv09zaPCgdzWO@infradead.org>
 <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
 <aajObSSRGVXG3sI_@hyunchul-PC02>
 <aamS1roqYDyEz0P3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aamS1roqYDyEz0P3@infradead.org>
X-Rspamd-Queue-Id: CD3C5219E47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79559-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 06:27:34AM -0800, hch@infradead.org wrote:
> On Thu, Mar 05, 2026 at 09:29:33AM +0900, Hyunchul Lee wrote:
> > Sorry it's generic/285, not generic/268.
> > in generic/285, there is a test that creates a hole exceeding the block
> > size and appends small data to the file. hfsplus fails because it fills
> > the block device and returns ENOSPC. However if it returns EFBIG
> > instead, the test is skipped.
> 
> generic/285 needs to call _require_sparse_files.
> 

The generic/258(src/seek_sanity_test.c) is considering filesystems
that don't support sparse files[1].

int test_basic_support()
  ...
  pos = lseek(fd, 0, SEEK_HOLE);
  ...
  if (pos == filsze) {
    default_behavior = 1;
    fprintf(stderr, "File system supports the default behavior.\n");
  ...

The issue is that there are some tests which write to offsets larger
than the block device. How about skipping for such test cases when
dealing with filesystems that don't support sparse files?

[1]: https://github.com/kdave/xfstests/blob/master/src/seek_sanity_test.c#L1244

-- 
Thanks,
Hyunchul

