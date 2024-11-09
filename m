Return-Path: <linux-fsdevel+bounces-34110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451049C28AA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B5B28296E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C891ECF;
	Sat,  9 Nov 2024 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6sd8aWi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37698BE5
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111220; cv=none; b=AtnJNL3xPgS+jLX2QEsIS03GqI9pxvNjGuQ0l70hxPYJWSNd1PlAbL4ieQssjuk7XYS/sbllwhAyMmMt+2e9IZ0kcpfWUzpYpuwfiDnAyWYzLzpwdImf95RgMldwmp/pl1coWZ4dI7gTA8HIu1rcqyufXCksSBnS9lp2wHjjTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111220; c=relaxed/simple;
	bh=dIS/luf+A275PZfROpgoat7CSSQZeaOI8Kx3mv1NTBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSgHxhY8DOuJYZUVcb0TdgmuFggbvit4K3x28v07qoYMZODurRoU1KBwfoILeyAfx1E4Bl0VV19UvUcSu0WE9CfKDIewBCVG2pnbBrG5Kw/sQzGX94VrPm/1cBFl8VtE8w/0G9Kg/Q4G65TFrBHWNmo3Jvv9vgEBtWk331fKXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6sd8aWi; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e5b7cd1ef5so23835317b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111218; x=1731716018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7YU+f95WvXvstutrp0D1/qOl6PgKoJCzrNPA4VqP9hY=;
        b=G6sd8aWibUufF4YNBmWXbgr0VA/m2Gw4fhnq0ZAjH0jRbCxPT0aCbXRT9Ort+HAaNC
         lB2R/u1YEvp5WAEcf+RYFs6M9Zr353LaFdpl7Q8IX9sytq40XubsViXwMloK5MH1ivR6
         6oNOqKA43K9XuES121TSnHkphYDMoAKuUvAK8O2JLxPgZYtlBrpEpHEEU/pMwvnwyU0a
         j0NRiaouQODLYWS1RKtI6LfOvWCRx8SdOo7alZbu2qEcClTLj7h2ytTT2UKvnZ1y4Qi8
         NWEpiu3wz4OYiwGo9fsCwFTGnvXXz1i/1gux9HtTeIVmu6TKiGpEtTIyNdp9TBk/eJ8D
         c9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111218; x=1731716018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YU+f95WvXvstutrp0D1/qOl6PgKoJCzrNPA4VqP9hY=;
        b=fR7EP3TE1l6NT3e6k5ifKzBXT4RvcHXT/JUkoEvTFY3JR03Otv8UvUUeEVt2pDjqWu
         A/YfSlpMu/emjbqzpepbGIjNjM3RkQUmchSYkekT2RVDjcYItvUPB/ampBwxK2aWbLnz
         Ri2/TzDWDNovAxCOWauyKLigePvUREODklkyKYR22xTw6O1feVdN3HDSs9m3pG9OQh7o
         2bPQWaAFMadmwWaN5RHC2IIXgBASR8vcVxNBQHHaXIYV6Uhwj/J/JNv5BP7jiEWQYCK2
         QY47cwWQPhQl8fcBMS9u+9DIOdO745Eb+2aj+krOBEFZSQWxr5PUOO0eNhl2q2vWsD3a
         MzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIXRnY2toOwJmVyFA6NbYERu1MBRbyA9N6mHO7FjPmJElkJ3OX5exw83+UPMwQuyrWmFRtm3JK9o059uxl@vger.kernel.org
X-Gm-Message-State: AOJu0YxqVdxO9cMbzNtl8qqsL4mkgUmx6hmgDT6IYeJPnUEvV9GW5SAN
	j+vyQIfsStSoF+p/trUQJJfmrDFxrWszj+1x+vO41wNIQ5xHGbf6
X-Google-Smtp-Source: AGHT+IFGUe1soxcok+0AXi2SUtey4ZmHQsuxSOXJJNFbgFIXGMDgfAQF1SulsPIHNet1vZ/xANolHg==
X-Received: by 2002:a05:690c:6f92:b0:6ea:8556:1cd6 with SMTP id 00721157ae682-6eaddf84222mr62093907b3.30.1731111217837;
        Fri, 08 Nov 2024 16:13:37 -0800 (PST)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eae5db4712sm3511587b3.52.2024.11.08.16.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:37 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 00/12] fuse: support large folios
Date: Fri,  8 Nov 2024 16:12:46 -0800
Message-ID: <20241109001258.2216604-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for folios larger than one page size in FUSE.

This patchset is rebased on top of the (unmerged) patchset that removes temp
folios in writeback [1]. (There is also a version of this patchset that is
independent from that change, but that version has two additional patches
needed to account for temp folios and temp folio copying, which may require
some debate to get the API right for as these two patches add generic
(non-FUSE) helpers. For simplicity's sake for now, I sent out this patchset
version rebased on top of the patchset that removes temp pages)

This patchset was tested by running it through fstests on passthrough_hp.

[1] https://lore.kernel.org/linux-fsdevel/20241107235614.3637221-1-joannelkoong@gmail.com/

Joanne Koong (12):
  fuse: support copying large folios
  fuse: support large folios for retrieves
  fuse: refactor fuse_fill_write_pages()
  fuse: support large folios for non-writeback writes
  fuse: support large folios for folio reads
  fuse: support large folios for symlinks
  fuse: support large folios for stores
  fuse: support large folios for queued writes
  fuse: support large folios for readahead
  fuse: support large folios for direct io
  fuse: support large folios for writeback
  fuse: enable large folios

 fs/fuse/dev.c  | 131 +++++++++++++++++++++++-----------------------
 fs/fuse/dir.c  |   8 +--
 fs/fuse/file.c | 138 +++++++++++++++++++++++++++++++------------------
 3 files changed, 159 insertions(+), 118 deletions(-)

-- 
2.43.5


