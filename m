Return-Path: <linux-fsdevel+bounces-76047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFzdKYCsgGkFAQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 14:54:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08134CCF73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 14:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D73A4304751D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3587336AB4E;
	Mon,  2 Feb 2026 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="l4wV793B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A31C5F27
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770040279; cv=pass; b=a4sIbbHKqhyiGetWVB384N/7iHXw7sS7BfsHNMWFqVILfeZ2dg0eb2bA0AJsZNXaB16dfrX1vdP3PWRzXnj2grteRHPf6ZZjxC9F6u7OmOFJWcwuENRSqM+4b9+YR+MOaecn1rvpux4buNNSxrLWfUgxTTWQ8w1388P+ew5hQyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770040279; c=relaxed/simple;
	bh=eoMdvvLfJNZhxC4okL5A86p7LVwnQvOwQNC6Tmrt4RM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cEGJz0ys+Blznr80drmY6AkQ0tu4aq/ngxgJOr59U8qbd9z8mSCqhVZOdFugTuqUO16G2wr009bOtBC0+grZ/nVGAwmtqagwGdNXmrkHa/AIp84tnlJU4TXcSctmGvE5y4/HrZdc9YvgYAxwZ73gQiAUNENDxt5lT5F/UC0X4ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=l4wV793B; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5036d7d14easo46258611cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 05:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770040275; cv=none;
        d=google.com; s=arc-20240605;
        b=Wg9L2hHTmYmH0vqUoh5KJGT/FR2llrzZ585832XOyy7WJ++Yxh3VFrx4yzZpr352B6
         37oyTLJwZuEZ05M3k13UOZR4icQIfX23QTA4lbCoWP4dvw9jIm9HJrFwiI5Od5U5BKC9
         fOw3ISZ5SFJ7IiUGbTm97tMflgSqxo6QVufu5rDXdXwM9c1x0IrCNA0x50q04sP5y49N
         I8tAbxVSU3Lu9sFYbXMdQAlMlWCu+1jizIa+jOjg5VPRWFpXZDCYxFTkS9kqZOLiMv/b
         WjmEfgV2PgTgOnq+tHVLPbXhIQdSte4peFLJKsofjh56rPNOPmCC5AX5StG2P5UX15Rq
         28Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=eoMdvvLfJNZhxC4okL5A86p7LVwnQvOwQNC6Tmrt4RM=;
        fh=L8MiPSa1Qj1DcQ93ay69BvEXcTOfh+JFE592sCRzhww=;
        b=hpvgRFZjDr/8Q4M9ZLoRxEUraM/G3eZY1TiSusOqM40TykYv+YiFrU13DG70AvcVVy
         eWK6bUwEsYHMgctZlhqnGylFDumhFAz0DyqHLUoO3XmVy2+TeqK+UT8M3l52XHznzAsb
         U8Q7ocgRonYuocCc4TgducM1uhm+jrhNpIOW19FpJbbRHq3gykM5Vp6aJdXhxFKO4CXZ
         yc/Ob4eadENPCF/paQ40LZJ9AhTb45pGJ27gYIrKeooxLpHNjyjpuHF3rXRfvIz8RkDP
         tcPCFe0otTdittMl82+8fp1Jo9abg96NiKrDpLyYbRyS/EP+9tmGQls59zzO4n2ClKiI
         2/5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1770040275; x=1770645075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eoMdvvLfJNZhxC4okL5A86p7LVwnQvOwQNC6Tmrt4RM=;
        b=l4wV793BGR29PR/Hu1VqZun6rmhgyD13pLbC6UfRX3TKDwARIfqryczW5AohPPWS61
         KeXb53oiPxZ2KQ8CRkzUx7zO8yeIG7xVOUvEh0u/n6P8CbDpcQENTG69jwoDCNhOzjiD
         qMYDYzb4LTgZGZG3jX1VGDFWOO29TJqYM85oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770040275; x=1770645075;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eoMdvvLfJNZhxC4okL5A86p7LVwnQvOwQNC6Tmrt4RM=;
        b=AIua4QGO7s3uyIciT4UYhM2YVk9F0Em58ECdx+LdCjFmbgm8CJIjhEpP8EQMRGSVNz
         sn1Ks+w/6hg7lSHoRqlECazjPrHVDCKds76lMUWtM3ANLiiY5RJOVt9TK7pLRamkZ9WG
         STq/a9dsRW6G4mu8SJwuswI8Mo7G5LGJCgH0jesKTcA2hm7VPOZ0R3/NV0/ddpVpByYK
         3EoQ1u4LCS7riPGKZDm+Uu161EBl5G2XMgzQd8pC7zEwl+QiDoKeUjRM1XJN2Y5l5wmU
         zsV8ZVjoBXhsZ273GHTFFfQA94KnXo1hICOMgDhE4/FyOibOf+Hq86sEg+We8GcpFkZ2
         BIRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMHpMO1Y1IEe7KPsDf2MlwvX9aBiWNLdNB7f6DrtGaVeBV8lU6fyP6RicDQD0coEokh4fMyfHS4w/avSmY@vger.kernel.org
X-Gm-Message-State: AOJu0YzQKK9A8Ww6PNeTIoT6D/SnZKKrkg3wtThxq4b7+7+y2CWlhRx3
	eC/OrnQkCGJ0cmJ782xm1xOM88hLg//PCRuIVzsWM4yunv+uoWn0E0TK8N7MNIVkZaLCYJRktax
	su2HSwM0FdNovAp53IE+xwrMkqsrkiu88Da/GRq3boQ==
X-Gm-Gg: AZuq6aKJEkaO7Mxf7AYFg5uZKEwZD8r3Rtrkx8YcTey+zT/gS4UBBLzSQZPPhrFN5nF
	ir9ANDTcfjEB04YNYCE1S+LaLhKyAWTOXW2hJ2Ncl4BmLfYlYwRuwrv+CcpcgRaUxqwdDmUdUb/
	NLcO1XzIG+KSBJ8DiAjGJUnyViUCqT/FhyitVSILQucx72+2nTFbPXyyXNlfJxGM+xoUxxWoaLo
	qe1Dy6igmJbGkn31exVrTkyxVRCpDlQHMvgmnCr2B4bRF4sL36enAoL1f622wN4D3sq/9c=
X-Received: by 2002:a05:622a:15d3:b0:4ee:26bd:13f3 with SMTP id
 d75a77b69052e-505d217ba87mr154308651cf.8.1770040275486; Mon, 02 Feb 2026
 05:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Feb 2026 14:51:04 +0100
X-Gm-Features: AZwV_Qh6A6zZZdceUx8tMzl9aTs5FcAK2seKVMKJu4IN_bo5o6gOCCgu_SrB-gI
Message-ID: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup, restructuring
 and more
To: f-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>, 
	Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de];
	TAGGED_FROM(0.00)[bounces-76047-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 08134CCF73
X-Rspamd-Action: no action

I propose a session where various topics of interest could be
discussed including but not limited to the below list

New features being proposed at various stages of readiness:

 - fuse4fs: exporting the iomap interface to userspace

 - famfs: export distributed memory

 - zero copy for fuse-io-uring

 - large folios

 - file handles on the userspace API

 - compound requests

 - BPF scripts

How do these fit into the existing codebase?

Cleaner separation of layers:

 - transport layer: /dev/fuse, io-uring, viriofs

 - filesystem layer: local fs, distributed fs

Introduce new version of cleaned up API?

 - remove async INIT

 - no fixed ROOT_ID

 - consolidate caching rules

 - who's responsible for updating which metadata?

 - remove legacy and problematic flags

 - get rid of splice on /dev/fuse for new API version?

Unresolved issues:

 - locked / writeback folios vs. reclaim / page migration

 - strictlimiting vs. large folios

