Return-Path: <linux-fsdevel+bounces-31673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481DD999F85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788131C221FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1576D20C46D;
	Fri, 11 Oct 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMRGbVSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE851FC8;
	Fri, 11 Oct 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637231; cv=none; b=B+Vu8REsp3t0Jf37k1AZ5RbK04I214FnZ4zUrUyLREsl9dlvATVIiZxixBiHgwV7miHoED18rhdnEqQgR/gsg5+ESrZzsoYFGj7PauOoPBt0tvvyeTZyezqm6qDzS6WtMwmKgkMj5BFdeAOpX93YSCfO3KASGSplM8/R0D1prrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637231; c=relaxed/simple;
	bh=nB9dsbKqJtIgTQIkoOkjmJto/x0EpkxTa0+qxq4nhhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RzMHfGbUSuObMp16yeNjK709C4LQPmhBawhbXwB4838zoU/PVEu/JkbTE839ws4ZJvRr/X9V9tO6C8Grqq75O6tzEdfGR48bVvGmjVj0hgioChWDGNq12OxtvRpp8FwH+jE/afGavL0qbuAzAhy6H2BvAg7M3SebmrObq5xWGic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMRGbVSj; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso282421366b.3;
        Fri, 11 Oct 2024 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728637228; x=1729242028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrZ3z15yOk446P3cZlx5JJvOCOSp8MVxeqXDlWF9NAw=;
        b=eMRGbVSjJOEUZ2Ait1R68wfTPsSYkUP9F0nrCqrEbJybYsFadAUHRaoeCtXCK8Y/v5
         Mymvty/tFHAJ6h91w+YgqTCpeVgxymz9RWO6MP8j37ZJK5/zJFIXgI7VbP3V7yxYnJhm
         fO1NLARHuyiwCdUda5hnF8FnFwXsiAO6U0j1+pLYJyvmik+HyEKOGtroMXFpkfLuGlLn
         hSu5S/ihQwDxKnjUqqIk3Oe5+NzT/kdLnZGAukC/XQTPdNYZonuL+u50nKzR17Xi6uaq
         NMPtnxRy7aY9Wyfhgwn+VpKq8PeIiQtSo7EHclGIJJaoM2J4mFKPXpFYXAOy+lCPR820
         YiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728637228; x=1729242028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrZ3z15yOk446P3cZlx5JJvOCOSp8MVxeqXDlWF9NAw=;
        b=iP512owxkiXFf3sQjrN1F7zRLGmHZlVkEwkTuoyASL1gcHg4A8AdLHMgbClMfgJ2WH
         NACwCv1po9kkuARB5kYwTdm372fTaYbBoVR1nV9kPDlltVVKtQ2+QNrMZCk0j6zke3is
         7Ls4F7WV2g0EJ5HNA6O18XHTnEENm3e4xo2Tm+zqh7d9gDhX01jyfHJnD/2rnbOzx/JQ
         iLK8FbP3EGsxjlb6V+/H1ejm2mqOaqbvO+wjvuT87LfOkaCfwikyjhv8oIFA7UI2Hwwj
         qebP8FsPOkCjlWs7GaSK5ZwJgI5wcJIWoB1TnMwOWU6cKQc+GUDWI5xNS4Bzexwrv1Iv
         mWqg==
X-Forwarded-Encrypted: i=1; AJvYcCUkj1Vb1Q5Y/5uNfEzVrFSkT9d5jycQl1p9ZH2NegWdoTjetuY0Yaf6OKNNzPPCTcKWfIpcd7mqGynNp7Fh@vger.kernel.org, AJvYcCV+RrLP7JXQ5960Rnp+XbwUJ505J15YA59Lyq29lju0zZSEsYfZ8sY2q0DePLYkZPwe+xDgui2Bezm1@vger.kernel.org
X-Gm-Message-State: AOJu0YxTnI4KpcjFFJUgwmUnn1SYQI58u2kWvrbIXiwgRv//3Z4F3GAq
	pCp9DhdyJ9xLuQ5mMju1BXkuimJKwrCw1KBJZEgHRgPu5lAJ8h2d
X-Google-Smtp-Source: AGHT+IFem/6Q27O3jTHzVz8boQiHlMtUhdq+SJT3+xAs3BRT5Gef78tWCGJ9vVFWWd32OxXWzyplsA==
X-Received: by 2002:a17:907:2cc5:b0:a99:4ce4:27eb with SMTP id a640c23a62f3a-a99b95a7640mr138885266b.46.1728637227662;
        Fri, 11 Oct 2024 02:00:27 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec5697sm189606066b.22.2024.10.11.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 02:00:27 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/3] API for exporting connectable file handles to userspace
Date: Fri, 11 Oct 2024 11:00:20 +0200
Message-Id: <20241011090023.655623-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian,

These patches bring the NFS connectable file handles feature to
userspace servers.

They rely on your and Aleksa's changes recently merged to v6.12.

This v4 incorporates the review comments on Jeff and Jan (thanks!)
and there does not seem to be any objection for this new API, so
I think it is ready for staging.

The API I chose for encoding conenctable file handles is pretty
conventional (AT_HANDLE_CONNECTABLE).

open_by_handle_at(2) does not have AT_ flags argument, but also, I find
it more useful API that encoding a connectable file handle can mandate
the resolving of a connected fd, without having to opt-in for a
connected fd independently.

I chose to implemnent this by using upper bits in the handle type field
It may be that out-of-tree filesystems return a handle type with upper
bits set, but AFAIK, no in-tree filesystem does that.
I added some warnings just in case we encouter that.

I have written an fstest [4] and a man page draft [5] for the feature.

Thanks,
Amir.

Changes since v3 [3]:
- Relax WARN_ON in decode and replace with pr_warn in encode (Jeff)
- Loose the macro FILEID_USER_TYPE_IS_VALID() (Jan)
- Add explicit check for negative type values (Jan)
- Added fstest and man-page draft

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
[3] https://lore.kernel.org/linux-fsdevel/20241008152118.453724-1-amir73il@gmail.com/
[4] https://github.com/amir73il/xfstests/commits/connectable-fh/
[5] https://github.com/amir73il/man-pages/commits/connectable-fh/

Amir Goldstein (3):
  fs: prepare for "explicit connectable" file handles
  fs: name_to_handle_at() support for "explicit connectable" file
    handles
  fs: open_by_handle_at() support for decoding "explicit connectable"
    file handles

 fs/exportfs/expfs.c        | 17 ++++++++-
 fs/fhandle.c               | 75 +++++++++++++++++++++++++++++++++++---
 include/linux/exportfs.h   | 13 +++++++
 include/uapi/linux/fcntl.h |  1 +
 4 files changed, 98 insertions(+), 8 deletions(-)

-- 
2.34.1


