Return-Path: <linux-fsdevel+bounces-53534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB004AEFFBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184DA3A5B93
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7221727B4FC;
	Tue,  1 Jul 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQM3aRKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568CC1D5CC6;
	Tue,  1 Jul 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387242; cv=none; b=rX1m0qs52nX1TIqke5+ucqepaUOZ4FCyDdkrRjWtsXNRXIaPV6OqEdNqjR1lIoLpEMYv37Xo/xeCQ+EsnBxln6tuQuKY3WDHxMY6HohAXPUgRV/6VL1rW2mjrNQTejHxe2UMsY3Rj+rbPtfsfyudeqBeTgsHe3AjsemS9Ks4DX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387242; c=relaxed/simple;
	bh=QQ2aSCMKAO1QDeQotHKimD7/9eejXBabA/tAb+LKHdo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B27AZJN1PnU77BeDThdnAbJIRO5gQ/EAtmKokDA+e4FgPtxQiw2PMR9poZBFfgTczqP1hO8FYLheg2KJLMF7p0ATkf9dQC+doWEzCpIDAJIvNPt89vYwJsstbW8K3h8gNcT4al4NoXO8REFthkjwvJjFqSE/ZqsBtl6fxOeUtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQM3aRKf; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a774209cf0so38307111cf.0;
        Tue, 01 Jul 2025 09:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751387240; x=1751992040; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BywMu5xeUMjOjbU7hpP8f/Jz2OUlepXACB1q3I9VG38=;
        b=iQM3aRKfdGGG23gwRur9YWSplxANwDcvm+Tvbkg55revEpnMG+umvoYDcCS1XgtGO+
         mySms15Cjcj8QVYfVdxpMguMB6DP9mB6mGUV6+PHwTc4uurFJ6X0NBeOh2LEnYRD9x0H
         +nkTE4huRFrWHZWVGOxb8BWNXDIcaXLqg0q5qToLFGNlYHB4pTwj7Y3S1WalysCVqoZV
         NCYjXW5ajlcaZmG/5IgqTsWORt6ksDilybJSTQbER4/BuMHVmuUCthRij/V0zCzyrGvc
         NdtfipNLkNEWx1n1P+6jDhyBsTlY9LkMmRsNyvWFFzbrqNYPAvDPk+E49KXjYnmVyxhh
         2vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387240; x=1751992040;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BywMu5xeUMjOjbU7hpP8f/Jz2OUlepXACB1q3I9VG38=;
        b=fYsJYSohqIMTnwaBBAgddRQiSHrT4+kMcAdX0nvvQlVcjsxyDMdEIH1aXVGOCY4y+/
         VKrQlWGiK4NSu8LBVI1TYTtB4+NnMquKKPQN25y6DqmEt7cEqUz+Sb9oWQTO45B1gCKd
         l2Q10J3lQgJ0mtQaYCKe+Nx0q4sjsmu0otmjcsG6hcGvpDil4JiHq857dZVgYd2jN1vm
         k41V73NxbXJitISwSpDPb1N3Iw80B/s5QTHo8fMnYFXcSZIs8OxpJ7xjFOHTTuGK/6ry
         6JoGYlumM2CYt4Iucfv6supfBDuk/SUrow7opR2pSbzG0VnXHRHNJWSDnxJMH6Ax+b2T
         cY+A==
X-Forwarded-Encrypted: i=1; AJvYcCUm348NvidzT6sP83SfI9EGpnq2yf/Me2H4jZNhbxIQqMkkW1kPddvwTbsnRT4DbLHrS/hbB6MEq4PUuzD4@vger.kernel.org, AJvYcCXg2w2m5fFNfH1hXOVOFwXWaE7zcDsITVbOs8BNY16y2EtQXq9ukLwpyPM4ZCGeEtzXSLmiBuCZPk/GRCvC@vger.kernel.org
X-Gm-Message-State: AOJu0YyffNXSkQncOlDNnIV4ZuNCkYVhCM4T/jLc2SfrcC5tmQCwayPI
	CmXogXCpGV25g1YE17Ij9LYWeQHy5eS9Hkm4QX7/+/+Js/RAEDmBkm41
X-Gm-Gg: ASbGnctqrlMS3DkNha+gG+ODakltbncfpCGSL7aFLW9hv5d9oVEc/x7nXDdvMKH6esX
	RAYc7DlgiEOBRN7nkYRM5rNPTt3F2gvgtoahu1G06nOIk4ZUbKrGOlv3Xg52RMo+KcO/uvctqL2
	LoxGNv+9Lsjxkr7jKH83IO3eMGR9xF1d0/UcqeB7YNw/Jsuhy/y2KyMkJ8K/ENV5nLUjxl441jL
	nILLpgMQh4A82lHRtjUBG5/KhV/e4DwHMe2ynqwGxSbbwJtNmFa3DohYP0raJEDNIhYXOkVLWNX
	384GdVAdQ1hQLQSKWdBl2uCfP7cNPB1PEEVdFSwuMp36ANJNzDTTUlAMNsN4RMTnTWoL0ry5I2W
	4pg0qrmf63OBqKeg00yCLN/IJrh2YicsehJCxndhI4NjdsgIFgE/RQMCDaUE8rUGocIN+vv7R9A
	==
X-Google-Smtp-Source: AGHT+IHxC+kmVUhZKx8BbrHsNUwmheKfilrtzu0NtWxS3jwNAmYLNyl5sct6HxLhHPEwNHl4qIBmTA==
X-Received: by 2002:a05:622a:1114:b0:4a8:18fd:fd2a with SMTP id d75a77b69052e-4a85bf69b80mr53998271cf.52.1751387239903;
        Tue, 01 Jul 2025 09:27:19 -0700 (PDT)
Received: from a.1.b.d.0.e.7.9.6.4.2.0.b.3.4.b.0.0.1.1.e.f.b.5.1.4.0.4.0.0.6.2.ip6.arpa ([2600:4041:5bfe:1100:70ac:5fd8:4c25:89ec])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57d530sm78032551cf.61.2025.07.01.09.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:27:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/3] rust: xarray: add `insert` and `reserve`
Date: Tue, 01 Jul 2025 12:27:16 -0400
Message-Id: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGQMZGgC/x2MywoCMQwAf6XkbKApvvBXFg9ZGzWXKulSupT+u
 8HTMIeZAVVMpcItDDBpWvVTXOgQ4PHm8hLU7A4pplO8RMLOZryjFg83NHE0wTVfiTgfz0wZvP2
 aPLX/v8t9zh+xMsGIZwAAAA==
X-Change-ID: 20250701-xarray-insert-reserve-bd811ad46a1d
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1751387238; l=666;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=QQ2aSCMKAO1QDeQotHKimD7/9eejXBabA/tAb+LKHdo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEQUd2YduvFwfOVKbXlpDNmBqkBI/rF2LKj9l/IICgYOws4KMg90w9AnSSVSXN2q6E0+ceGIEE+
 Pe1gh1zwQXww=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Please see individual patches.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (3):
      rust: xarray: use the prelude
      rust: xarray: implement Default for AllocKind
      rust: xarray: add `insert` and `reserve`

 include/linux/xarray.h |   2 +
 lib/xarray.c           |  28 ++-
 rust/helpers/xarray.c  |   5 +
 rust/kernel/xarray.rs  | 460 +++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 472 insertions(+), 23 deletions(-)
---
base-commit: 769e324b66b0d92d04f315d0c45a0f72737c7494
change-id: 20250701-xarray-insert-reserve-bd811ad46a1d

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


