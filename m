Return-Path: <linux-fsdevel+bounces-10559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939F984C484
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 06:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ACE288BA0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 05:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01FF15E97;
	Wed,  7 Feb 2024 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7T4y5ak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB231C288;
	Wed,  7 Feb 2024 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707285454; cv=none; b=TtcEm4dpYwc1qFVBK+GleRBLu8bqBEypItfpiOCMYtBCZEsrViuCeJqzgPL3vDECGSsvViga6Y2v74GpY1pqNVqsgjisz1yictgxwKKO6cJ9nZT8/tHia5bfjoIN+k4qyhacCMxtrbrrGibmkYrn3SWivkRREaCI0SLtq4XuCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707285454; c=relaxed/simple;
	bh=RF0hFvyRbGiuN20eplUeAeat24++1d++IJSeEY3tP5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxRGvhBJcmVmAZc77Xrr4iFGHDBke4RsjRbGbBIg+wH3C09UK/c7FvgZV2h5ei2QbhLeWJATmo8+Ayj2eQJGLUBvsfKgzNKAOR45uuPjEB9WsOVvv5KGbTScCOxOEfitxmAubGuUQ6zLTjumE1BzK+1bazqLKUGL+CjgjxT/vuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7T4y5ak; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bf7e37dc60so18363739f.3;
        Tue, 06 Feb 2024 21:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707285451; x=1707890251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1J7sn9aWfaLCjcTrgwLaxeZasaTU7yPXsxo830YRUgU=;
        b=c7T4y5akEQJK0/j72tr1GJlWzKgFsHY1+OFiUShtpELoCKRdZ4omXiv9+iGXI4JKLI
         CGTCxaTsd3hWhMcpTn9zfCJYYKwSwndKAZ8+v8u7pHyTKlTtog0rBHzBounAMVKrsahu
         Xc9SQfaHjYz+e7FN/PJdFsVJOKrpz+CVfS2tDGr+Q0CoISzrP+tJhmyHjXWT4i7zAz19
         StRvksyZDlMLLfOpiSw41nGNtUceVHekA9wmXJGsbK+y5NhZ365/KF51OhaRDt7UlIQ3
         sv4VUboHX+bXBJOL5WlelvHPPcO2g3ATzrrP7CLQNdqFhIM5umUtr2EbUfhAnDqbhXO4
         0lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707285451; x=1707890251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1J7sn9aWfaLCjcTrgwLaxeZasaTU7yPXsxo830YRUgU=;
        b=dhWl+v5ACMHPLlT6cozsTuLf5Zy94Xzl6jUv0N82r7IlfGXRCZz/WeDKBBWXZRZNGQ
         YQ7DUksO4JsRNNFYrHZH71UvRUsUSb3lEO0qkDO5HX4+lXx1cewjIy3UYfQJZaQMhBG0
         UCafWDH6LH+dDKTRcxJKhg2pzSL1ya0az+PvVHb60/2s9Qt4zqZX6EsZqvI47XDWFHj4
         C5mrQnACHMmQvRXrLGvnWagR74GByON/1yfYgAVxk4eFlbCOABC1DzTrYnGNHrbRY5Z4
         sTKH1EWz3LE/Q87FfovTLXbiiLJmEeWprw5fMOkDXmEvt0WGBpxPi/jMQjbIXdt7gYfr
         dhnQ==
X-Gm-Message-State: AOJu0YzMRSmRgJGLXdolhDFbxwUxShWM/2O8SACyEwNPoyvvRTp/dIrZ
	V3edLbySTQwpqZr3Jt+cz0rwYN5/M1GgSvuRMlBQhBrJfViep8pRj9BTuWArhbI=
X-Google-Smtp-Source: AGHT+IEkPxrR5zmepagoF+Wci9FImWrKsZVe+/8uEQzlCoNprRmMYvHkhnvQa/ZXUTh8C5276cdt5g==
X-Received: by 2002:a05:6e02:923:b0:363:c5df:d36f with SMTP id o3-20020a056e02092300b00363c5dfd36fmr4880344ilt.16.1707285451013;
        Tue, 06 Feb 2024 21:57:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1k+xvWYahvnC+oXtGMTcPEwhKE/90yxUnWJYhVl4TWv4OXDzA1p8NurJ1u8TSjg60T5/uFyQnz3bKjSk0WVR4F0225ccVZ7OL+DH5jQG+MxDTjRCwJrC4wSXo+yfPK/QoG96MGjxVSwMw9aIKp53y48LWfVgf4wiZIyY0aWrbU+1kMhKPw7oJDh7/uttmuoIJ/3qxG4IS5lHgRZ+9u6daHPXIgeGBNZlw57wKRLwbPVPgwXkXgXeuxSu6K2RH4iElpQHsdlgSfwlm4Ei4uRgwcYof4ApVyJqFlJAffHQitnoPGacVGjnuIcch5s0K3GmAMkLJ5ss4sZBx66U9+et4IV3Y52Xo63DOVOpD7Q==
Received: from fedora-laptop.hsd1.nm.comcast.net (c-73-127-246-43.hsd1.nm.comcast.net. [73.127.246.43])
        by smtp.gmail.com with ESMTPSA id x7-20020a056e021ca700b00363d69f2598sm146020ill.45.2024.02.06.21.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 21:57:30 -0800 (PST)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	kent.overstreet@linux.dev,
	bfoster@redhat.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	masahiroy@kernel.org
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH RFC 0/3] bcachefs: add framework for internal Rust code
Date: Tue,  6 Feb 2024 22:55:58 -0700
Message-ID: <20240207055558.611606-1-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for Rust code into bcachefs. This only enables
using Rust internally within bcachefs; there are no public Rust APIs
added. Rust support is hidden behind a new config option,
CONFIG_BCACHEFS_RUST. It is optional and bcachefs can still be built
with full functionality without rust.

I wasn't sure if this needed to be an RFC based on the current status
of accepting Rust code outside of the rust/ tree, so I designated it as
such to be safe. However, Kent plans to merge rust+bcachefs code in the
6.9 merge window, so I hope at least the first 2 patches in this series,
the ones that actually enable Rust for bcachefs, can be accepted.

#1 is a prerequisite in KBuild. In order to call bindgen commands in the
fs/bcachefs tree, the bindgen commands need to be defined in the
top-level scripts/Makefile.build along with the rustc commands, instead
of in rust/Makefile. This is the only patch outside of fs/bcachefs/ in
this series.

#2 creates the framework to use rust-bindgen in fs/bcachefs and
introduces the new config option to enable this. This patch does not
actually generate any Rust bindings; it just lays the foundation for
future patches to create bindings.

#3 demonstrates the new Rust functionality by implementing the module
entry and exit functions for bcachefs in Rust. The current C entry
and exit are retained so that bcachefs can still be built without Rust.
Given Kent's goal to use Rust more in bcachefs, the C functions will
presumably be dropped in the future.


Thomas Bertschinger (3):
  kbuild: rust: move bindgen commands to top-level
  bcachefs: create framework for Rust bindings
  bcachefs: introduce Rust module implementation

 fs/bcachefs/.gitignore                 |  3 ++
 fs/bcachefs/Kconfig                    |  6 +++
 fs/bcachefs/Makefile                   | 12 +++++
 fs/bcachefs/bcachefs.h                 |  5 ++
 fs/bcachefs/bcachefs_module.rs         | 66 ++++++++++++++++++++++++
 fs/bcachefs/bindgen_parameters         | 16 ++++++
 fs/bcachefs/bindings/bindings_helper.h |  7 +++
 fs/bcachefs/bindings/mod.rs            |  5 ++
 fs/bcachefs/super.c                    | 31 +++++++++--
 rust/Makefile                          | 67 ------------------------
 scripts/Makefile.build                 | 71 ++++++++++++++++++++++++++
 11 files changed, 219 insertions(+), 70 deletions(-)
 create mode 100644 fs/bcachefs/.gitignore
 create mode 100644 fs/bcachefs/bcachefs_module.rs
 create mode 100644 fs/bcachefs/bindgen_parameters
 create mode 100644 fs/bcachefs/bindings/bindings_helper.h
 create mode 100644 fs/bcachefs/bindings/mod.rs

-- 
2.43.0


