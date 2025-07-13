Return-Path: <linux-fsdevel+bounces-54771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE27B030EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 14:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEE23BC840
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6093827815C;
	Sun, 13 Jul 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAPSa+Z/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B492259CBC;
	Sun, 13 Jul 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752408371; cv=none; b=GM4NCOUgJuILCMbx+l2plreNQL59V9Yv+00vg2EksLPstlqLdvSrAPRMWI974dHW8zTKEKypdnK8l7/zVNxUioCIFIV9HvND3c+pyVP23Ovt7H2hU1fgRf/WeQst1heQdw/gwlzYn9eZTZ6VAMVdoFMXbeSQFkM2VJvalHxhxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752408371; c=relaxed/simple;
	bh=8A2CU0aMX1NF93vpyoZnL0IilMix88STLXyIo8C2Tjk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iZGvFhgBQQsFcf/ZwJdC4HMQg02GP4qn2q8HtJJOONmkas7wsvMiSA5xscSh3SInv1eyQg83AoZFXtshxb02WlFd6rpj/TKr7by7g5TIGIhKI8X+G0leLe6clZLi1bC7DF4iS0dMlmLh74TCzlJ3jf3QLHU/wqDE0tXtgXzoEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAPSa+Z/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a7a8c2b7b9so47773391cf.1;
        Sun, 13 Jul 2025 05:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752408369; x=1753013169; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5wY5DLkzyddb5MO5enn9Zdp3qtWqv34wIpy+C05jFQ=;
        b=AAPSa+Z/VQu+/Jtxickb9oTma2bGOZFXSiQ4YBfwzbbJwcT+RbEMEYN0MFLHSbkR+o
         3iF2l9o1pogCZv3cq0bpWq3JAQUsb6Mdicpm0wMYJMMB+PShcfPii7lYTlajy2Olamnr
         fK0cV+K+y2jTe9vahPbhJjD3OCRjONcU3ZTwdI2mSCM1wdFD4J1ozR/HgZhq1cpdKY/8
         09Ngv+6P2sRGMpXa2giCcoYmvQZY5G4++AjDL1PmvMHaZe75uWuENiHfnGlNJluTW5Lk
         mRh3+C53xZ7tOlAm71H4FuSSMDA0IMvLsd0ELmhZmPiOYcIQtPO6X1d46gRIl9ksjSc/
         WBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752408369; x=1753013169;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5wY5DLkzyddb5MO5enn9Zdp3qtWqv34wIpy+C05jFQ=;
        b=ad9QfU8nkV9iPLKVAPJyYOH3Uw4sB+qgmfHhLEN18FDdndLzYM6sfrRDAmjKwZHABM
         v3t5c/yxh3u+PrvT6PN8yDOCttKmRcdX7K6cLx0BCcoVE9oCVY/5mveM6REtZh4pVubA
         Je589hxxOFSx1eVZ5GnzqU+rNoceRXkF9mzxVkwHQaJ93Y1VbBUfdMWDLj3vLYHCL95A
         Hkb3QsAwUxpV377dmR67HrOLsHhH0sbEaXRyRsXc9ialOXCPeZHRceEJVVmCA8Xvuqss
         MsYFhBSkwhg08qbp3oKhIAk3Zo0nBTB4BkueKPZ0a6dZl14bEpG5VfthrNNSDkUcpvO4
         GMYg==
X-Forwarded-Encrypted: i=1; AJvYcCVCFoU/SKbHddAkWKtUvdkTrSMjeNSGZYSQAbusMX2GGxRClIkpVOhilpcc6MDK6gMUEx43b4jW/goZjARI@vger.kernel.org, AJvYcCXejHoPfx7mSdA+D7LXnzM4dAdO3Z+p4uJe+O3p+Z789U8Vltjw/JM39koAMU7ONwS+QQpsRgjB/LkwTY9t@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNEMcP2oCDv5lNQftdNEFuU1rSRSkFgjrfwdO1q4hHYY3ZWFO
	cMeV8aAo08zZ+TnWNojjkI5tL3JluXOumsXhixaujZakuY257dqaQuVc
X-Gm-Gg: ASbGncs97V7obDLl4ps3z+f/MOlXv76bgnd+hjyjChcfjKKXv1e5E7UE8ukWdy5fAhp
	uwzSHzlsSyTqIV4tqCZDVOklrVKF8+sk94U7v3rrGFhpSsAhoHIW7LGTu4v7LkCzSmz+8jAJAC/
	xpiZJCzlVEyxvcbLMXRaPFCIpnDcaeepYT2q5XISMpONB0oSZpq9oyHXZcTLMRhP9Ub0Z0f+4yA
	ggiYAHulJ/UnWAlh02W1LYlUXTFVoGvjddMa9I/8mWoJt4KczUM4YTpqrW8lratBJq4KotvjxnT
	uVdsl3EbW8ReUhJmA4TK1by7mhIKebxuJPa1fa1OiIaqKZVSIaT7AgvwJeyV6/h6RfEwu1U/kNI
	iSRibBclaYbqM2jQx6vv7+U3Agt9/9DPBEg==
X-Google-Smtp-Source: AGHT+IEyr8Bot4bW7ek0wTRHNCSY4sqQt/8tvDYlyRMheS1Dz5VYhBnyP0aHQxUJftLbaXZJYFAVJw==
X-Received: by 2002:a05:620a:1a29:b0:7e1:9c2d:a862 with SMTP id af79cd13be357-7e19c3ceb60mr453735885a.39.1752408368922;
        Sun, 13 Jul 2025 05:06:08 -0700 (PDT)
Received: from [192.168.1.156] ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2desm39706261cf.72.2025.07.13.05.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 05:06:08 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/3] rust: xarray: add `insert` and `reserve`
Date: Sun, 13 Jul 2025 08:05:46 -0400
Message-Id: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABqhc2gC/4WNQQqDMBBFryKz7pQkVC1d9R7FxWhGHahaJhIUy
 d2beoGuPu/D+/+AwCoc4FEcoBwlyDJncJcCupHmgVF8ZnDGlaY2FjdSpR1lzuKKyjkiY+vv1pK
 /VWQ9ZPej3Mt27r6azKOEddH9vIn21/5bjBYNutL3rjW+NhU9h4nkfe2WCZqU0hf+n31kugAAA
 A==
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
 Tamir Duberstein <tamird@gmail.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752408365; l=1285;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=8A2CU0aMX1NF93vpyoZnL0IilMix88STLXyIo8C2Tjk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCLoTgBvEHahT2dYa7MEWkkhIGj4Uc/WV9TbQJ6JuXLaIkLgXIa/FLUOskUmEMkZwWLJGTUGXNm
 6xcYENA76RgY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The reservation API is used by asahi; currently they use their own
abstractions but intend to use these when available.

Rust Binder intends to use the reservation API as well.

Daniel Almeida mentions a use case for `insert_limit`, but didn't name
it specifically.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Explain the need to disambiguate `Iterator::chain`. (Boqun Feng)
- Mention what `Guard::alloc` does in the doc comment. (Miguel Ojeda)
- Include new APIs in the module-level example. (Miguel Ojeda)
- Mention users of these APIs in the cover letter.
- Link to v1: https://lore.kernel.org/r/20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com

---
Tamir Duberstein (3):
      rust: xarray: use the prelude
      rust: xarray: implement Default for AllocKind
      rust: xarray: add `insert` and `reserve`

 include/linux/xarray.h |   2 +
 lib/xarray.c           |  28 ++-
 rust/helpers/xarray.c  |   5 +
 rust/kernel/xarray.rs  | 533 ++++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 536 insertions(+), 32 deletions(-)
---
base-commit: 2009a2d5696944d85c34d75e691a6f3884e787c0
change-id: 20250701-xarray-insert-reserve-bd811ad46a1d

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


