Return-Path: <linux-fsdevel+bounces-30440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE4A98B6CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DD01C22179
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5F519ABC3;
	Tue,  1 Oct 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBAHWJ0d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEED199384
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770977; cv=none; b=dX/yv+DkuFvRbjWvdZN+ZaGcNsxTrF7o30fxWZGqM/9ZU45lU8GuEjNxz3VnBMvOS+Lay5HdwXILgHYxlHsN6jWAfa91Tmc5qcOplmFVwQNIO0WzOCAmO8v7lKMUlDatiCzZGRMcgLCvYWKzajhtWLM4iFqRoTfNVGgPRyVyRBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770977; c=relaxed/simple;
	bh=w0JowvTi18hE0GjTdH+6npiDuWzuRMfG9WyYKf0+FjM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J1q+RaK3Sx4MsWdtK/RG4dTMM2a8j8p2Leec5++ygU+F+aF4odRQ9DY5jmkMKb/jepuhXimzDAEgufe+YrtSccY+/fXyjaxMuZuneMeFDJO/fDx/nsxXnTBStPp0sRDpnpd0Xkku82b3pO4ffr7aUnfkRXBcP5KeFVklQMvDhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBAHWJ0d; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e28d223794so20249057b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727770974; x=1728375774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vBOonmtWpafiyH2KcYIhhWKcRFN+NycMirinz9XzCfs=;
        b=DBAHWJ0dVahW02xRQygv51duz+2+B1PbuIRaAax33+e2cSFKZ+pEHpXDgevqqs3P8i
         VM+FoInXgFDAj0mPfIsW35mfqGfjsFw03/NTl9HCZVjk0AYsagTRGdbUjTj9KEP2NSBK
         sFQgI7+Ls3ItCbPDqY2GZ+Ht7pF6TV+a8kIlJuLIEe/7IIf+LmMsDR5+rmp1VPddlY8t
         /8ySQyeTvgywYPZaS4XnlSW0FlCcrxjcQEBtr1aU1PoIl15ZrLEC3Eh4KTqdE6ZESzkr
         6GZDrQHP7K4aEeWrrUHb+6kyre9HvYUVlo7Kb6/wFH3GFXMeLQeU27zE3rO12pJtSP00
         mC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727770974; x=1728375774;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vBOonmtWpafiyH2KcYIhhWKcRFN+NycMirinz9XzCfs=;
        b=ZWcLmgGbAOVeVvkQ1184VLyLNnYn3JidgI8OkOq7u1dnYhPAicY1STGUuVIuKQRTNs
         +Ywi971/iQHzJqUaFdXoaR7h7g2O8rueuEIHnjyioFWrtPhTo+H3qq6NfZegUeB4s71Y
         y1/ytR53fpnCIK+6O4grMzHmxSfK7J+bq600QQ0kBt7nSa4BxM/4pZ50dJtl3LZHji5a
         VVfUzEBqDKnqE64yWRpFqbhVdwp4unLrpv2tJA4EtSyu9tcryyZlj5wsllWPzI6GEyBU
         GBLbRzTtx0n24wCVEYUkn3JDVpx2eNvg5pSYmZEaxPfsTi/a8wLKU+iWB3HCH+uscJmc
         I8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCW41/ZZ2WP/70++6/vtjmD8SgtRii/u1Xj5yokepZyWMF2WveqGbZW9upB106MDWsWJv9ZIgIhpsqGMas5U@vger.kernel.org
X-Gm-Message-State: AOJu0Yw24cFtuV3H8DqAQOYEkeOsKrOaEat+0iWbUqPQM1tJjKG1WV4z
	2oY7Zz4BZ2WzRjyjCT5I8bWAq/IPV8AYi4GtI6Pgysl8+mn6NLlEtrR3ZvINcblNYN5EE0FzKSh
	9GSS3hd+R3QDKoQ==
X-Google-Smtp-Source: AGHT+IG6wu6+2efyawGGyR8gji8j0eXJwdgsrvU6tNCQRfWj68OrfbpT0VGloVv6tfKIdSxWrJSXJjni57xjWGk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a81:e349:0:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-6e2473994camr567347b3.0.1727770973742; Tue, 01 Oct 2024
 01:22:53 -0700 (PDT)
Date: Tue, 01 Oct 2024 08:22:20 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADyx+2YC/3WMQQ7CIBBFr9LMWgwMxLauvIfpgsK0ncQWA4ZoG
 u4udu/y/fz3dkgUmRJcmx0iZU4ctgp4asAtdptJsK8MKNHIHi9iNGLl5Hz9OhLYWzn5zuhuVFC dZ6SJ30fvPlReOL1C/Bz5rH7rv1JWQopWm97hiJ1u7W0OYX7Q2YUVhlLKFxgLn2+rAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=w0JowvTi18hE0GjTdH+6npiDuWzuRMfG9WyYKf0+FjM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm+7FN47Gj4EzpbLLAwopu3PXd9G74m8EUq8Vz/
 sHFIn+hYBCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvuxTQAKCRAEWL7uWMY5
 RgBaEACOAVNHDr8moNOYZ850uLhFL6UznHsqmhQkVEQvIaq17Y/4Qh32WhY6Yw67+Lp2G88CuL0
 HwuG5IwKvSXTAkqaBLOla4TdYBGRFqkrQofDJGrZpItYD0PDdRQDndcrNdzRZH/u5PayrfJM8vf
 7nviBgZW6r8cAYYC5azZRpO10seopLLTNH4dXnIk1hQcdQ/ciGM2C92e1F++ZJDSy80a5yPO1Yb
 I0f4wOPma4/YLnqsrE6iRU84ycfbns7DHV+DP608bNyFOn7vPj4QDvCn4HPQh6q1vM6ReVcqUlL
 SBdBv2uG7vSM6kucI/Oc7pnOYDRgBY4PBEwFVJYXJ8OwYpbiTDJPGaI3UynWpbpUJerUzEm5Z7k
 cHRXGBKRBT5xTejCTUnilIZ/zM3mBjukCibF56ZJ/7O3dsjE3tEJdFN7Bj2oWPooOLIglM2ceoh
 xYxeTiJ4lu/IRFiXOAc7re5nxQKUELXxPaTOl0Oi2BCC4dbzIAPLTfvLi1ZRQikqIssxm84U5wo
 Bl2pUWCTGMGoNvnN6b6SAlwclyhB4N4uJQivqZHnjvNAmilyGNTEcZFubRL4ZzDUODm4OSQTGuQ
 C8aNUyAcHZseIE2/9WHW02CP5KeenEV0LxcuC3Mktgynjk7f5vvSIw5oVjPLaNSuxorBKlfLLO9 afxLPRu+7y6qXCg==
X-Mailer: b4 0.13.0
Message-ID: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
Subject: [PATCH v2 0/2] Miscdevices in Rust
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

A misc device is generally the best place to start with your first Rust
driver, so having abstractions for miscdevice in Rust will be important
for our ability to teach Rust to kernel developers.

I intend to add a sample driver using these abstractions, and I also
intend to use it in Rust Binder to handle the case where binderfs is
turned off.

To avoid having a dependency on files, this patchset does not provide
the file operations callbacks a pointer to the file. This means that
they cannot check file properties such as O_NONBLOCK (which Binder
needs). Support for that can be added as a follow-up.

To avoid having a dependency on vma, this patchset does not provide any
way to implement mmap (which Binder needs). Support for that can be
added as a follow-up.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Remove dependency on vma and file patchsets.
- Remove mmap, llseek, read_iter functions.
- Drop file position commit.
- Reword commit messages.
- Link to v1: https://lore.kernel.org/r/20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com

---
Alice Ryhl (2):
      rust: types: add Opaque::try_ffi_init
      rust: miscdevice: add base miscdevice abstraction

 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/miscdevice.rs       | 241 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/types.rs            |  16 +++
 4 files changed, 259 insertions(+)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240926-b4-miscdevice-29a0fd8438b1

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


