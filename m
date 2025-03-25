Return-Path: <linux-fsdevel+bounces-45040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67152A7091F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 19:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AD816F858
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE021ADC86;
	Tue, 25 Mar 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="Dm5hoeBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D71A8405
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927952; cv=none; b=VZeR3SKFxJxYEZdEOpsIGTeUGWJdMwwipXFsNtacb+lRivDJNC3iUIIXmY3rCGxMFDm08EbVPaCYPr3bw8Q2qBK7luyO0QNg7U2ZLYqqAm6xvCv0OP4sbhcmzYdyLodvaEFEMZP6A1X9ZUT7WJVj+apfs2FqbOyf+RdAoSL+ZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927952; c=relaxed/simple;
	bh=bCJlJhl8YucfnAzgKhJCd2WQ+80iWTH8RHXaGInB99Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=naLf4rJc6Eb+aa6UohfP8F7E+uUne6JXD5Phnd/OHNIDSZLYZcsXvi0yliLSQFr1wqHeBU9t2WUZ+A3VQpr3Hm3FAzbyyMPrdbH3J/omx4YsHkqbB/b7M1RdgXdq1QtopZe88MA4GM8tPmfFwjhf8FnL8Yjr5IqtC/YgH4G/g60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=Dm5hoeBW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22398e09e39so124253195ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 11:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1742927950; x=1743532750; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n4sTxL8z8ZFyKWGtLFgWMnbMp9iEFajQjElF2stpIL0=;
        b=Dm5hoeBWXZVQGzGpD+AEbaFtS4Udy+CkEbMjSVMi1pv2jw9NvXokmbI1xaSWPjMcAH
         hUQxrkR+vIHxrpgbAW3Roum2I4djjrzLG9sJ4DeuyaK1UyHMkveWkehC7apiCDBIN0KA
         JV4cRNN7FXKJFnAhWLglpIWyrAA9J2xlA+VciUidwHOuEzAvBqk/+J2a8sOswjhnp3Az
         RvPBjEZ59ZNpb/yC8DVQGeg8n5b08ER5zuOjdfe9akf/xqVu1kHy3+dJFrP1RXeKd111
         CIdPjXopBx74+IdCE2wm6+BuwNlF/0jvuQ9xmhLpGmQ8Cy4sCofWlh7h45ZTQ5VrGU/W
         Pdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742927950; x=1743532750;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4sTxL8z8ZFyKWGtLFgWMnbMp9iEFajQjElF2stpIL0=;
        b=CXkH3DlprGlK42TYJysWYLIC3YwrLU9USsebZYkOkQ083coQXSeGiIyVQvykLmLCoj
         /2WDUEPHa4suWU4HOEPhoMLrtJnp3xCNnDGAsWjn3ghL1fPecMDMAs5Jr2u8Y2ptff87
         ykTVONClX6qtwaDhbxJEzVE3D6woRoQggZkvfds2rl1USvKW6QeKycmXi+SzoLGyc6j+
         eVfLJdpghZ6xm113j94hLJ+0YoZQ0b/WeWhONZmNvm3iqbpIvHZ5Uf6zLjRFIJIJllOK
         CosSFhd1s67m5MpZwJ8MCYOT7mS8bqsfsJF6WaJalhEiPo/ZA8eRXzAaj/0znR6cmWxi
         tqPA==
X-Forwarded-Encrypted: i=1; AJvYcCV1mbZJgHtrbp5OVxw8TNnXrR/iq44K6MePCR8cdtglDKRPSWpbzhrn5qPVfuV1Uehj2cmxSmyXgM2DwGMr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jc8UUzKb5HXxsQJPdPIQzUYovx6NWmn5mPqbwnpUZfFyzqrU
	bz9xYwlD9qLpe4an8OuurfpREixb1FjkYoAyQxdHidtUcbnSVe6/mw5XaZHNSOe3NSEQVbwYoqZ
	g9e2G86EF39WyC26bjes8iAmH0K3UWLIfp/OdDkoACiJSkMjmRw==
X-Gm-Gg: ASbGnculTr5ifmjBQYN1/pt4PVPI4g00rUH9afez9NWR6HvLV5RVoCUok+gpYnWRB/7
	kqJQmWbdY+nfD1r1KjY9OBeteJMSTc3D4OjraSY3H2I80G14IPUyAxY7KDtlzUUZbsLEO0F35X1
	abgaQkqRtlABNyLqV8raeR7nDLcXUbdgalimzDxw==
X-Google-Smtp-Source: AGHT+IGSTGm3jyjlzqMiRIBP9nkdZErm4upxg148yL2BQ/Q/JmGxg4x58u+o7i/pQzVYoMgRRXII9Cgtd8qgy/C5y/o=
X-Received: by 2002:a17:902:d50f:b0:21f:4649:fd49 with SMTP id
 d9443c01a7336-22780e2bc7amr292152155ad.49.1742927949535; Tue, 25 Mar 2025
 11:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 25 Mar 2025 14:38:57 -0400
X-Gm-Features: AQ5f1Jqh8RozJArAut6NjWNnAfpcNnES62KdtTBuxvamGV6dc19eM3WlvW-jdyI
Message-ID: <CAOg9mSQm_2=gAhyqUHjbK6pqedxH6n6Wd5Zq5opdZ0gjHMKsTQ@mail.gmail.com>
Subject: [GIT PULL] orangefs updates for 6.15
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"

The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-6.15-ofs1

for you to fetch changes up to 121a83ce6fe69d3024dfc24fee48b7a2b5386f4c:

  orangefs: Bufmap deadcoding (2025-03-18 19:39:19 -0400)

----------------------------------------------------------------
orangefs: one fixup

From "Dr. David Alan Gilbert" <linux@treblig.org>
remove two orangefs bufmap routines that no longer have callers.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      orangefs: Bufmap deadcoding

 fs/orangefs/orangefs-bufmap.c | 25 -------------------------
 fs/orangefs/orangefs-bufmap.h |  3 ---
 2 files changed, 28 deletions(-)

