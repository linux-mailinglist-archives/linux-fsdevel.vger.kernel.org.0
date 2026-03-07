Return-Path: <linux-fsdevel+bounces-79687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOe8F8IGrGkxjAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 12:06:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D003722B5AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 12:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B8C53030D2E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218BA345CC3;
	Sat,  7 Mar 2026 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iObTKjqo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15134322C99
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881555; cv=none; b=VGAM4tuATcT1uR7xiLRBWcIrbPkRVBeAbgkPOdzY8xHAH/tXbPgzoqRgbi0KQ14WgjHGPuhaArA/C7KrzhaU80aOO8y9I3iDoxk2TiDIjIlN3lLRWiXLOh9zVPIYJgSjZt/bxk2pyzcEIFtXgWNTUsslbchhCrJcajAcf4aV0qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881555; c=relaxed/simple;
	bh=lT58K6Dk0Hbj1cl1czkKCtG4GlWipFK2o3wPuBoy2Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0Q2nWT9kxAZZKE//x1VYSg49yaWwFOR3OJBInpyfITyJtBtgWfHv/TZwA9NxGhKP+VC+UzLDQgv2PZvDDEJq4Z9ZReAlsL2xjip/ihMWYBlDugG18GqQm2lKAoWSNWqW2qiQSV8yv81Gz1NrjLz3VTBj+Eg6wmybN6v/N2XY80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iObTKjqo; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9419139eb7so312392166b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 03:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772881552; x=1773486352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kge5iI/KgjzzAQykVD+H7WhOC6av6WSvtnjzzqn3c2s=;
        b=iObTKjqok/B8W7S/Utq/06fdynedQxqDpN6yleIwd38QgCr4edifW0P8qSgV/T9FC4
         dI0KHI4Mn0k+AfXn7WdZV/ikmP7nPK3MaIHWLLLCOB5v+TdRxIBu46TkHNiXTk8XGUhB
         MVNn9Gr5myD0rpklZpKUemJnZuGSLq6xUG775RvSqJNVe1iVB+c2rIyvniOmDLh+izRL
         NVoUC9edlWZGuoQPF5J69gnJFfD9k3PM0psLqueaqZfCLRSEMpZNVuLJUTr7UJ/ReVF+
         jOS1zxgL6zCxt9FeDtyU4G9BAzmKrR2/IrYjeBO3pF5sk/l+IkQ6N14zyPWfqaTuQ3qc
         cKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772881552; x=1773486352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kge5iI/KgjzzAQykVD+H7WhOC6av6WSvtnjzzqn3c2s=;
        b=MXn5mdmguqHB1o2v7nMVuqBuCa0f+Oj3A8zF38bHJAMacMgS1PTyZ/fQCsjLSpBBFm
         hzDlQSFGTKerLQLd1WDmUlVEq7QD5ZINNWsGLg6AQAJCO7supKysscy7Vre7h2kzNBeD
         /5f227pqZUB6pzI74RieowWvgRwhrJBVD7N7OJeX9qj0z92n0ynCEiwk1m+DhXpsGlwm
         CKzsOR5EgQo1uWJRjqcSoDtraHl49vL7JfszW5UmaNpYz2P/g74EDXVQXKwJ88kSgWlI
         1FDDqD6Ejlb9i61m4RP8rA6vXzRF+y29B1dSGG/CNky0TODJWehsfOxXm79dU/qJEUYF
         lCog==
X-Forwarded-Encrypted: i=1; AJvYcCW4PWYhzaLsyZfZuRl7QHzTOQAdM3fmP0sdmmkABrEoxK/0UMMwb+JpzhifHZPGVP7fnCNL+r1AiJeQnga1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+i27g0aYS7qoZJOQt99KLho9u7MeIzy7vuVbHiJek6KqSbD+
	xXhq19yeGWJvFpowBQNeb77BYnCSoVSe1Hzya5NEUK7nQkD8DZcmkdQ1/7Aw1zY0
X-Gm-Gg: ATEYQzxaqSHNnUlG/h3hjsCmxn8ENn+ilagISbTh38xZpBv29XsB/704vEwyJs9Yc0a
	Jv7hVzKZemw0n0E5Slnpr5Z4q7KmRzIRynzlDK3DsSx+lffx7A3vF6hZinzQGds/v3PAvpSugmS
	5qjbyzfwJf0/OBjIth9dXwIZljlhEH/RTjFke1nq+gSABfmfr17moog+yEb8UbhDyYcy+lTMCqd
	UpzbPhlxzFGz7zBbvROkWMhnQs1wJv66bmP47bSQ8TFQLcoye2RQwJWJ9GxbMxh11w5AvYovbRh
	jBwnOPCkPyofp2Be6JK8lTJrQZ47Nra+NavxDIqAtzp5LBOKx0lvVJT0fsBkhKkbWmRt1Xa8MRk
	LwBhTaBwb4jY93af4S99Io7wL2VBdAHlDca6oBImD5zXFNhDQiq/UhheisL90bxNygAYQFtNgs4
	RMPM6Y0s3gIslVSoTm2rOagmCYJxQ8xD8DfqoHzfqMiJ5gJEWSpaFGg5Fvqt+X54SU/6GxJYMBe
	TFTIGIuv1F4UJl7Wpr3n4WCtucm
X-Received: by 2002:a17:906:ee88:b0:b8f:e46f:8079 with SMTP id a640c23a62f3a-b942dce9b5amr256365466b.22.1772881551891;
        Sat, 07 Mar 2026 03:05:51 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-7ad4-b88c-4d95-6756.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:7ad4:b88c:4d95:6756])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8b116sm128558966b.23.2026.03.07.03.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 03:05:51 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Tejun Heo <tj@kernel.org>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 0/5] fanotify namespace monitoring
Date: Sat,  7 Mar 2026 12:05:45 +0100
Message-ID: <20260307110550.373762-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D003722B5AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-79687-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Jan,

Similar to mount notifications and listmount(), this is the complementary
part of listns().

The discussion about FAN_DELETE_SELF events for kernfs [1] for cgroup
tree monitoring got me thinking that this sort of monitoring should not be
tied to vfs inodes.

Monitoring the cgroups tree has some semantic nuances, but I am told by
Christian, that similar requirement exists for monitoring namepsace tree,
where the semantics w.r.t userns are more clear.

I prepared this RFC to see if it meets the requirements of userspace
and think if that works, the solution could be extended to monitoring
cgroup trees.

IMO monitoring namespace trees and monitoring filesystem objects do not
need to be mixed in the same fanotify group, so I wanted to try using
the high 32bits for event flags rather than wasting more event flags
in low 32bit. I remember that I wanted to so that for mount monitoring
events, but did not insist, so too bad.

However, the code for using the high 32bit in uapi is quite ugly and
hackish ATM, so I kept it as a separate patch, that we can either throw
away or improve later.

Christian/Lennart,

I had considered if doing "recursive watches" to get all events from
descendant namepsaces is worth while and decided with myself that it was
not.

Please let me know if this UAPI meets your requirements.

Amir.

[1] https://lore.kernel.org/r/20260220055449.3073-1-tjmercier@google.com/

Amir Goldstein (5):
  fanotify: add support for watching the namespaces tree
  fanotify: use high bits for FAN_NS_CREATE/FAN_NS_DELETE
  selftests/filesystems: create fanotify test dir
  filesystems/statmount: update mount.h in tools include dir
  selftests/filesystems: add fanotify namespace notifications test

 fs/notify/fanotify/fanotify.c                 |  43 ++-
 fs/notify/fanotify/fanotify.h                 |  19 +
 fs/notify/fanotify/fanotify_user.c            | 102 +++++-
 fs/notify/fdinfo.c                            |  14 +-
 fs/notify/fsnotify.c                          |  28 +-
 fs/notify/fsnotify.h                          |   7 +
 fs/notify/mark.c                              |   7 +
 fs/nsfs.c                                     |  21 ++
 include/linux/fanotify.h                      |  17 +-
 include/linux/fsnotify_backend.h              |  22 ++
 include/linux/proc_fs.h                       |   2 +
 include/linux/user_namespace.h                |   6 +
 include/uapi/linux/fanotify.h                 |  79 +++--
 kernel/nscommon.c                             |  46 +++
 tools/include/uapi/linux/fanotify.h           |  79 +++--
 tools/include/uapi/linux/mount.h              |  13 +-
 tools/testing/selftests/Makefile              |   2 +-
 .../{mount-notify => fanotify}/.gitignore     |   0
 .../{mount-notify => fanotify}/Makefile       |   3 +-
 .../mount-notify_test.c                       |   0
 .../mount-notify_test_ns.c                    |   0
 .../filesystems/fanotify/ns-notify_test.c     | 330 ++++++++++++++++++
 22 files changed, 746 insertions(+), 94 deletions(-)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/.gitignore (100%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/Makefile (67%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/mount-notify_test.c (100%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/mount-notify_test_ns.c (100%)
 create mode 100644 tools/testing/selftests/filesystems/fanotify/ns-notify_test.c

-- 
2.53.0


