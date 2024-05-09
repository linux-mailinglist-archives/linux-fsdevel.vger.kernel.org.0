Return-Path: <linux-fsdevel+bounces-19184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDE98C113D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261F51F22FF1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0933039852;
	Thu,  9 May 2024 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCbyygGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B362C683
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265176; cv=none; b=Zb5dq/sFiJesUX3GsBbdpCyRc8eRmllDVdFF3UoILZmf7a33A8KFJ1HJafoeYKIRn51lkda2osLwenT+JXicSUwzIJsu3TQK6ul7h77qccHznHqFmLopAKXCpvBON38jRpOBOMTwxUZ2cnnZyi8slTxtZV2p22Y19X33BIl0IKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265176; c=relaxed/simple;
	bh=BoF68je4rqEpRfNjiAZCKwN5Cf/aH6PGxhGKMQ8g4BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjkszDM1VMsz67IgFQHnjU4LJSZ0xzWoNQXWFbyN4VVpzHENFURXofPdMEv48QDoETzkT+vqmTpoC9tkmhZGuT1uxgyi7t9ACK9Xq3osbQ9VUEtngmLlObS81r1r2QjUF9pnQ0ulW4eEM+ogsjUtnh6aY+kOCt5YzaLlduPEqBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCbyygGN; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69b47833dc5so4391056d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 07:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715265174; x=1715869974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRV83KQN9SEoSNevVpd2ZUl2DsURMIEyWmpahwKs3C4=;
        b=PCbyygGNnn+99fZK5ak6WMSjh8ppfgXTCjW4df8ddeMI2kL5ebcEkNKerq18uiJY0f
         y0AmewbZNgqUIv2GjZAPytqJJgUCWIZ9ueFFsU3mWB4oEbxg4F66WdWF0WDmpHfXm9NG
         xk5X1NBb/TZBhuiKmAy/ypAcWG3pu84LcjA509MqOUI8b2ch/o9YMop4Ta4Ub2YAEAKi
         2r6qI/cxuDJgEzHxBXRFUi/ylsEwV3qxpNHnap09jnnV94LB005Gdu6VCK11olPVX5fQ
         +u+/HUEuwtqhc6bvWWDD8bhLExN6ip0fDeeTlxgrYL/PGlvElBCetxgz7ZkHRsHhyDGq
         8D1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715265174; x=1715869974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRV83KQN9SEoSNevVpd2ZUl2DsURMIEyWmpahwKs3C4=;
        b=m8liGmICGEdlDshKtmXZuDAXVrbu9MiEzY7MOtc6Fmh4AeaoljWeq/V0IpDly4yu3r
         i0M5PpTp1hKd9Av9baCtTHa75GRRKm7pu9Owc3BQXyHMB4kRAdyQ02MdFS6alLy3GhB0
         IXoWby+AcmmtiRnFKNhwPmAu6/ohVsbBLuOBR5tiVA53lBjAhjAwMFTfHHRfXVBi8yzj
         wCj0iMtMZ3OGYfJZE3BMBVbKjhlJ0/j++U3APumP4Az7GwwHKU+lMTdtWJuB+MDqXbwE
         Xfhl9CYcuDiwosWMcZ3nFTgB61w4EyoPsg6Nn5+9eiBu6EXlzCc9Fe315T6MbM94MQI0
         zMxg==
X-Forwarded-Encrypted: i=1; AJvYcCVqQKaGo8ymLIMNeLnwK3VUae/Eog7MrhRlQNstKS4H9FYzssOOy1J20U23A6IVQBFfLjkXKrwjqjsTUUW/Z/y2tCabVlp4J5TwhpeomQ==
X-Gm-Message-State: AOJu0YwPRSRBiN4fwgYcBiNvIL8+gn84mOxMt601M58oiQMF+Wa8o6l7
	KqwoXkCSe6sRxQsKsrJKPFcRWNA30SasMJZfuJlLDAmXkqKLwrY1yeQpxBlGRpRCcNVV82yhlI/
	BDX3D1S4mMR8QS/Jy+hu8zg1A0IA=
X-Google-Smtp-Source: AGHT+IGLLMGh3f0DAXpH4pGRc8bBAUPiCK3FoRn3DVoIDVVSzLd60aM8bNKJNWPyvHSOzvxIiYr7NIMXFOrUmeUdx+U=
X-Received: by 2002:a05:6214:5014:b0:6a0:c768:6a58 with SMTP id
 6a1803df08f44-6a1514dee90mr63414876d6.48.1715265173612; Thu, 09 May 2024
 07:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206142453.1906268-1-amir73il@gmail.com> <20240206142453.1906268-10-amir73il@gmail.com>
 <c52a81b4-2e88-4a89-b2e5-fecbb3e3d03e@dorminy.me> <a939b9b5-fb66-42ea-9855-6c7275f17452@fastmail.fm>
 <CAOQ4uxgVmG6QGVHEO1u-F3XC_1_sCkP=ekfEZtgeSpsrTkX21w@mail.gmail.com> <e9aac186-7935-485e-b067-e80ff19743dc@dorminy.me>
In-Reply-To: <e9aac186-7935-485e-b067-e80ff19743dc@dorminy.me>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 May 2024 17:32:40 +0300
Message-ID: <CAOQ4uxjcdYTKHQn6Pxt_jFRveUZ+CF6ih+0nTXXjtGEsAFxoWA@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] fuse: auto-invalidate inode attributes in
 passthrough mode
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 11:52=E2=80=AFPM Sweet Tea Dorminy
<sweettea-kernel@dorminy.me> wrote:
>
>
> > Sweet Tea,
> >
> > Can you please explain the workload where you find that this patch is n=
eeded?
>
> I was researching before sending out my own version of attr passthrough
> - it seemed like a step in the direction, but then the code in-tree
> wasn't the same.
>

FYI, I have pushed a WIP branch with some patches in the general direction
of getattr() passthrough:
https://github.com/amir73il/linux/commits/fuse-backing-inode-wip/

It is not at all functional and probably not working - I only verified that
it does not explode when I run xfstests, but passthrough_hp does not
yet have an API to enable getattr() passthrough.

I am posting this branch here so that we can compare notes and so
that you can learn it before we meet in LSFMM.

I wanted to give some ideas for API and implementation.
the main thing I added is the ability to declare the passthrough ops
in a mask with the backing file setup:

--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1076,9 +1076,21 @@ struct fuse_notify_retrieve_in {
 struct fuse_backing_map {
        int32_t         fd;
        uint32_t        flags;
-       uint64_t        padding;
+       uint64_t        ops_mask;
 };

+#define FUSE_PASSTHROUGH_OP(op)        (1ULL << ((op) - 1))
+
+/* These passthrough operations are implied by FOPEN_PASSTHROUGH */
+#define FUSE_PASSTHROUGH_RW_OPS \
+       (FUSE_PASSTHROUGH_OP(FUSE_READ) | FUSE_PASSTHROUGH_OP(FUSE_WRITE))
+
+#define FUSE_BACKING_MAP_OP(map, op) \
+       ((map)->ops_mask & FUSE_PASSTHROUGH_OP(op))
+
+#define FUSE_BACKING_MAP_VALID_OPS \
+       (FUSE_PASSTHROUGH_RW_OPS)
+

Which is later extended to support also

+ /* Inode passthrough operations for backing file attached on lookup */
+ #define FUSE_PASSTHROUGH_INODE_OPS \
+       (FUSE_PASSTHROUGH_OP(FUSE_GETATTR) | \
+        FUSE_PASSTHROUGH_OP(FUSE_GETXATTR) | \
+        FUSE_PASSTHROUGH_OP(FUSE_LISTXATTR) | \
+        FUSE_PASSTHROUGH_OP(FUSE_STATX))

The idea is that these would be setup during FUSE_LOOKUP response.
Let me know what you think.

Thanks,
Amir.

