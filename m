Return-Path: <linux-fsdevel+bounces-31352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9203995356
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 17:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B34B28246
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31601E0493;
	Tue,  8 Oct 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLtAwEs7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2E21E0B6A;
	Tue,  8 Oct 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400886; cv=none; b=LIuP4FlmN/9kfAkhJKPAAFJ3BhZnaaPZHPFTV7pPwaE7m+HmVLhiKmOwLOgVtVix4Qyug4P85icxt97gP/+Jh/l0r/cGuRIxw59TvOrThg9xTJEDAAVXurpM8y/fJtMvfgD5GJs+L5RZBxkGjXu4EhIn/2vwJa08w3pEX+aST/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400886; c=relaxed/simple;
	bh=VzsgDq5MVZ2mDxb4FjcfgJ0qQMKi0AQ2VPGqZYPRVpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TqCXZXX8STQKZlZSHDljRRwrLCUh+yDsrXCDY1vGbAtDXfDqsqhC7Ni569Bxj+mBY2qROW5C6LZpZZ75V116F30OzIZzzpZfx6qedDWX20uajAj/kLfglYqUsJF350dMMLLBMFH2kezmuasJ3vh7ZCb9JIAqpy0CrtXw1yO9Rx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLtAwEs7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9968114422so135140766b.2;
        Tue, 08 Oct 2024 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728400883; x=1729005683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=muKE/TLkaf6iJZHcMo7cWVQecMImEoixQGwziUIwwhY=;
        b=OLtAwEs79tmPlEdBveCNDQmiE3882uTd6fXjRTtrL83O2A5CiaNXhc1QpQlnao8rcy
         zzaq0H+HY1tKzqAtdKCAAOWSctaGejSeJYNnnrMtIVeR7Tm8y1OzlQy12FRCuGRQX+zg
         VMNbYBrtnaj5q84HJRNvafCK6Hec91cZFQUzGwSZXhJx5tSdTKr3lEa/opfmJg5MqcJV
         jjM28qRpaYJao/Qaxf9sXB2iTZ3kRpq3KErpcrmxouyviQuy9MbYV+rNBmhYBYN5/sLe
         MrNbsn2twLCrWtOI7cIqxLONPk6UssGkp7kYIidbib5NV7AdjM4jbx9uroXjFq6r7FcW
         2EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400883; x=1729005683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=muKE/TLkaf6iJZHcMo7cWVQecMImEoixQGwziUIwwhY=;
        b=QHb1DmDjS2ib6gHrvGuJBHyHZxf5Tfy7G0FTdZe7uDZ609/SzZxO8IruH1w2ugIMCs
         9yJjrkEuabmLifgTH5YDj/R51pcW6qNgCQ1MEycOmQ9CS5HiANZrtxoL+YeXDVyNhGiH
         86/DqFUf7ch2eyjmP4r4Wt6Fjc/NQNtZBQiDTp1m/TWnWQb5b0EHsCtPDkzGUAeO1V5/
         u3ITHDau8lTEWc9Ls624GjDNmEdFS1GG8MzSOnkzvPVkoaysiRDTuBlDcIvdjUubo9P0
         sFC08dP30xHwboRWy1/bE/yuIclRdEIEv2yhpoljqAsCM254TmRmjwe0rWXW1hcKZWy9
         oRyg==
X-Forwarded-Encrypted: i=1; AJvYcCW5FUIv5G3zFedrbNWareUAdUr2nUalRoTyX1IUZLz2qgLu63NRnLPUyV7avAREpoKXBZ0EUbAVsb+0B2sh@vger.kernel.org, AJvYcCWq6W6eP4aYiPK86ppl2w6f3RLBoN8VnZIcr5GQvF0Fduu/lbccz4mn2tIraENAb2eO6w9mnnhPBFZ2@vger.kernel.org
X-Gm-Message-State: AOJu0YyznXm4gCHsFM+9Sw3awMdb9ebYsiGGErKEUIaunJD1wYgs/2ZA
	yMzsqAaph+E/OWNn51PtSDji+HXI7ZXnIksaymTo8eKxAmLemmIq
X-Google-Smtp-Source: AGHT+IGZVvZHFoyExYzmqdu9dUPGeZQgQ84HcrEHgx9HpJgg/CY/hwuA9J7GqzDS5IEY29lvf10QAA==
X-Received: by 2002:a17:907:6093:b0:a99:4136:895f with SMTP id a640c23a62f3a-a99413696a0mr1179739866b.41.1728400882446;
        Tue, 08 Oct 2024 08:21:22 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99384f8258sm487910466b.16.2024.10.08.08.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:21:21 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/3] API for exporting connectable file handles to userspace
Date: Tue,  8 Oct 2024 17:21:15 +0200
Message-Id: <20241008152118.453724-1-amir73il@gmail.com>
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

The API I chose for encoding conenctable file handles is pretty
conventional (AT_HANDLE_CONNECTABLE).

open_by_handle_at(2) does not have AT_ flags argument, but also, I find
it more useful API that encoding a connectable file handle can mandate
the resolving of a connected fd, without having to opt-in for a
connected fd independently.

I chose to implemnent this by using upper bits in the handle type field
It may be valid (?) for filesystems to return a handle type with upper
bits set, but AFAIK, no in-tree filesystem does that.
I added some assertions just in case.

Thanks,
Amir.

Changes since v2 [2]:
- Use bit arithmetics instead of bitfileds (Jeff)
- Add assertions about use of high type bits

Changes since v1 [1]:
- Assert on encode for disconnected path (Jeff)
- Don't allow AT_HANDLE_CONNECTABLE with AT_EMPTY_PATH
- Drop the O_PATH mount_fd API hack (Jeff)
- Encode an explicit "connectable" flag in handle type

[1] https://lore.kernel.org/linux-fsdevel/20240919140611.1771651-1-amir73il@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20240923082829.1910210-1-amir73il@gmail.com/

Amir Goldstein (3):
  fs: prepare for "explicit connectable" file handles
  fs: name_to_handle_at() support for "explicit connectable" file
    handles
  fs: open_by_handle_at() support for decoding "explicit connectable"
    file handles

 fs/exportfs/expfs.c        | 14 ++++++--
 fs/fhandle.c               | 74 ++++++++++++++++++++++++++++++++++----
 include/linux/exportfs.h   | 16 +++++++++
 include/uapi/linux/fcntl.h |  1 +
 4 files changed, 97 insertions(+), 8 deletions(-)

-- 
2.34.1


