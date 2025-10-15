Return-Path: <linux-fsdevel+bounces-64301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23994BE062F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A6F189A3C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7686D310631;
	Wed, 15 Oct 2025 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMrVogHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A030FC1B
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556321; cv=none; b=UutytKQ1vOl/+OCzCmXKgHu1x5qRhODFic79YcfBkba52ufRCe4fFvZz7YK42BJwVaD1ahmFcHdqfeoHkFd6ZzWl96Y+Edyh4l00vnnBWrWdq/lYmPwfs9cRV5nrM2STyU+jsQ+hoftWvfSN6cC+1YuhzH+5OJ3BecTlRroNlqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556321; c=relaxed/simple;
	bh=Kd0EzPTdfyblnmo1RxE7jLLbIDYVUJvE5DzKX0nK5ME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vf0Zyfzg98Z8jorSnZ68dUS79EpYFlpgR270GoIT3VAzx1bP3NsmP49TsNKHiLT4lwPFP1qNF+SDfRd3obR1v5Qxg8KEFLmiZr2PnPFxHxVVsGlrZ7/KefJ2MrM7wO+9nPhtRHBMC9lpK80Wh1dQ7RopTl75WrhSinN2Vff0PSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMrVogHc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-88e51cf965dso202742185a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556318; x=1761161118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfKLoaIE6m6YAqIlpySfZ0ebyLDDrsoOWfky8dWsuu8=;
        b=LMrVogHcGeDeNnUmoDhp1Krga++idOt61PfnQ8nq+3PdvwKyUiws7bhrvpk0b7CDP/
         PHSIjY1iJksa2BhauBRnYMKCa/I280ce7stALHOIvdRk7qWx2SRUowDi73acVUB79S57
         jXzRMkCYivEYnL4oIcVDkJQCHs6urxlAPDI6XW5+axPqan+BaSEWETFfUi6H3qhRt1yL
         nFIUNQsOGG6H5jScPpkkE8gsB7aa9iMYt48RqBk61JvTtRMKlmjyAMjOADtOdURgh/Jb
         MEdxYcMfUMLIsqE690ypLxJYdc0KzEHJO3mwynr6D55fwU/gMyPjgnwHZrslFLR05mIP
         InnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556318; x=1761161118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfKLoaIE6m6YAqIlpySfZ0ebyLDDrsoOWfky8dWsuu8=;
        b=ShVPazFx69zQLeXsp5r6Qi0bLYOZyEj+Zztkm82qlefYJyD31JlMuyRkuX6DFycGPY
         WpB+QWK40GboMVkcrxHkdUX/mBtNr60rfKzfTRJIopAM2+bAHpr7jYJj1Gnx5JEI+Qzv
         QvjaK/e3lNOZ3TJTtFfjRsp0MbvGUxCMylWs5o/P3xh2V2efJcRNDkIv/8C5jyiQxfpx
         kqd2Xsyryry6zrZTh1bmv4pa1BWyudyJsM+22MwP8+hJ8yKWtKdAI8I+iYGjatXTPnda
         h/RbYoMj8n/ax4Fuo+Hq+VjuCD3B6WykjWue1QRTr4rZ0GfhPCYtV1ulZJYW9PqTvA+v
         87Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWQPO9v+5es+01PZDF3uFdELdips3q3wqBAx2W6Hh7diS9IBlY8LFlhw3s7n6ZgbXUcqejldOi6Uwg11H45@vger.kernel.org
X-Gm-Message-State: AOJu0YwDR9zYoblmAXItbbs3kvFnVwLUH4McV3YHxzJyRbhdWy/TNjU2
	KaTI5GK+Wkbs0bWyB3jVY2TCFGglrwk9f8UqxyH45UPUxmrf6eb1YsiO
X-Gm-Gg: ASbGnct/2SoQ94AGUa5QnJCzb5Hpnv5ZuuhAQTtLvMmwVvPmVIoy5Xv64obMgYhlAcS
	2wg1Qs4hWjMQHl1KsItRxSlQGTBd+kMtghw4zD+uHQLBBpW0V5nSGIhyaiiOMYXinN0Dq612gD/
	IPsB00LBVURRG/EJu6oAgu0nyR/V4kIgqlWMks7PYvoZXY3Q0O0nPru8qezsfKKbeHL+k8mtBgS
	PTKcd+Fx8xgHEecucmCu1Nwnf+2s2kiKxZ99KiSUJe7yowOfEUbvyIS2+QebonLiZBrV3px6V3U
	tr4quvFb/O6Ih80lKpYnxaJ2LSRVARSE4i9LdtlkorrUfw6Xzy2nqjEmAwDlvqluOjv1AqbxL8o
	GhM819agvKI536/+DQ5c6COGiOs2XDiUM6QxwEQB/3RT70HEdka0UqAocpU33oNOqWcWXPiFGEM
	Dl5PblQ3P1eLubr9t87kLhAlZcEmW9WjW6bZy/UTkdzPV2Fk+xARvrUoTJy2hq9RZ1ihzdHdwxd
	hTYHCHfvNV+0SR00OSfdrZUjboD+heaZVH6qnUH8wwuexEJ5wsJ
X-Google-Smtp-Source: AGHT+IEyJ4wXPRNVHomX6M4YCh9mUoGoZWRpoOJh8NtSqhKRuXmvyAnybqGcRN9E15RRAuo/qFdyWw==
X-Received: by 2002:a05:622a:5809:b0:4dd:8dcc:17f5 with SMTP id d75a77b69052e-4e6ead15d7dmr389497071cf.28.1760556317628;
        Wed, 15 Oct 2025 12:25:17 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:17 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:38 -0400
Subject: [PATCH v17 08/11] rust: pci: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-8-dc5e7aec870d@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556296; l=872;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Kd0EzPTdfyblnmo1RxE7jLLbIDYVUJvE5DzKX0nK5ME=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEhfQevpl/RzFxxXnpbY5oPfpzKL1+vKftdtwGLN29QKlCkDGEX76xd9UdrJV0rHFhQ062F1yi6
 DHt74TqCP1g4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit ed78a01887e2 ("rust: pci: provide access to PCI
Class and Class-related items").

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
2.51.0


