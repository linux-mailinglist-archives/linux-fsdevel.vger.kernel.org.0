Return-Path: <linux-fsdevel+bounces-75380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E/fEIZUldmn0MQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 15:15:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F1480F06
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EABA30062E8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 14:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC14B31A7E2;
	Sun, 25 Jan 2026 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4R/GN6W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DB191F91
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769350545; cv=none; b=GeibRgAGgxYn1Yb+teIcbej376Tb3pKBTjzrfvlUUi4B4MXd98YPoIwYNdL+aOiP6dRg4V9hd9a7UXHyD58Tt4Sump7WjiD6WepxZfPmwyAunHqyhHXc4yhTdHHXbOWFFFTwVi57GyzpcfhtXCGjXAMssuz8ZN7b0UHEQtMMAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769350545; c=relaxed/simple;
	bh=temAubeJFIXfJ/LuMERZi9joihS138uf4Gmqe8B2JD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nn5UbiEFO3pISF/n8dlLZiR1lYzTlBiiIZ1x09SCJC3imu9cXKqWLcnBnXxxDrDcbRUStr6ei/fqOoCFWMWADJEf+StXpLkkVNNYDack7SmPj9PYkwlDxwJ285KPfIOvWSfIm7+aNgyusIrqvD6ct5ZS4xCL9spMUG3U3PH8KUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4R/GN6W; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8230f2140beso1197933b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 06:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769350543; x=1769955343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/ycpMC0/t8L6EJi73kgeVshwHtTnwOPRpL1nHy2x8U=;
        b=d4R/GN6WhdrSiJJXd7GUaEDnizCmL4GGwTWiE5vs57ta7ghq+BOkp5Sqs3k/EML7HS
         J2VaD/ybv+AW2JntVeSemOSrjNVw7StFFpaptbsAAm/iZwlzzKpKcQ+sBvnm4GdLrwVg
         wffzjyMfyTv435GZyVugqV8xxWreUhAa5p6RHwPX7+Npsd/yZb1R0MAD/thcK7xm5van
         AIGrkxgnMIiEJo1O109L0Y9tabfXSY6mIxKoQt4mWT0nhtE9F3hh/qdJOR0AV6xbvtP/
         d1QETZEUq3J3+mjOh3Y3rztt/1IsTndCkFqvAuOBRTBlsO83LVmNPwoS/OckUnGf1F2F
         HG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769350543; x=1769955343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/ycpMC0/t8L6EJi73kgeVshwHtTnwOPRpL1nHy2x8U=;
        b=nCESHlRDK9dyEWKAKQ8L4NQVBXryMI1DWlpMmsLSn6Jt8Xb2mlaRqL/+R7u+HQaDZz
         Uh17D7kMtcYCwbhk3geP4uCawJGVo9z6mlCL1BLqrVnV4nVM96MiwGm5Mqy7vHO405oZ
         ct0FPtGl44OR+esjZu2TGQzmiJGJFrGUfFaTsiEs+ZliFpUup9KFsfzffMmR90wffcQp
         DV8t0BL0YBrVggkcK4rCxnbFfjQYW51hgrbxj+DY7biq72457BPP6LNX6VHaIloP8EG5
         irS7dVudYk6CJWArYz2aZfdKzmsCu7xclTQbVqI0o7bpN7Z84X0/07SgaLqtMgJsRd9t
         M0Ig==
X-Gm-Message-State: AOJu0YwMIstyaK4Q2jpSAney/jHKxbhyDQwtT578D7CsQ9QQ2uqzhpw/
	Zq8uMj9t4/PVAtY3maLsF0PiftDmIVQm929h5HDTzbCqi6TjrBcN7ozZwvLspA==
X-Gm-Gg: AZuq6aJ4583Jl3C/iNR52dnAeZC77ztvGikfg/Qi2vNYrHCFor7AFhsdSVjX8qg5Yd9
	ZWwPtOy534f+/b50hbSmvD18ECnwknyt5ihWZ+27VXU5LZIJZH3W3PM8lGUhHtN+FVjk3HdheBN
	HfA5+F2MOKG1WhBc14baW1fyjvhrlrr5RU+ca7LO5LXX03b+QWnzE2oYaJUteK2VozMX9+iWIkO
	kUza/QD/wbnPKMrgZPOvkp5THzTVelrpkwmuiy4x26/ZWfIXkK+pTIl252C307LePU5TdX28D29
	Qc6xs6fbg9ut9Y2sE1DBsWeVr+aeCGU4qgpXcIvVbk9cGEyqXTJqjkvIur9RVoy2fCMc5kD7gZX
	O3eRnyD2SOIK7DOIn/6a8s3j6YZ8+v2FkcY0ENV0X5BaTJ73E0sRh1qzPEBFc1rRfjPhQn3oHRK
	5H+L4vdKhX2fW/5cIhuDE3z68kS5BUap4t9UCGVnaNTvg=
X-Received: by 2002:a05:6a21:62c9:b0:371:8e6d:27e8 with SMTP id adf61e73a8af0-38e9e5eb6femr1745093637.28.1769350543447;
        Sun, 25 Jan 2026 06:15:43 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a4135e6sm6334225a12.25.2026.01.25.06.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 06:15:43 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de
Subject: [PATCH 0/2] O_REGULAR flag support for open
Date: Sun, 25 Jan 2026 20:14:04 +0600
Message-ID: <20260125141518.59493-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75380-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2F1480F06
X-Rspamd-Action: no action

Hi,

I came upon this "Ability to only open regular files" uapi feature suggestion
from https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files
and thought it would be something I could do as a first patch and get to
know the kernel code a bit better.

I am not quite sure if the semantics that I baked into the code for this
O_REGULAR flag's behavior when combined with other flags like O_CREAT look
good and if there are other places that need the checks. I can fixup my
patch according to suggestions for improvement. I did some happy path testing
and the O_REGULAR flag seems to work as intended.

Thanks.

Regards,
Dorjoy

Dorjoy Chowdhury (2):
  open: new O_REGULAR flag support
  kselftest/openat2: test for O_REGULAR flag

 fs/fcntl.c                                    |  2 +-
 fs/namei.c                                    |  6 +++
 fs/open.c                                     |  4 +-
 include/linux/fcntl.h                         |  2 +-
 include/uapi/asm-generic/errno-base.h         |  1 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 7 files changed, 52 insertions(+), 4 deletions(-)

-- 
2.52.0


