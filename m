Return-Path: <linux-fsdevel+bounces-79757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIKCN9mfrmm2GwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 11:24:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84946236FBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 11:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C575330465F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A016338F255;
	Mon,  9 Mar 2026 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M96LMfqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CD36BCE2
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051856; cv=pass; b=ZOLLpPyvklgTyo7pJjm2PJKkgJuwmUKMRgyzM0Yae1A+TEsvezurLKntNT86vAPEyjfeGXFt6w+J/U52T1+wFQt7C7CQjuS9AtzaYNj79Mvbd8rc7C2E38abvFRHJQY9V9dfPDsxBOAou3hHpS3tA472N7f+NsdGJiqr9J2uQIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051856; c=relaxed/simple;
	bh=qfjcpKlEgFWwCO8gJ1zijvCoQmKxg4JNjWavrbN5RKg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ooJgbgrHqFNXQ8xghinJWBXHlFl2L8D1JJMmiN2/HXQu079ChjoKWLLLoUzzqCH24/Ne8Ix8gkArLMMiIJ0yV7GOd+8erhzqf1Mbyr/w9HxDKb8sLBti1oRxC7+LNlW6k6LbSp39eGdEBAHVdtL1Wb4KfxLx2f+Y1arEkhC7OHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M96LMfqK; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56b255b1dd0so847497e0c.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 03:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773051854; cv=none;
        d=google.com; s=arc-20240605;
        b=lck/YJRsJxST94G6Dul7EA7ROuDGTmzmymC4kNI20YN57o7jEiJVCcSWk4PXhYR92g
         gx/49Yid63fwqzJgQ9H5sL1XCIcfjPXL40xRgv9wURHrJPa3SIJvMBLFVyMiq6AwM0EE
         SQDdT/nul655PvUgXFPz78KNmmQAvTSExqKEuolptXetAMfJw3Qakb0RquNnrkdnUpon
         OTMHZ4NJ4WepMbr0+maaX9TxZxPWgL120Mi9l2uZdIVhQ+Yz970eZJjkiHQYV9dqjPF1
         xE0fkDWZO9ifi5/V2M7Z2UD2Z8IVep+KSaJSmeaTrvRbhhPi+bme6dfHi7JP4a61/3Nc
         qJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=qfjcpKlEgFWwCO8gJ1zijvCoQmKxg4JNjWavrbN5RKg=;
        fh=IGEK5D2j3WbID0n3rHigJp9U9YAFx6YvBP/qDFnku/M=;
        b=guL0yiv/l8k+/Z301AWXsQxZzWEOT1gyOwecJV45RlBqRjhmSo9g/7cLCknzPEIF9Q
         YST4BDIqSUjyVGLbq4h7z8Rczcc2BfK8bAEnNPPu0xO8M5wb2H2Y1KiitvZ0DbueJqz4
         UHDIma0/GnBaSTx05O/EgF5ozI1n5oUsbUUeo7F04CAS70XeSuxOEsXDa5atnto9tMVw
         R3JBJnvQmphNxShgOlOgMqO6gkXK2lp4WZylNs0sj7vXfkt16i2gX6uCS1arpOMXlkUT
         LS24hCRzd/+4CqS1+myxfGD3Gtcu3jNuqyXq1mTo5bzl595LIApShZMwKnbiKhD/yPuq
         ifig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773051854; x=1773656654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qfjcpKlEgFWwCO8gJ1zijvCoQmKxg4JNjWavrbN5RKg=;
        b=M96LMfqKaJvEVJwEIlT3gVqm6jdVQTb80uRK6eoj5smIxK2f6vuI80tebqRdgbT5QR
         qi3+d1OvKq7QoJq1Atf7F2rwe4Wz230Dt9v9liy2XF+pjmVVjEHuYSPACelsE4BGVSOm
         Ef1BtPy9fgGpnusP5JzQYN1+5V7itjtuPuMNC72PGbNcJWYjGRoxQIFH4SfySr1JR9h2
         e/zuzTLUbXqYFfByZ91cO10htAYaQg+NlrOFh6h0hWc5YlNWmh2tSc0b3+HhIW4e2e/U
         ZBcCnD9TyPpRF2pF9tr8y0XPU4X3U9TOrpaw6516nswxKikZ8kmdOSdE50mofZAmhn8G
         Bfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773051854; x=1773656654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfjcpKlEgFWwCO8gJ1zijvCoQmKxg4JNjWavrbN5RKg=;
        b=SIcrQJr8xKrg6UWBjLJUpd84nH23q+s/1YP025NoLftZfX+GdJwm6r2ZO0kqMFpJky
         LdT+T5p7FB/w5HjIaSinlGoFcAlgumV1L3+w1qP+Tj9rUmuGV2Do5PYAqh2mny/SmFQO
         S/H8EW0vqUNCANMR2Zxv5Z7qIIlaRQt0fyKZgBpILF+mqJvBjiSPXUF3bS6/58kCoRy5
         y8tN4M1vLIxTtkRbuOY6p8TCAxyefkEfBC9LXEGsuobgPIvd+RIDkDCtWX7ujTJcwg1v
         BqP8XdSxVO7p1qb+vEWpDZsGAMtFkxXF1sHSTJunNUUrTv56ecbgOfk3ZMWH6O9ebGJn
         aPqw==
X-Forwarded-Encrypted: i=1; AJvYcCXfvED56WJGF4nH2OSJA3zcQZhNZYpfjP5E2G8guYx+NGTARfas60NWiNt8esrhPc2emF6mosixwX276Swe@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPLwZFdp2xqpx3BTr2h6qHnwW2+wv0J1fXXqi5pdRs4IEak9p
	oN3q+XlnobxwrvtYws6LUPu866qqbEc7qfOG7Jkpba6b4S34RE255MhVNjdC+83oAzcRDFzLast
	+TbT9i84++Ow0CaCnGn1ZYYZtsU6o3ZznBc13kVk=
X-Gm-Gg: ATEYQzxCxsrnRSCo2FHwxnYMkL8jjMILCXgwa5T3zL67lH0EFpT4oHkkV8fQQ2pXYvn
	gvElXiM11PvgyO5PNBXUTugtx4sDwG5uO0Gu5o+llAr6r0mDqp6fIDPX2tWyi+tyWl9/bJBEzEc
	x8lUUuupvXdq/FMp2pNnDayMot9NsypQEkzliHtdAbrOUW76p/yznhy6KyyePW8d6F6+yarNvsT
	U/eHwPdkM/HJoV2y4XqpDHltq8Xh03F+aUUGnDUONRik075SrRvDCCRU8VfXE28GsyjobQhbObF
	gNLEICA/5exYKif8fyl+NePNmaOgJTJKUa5CnWWktXcrlTKQuA==
X-Received: by 2002:a05:6102:6cd:b0:5f5:2539:9b11 with SMTP id
 ada2fe7eead31-5ffe5f75506mr4624398137.14.1773051853948; Mon, 09 Mar 2026
 03:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xianying Wang <wangxianying546@gmail.com>
Date: Mon, 9 Mar 2026 18:24:01 +0800
X-Gm-Features: AaiRm53pzT5XMRFBWgfUI9kvmtqbtHPHoXIqvUIc-7RG_c2omjGbqGhVbNcPkgU
Message-ID: <CAOU40uDriX5NCfac2iK70z-M3Ea9pTMvTHtPGz97HKXbYhrjdQ@mail.gmail.com>
Subject: [BUG] WARNING: lib/ratelimit.c:LINE at ___ratelimit, CPU: kworker/u16:NUM/NUM
To: tytso@mit.edu
Cc: jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 84946236FBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79757-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangxianying546@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.865];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pastebin.com:url]
X-Rspamd-Action: no action

Hello,

I encountered the following warning while testing Linux kernel
v7.0-rc2 with syzkaller.

The kernel reports a warning in lib/ratelimit.c triggered from the
quota release workqueue:

WARNING: lib/ratelimit.c at ___ratelimit

Workqueue: quota_events_unbound quota_release_workfn

Before the warning occurs, the filesystem reports several EXT4 errors
indicating that the filesystem metadata is already corrupted. In
particular, ext4 detects that allocated blocks overlap with filesystem
metadata and subsequently forces the filesystem to unmount. After
that, during the quota cleanup phase, the kernel reports a cycle in
the quota tree and attempts to release dquot structures through the
quota release workqueue.

The call chain indicates that the warning is triggered during the
quota cleanup path:

quota_release_workfn =E2=86=92 ext4_release_dquot =E2=86=92 dquot_release =
=E2=86=92
qtree_release_dquot =E2=86=92 qtree_delete_dquot =E2=86=92 remove_tree =E2=
=86=92 __quota_error
=E2=86=92 ___ratelimit

During this error reporting process, ___ratelimit() receives invalid
parameters (e.g., a negative interval), which triggers the warning
about an uninitialized or corrupted ratelimit_state structure.

From the observed behavior, the warning appears to be a secondary
symptom triggered while handling a corrupted filesystem and quota
tree. The initial corruption is detected by ext4 during block
allocation checks, and the subsequent quota cleanup path exposes the
ratelimit warning while reporting quota errors.

This can be reproduced on:

HEAD commit:

11439c4635edd669ae435eec308f4ab8a0804808

report: https://pastebin.com/raw/yJp9p1dM

console output : https://pastebin.com/raw/tyPquTTH

kernel config : https://pastebin.com/7hk2cU0G

C reproducer :https://pastebin.com/raw/Sh3a62JM

Let me know if you need more details or testing.

Best regards,

Xianying

