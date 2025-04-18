Return-Path: <linux-fsdevel+bounces-46695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B5EA93E59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 21:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27AE5464D06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67532253A5;
	Fri, 18 Apr 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuu8RLQ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FCF217654
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745005150; cv=none; b=iA4TnQjMyE+qpDlFQO7auLtFz7o8gH2Vg9olqzuoGlJcZbbCgaYlRf5hiPGYLCET4kCF4SrSZbL6jgC5XUkKCqvPtWo6uh+6TfEH943SdHMhqZKV6mgx1QsVwnyCfVNoZ4D+sJ9CSim36gGHTEqbeHdvIsyVdxT76DcXqwFj4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745005150; c=relaxed/simple;
	bh=m9gkTEX73eajvVfhk4l+84if7YpQ9fNwVMDWF55/hRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iSAVJrJ53qn4dHz7Cxn+8dF4LX4lpAwTW90Q8qin2fURJrj+hhPGdQ7UfgehjfoHAYCEpoE/MR+1YWPkppbIsAksU/3yexDmDxEAhfVGbSgXV2BmHXNSwG9bnlozsykLTSDP0FUKPKQEWagaOVvhoCsnuyLKYEhcr1MxxxVtjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuu8RLQ9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so3335551a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745005147; x=1745609947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2l2ivkmtYn9IhCSK9b7ZnP2SdozAAjOdyIaCuR8zEI=;
        b=kuu8RLQ9Gu7QGDCdiX2qasgiqOg/wiR13CZ6TlVP9IuBZ6GMYU8t6bu5xLmEh+AGa/
         6NmKTR0zxZGAnDKxasnLHuZIzHelwJTfX2WF9YxolWI1KidHRFVi1h6DHgyBfiiyskx3
         B4fcYR5ka1f4xeg2uinwrkyh3clY5EscMVFs93igR9tZgM5/kC12c7WTTNLg4mHkM4iK
         MY7KuQRDuX+EuH6e8rjfLYEB7ZhHs/fTtauCrM4UieHl6NcX4Jto6BRiKmeli3N2+Sf1
         tYaGlD3nXiLCPhUKQLXyh+KKHdnm/TUsl3Rf/+Eleqv6piSaGqHb60vG/iwO4UJvXqMk
         5Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745005147; x=1745609947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2l2ivkmtYn9IhCSK9b7ZnP2SdozAAjOdyIaCuR8zEI=;
        b=F0OZ1dGakJX+IMfenB/BrWGS/nQ/33TkmxW7vD5x47hn1rWs6txQMYm5w5yF3LEJX+
         gdncBq5Ux4MIbp/58xOl9oY9OG2+iYtFM9EY86M88QgEmeg8vF1vZ+yAwCNLp2MjdsdP
         RJbbB67mSpP6M6XtHKZjtSKIW/t8MBQwTdJ5XEDyzpmxG6KrSVcWiT1E8CYczuE8WUVE
         AUqSx/PM1b36I5M6kKno/14sEvB6o1Ji/kdp/PdQEf7NzqA/LhdkQQOjtBvU0nsGN+Vf
         EryzJ1pldtqV1rytZWgz6pZ43i1ciyycUPUwGpxIo7Hyc9CN9x8RMRXvyu6VwAVWOKSc
         4mxw==
X-Forwarded-Encrypted: i=1; AJvYcCXgy6I+p7vzHMqTPoEvw7G70kxy6gGXFldTWAfNNXnyqsxXNarKkaufT45h7OVunFvWo4TOFJ8DJwn5A7sL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19blBwzIobH2b7VyhiaekilFV6CJMswhrWHg0sRj1tma+bIQE
	ID4eBqey5LxKOUM8cBRzYbXebYevnxCiDaClWdiwIFLYL+NacJv7
X-Gm-Gg: ASbGnctkpKL3KWkHpYsKKoTt4k/NUWIS5RdbsKXrd9x61v52lGzgHP/WnkQmO2zQ9/a
	NpPpjyaQrIn5QMrRW7lL1qlj6G1opgYLpIkhO9Lyb7jgDkSo1TCXAZGj6kBzeBgiEWMIYWO1tkg
	Kd1bvIt6uTFAcavb6hi053E6ia8vI276qayBY/2DhCMhmLacUZXoqYHat0NiV3LIePHa2zc78lz
	227JCgojrwnoWMJqgZXZ98XNTmio37M1lHirjf2QgwyGd/91jKB0pOL4Mac5mKUc0XiZZybVKUU
	ec+L3ljEoXDge0kTdbY0Ia1zJPnWj5QrewSgani1eSouz50JQ90Q++x8L3UO93FfVEUsLn+++2J
	gjRERLavXLIX+GTvb2jzh/MqfP9HGlFGABz0kNw==
X-Google-Smtp-Source: AGHT+IFaZTDBrZ6zTZvZKMbSLt6th7Fcq6kamiE5NKRvflXKQ3JOkZ+cr94dfEyZ/NO5R7GBOybYXA==
X-Received: by 2002:a17:907:9450:b0:ac7:81b2:c6e5 with SMTP id a640c23a62f3a-acb74dd85c0mr338226966b.55.1745005146204;
        Fri, 18 Apr 2025 12:39:06 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef4798fsm156084266b.151.2025.04.18.12.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 12:39:05 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] fanotify fixes for v6.15-rc3
Date: Fri, 18 Apr 2025 21:39:01 +0200
Message-Id: <20250418193903.2607617-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

I was working on adding support for FAN_MARK_MNTNS inside user ns
and ran into this bug.

Unfortunately, this is Easter weekend and on Sunday I am going for
two weeks vacation, so I won't be able to handle review comments on
these patches until at least rc5.

If you are ok with the bug fix, you may fast track it and if the test
needs fixing, I can do that when I get back, or feel free to fix it as
you see fit.

Thanks,
Amir.

Amir Goldstein (2):
  fanotify: fix flush of mntns marks
  selftests/fs/mount-notify: test also remove/flush of mntns marks

 fs/notify/fanotify/fanotify_user.c            |  7 +--
 include/linux/fsnotify_backend.h              | 15 -----
 .../mount-notify/mount-notify_test.c          | 57 +++++++++++++++----
 3 files changed, 47 insertions(+), 32 deletions(-)

-- 
2.34.1


