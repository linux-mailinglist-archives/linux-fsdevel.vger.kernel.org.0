Return-Path: <linux-fsdevel+bounces-55938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB193B1058C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 11:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288ED1CC7C5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 09:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBA924DCEB;
	Thu, 24 Jul 2025 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjelGoNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024824BC01
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348650; cv=none; b=vBXETIPuVdNwjeC62oAmb0bvJnNXoVqSDnxZY6/YLmpN5QOuBVaGYA/o/uzgP17Xh4vUGgmixAacSdEq6iWZXt/ix+K/K895ZyWbA+Yxg+OSkTF05cTt7sA9VrfUzJNagZs+ti/m7+ZlW2Q5/dFHK7pQZI6829nxxDI4CiUh2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348650; c=relaxed/simple;
	bh=UXDu3pWBfSF2IsqAu8LZMSLDVSnlFzYsRRF+ohnfa8A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=m7ChYWB75aXpWv0jz4V/KiDy41f6cOLl8n35QZn5FdQYZjOBNnahlXxunBL9e0Qjxn2P7bXqI6V8Z9CmO4KRDE3LxWyLT/oc4YM44H1HQzl8XxXf5TBxgiipD0qb4RSOilGyV6rBc0bywfZMmuMnY7/QCcv7ni9HdJ8FIExLg/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjelGoNt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so1334910a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 02:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753348646; x=1753953446; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NU2pNlupjMxMrzWIDA4T47dZfIwKflAaYjNOxIZYknQ=;
        b=BjelGoNtQQwvYbRWimQaXxjkoWho7X8rtwd/o/RxeHHw9UT72PEmuzdbO2Lq94f6zl
         sWm1XCFszAmqaIju3PfQCbsecCZJA90435jSlZX3jTfG5T2WSnXE+RCdZ5G5/RqBT3YE
         OtvkL7aYok8L4OdRdfqUt7X709mCbpcW46vZ2fVG7f26i8tGrm+3E2qmM+hWsFmeSAYj
         Uf+Uv3I0Zzc5+dr/Tv7v9pixtHKpFTaHmMNRmz+r0uVslF0QhHYtgQJFvPNOSRS7jVz7
         NWtk5fN7d4doQqtTOuVFAhphzv1jI1z/8qkIY3QLDsVM17zzFB1z6qcij9tHXMTJ1KZ9
         49DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753348646; x=1753953446;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NU2pNlupjMxMrzWIDA4T47dZfIwKflAaYjNOxIZYknQ=;
        b=UWPTjxN0TpzS45DwhJztgW5DUB90iFO1bLOv8+zcwNvVGB0uXg5psO8qj3qPv+3QDR
         JzPuYWTlAMEhj8ggGW5rNUDymSKECQLwkiN/fCso+D8pdWKlj8ag+fZ9pf3TxvzOntgU
         xp3bEcq+dcK0s67DGlm74WFiaZPvTDaHn6/IIGlc9BQyybmXyZrAGTqRj6NwPwtzGNGk
         wtcDnzJJPsbt/VI64bfOmmhtHItvjCr7QDpZfNQXlsow7xVMT/iHTJ6q2zQCSSOcDTrN
         SmAFH04WONnO8CJ7X3llMDwel0rkHD32hFxy9deAYGajZfip9pi8hoQtx2R2KwV18wEl
         /kvQ==
X-Gm-Message-State: AOJu0YwEQrXRjpBEZXk2kZOWca4Hvs7PeZvCYqdcFnosZU1LaKY657jP
	6QigfbH1WcG2Ti32PvotW9QI5tQ/In/SmWy9Zyhgx4cEwC3LUH4+EB1Sw0tbosdKJGK8SDPbnbL
	kqzCQTsU70dPIF8z78cSGdJ0WAqVFpy9/NENzaBs=
X-Gm-Gg: ASbGncvktE530xbrVybHsDQLC7FjNoaBvQLPUhw3DawJgx2tO44j4DsCKO4df2nlw4J
	xaR0xjC0p0jghOyQ0/DkjkUEBVlJq8IakOOQ4NORl5C+Bvv9vD67DkIVCt1rv/6FjBB+DHLfX+F
	WbXdJWEceqZS+pHZwxdN06bZn1Tbl8ehG6GA21hqj/lr1/ANUlybPX/T+7cTyrtJTIBW68seEKS
	11k2UmH3A==
X-Google-Smtp-Source: AGHT+IF9l9hif+8olB9jdInvUPrecdwAoQtWQw6uBbubO7TK3pkR3oM4bxAjJLnHyHXcB/nBk0pcyW0CJmaPl0kEApU=
X-Received: by 2002:a17:907:db03:b0:ae0:d7c7:97ee with SMTP id
 a640c23a62f3a-af2f8b59137mr765523266b.41.1753348646082; Thu, 24 Jul 2025
 02:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gang He <dchg2000@gmail.com>
Date: Thu, 24 Jul 2025 17:17:13 +0800
X-Gm-Features: Ac12FXx7_l31Ut7y0l2eOjkS0rRk30hah6vAEOb-JdsIxvgl_a7nhGhUH--YMNE
Message-ID: <CAGmFzSc1bVUg9-6Y_kDb4OXNLH+-9jb+O3iCAA+sKyNRSnrFWQ@mail.gmail.com>
Subject: fuse io_uring test performance is not good when fio iodepth > 1
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Guys,

Sorry for the interruption.
I integrated fuse over io_uring patches in v6.14, but I found a
strange problem when I tested the libfuse null-fs test case.
the fio commands as below,
1) fio -direct=1 --filename=/mnt/singfile --rw=read  -iodepth=1
--ioengine=libaio --bs=4k --size=4G --runtime=60 --numjobs=1
-name=test_fuse2
the performance result:
enable fuse > default fuse
2) fio -direct=1 --filename=/mnt/singfile --rw=read  -iodepth=16
--ioengine=libaio --bs=4k --size=4G --runtime=60 --numjobs=1
-name=test_fuse2
the performance result:
enable fuse < default fuse
3) fio -direct=1 --filename=/mnt/singfile --rw=read  -iodepth=1
--ioengine=libaio --bs=4k --size=4G --runtime=60 --numjobs=16
-name=test_fuse2
 the performance result:
enable fuse > default fuse

Why is fio test performance worse when enable io_uring with fio
-iodepth option > 1?  it looks fuse over io_uring feature does not
handle this case like the default fuse configuration.

Thanks
Gang

