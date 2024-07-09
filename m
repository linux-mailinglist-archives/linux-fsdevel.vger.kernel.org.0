Return-Path: <linux-fsdevel+bounces-23377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B121692B713
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AE21C22228
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B8158A08;
	Tue,  9 Jul 2024 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsKztbHE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF4158211
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523970; cv=none; b=VRkVv7AbAK4H59/vG0qgLQDUHRH7TkKMgx200lVFVis7Mys8fnIqBMxsGaMhmwgsLK+CT/8eWNNrN2JgK+gJdq6aBg028kZ39slfzXk7uAttcRHNQ4/2nksXBPj4m21EPL7yJEhcT/gvG6s4kdoOHbfE609OdNV1A3TpL+L02tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523970; c=relaxed/simple;
	bh=BItnevYQftOCRFmTco7LyFoPZ4oUphW+9VYSudo+9NU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDi71xKTfCwqECuzUpv1QzZYKqbfPaOqOzjm4//ULcev3Wz9t02ltdHk7FJjlCot1eg5JXamsP2JRhXnVloLvjaytXEPWgZMkD+ymkkrOzwAetVvgs8yrCRmVO7cHPsDFPay59rpCk4Afjrq9GhK0ij/8ncnnimqGF5OE6btuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsKztbHE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720523967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qwbHLNXPzAR/N/8uXrZSRmFQ5c/uLTMXj08MAhKvTTE=;
	b=AsKztbHEKoLn0J3GYHUncxFaFy3gVR3kIaTIetzSQCElMA94IIgPUTh+tYUrA4Z+yhmU1F
	CKOpDyk+PBUW11NWx+SyfBwIvBzjZUVZbu/UNnG4N4+t2x2PbHxtEnXY3+mVZ7Uo5jJbME
	cjYVk0VlWrxWm6od/h4rnvIcUe5FOxs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-xef0G98fM5ia2AoiD597hg-1; Tue, 09 Jul 2024 07:19:26 -0400
X-MC-Unique: xef0G98fM5ia2AoiD597hg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee94b0e2e1so45863431fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2024 04:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523964; x=1721128764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwbHLNXPzAR/N/8uXrZSRmFQ5c/uLTMXj08MAhKvTTE=;
        b=wzYdzgeFIPkvWv5VuTVTQ7EEIJ5e4t4L7sFlbuV9yASG4uq5HNoec78S8u2ZmJFDDX
         LzUGiwdX9oXr2gWIctDh2kkz+xvcDQsqu+/+EAAgIoUnfzCCuUHMRpN0Rd9rc6id4S62
         YRfb8nkogk9LsLQTUWJ6FkWTF0XSUf1Y9NE5zBM31xW/INhOjtwQ7h2TmFLSJ7PRT4hI
         Sp/f4j9zOIUD1th6D9+SwMCZjiyyrcmG7HpSOW7Kl+2jYB3A17h9T1pFKjdJAQDsNcI+
         s3rlcqdiTyByloYHlyT9sYnqVRzjX3CaZ3ckzfgpxzAy9UGTz17mZjmaFc/TlLf/TLYi
         j0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUczR3DcFAfSw0YlcnrL0dmjeLS1IXOrm8oT2H47Aq4bcuu8XUeWNge1/NzMpsCHWqtJoXs/KhSrhd+KRaC4DlA5IAZ+3BfAIHmEfYxaQ==
X-Gm-Message-State: AOJu0YymsVWYjA+sZg2UkrDrjVKzYe62lyPjoUaMlLgviDdH2tjz1AA6
	tyOK7YjFpQ8ZeDW4iZlCt0vAbpCOMqKY+dI7QG9jdJtgSP+9gU9rcmXTtf6JSfmpZh7RVMVY/V2
	yrdCGs4IESvsTLSm1QMF+8QNNjCD3opJOecsxZ7j8rIqSoZqc01CqMqk415Zm4OQ=
X-Received: by 2002:a2e:9f03:0:b0:2ee:4ccf:ca4f with SMTP id 38308e7fff4ca-2eeb3101de6mr16104951fa.31.1720523964487;
        Tue, 09 Jul 2024 04:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFGxEpvT2wnJU72VkvZj7q8tuPCVpDDqG6kBc7TA4IZyQG8gcuy+uWDWNgH2hnWmFNmVBcCQ==
X-Received: by 2002:a2e:9f03:0:b0:2ee:4ccf:ca4f with SMTP id 38308e7fff4ca-2eeb3101de6mr16104291fa.31.1720523962911;
        Tue, 09 Jul 2024 04:19:22 -0700 (PDT)
Received: from localhost (p200300cfd74b1c2b6d9a10b1cecd2745.dip0.t-ipconnect.de. [2003:cf:d74b:1c2b:6d9a:10b1:cecd:2745])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa078fsm2244778f8f.71.2024.07.09.04.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:19:21 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Hanna Czenczek <hreitz@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 0/2] virtio-fs: Add 'file' mount option
Date: Tue,  9 Jul 2024 13:19:16 +0200
Message-ID: <20240709111918.31233-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We want to be able to mount filesystems that just consist of one regular
file via virtio-fs, i.e. no root directory, just a file as the root
node.

While that is possible via FUSE itself (through the 'rootmode' mount
option, which is automatically set by the fusermount help program to
match the mount point's inode mode), there is no virtio-fs option yet
that would allow changing the rootmode from S_IFDIR to S_IFREG.

To do that, this series introduces a new 'file' mount option that does
precisely that.  Alternatively, we could provide the same 'rootmode'
option that FUSE has, but as laid out in patch 1's commit description,
that option is a bit cumbersome for virtio-fs (in a way that it is not
for FUSE), and its usefulness as a more general option is limited.


Hanna Czenczek (2):
  virtio-fs: Add 'file' mount option
  virtio-fs: Document 'file' mount option

 fs/fuse/virtio_fs.c                    | 9 ++++++++-
 Documentation/filesystems/virtiofs.rst | 5 ++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.45.1


