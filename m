Return-Path: <linux-fsdevel+bounces-21796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B9E90A2E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 05:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4FEEB2112F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 03:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910DA17B41B;
	Mon, 17 Jun 2024 03:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YvQQYkNp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CADDDA3
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2024 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718595282; cv=none; b=uB+xSHknqbuy+YzT0QDxdUQrTmOCbjQwxenDHt85f78AUQKxrxItToayyMXVgwiVwEWwdCz5wfyJHZ9K4TtflbCk9R1yeBHvEniNRkVgzTpB6yH/LcFpr9GlfbMjoQ7stadoNg7q9W0WnTMReYzH1zaiYCA6HSk2QtHv3fjofdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718595282; c=relaxed/simple;
	bh=SKlKYURJ/WFlAIa+QFwCKk08IF8XzCu8P3iyBqkBEQQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pzawn+Le/2ci2MYkX3gOH5FBCCEPZIGslPzX8T2k4Fg0sMiVEpaF6cIPRb2h9wJrk9Va+w+5IEygjwSfIYS2KJAzW5AP8NgFB6lIX4FOiYosm8MdtCQiTO4KlS7MgxWeNdfrkRgSYKiEbQeBcPvDkrDFRbfCZ3WeVZS2gEEn8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YvQQYkNp; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfefe1a9f01so4372006276.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2024 20:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718595280; x=1719200080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SKlKYURJ/WFlAIa+QFwCKk08IF8XzCu8P3iyBqkBEQQ=;
        b=YvQQYkNp4S9qofMqBhzrDOByj8tTNJK+qyaRTOqK1lDkaAISs45g3MMQyT4v3AeThq
         0T7DIIMVkl4orm4uRulopkKZowqnPb3qFNlqxZRZVfGYMg4V+rpIcNQ9Q3LdVYiD4aja
         B1etjuytdN+b/2CsE7ADt5+gsmOlgyjGxBldM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718595280; x=1719200080;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SKlKYURJ/WFlAIa+QFwCKk08IF8XzCu8P3iyBqkBEQQ=;
        b=FpAhJLQtbXrKH4m49428qvWU9/l4w9/j66bbdyT02K71IywkbWKNhacqOa3W5sjyBQ
         Kr2MxzQCflfTA30Qa6jE1h+kmCPfdBJZxY9HS7CAMP4TThBA1XTpDkTI/eiSKKBQMn7Z
         VrjOjQHbFEOiYC0y4XcXXn4+NooISWrCcdpXF048dkPU0n1EPG6QIT+DTfKWnJpbCudQ
         iN5yXNzNHMrqGHmhKIZdjI93VVBq1Btkee2mWcnJI1eLF3aAs8hE2m4nc+CxSx2nRTaG
         WaKoSydfq5dWoJZYtAQwCurcTtAZvbTr763X3vzPusOV12AlglodMIxbPHwtdzCxgUpN
         +t0w==
X-Gm-Message-State: AOJu0YydieCoyMhkzqylHlo62dvXXS/29j75Fsvs57364g0UZYjmwLtu
	YYv9/SkVLtmWbB+S0da3GcxXTH8fZJv1RK7mrcK6Xh/WP48MnmWKEqlDFZFClJhkhUSYbyYYbSN
	3YvvSM8qdf9plB93uTtGeYp29GWRagae+aWvIdk37gMKS/Mz6uA==
X-Google-Smtp-Source: AGHT+IHlch8IG7L9R33KG9Yznc9GP2oHN3EkIIu5XBk3nJp8jd21nsJ54zww7BnboiB0ZQS8XDIR0t7VU/ZJxuViuW4=
X-Received: by 2002:a25:d856:0:b0:dfb:441:e03a with SMTP id
 3f1490d57ef6-dff153db9bcmr7849218276.34.1718595279829; Sun, 16 Jun 2024
 20:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Mon, 17 Jun 2024 12:34:27 +0900
Message-ID: <CAD90VcZybb0ZOVrhE-MqDPwEya8878uzA1RBwd68U7x4CufkTQ@mail.gmail.com>
Subject: virtio-blk/ext4 error handling for host-side ENOSPC
To: linux-fsdevel@vger.kernel.org
Cc: Junichi Uekawa <uekawa@chromium.org>, Takaya Saeki <takayas@chromium.org>, tytso@mit.edu, 
	Daniel Verkamp <dverkamp@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm using ext4 over virtio-blk for VMs, and I'd like to discuss the
situation where the host storage gets full.
Let's say you create a disk image file formatted with ext4 on the host
side as a sparse file and share it with the guest using virtio-blk.
When the host storage is full and the sparse file cannot be expanded
any further, the guest will know the error when it flushes disk
caches.
In the current implementation, the VMM's virtio-blk device returns
VIRTIO_BLK_S_IOERR, and the virtio-blk driver converts it to
BLK_STS_IOERR. Then, the ext4 module calls mapping_set_error for that
area.

However, the host's ENOSPC may be recoverable. For example, if a host
service periodically deletes cache files, it'd be nice if the guest
kernel can wait a while and then retry flushing.
So, I wonder if we can't have a special handling for host-side's
ENOSPC in virtio-blk and ext4.

My idea is like this:
First, (1) define a new error code, VIRTIO_BLK_S_ENOSPC, in
virtio-blk. Then, (2) if the guest file system receives this error
code, periodically retry flushing. We may want to make the retry limit
via a mount option or something.

What do you think of this idea? Also, has anything similar been attempted yet?
Thanks in advance.

Best,
Keiichi

