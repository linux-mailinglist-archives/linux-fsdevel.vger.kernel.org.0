Return-Path: <linux-fsdevel+bounces-20297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4017F8D1379
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 06:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715CA1C21C3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 04:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5100D1BC4B;
	Tue, 28 May 2024 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWyahfaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D677182B3;
	Tue, 28 May 2024 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716871010; cv=none; b=ZxhWq8pPw0xHdUfASNqjrbxKznvhpM7YUff5tXtsQc6PC002EzrVKUwneSjBKGbuDhrHQGirDbvF9Bnl83fAZuzJBRU7iGVJDmPUVHz9a4pgzB3mhG75lk0xj7WKLGlRU9IvrC70CrM34yacEH/frXx2qCOC8x+ItCGdaUZuQfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716871010; c=relaxed/simple;
	bh=4Mk4SMAAddY6j9o1WSpALg33xgkQ7ul+F5fqnnH3o1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHyAwyQfG9FibAdYt0rUKM2VysckcngaTyCsQhpUrWLEWWB7gXVjRWs46+38o6mqhEHiaSnruN5gyYul839HHMTJVykhgTP3/zWzlcnqG7l2+Py/3DtCCLn3J35bxzePrhWwKVQvAommtg7pKjF6jdLmdQKwfy6Y2/XI4oUikXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWyahfaH; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3737b70a74aso10030365ab.0;
        Mon, 27 May 2024 21:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716871008; x=1717475808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=funHFy4Yfj0AgN0Z8AiKsswEqhqQdmasAv6JVNU9tuo=;
        b=NWyahfaHOETktTT9adaJV3dWU4bUK8cGsxR1hX8xiIGjo3TzgJcfYYHtAFHK5jhWOI
         rb5320QQ3OXVDEQIfnf77PNR+gVFUF0vFslMWoCWh0D7NpmLdMdumyHSqOo6BZimA6to
         nIAOKNbtAZncaLbQIpuwFnvKNf4pPVtvhdNdSudVMTfsi9z0P2oePLvtSSJJxFqSPyXS
         /y6TiifOybihvuRsgJ0Ww6+jCzMPdxYqxnc7UE2sSTW5y+U43sFdAXHU5rAQ01MHlJvZ
         2mxp0ymB/1kotF5wRNm1ctkHGcn21LT9BbG1Y97OXIlwVn88coYOFS5Ng77i+06ueehm
         rjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716871008; x=1717475808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=funHFy4Yfj0AgN0Z8AiKsswEqhqQdmasAv6JVNU9tuo=;
        b=CFoAWsVEmoX28MTGHgxJJVjbd7Bee9bzGXe04i9gOGSBxfnXeJ4HCsuoSUhh64+XG9
         85jloNEazQBKOCZsbNDePE4wytLbgPytsfcF2Dic1miTaiFGymBtriiP6fh+jKqaWY2D
         69yZHLMUgh5fwy10tAnKbQSjw1A9Lb/cvJrZfgKiKOWPK6R8rP8tUvYvy8t6V+KuZXZk
         VyNyronMVnYVGLmpo3IyDvzb30eCYqqBQz+413CHzmz+Ven5ZvhdtIeGuq4OSOkGcHBU
         0W+I0FJnK40A7VMF0FzjeGl1L2g1WW3Wfd48IXjHRUJMATp5nb5krq398ZNh9JiohvZv
         O+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUo0w8bx7i9wmWi1Ohy7nzcgWFP/L0oav7OEAytBPQAYVIiQCdAIfxZWRFycyGnDJUWvYrLg9FLv4LMof/YDXjcvS1BpYAHmCjYI73tBGgU/x9k/7tgtUj1CPAuEK+VfUSefqC46+kVrUaiLqnQ
X-Gm-Message-State: AOJu0YxlGDdegVl/udJpwiOc2Lu0smQV2Dgklj7x9iCVHFnTxKEp9GZs
	ymGnqIUSCES4Aml/LHFwAby68k3n1OjvRnPKXupCVJHIwPmHWWCQ
X-Google-Smtp-Source: AGHT+IGN1Am1ld4JyS0Brf6ZSkkvrVRmXk7yomhAQRjE0jxq3I84tJ+CjAYMimRlrqwpSlGx4UMczQ==
X-Received: by 2002:a05:6e02:1d98:b0:374:5913:1f78 with SMTP id e9e14a558f8ab-37459132078mr36831475ab.0.1716871008474;
        Mon, 27 May 2024 21:36:48 -0700 (PDT)
Received: from fedora-laptop.hsd1.nm.comcast.net (c-73-127-246-43.hsd1.nm.comcast.net. [73.127.246.43])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3737d1468b7sm18013605ab.26.2024.05.27.21.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 21:36:48 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	sandeen@redhat.com,
	dhowells@redhat.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH 0/3] use new mount API for bcachefs
Date: Mon, 27 May 2024 22:36:08 -0600
Message-ID: <20240528043612.812644-1-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates bcachefs to use the new fs_context_operations functions for
mounting and remounting.

However, rather than using the parsing utilities defined in fs_parser.h,
I stick with using the existing options parsing code that bcachefs
already has. This simplifies the changes, since integrating the bcachefs
options with the generic parsing utilities in fs_context would otherwise
involve some tricky macro manipulations.

Following this series is a new test in Ktest [1] which exercises mount
and remount functionality to test the new code.

[1] https://evilpiepirate.org/git/ktest.git/

Thomas Bertschinger (3):
  bcachefs: add printbuf arg to bch2_parse_mount_opts()
  bcachefs: Add error code to defer option parsing
  bcachefs: use new mount API

 fs/bcachefs/chardev.c     |   4 +-
 fs/bcachefs/disk_groups.c |   2 +-
 fs/bcachefs/errcode.h     |   3 +-
 fs/bcachefs/fs.c          | 113 ++++++++++++++++++++++++++++-------
 fs/bcachefs/opts.c        | 120 ++++++++++++++++++++++++--------------
 fs/bcachefs/opts.h        |  12 +++-
 6 files changed, 185 insertions(+), 69 deletions(-)

-- 
2.45.0


