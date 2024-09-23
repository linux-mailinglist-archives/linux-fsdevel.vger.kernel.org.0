Return-Path: <linux-fsdevel+bounces-29829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EA797E784
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 10:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521D61C211FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E6319343D;
	Mon, 23 Sep 2024 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUuu5rjC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7017BA9;
	Mon, 23 Sep 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080117; cv=none; b=GfKVvPxP6RUU0VlBfSjORhSKE8WMtcYod6sRXagMntzBktvq/D5hj3tqjDAsnhBFvQWXKcNiN/Md/CLShY/DSRBA+ib+751j8f9NTE8y9T2o4P+ODQeJSVFyrUd9MiXdgLeCcDDH3pOer2AXQj8yUHPQSHDzOKrjIHhushmNPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080117; c=relaxed/simple;
	bh=yHtG3hlnpI3BrMNM+sawMfp8abAJ61ytI5jNxG6T+1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gHNjNZ/pTS7xHiDytowMVllRuGbDkPTR+zUbH6mHq2LLh37Pus/39Ug4Eo8SimCLa3bVPR7G3nf+0K5EMO4d+votJmAcHxKYrQhsc1sqxRT40S2Qb9YXzG7OX38V9/OosmD4CVniheizrDgs1A43O5PeukdmpSlKwCyGFfzgQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUuu5rjC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7aa086b077so533014666b.0;
        Mon, 23 Sep 2024 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727080114; x=1727684914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9C/zxi8apjLDMZQ5ZZwCJp+8pzL4l0A19wCqb0vQaQ=;
        b=KUuu5rjCBbkVFfMDUjmoAVQmtl+XJO8bAaBHMHb7ltNlTgLCvSDDfgbgsu546uVgTY
         nzfokuUhfXSEoiHLjc67MHIMe1kkJAFvgznWe+I3Ln1gR/IqERjSgwn06v1btwS0DPy0
         LYsQWByp64bdo2oyfNR8NS1DgpMCD7w1AyVJE7a91aBvdj0yktqFCdEKVIeJ6QTf7a8+
         GolpDBpWKQEr8t/VChD5GWXVefLQOSoqhhWzyN+JErwN43HEDsnhIDEJsUd7km5pDKFb
         TIDcb38xnFG9YCZhVD7dtF05g/i2QJyObQhE2zuVr5AdiWaQzK1/bIMdcqz5MLk6oNJp
         aKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727080114; x=1727684914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9C/zxi8apjLDMZQ5ZZwCJp+8pzL4l0A19wCqb0vQaQ=;
        b=eKYmixIWjN20WDr+6Yd4h0wqWYdfXr+X/xzO1TADe2EVWrx9yb6MzEI9DSIgVTaFuO
         OQqxtXVP4uz5qRoU5j2z1WsplMGV6pTHC2Jfm2vNwlAZm+V0APHOZe3EhVbko2uHeXM1
         zCu1epVM7/l72JRurIZ6ndriJtvMZtM4XYoJECeFm0e1hETnQpyPqRoo30YRZVPYZWYK
         I223G+rd6+Eqr9tx4wVkT44EPL+RpmgXXYbT9aCYEW9tgOHtvkGGCCpKHFakvTHcI8Kv
         lcJrdaIqnnm6YCdwWEmqGJKFkeJlQY3/r2Hxfdt2NyoYEyqAMhsnb3ffVCqz0cde2yFq
         Rg2A==
X-Forwarded-Encrypted: i=1; AJvYcCVf6WzbKw0BXut15LbCCk81nSYaEcoJs9WNXos57eBBIQG8CWpGGoYq+Q+/bimUWgMJs22cORB/M9Gj@vger.kernel.org, AJvYcCVnhF01gRl4ER40GsVsctSZp5bRDNQjfKyChbZbQBcNjB+uA83+Ps3cHOJ1Sqt447HkkDOYFo4LG0K34iNr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr74r0PHE57TLUokwepQXA6AK/knF/XTVR7BE/IYQNRLB+xQ/C
	Ut1m8MybY2L7jpzcOh1bCfUJGWie+UQgM8NBzwkdtjqIpWg7IzY+EqyAAQ==
X-Google-Smtp-Source: AGHT+IF1SMfcx0uP0ubXbVbGqr8tI7cZNkjk0wAUmlPqKaxQCdwKfivcqYVnRXbCNA8NmXScphDTqA==
X-Received: by 2002:a17:907:9343:b0:a86:963f:ea8d with SMTP id a640c23a62f3a-a90d516abaamr1169402466b.64.1727080113750;
        Mon, 23 Sep 2024 01:28:33 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90cbc7122esm512948866b.124.2024.09.23.01.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 01:28:33 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] API for exporting connectable file handles to userspace
Date: Mon, 23 Sep 2024 10:28:27 +0200
Message-Id: <20240923082829.1910210-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jeff,

These patches bring the NFS connectable file handles feature to
userspace servers.

They rely on Christian's and Aleksa's changes recently merged to v6.12.

I am aware of the usability implications with connectable file handles,
which are not consistent throughout the inode lifetime (i.e. when moved
to another parent), but the nfsd feature does exists and some users (me)
are interested in exporting this feature to userspace.

The API I chose for encoding conenctable file handles is pretty
conventional (AT_HANDLE_CONNECTABLE).

open_by_handle_at(2) does not have AT_ flags argument, but also, I find
it more useful API that encoding a connectable file handle can mandate
the resolving of a connected fd, without having to opt-in for a
connected fd independently.

Therefore, the whacky API from RFC was replaced with an explicit
connectable flag in the unused (*) upper bits of the handle_type.

(*) It may be valid for filesystems to return a handle type with upper
bits set, but AFAIK, no filesystem does that.

I chose to implemnent this by re-farmatting struct file_handle using bit
feilds.  While using bit fields in UAPI is a questionable practice,
file_handle is not actually in the UAPI and the legacy struct
file_handle which is described in the man page, is binary compatible
with the modified kernel definition with bit fields.
If this is a problem, I can add (and strip) the connectable bit using
plain arithmetics.

Thought and flames are welcome.

Thanks,
Amir.

Changes since v1 [1]:
- Assert on encode for disconnected path (Jeff)
- Don't allow AT_HANDLE_CONNECTABLE with AT_EMPTY_PATH
- Drop the O_PATH mount_fd API hack (Jeff)
- Encode an explicit "connectable" flag in handle type

[1] https://lore.kernel.org/linux-fsdevel/20240919140611.1771651-1-amir73il@gmail.com/

Amir Goldstein (2):
  fs: name_to_handle_at() support for "explicit connectable" file
    handles
  fs: open_by_handle_at() support for decoding "explicit connectable"
    file handles

 fs/fhandle.c               | 70 ++++++++++++++++++++++++++++++++++----
 include/linux/exportfs.h   |  2 ++
 include/linux/fs.h         |  3 +-
 include/uapi/linux/fcntl.h |  1 +
 4 files changed, 69 insertions(+), 7 deletions(-)

-- 
2.34.1


