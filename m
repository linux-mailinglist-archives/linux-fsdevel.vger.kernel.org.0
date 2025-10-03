Return-Path: <linux-fsdevel+bounces-63349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DF6BB6617
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 11:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17EA04E7ACB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA12D8370;
	Fri,  3 Oct 2025 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LszTdb+c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8C1B4248
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484120; cv=none; b=P/LAApIYYtly435Hc4GR6RbxpdTUOz855jsbyHAkJL6MIxXGYtWhcmesBMKgt1gHTe4M+5IqZt3js0fTUzFhX+D4dmZxUFV6IBk2aei0ok6oEluZMnSANl2kQeVXIr7ljDnfu2OI8VIGp2z2YsSXKn3MwcbRKjr9K57mUsTNqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484120; c=relaxed/simple;
	bh=vvUJddjEBDF+Ztgm1hAHoT+ASJXHJAAKJ82WwfFRfu4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EZKwSwhDk/oi/s7FRNpjjw9Thw6chSLrYMx+LoSh7QP09ioQnc0yGLdQ0eMnUa/fTNa+3ox3EC1jbJW31PJWDQA8XyACDlvvRyhZtwI/V0GvvgKmtCX2AFqy80vzU9HwIZEGwTcpE1TP7b0sVSK9aIkdLPeEsng2ZC73ZlfA+2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LszTdb+c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759484117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cTvI1DpoQ3LONUfIqcabKF8qqakEhbOmxQY1Lj6nxQQ=;
	b=LszTdb+c0rcTsgXuoO6AVLAXZ9BL8mrzux8sDkDGULtDIrdtu4IvcHj5dsRdNO1IPjks3G
	qJduB7ScUVoOOaQoWup7UQHm3VwkJKsGHafGAX/B/k1lvYz7ti95OTAbnGZUdgeBel1mPK
	DFVQteDkZhWcPfjWtlqwAuySYA8KzG0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-nQca1qZeOf6lfAb0ltIgDA-1; Fri, 03 Oct 2025 05:35:16 -0400
X-MC-Unique: nQca1qZeOf6lfAb0ltIgDA-1
X-Mimecast-MFC-AGG-ID: nQca1qZeOf6lfAb0ltIgDA_1759484116
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3efa77de998so1404006f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 02:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759484115; x=1760088915;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTvI1DpoQ3LONUfIqcabKF8qqakEhbOmxQY1Lj6nxQQ=;
        b=TS2rsneb01XX5TtVdAS1nV+9SsOoYT8tLUZLfd7Rokx7qy7gQGrhXfb+/Uy7GSN2e5
         4+MMCxn0j6OBShx6+H0UmcCaJ6Yt8KGEX7tG6gAdX7OEun6L0jytYX0uUlZQaKxeNuRW
         CWQbvZRt9Xj/aG+leXD9yzlnRHTwpTqPL+XMmh8EIPt5wthMm/ztLKdprZ87ML4TnWTg
         gYiD6yeoSfoGW5T6099OwkPQvNpxPTWF17tO3MzKSipLIcGnflDuxqq/4TMm/7+3p7p0
         9SxOzfXjmpUsqnXiHO7BxGkgtbDAPb8c8+rTaHYRn0HRt9gnyBJa0zMPZ3UjcbVMWqUx
         65qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbWuu0QAmGFLvpExi9qfTYwfeUNOvW9GUm+Ybzz2fSYgccgE6Tobj7ewYs/yTTWg1u8dL3gF4ssrGMbQs4@vger.kernel.org
X-Gm-Message-State: AOJu0YyP3vnnnJXZ7COxiTKymhqklQOBEhi1+ybRpdEUfnB0dUoRL/xh
	J1AKfFzjswpYbf/q+B83ngljd2EpEm6a/j7yrC5qJaRngBfEqbG9l02/jBL31dQQLc/aYevFa/9
	7BtGX0YE9TeU4qvOpR5dRZPrCIn30U66+AKUWNvIDunZzheArVE9xQPlXx8YdGhm05TghSsxSog
	==
X-Gm-Gg: ASbGncsW2YHqTSrpcrK39dH/3hM2EnbLdiaKPPqxaNko5AvFeOY6n3yRxu8OhCB8lu/
	FsJebsjQYyVSOlZOdculGD0lCDSywFxDpYtyHrhUrxBSVJCDVhUB60w6GD++Zlfg2kzlR1lRJaj
	9ChqbwlDwrWf/FbQloqPLqSpNf+7Gnx2zDCv24jK0n2SPLPl13mebMvEXyQ0FIDbsbj9PSE20LP
	UMoZNQ92CZcYTHAoXtUPhjHPqcQdll92CAW0g+o7ukc7QIU1DYkRgv7+2fDAXz2akc9B8E50hQh
	7tqX42GoNoHYH2XJ1RzCN9Uk5BF548+AAc8Wnja31xRyIUDsN6CnZtid6BUp9q5rJR6RejR9
X-Received: by 2002:a05:6000:288d:b0:3d1:6d7a:ab24 with SMTP id ffacd0b85a97d-4256714bdb4mr1271048f8f.17.1759484115155;
        Fri, 03 Oct 2025 02:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0vyuKNoB3TDCcPMspLmidueip+wl7tYR26n0nTXJo0IDYg1kMeuPVLq6KLG4A5ZpZfhojIQ==
X-Received: by 2002:a05:6000:288d:b0:3d1:6d7a:ab24 with SMTP id ffacd0b85a97d-4256714bdb4mr1271019f8f.17.1759484114612;
        Fri, 03 Oct 2025 02:35:14 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a020a3sm121695005e9.10.2025.10.03.02.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:35:14 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v4 0/3] Test file_getattr and file_setattr syscalls
Date: Fri, 03 Oct 2025 11:32:43 +0200
Message-Id: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADuY32gC/2XNQQ6DIBCF4auYWZcGBBW66j2aLqgOSmrUACEa4
 92LdtE0Lv+XzDcreHQWPdyyFRxG6+04pBCXDOpODy0S26SGnOYF5awisw7B6UD84mvd9wRRmgL
 zpkQmIV1NDo2dD/HxTN1ZH0a3HA8i29evJak8WZERSkpNVS0Mrwyj9ze6Afvr6FrYsch/gKLqD
 PAEqJcWkjMhKqn+gG3bPkXgEBTwAAAA
X-Change-ID: 20250317-xattrat-syscall-ee8f5e2d6e18
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2156; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=vvUJddjEBDF+Ztgm1hAHoT+ASJXHJAAKJ82WwfFRfu4=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMu7PuFiVNFlSp31Tg6o8o7oE+xkXo3cWqYzM4rwvJ
 r5oMnGuPNtRysIgxsUgK6bIsk5aa2pSkVT+EYMaeZg5rEwgQxi4OAVgIvlZDH/Fc21s+h4uW6L8
 7YJoZOVl85LTIiecjiqefrIiOF5n1e0PDP+jb4nm3n+99ttT1gXWRzP5Xn/9eN/o2Yw0y1/beWa
 UVC/iAAA710mh
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Add a test to check basic functionallity of file_getattr() and
file_setattr() syscalls. These syscalls are used to get/set filesystem
inode attributes (think of FS_IOC_SETFSXATTR ioctl()). The difference
from ioctl() is that these syscalls use *at() semantics and can be
called on any file without opening it, including special ones.

For XFS, with the use of these syscalls, xfs_quota now can
manipulate quota on special files such as sockets. Add a test to
check that special files are counted, which wasn't true before.

To: fstests@vger.kernel.org
Cc: zlang@redhat.com
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
Changes in v4:
- Use _filter_file_attributes to focus only on nodump in generic/2000
- Add _filter_file_attributes to common/filter
- Link to v3: https://lore.kernel.org/r/20250909-xattrat-syscall-v3-0-9ba483144789@kernel.org

Changes in v3:
- Fix tab vs spaces indents
- Update year in SPDX header
- Rename AC_HAVE_FILE_ATTR to AC_HAVE_FILE_GETATTR

Changes in v2:
- Improve help message for file_attr
- Refactor file_attr.c
- Drop _wants_*_commit
- Link to v1: https://lore.kernel.org/r/20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org

---
Andrey Albershteyn (3):
      file_attr: introduce program to set/get fsxattr
      generic: introduce test to test file_getattr/file_setattr syscalls
      xfs: test quota's project ID on special files

 .gitignore             |   1 +
 common/filter          |  15 +++
 configure.ac           |   1 +
 include/builddefs.in   |   1 +
 m4/package_libcdev.m4  |  16 +++
 src/Makefile           |   5 +
 src/file_attr.c        | 274 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/2000     | 109 ++++++++++++++++++++
 tests/generic/2000.out |  37 +++++++
 tests/xfs/2000         |  73 +++++++++++++
 tests/xfs/2000.out     |  15 +++
 11 files changed, 547 insertions(+)
---
base-commit: 3d57f543ae0c149eb460574dcfb8d688aeadbfff
change-id: 20250317-xattrat-syscall-ee8f5e2d6e18

Best regards,
--  
Andrey Albershteyn <aalbersh@kernel.org>


