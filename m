Return-Path: <linux-fsdevel+bounces-64578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA7BED69E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E5814F3FBD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C012F6579;
	Sat, 18 Oct 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4d5twMq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFB2874FF
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809563; cv=none; b=bYiqcXqNEzyAV9VLBi4iZafdsNEnuy7pJp11ubGFm8IGairAlitBmPd+WRFtirMmABpijdihrcM48pOt0iE53SStQ5M2DjJ5gNdZxEMP+gDB+NlngmKB4nLXr3/x5m9UjYGjSPztz4ieN1cA9QPdXpibp73b1Td6cL+utK8jxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809563; c=relaxed/simple;
	bh=03bsWp5q/RvNg/sXSrzNos1bBBR49+qyJdq4+m4Ha6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MIcm+XGRtaSijSgFvlFIth61mGtD9e8/MvuTHL/Umbx8GFIkH2xdDaKz2ntQfIArKz27Q0vQUXF7Fg9jJlBuJHdcYTPoKHalDkg85Nclnk/s5RM3GY6hioLIe3Bd3MRKak9DDadEObgp9oxHdJFr0X/sgkS7tqRkMlyvyFRxBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4d5twMq; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-890d9981983so330120685a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809561; x=1761414361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5WimfWZlEqiYHKzfmcAckTYkDvTe0+bpTYNTmk8aT4=;
        b=B4d5twMqq15Bm4EX95wI9H+g9Jr4ulZ0Z2Blp27d9tlkapDkfxPWxVvAX3MR5FcYD1
         j1C7SIRD1af1Caj62Q0lteSNdf3CpvaN7soagf+2Rh6DfU1ehN+iYXDRlJM4NYLJoR/8
         jKmLVTuarADNH/eQhdgR3DKmZ/bVA98jgdLCnCRjqJdeZ9ASlFozjb/Skv0W9xczvSUX
         5tSIAmas2MIlcs0es82VfRqbFmPt2zDg2T4Z5u2urQBT2siO60YzSSZ1PaCqBdGpMcP/
         pD7KQwBQHFgvXeXTpNVJX3x3fXFu5zj+ZVIKJHizeeg2I9b08xEwSIuUmKYSPa7s3u4V
         bCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809561; x=1761414361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5WimfWZlEqiYHKzfmcAckTYkDvTe0+bpTYNTmk8aT4=;
        b=HJiipZtuzZmrQXWnF4m/GxRWtwyGqH7pO1MwLGJtaoqPYb+YHswhe1xkxwiwQ0F1O+
         bLHIbG0VReOW9AB3jT3PEBZgqTKaf5YmTsKnZYy27SmdZXyeOK4TGEM/lY1b3Cug2nrp
         YDS07D6TvUrVMOFVFvUxIeCsWzibJvWLNud+ODminq7fsTQUSHJYI1BZe/98V+9K2ToA
         NeEvBtru9PaIpGbasbE6Cm336RMJHiiGbxhXDQa960kGhsmL2HoaxsXqa6ab+mbvf+rk
         r86Yc0d+4z8p1jMIJx/tS+HJClhoYBXgUouy1Pdb/pZrlDvGgoKjlkvz8pcGyrRc3BPo
         6h0w==
X-Forwarded-Encrypted: i=1; AJvYcCX5QOu/LT1ipRmvMRS324hnCSi3K41atxSFhM/g4ipCRwNrlS+eAF1n1Ps1IMSreuQ3seeR3JLAs4M8jADl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Te4vYYhfnYBqlFB5VUvGzOFEymdMjtL5SG/rJdwN8Q3r8/C4
	/B//vxdTloVZ/FOoQ58b0ZoPeR20oHLm2QVpsSUOIwR9aEaoqfSyswt8
X-Gm-Gg: ASbGncuYn7f0Kyf+rsUcoWaKEMm+DGSnRo8Y3R2tJ7oMX/6Nt/yTEje+G+K2csVPWsd
	YSR3XKHi8HGXNTtkcnpJ+Kb+iVoeiBeZZ+2rJZaiKUWoyyK8GfqU38ZvulQbuUK2AJjnAuH++HN
	D3dYnHCZlSJvsiT8GF55vBzQk+RCTrU4mPNqw8DFiINpkNcSgdLMpMOFNQxm17zw0zRAE9JJut8
	FV8i00f2zbvw+Vkv/FT87oJGYWtaE+y+Ju3iWwrbYhClYH7X9xT+ROgcK1Ca+lBbMO9IZgIJooM
	b7Vk5FhKWaGkue6GK9DV2w/T/yISBlHWUt251ngBpV49bigS050VL94W1SdEgiYR+5CPbKT5geC
	uvG7EsiKedWcn8cbmGjC/f+Hg9eWbKrC/iH+xqvbSRpp5Lpk0tKtSokK0iji1C+qaqb1EZrBdsY
	WjMTr4CVOUeJT7xENKnXPC7ETvCPCw8im099Hkh7uyKXLzLEU0KaxGadqjz8Z0JX2BfH5Wcrsrh
	s+NLVo5ezdpAL0BvJZL/PHU/J5Ng0QEC7hREBHp0GEqjuwDiZodoVXE9c/TXGU=
X-Google-Smtp-Source: AGHT+IH8lweP2XYB08E+inbzDnXw7d9uWVgrdDvTnlgrkRHMKVP2lag0JhfKwKbfvNE1zYcp4Zi2rA==
X-Received: by 2002:a05:622a:15cd:b0:4e8:894e:1345 with SMTP id d75a77b69052e-4e89d07d9b1mr104925911cf.0.1760809560785;
        Sat, 18 Oct 2025 10:46:00 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:59 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:19 -0400
Subject: [PATCH v18 08/16] rust: pci: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-8-ef3d02760804@gmail.com>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=918;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=03bsWp5q/RvNg/sXSrzNos1bBBR49+qyJdq4+m4Ha6w=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH27Y5uAfTmrvKZIdGCHYL/oomYMJkFLfNEOLtlLtpxxDPHsRr1ISH3D/10dPkATw5kw42q12/O
 zIe1ETaFKVAY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit ed78a01887e2 ("rust: pci: provide access to PCI
Class and Class-related items").

Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/pci/id.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 7f2a7f57507f..5f5d59ff49fc 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -4,8 +4,7 @@
 //!
 //! This module contains PCI class codes, Vendor IDs, and supporting types.
 
-use crate::{bindings, error::code::EINVAL, error::Error, prelude::*};
-use core::fmt;
+use crate::{bindings, error::code::EINVAL, error::Error, fmt, prelude::*};
 
 /// PCI device class codes.
 ///

-- 
2.51.1


