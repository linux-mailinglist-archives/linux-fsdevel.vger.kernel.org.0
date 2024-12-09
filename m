Return-Path: <linux-fsdevel+bounces-36730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C769B9E8C21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 08:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8371A28301F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 07:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558BB21504E;
	Mon,  9 Dec 2024 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SvSD9kOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D7221481E
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733729272; cv=none; b=QlatYyyssSp5M8r07DFUgTGAMp4H0Ld3Mhv/ZCsNuFIKmN4xsJ3bO05z70s8QUqAJs3zgKgsmMFGvEOeQSyvfz6N2coXDzHnR/KHFActvmVkrpRCuGNlHFI7nuWowz/rIfFgvn/V96Q6e71jMTtWjtTIJU6oadH0pfCIZwAY9bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733729272; c=relaxed/simple;
	bh=CzG4LCYCgy1J7KvD3L4+YV8+zVCLxj5TTFerWUZmz3Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sjdkJuMCDSKyVYASD/IffnkgpuC+Z5Ll2CQHGBq7OeNsSJoBz7VVaouurPdRVCV3fd3Fr6a3q6ztJxVMbkR0K3XOtXp9B978STuq7Qrxrpe65HkK+EiPArypUQkfvbz6IwKbZktxUu8cFQqKBGP51CplYMzHXD6pU3GQ9+3XMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SvSD9kOP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434fb9646efso2781835e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Dec 2024 23:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733729270; x=1734334070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lYqKVBlUL80Zd9rsetNolMG8mIV6iaS5axJEolGX4hc=;
        b=SvSD9kOPcmlTS90LXEujnRZXRlcUNsLj3w8/mw9sblwx508qbrNs3djECXM4HtlE4T
         rkPb9NEVkuoTlXUj9TdLCwotRt1akONaJMdeJHJc7Bnt0u3Dy5zhH41Eb3QQjSodEERN
         fDwhz+/4FQPDhm++qHu/GbKm8z1qiB69SjcyF6OkwoHt9BXaUu8I7kkQ2ekIzhdKkw6j
         RFuh8sgKMUMlQNkBiKtonPnEzKqMqbDQrD6EtVr8uvEND7dxFtRQO6r79gpYAmo0kmpI
         UgxsF2l2iriOOKupUWr4dKqUD7m1jyQg6LhsQz+Wq+xQNjfbG+Q87IFRzR7/fs8wMPFV
         WrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733729270; x=1734334070;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYqKVBlUL80Zd9rsetNolMG8mIV6iaS5axJEolGX4hc=;
        b=EVQiuvnYy0zKMdJdnfIr2LDEZ7j/12aUscLmBLGtZxBCOjlHGpklKJEwkLfplTvB98
         sONMmgypA4+d5kvIlGS8SgegX+ZlO6TXjhCfmuTPOSbNVQ1cjx8B+OLt03EKZpiRi8Sk
         PvOoIDVFrQYdDOK/VfKWzng6fbUf8MrDQBdk55zucE4gKfslraZfpLp4cvBmGOSg3y6y
         RmRkGy+BNqjnVvcD6ds+gCQ5aJVKdooFW72dNqNV6uoB0kxyG0qusZ1tRGzh+gp+kf/d
         kT8h4Tgqz3F8B8xx8KYRrtzs3Y9/BxA8vwPl7pgtaOWYnsX1ixKFGh6QwERBGDWQ5kFv
         wYAg==
X-Forwarded-Encrypted: i=1; AJvYcCVy1g3wAJ5qaTsO1utoc3FKwnw5PjRWa860plJOg2/x4L0QYduoq2exApdxjSB7ts093MGGKu7jqMNWP/KN@vger.kernel.org
X-Gm-Message-State: AOJu0YxCJBDqY3PnIoS6fLk21bFOIBHZdiQQmhPPbvbIR8OBQIcYzxuO
	lTmCjKq8QAlZrKLnMmHqJBTRC/f/Cwkhg4mkQyJWhUolexArpeuf2c0jplQyHWjIjEvvI+jUYQe
	Dazy1OKUS7jU4Qg==
X-Google-Smtp-Source: AGHT+IHLip+cWClqTDmOvhFKsS3OnDFtSGJSQAvn2hFaHftIrUei/OnvvkIwlZEReQn9AZ3pcDHXxEmZC+fEB7E=
X-Received: from wmbg8.prod.google.com ([2002:a05:600c:a408:b0:434:e665:11a3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3544:b0:434:a386:6cf with SMTP id 5b1f17b1804b1-434ddeaceebmr95173205e9.2.1733729269824;
 Sun, 08 Dec 2024 23:27:49 -0800 (PST)
Date: Mon, 09 Dec 2024 07:27:45 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPGbVmcC/4WNSwrDIBRFtxLeuBa1+diMuo+SgejTPEhi0CItw
 b3XZgPljs7lfg5IGAkTjM0BETMlClsFeWnAzHrzyMhWBsllKyS/sZWSsTVokDlakO066pV11g1
 u6FQvrIba3SM6ep+7z6nyTOkV4ue8yeLn/lvMglXZvpfyPqhW8YcPwS94NWGFqZTyBaXYGhy7A AAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=765; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=CzG4LCYCgy1J7KvD3L4+YV8+zVCLxj5TTFerWUZmz3Y=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnVpvyxYWPC/5hiHYX4LjZWZlV9uJlUfDGKM9Ix
 hFy8ZcDj8uJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1ab8gAKCRAEWL7uWMY5
 RqfCD/96mpl99n+3ADLxOsLLjsqfGfh+No8JbR1DG3S0Au+2tmR3fKhTObeJduXi8+oGhA07xAX
 bSLgLSOpXdCev0kOHCI2pFeE1oqQdOKZdUuFyc2o9+7DmoroSpSmbg9qMeSTQ3xelGjY9Orqc29
 +fVWgY3b1QhZ/4yVUxqbgxQw1QLGZPAVq2Zoosu/FSxAU4lc7zfDlj/NLw+HJFcG6nJUqdDfOzj
 ZvLKO/LVwWRd4rA7GfnCFjrwN9wJbafe/iTHfb8lyKphyLmh+fv6RMy4XbHAfUYZixDf4mYF64P
 ohXlRu56/+EHQUT6sSyic1hvfUZlTedt+sp0YWb/Icu6qNXxepBcy2nygv4Ki5gf6Xa9s9zpdxP
 ZieyDyoBmxCbu7byUM1+hhxaO3rtAByvRxHMQL0gVOHtHRlPfVY9vOMhV2wOmZUaTscVszoY6nd
 0YXoTaa54+QF6AgDBgpPQIEXxtFqMFeyw9vdYwH5UnXihtFVo3GcO5me3BDOGGtEmIEEn1l8SBN
 s21NKcDSThZBDDcaPja31Brb/mM/dKzenZUrb7wgXzfZMag/0yA7/NiD6IHbRblqCCl6slPjV1U
 /syVR69xSlZEENd4G1gLDkKwcnLxaLbGbyfgXkSbF+MeEdu53pOA/4zaLqoDP7vJbrFvWxc0NZa C6Ow/qMx4zn4q3Q==
X-Mailer: b4 0.13.0
Message-ID: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
Subject: [PATCH v2 0/2] Additional miscdevice fops parameters
From: Alice Ryhl <aliceryhl@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This could not land with the base miscdevice abstractions due to the
dependency on File.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Access the `struct miscdevice` from fops->open().
- Link to v1: https://lore.kernel.org/r/20241203-miscdevice-file-param-v1-1-1d6622978480@google.com

---
Alice Ryhl (2):
      rust: miscdevice: access file in fops
      rust: miscdevice: access the `struct miscdevice` from fops->open()

 rust/kernel/miscdevice.rs | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241203-miscdevice-file-param-5df7f75861da

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


