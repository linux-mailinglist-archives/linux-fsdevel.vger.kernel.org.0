Return-Path: <linux-fsdevel+bounces-79714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIojLSc/rWmN0AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 10:19:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B95E22F24B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 10:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B589300830F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2026 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516FA322A1F;
	Sun,  8 Mar 2026 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS3BZNx8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92835BDBE
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Mar 2026 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772961571; cv=none; b=kp8FpTjMfv8m5VbT9asjvOcpWmmXL9f6LUn0UsqMh7sbo7mk1Pi1o8MhmNADPbDFfGTHedETYykUr5Jev59mpEhZxS8oc5fGK0gn9nVc0GOuEMR/5W3IeldrQLBTkZTgHnx5J9ySF8+Ryd9nTTjoHNeOqGKdHh1DzERKCC6dU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772961571; c=relaxed/simple;
	bh=qYzgh6uAd/1Nf5hmJK0kVF7yvFRbMy5kDQaFgFAuQVo=;
	h=Date:Message-Id:From:To:Cc:Subject:MIME-version:Content-type; b=F4kRDe6+o/g9yXgYxiOg0fhmLxdTXCljb3odWrGQOagbh8Y8wS158R++Ml+E2nx7g6xmyVqufWSXFxrLho7ZzkbFBrbrw6AQ/ogfOPa8dm2F5yaLULi3BgHf1IhhHqnaQuhP4/+deY+v6VZzRxYGK6+o2O/Xz1s8nWrNEmMT0Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LS3BZNx8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8298fad2063so1666643b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Mar 2026 01:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772961570; x=1773566370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYzgh6uAd/1Nf5hmJK0kVF7yvFRbMy5kDQaFgFAuQVo=;
        b=LS3BZNx8AzNx7qnmiBP27oh6GYvUgCEBATLBYY3qytWtx+fSHxuVFhmQ+FzkptCmxE
         COXIKbxt8fiSe3qoU/oUUNJkqOOt4Ii/FM7+Nhayr7td7pdEVBxiypYTMVgwdiCYehMD
         2X4YUdpeWs6L8lC1xLbiNr8LtJ7OUQYRDKrS74y+E+KQavSwLoSNagI5lstpy6KaIbJ1
         IGf7CYLXBlBu+l8d/nJZ/h9oUjJiBanIDEpDmrEERnKIpB3ajSxtFKXD98lZUxaQPibf
         a9c7//W78FWtjcsMfnXkxfwQhXNaQSxs6O99RzSuCs4ifvnIWB4caQygtURoY/tCyavL
         6Qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772961570; x=1773566370;
        h=content-transfer-encoding:mime-version:subject:cc:to:from
         :message-id:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYzgh6uAd/1Nf5hmJK0kVF7yvFRbMy5kDQaFgFAuQVo=;
        b=w1AGTsceRGO0dB7/FqbjBnVZ+rWdhSoP/SjloaVnKM6E917mAm7ZdbpppHMvkb1RzE
         6s18R1imQi1EAQaOgyz3B6+tsM+yWI/a2xDEcmpX5UyVE77NortX7bmFy4ViReJxrDsM
         jMxHgQFhmW20zHbGZceD27O5QvAszLY0yIz4/Z9ltRj4v3dLUBejdIyNeCvVE7Rk4CfP
         7wEsGTfHTdlrbkkrygG8OdGuR/F90ORc70Zx2geQM6gD+FcDXaSNfERGHLVMDefbbTMZ
         YOOq8Ap57BGmLOY1B+kMwqdg0Mg1irTD6q2q4Fkk0z/WT3JQJRll96HbZqndskb1hBU4
         XWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmxQC6VGYY5yt+xJf+b+DJStWmBa4bBCbUL/H8L4E4PLubszeY/rVlsnddKPXcFMkfMzHo2ya1lFj5rS2v@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JYSnfJl8tWf2CbbkkEW7wqAtnB9r/Jr59zQu7J2hsydLN+Ti
	JhG9d9Wz8+ZwXmiDJQLkd5oks8duxt8rrm4LUb9tmXEu2JNIOXw6Uazm
X-Gm-Gg: ATEYQzx/JxqYxNBu+ZIYEWOBIBH6hjevUcI7JyGeX/2IB/Q0ajppvia8WeN9koXoxwH
	7l8IwN/4JrxQUFDjAMotGPUv0t+97jJz9+pIO99p658PoQFg6/lHJbTpFO5zSzDfUSAlDtnY+jH
	HQCQKri6viTtJ1P3Das2pTDZc35WRZvWsmnpV5GQQzU40+R4sbotHn/JgJ9zKtSsaWrouqdtOU3
	poFvdJyyLlB2wBZYK21DD29rYtNi49ZCKQpIMkh1F+/V6qua5QBbUvMrg1eNMyrdH5sd8U1v7+1
	5nh/suuLgjAYQb9WwbYFoayvX/bqQXYMWULNrk0I+uexkRwnhQw/XU0TawgD9VaLi8+ZykObW9E
	GLAufjQLHhnLnJHdxwJU/fGpy2dFvfUFk/PjLa9E0ZJUda5POB21/FGQLNwaS3ASvO5mrzf7F3g
	1eR7eyTP/dMz1MbMNnpV+0Pg==
X-Received: by 2002:a05:6a00:983:b0:81e:7496:f826 with SMTP id d2e1a72fcca58-829a2f6d717mr7319185b3a.31.1772961570117;
        Sun, 08 Mar 2026 01:19:30 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a46765a6sm6709106b3a.29.2026.03.08.01.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 01:19:29 -0800 (PST)
Date: Sun, 08 Mar 2026 14:49:21 +0530
Message-Id: <v7f6u19i.ritesh.list@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Andres Freund <andres@anarazel.de>, Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <pankaj.raghav@linux.dev>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org, jack@suse.cz, ojaswin@linux.ibm.com, Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B95E22F24B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79714-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[anarazel.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.839];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lst.de:email]
X-Rspamd-Action: no action

Andres Freund <andres@anarazel.de> writes:

Hi,

> Hi,
>
> On 2026-02-17 10:23:36 +0100, Amir Goldstein wrote:
>> On Tue, Feb 17, 2026 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
>> >
>> > I think a better session would be how we can help postgres to move
>> > off buffered I/O instead of adding more special cases for them.
>
> FWIW, we are adding support for DIO (it's been added, but performance isn't
> competitive for most workloads in the released versions yet, work to address
> those issues is in progress).
>

Is postgres also planning to evaluate the performance gains by using DIO
atomic writes available in upstream linux kernel? What would be
interesting to see is the relative %delta with DIO atomic-writes v/s
DIO non atomic writes.

That being said, I understand the discussion in this wider thread is
also around supporting write-through in linux and then adding support of
atomic writes on top of that. We have an early prototype of that
design ready and Ojaswin will be soon posting that out.

-ritesh

