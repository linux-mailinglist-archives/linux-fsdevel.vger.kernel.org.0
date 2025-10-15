Return-Path: <linux-fsdevel+bounces-64295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4A2BE05CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 441174FFED8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2830596F;
	Wed, 15 Oct 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbCdb+fM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1078C30DD0D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556308; cv=none; b=QCPChJLsxBrIV5Km5+l9i17kY6Xqgk2WWEmAiGnQhz6GNzmmKgcIp4SkwvOEvLNpIfnrV+yVTU3yhMo86nA/6KC+BXxwMig97q6WI+iL9IjFxQ/e6sLJFaQHHL6YqESA8wkL5lG9kS3dd61t7f+aA+fH8fIkqOSsPMYZ8aHF9oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556308; c=relaxed/simple;
	bh=/6FAAPliz9JMtIVhSN5WM1U6uwaxaWrmdWOweTW7QYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFbDDsKackrKuKGfKteY3603X7L3Gomw+0kWhw/HdIEC/kQfOJNeoo0gg+AIe1yItPi5nhV6pWGhiz41spiGv/3qmtsIEcyz/wkZlXhqwd9Y7RuIZpAeadNt7kcPrIHk4VPenoH04Do3+zJnuNpLubYe89hDiww5KCc/NK3qE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbCdb+fM; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78febbe521cso94968046d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556304; x=1761161104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+cfNHruMdPBuLxqLR3jBeCuq6DohSxciPX7+EKAG2M=;
        b=JbCdb+fM+OVabHRFA0Q4ek4JESF0QVGj+1Y+55BDVoMky/bZJokq4LiZQoOYNJo+6+
         7DXUahkxmMERzwdWQZZs0E3KcR3RoK9s/8h0Ro47K8vtrh75OjVFVQAJyl9PdUQBRLlj
         eYJ2bxdgv/4W8p/VXKBJS/lc8Yfrt4CAAWHvxgzjEGm1nCS36OGdoDXpkNW7EQmDMLbt
         r4kuh0925ie7RHRpBJJg+q9zIL+DH58iQIoxaZhmC9Ov7bIgBvUYv6/YoumwSZImbTjb
         cda9nCeWjILwA/5qrqhY/1Q/tGQs6JlncqJi0o0Y/N0marbQ/O0MGe9fiqmkEhmPQ1P7
         i9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556304; x=1761161104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+cfNHruMdPBuLxqLR3jBeCuq6DohSxciPX7+EKAG2M=;
        b=jeogSYegxJzskc2X1Wci/ul57zGMukE+K/PKAV07ASv0pxiwNQGDauwvcNl6iF6REd
         yIW3kuJJQGJ5n7IWiMfoSE76oP7U0FfPBkBKYNKfjAcspkQHXaWbH7X/1GZVsPjZMJrT
         F+wnBD6yQtGo2PPqnEK010uEb6goypPSf5G843BPZpRDJ0zu8ga9lRS53mcoMRQ+SsIf
         kvSbLJNcSQuY8YdoNRxNCDKvTZAuBxnZXWgZhcN3B0dm+nbv5j3a6K93r4GWBFsBK9cf
         TxvHk3hx4A3pn4PzrekK7eq7oRPosjpcVf1mPO1tre6s70v+6tCersNgOU6jjI5JJbOC
         g+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuMupKYGTsrZAvY3u0atiYsB6HZ8W8eiyBGM/Zk7TkmQRPBX816nze0QKTIKgZyR9yNWpY8n4nS0KtmLaS@vger.kernel.org
X-Gm-Message-State: AOJu0YyJVqGc1NiRp3MsQwTEceqhUyAZPqbyKP0L/VyJoaPY20M6kDbS
	iMAbL7ltubmyHcPRLXUT+yZGS89zMIGSAQwmYUjqy41kiQzhbR1v1hCh
X-Gm-Gg: ASbGnctp2+naU0V+ZgNA0u26Ioa81+1IdoKrpl8iGRG/AEOrMkiZ7N7vGiII1YDSXUj
	Y8uwLdwFQcOmOC2qwiUioDlTG1vu23VpcXzwopnYE0cWqjqaRzjHBHKJ4by4vjzkgFLGg1SFsDz
	pKMbngzEK1UwtmUzdNRUBXP5Nq98JQSwKbVs7hlpK9pcR88K9cL/BSLwyfaR/z9MJlObD73BZfx
	MNnn8XlgOgsFIHfJjv+3CQJYPU09uHu8PVxlVZAtTADKfUxbjyd765tf7LQFtwIIOju5x3CFYJ4
	i3ZNeMbGmBDrXskXN4oZLuOgUhnCSGFfwQ1aUzUOlGY9h89v1N7gHuuOKbuPpbulwEVm0fyd7C9
	gBsoDaB30nQnHhM8ypgf+G1PQAJX9wCNzI5ThIdmyErQN5aSmaOFEWbRKBIljvGOrKF9hLbRD2C
	nx2fXzpOwRd09q11E3fIfTLGbmp81o1bv+AHKT7qh2iklQwY/4uUvqICHLoP5RsbBB4gUYoM7gZ
	zt8Mvy73AjmGLCaA1RSZGI8YqGm
X-Google-Smtp-Source: AGHT+IEX9u1kD253LkrUXYqr3dEKSTO5L1DiyQsTG96pQUi26l2qBcGyddQYo91Es/OcoCoyz3pFyw==
X-Received: by 2002:a05:6214:2b0e:b0:87c:115e:47c6 with SMTP id 6a1803df08f44-87c115e4a3cmr1082086d6.60.1760556303575;
        Wed, 15 Oct 2025 12:25:03 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:03 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:32 -0400
Subject: [PATCH v17 02/11] rust_binder: remove trailing comma
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-2-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=933;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=/6FAAPliz9JMtIVhSN5WM1U6uwaxaWrmdWOweTW7QYA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH7AeKnZyD8ngl4+hPz+8Rz7zx2cNxYrkgP+Fzg1nzu/J1gZ5lAhrwaQqIaNPJOGnMwEnAQZVmN
 mf304LMVVag4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This prepares for a later commit in which we introduce a custom
formatting macro; that macro doesn't handle trailing commas so just
remove this one.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/process.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c..d8111c990f21 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -596,7 +596,7 @@ pub(crate) fn debug_print(&self, m: &SeqFile, ctx: &Context, print_all: bool) ->
                     "  ref {}: desc {} {}node {debug_id} s {strong} w {weak}",
                     r.debug_id,
                     r.handle,
-                    if dead { "dead " } else { "" },
+                    if dead { "dead " } else { "" }
                 );
             }
         }

-- 
2.51.0


