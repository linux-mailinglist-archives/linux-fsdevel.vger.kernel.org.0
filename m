Return-Path: <linux-fsdevel+bounces-19614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086A18C7CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A86286289
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13815ADA6;
	Thu, 16 May 2024 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="cN56MSaO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE715B96B;
	Thu, 16 May 2024 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886321; cv=none; b=cC9Hs95gM3AF42H/U/sNWhDWI3Vt4Viym0kK+kean4DXcpvDuqzhOLH0Mb8zyU2pCZH5+X8fSPYZI7Yvfl8cqYpYUWlA4iy6ajc0VstF1/X2LcLBnG1nk7XqXzdFMecbQ7eoX4G31/78SuMa+y2K9dyVfGy8p5E3LDHvOKOcxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886321; c=relaxed/simple;
	bh=dCufPo0k+5EGqgazK+H69P+Cx6l+Va1rtovlf9VP2VY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAzjtnnSFXz3pAuv+Baww75bySqO3bhON6sC2h5lovxeDxch/UUzx0fbKLBYafVHpl1eWY39FhOZTte3uo7aIozlY+r1wu8aGt/si9BLNWwvRt7XtVsgpRuF8C9PwBGSQRYUmp9xNJonDO0tj8dHvdngmoz0s6VT75/t1BooHcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=cN56MSaO; arc=none smtp.client-ip=173.38.203.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=14802; q=dns/txt;
  s=iport; t=1715886318; x=1717095918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WikPN1aozAODGlwU5sGnmfF5s8efLsy9tywRfkBTanI=;
  b=cN56MSaOQjtZGTeikn4Psl2GJ7clDB43R0ktEU4Cux+WG/1gf1UJ5+GA
   jju0iDuHHxK1vpa9eDFJbxIyP508VShh2liyviTgeoiMhpfVt8Jh+h/Be
   Ea4yehfFqgCCpKIleeStRJlVaPjlN5WZ9M40rMCJAiLlVXzcjcq0FVuVU
   I=;
X-CSE-ConnectionGUID: t8hH8awMSuy50LezSOW19g==
X-CSE-MsgGUID: Tkobr50fQ8SnlWtJPnD7tA==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12379872"
Received: from aer-iport-nat.cisco.com (HELO aer-core-12.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:10 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-12.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ495v100681
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:09 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 07/22] rust: capnp: add SPDX License Identifiers
Date: Thu, 16 May 2024 22:03:30 +0300
Message-Id: <20240516190345.957477-8-amiculas@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516190345.957477-1-amiculas@cisco.com>
References: <20240516190345.957477-1-amiculas@cisco.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.83.14, ams3-vpn-dhcp4879.cisco.com
X-Outbound-Node: aer-core-12.cisco.com

Add the SPDX license identifiers, since the initial patch added the
upstream sources with no modifications whatsoever.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/capnp/any_pointer.rs                        | 2 ++
 rust/capnp/any_pointer_list.rs                   | 2 ++
 rust/capnp/capability.rs                         | 2 ++
 rust/capnp/capability_list.rs                    | 2 ++
 rust/capnp/constant.rs                           | 2 ++
 rust/capnp/data.rs                               | 2 ++
 rust/capnp/data_list.rs                          | 2 ++
 rust/capnp/dynamic_list.rs                       | 2 ++
 rust/capnp/dynamic_struct.rs                     | 2 ++
 rust/capnp/dynamic_value.rs                      | 2 ++
 rust/capnp/enum_list.rs                          | 2 ++
 rust/capnp/introspect.rs                         | 2 ++
 rust/capnp/io.rs                                 | 2 ++
 rust/capnp/lib.rs                                | 2 ++
 rust/capnp/list_list.rs                          | 2 ++
 rust/capnp/message.rs                            | 2 ++
 rust/capnp/primitive_list.rs                     | 2 ++
 rust/capnp/private/arena.rs                      | 2 ++
 rust/capnp/private/capability.rs                 | 2 ++
 rust/capnp/private/layout.rs                     | 2 ++
 rust/capnp/private/layout_test.rs                | 2 ++
 rust/capnp/private/mask.rs                       | 2 ++
 rust/capnp/private/mod.rs                        | 2 ++
 rust/capnp/private/primitive.rs                  | 2 ++
 rust/capnp/private/read_limiter.rs               | 2 ++
 rust/capnp/private/units.rs                      | 2 ++
 rust/capnp/private/zero.rs                       | 2 ++
 rust/capnp/raw.rs                                | 2 ++
 rust/capnp/schema.rs                             | 2 ++
 rust/capnp/schema_capnp.rs                       | 2 ++
 rust/capnp/serialize.rs                          | 2 ++
 rust/capnp/serialize/no_alloc_buffer_segments.rs | 2 ++
 rust/capnp/serialize_packed.rs                   | 2 ++
 rust/capnp/stringify.rs                          | 2 ++
 rust/capnp/struct_list.rs                        | 2 ++
 rust/capnp/text.rs                               | 2 ++
 rust/capnp/text_list.rs                          | 2 ++
 rust/capnp/traits.rs                             | 2 ++
 38 files changed, 76 insertions(+)

diff --git a/rust/capnp/any_pointer.rs b/rust/capnp/any_pointer.rs
index c49216cd031e..83ae07a20a09 100644
--- a/rust/capnp/any_pointer.rs
+++ b/rust/capnp/any_pointer.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/any_pointer_list.rs b/rust/capnp/any_pointer_list.rs
index 1c4e9e40c879..f7f4fae5678c 100644
--- a/rust/capnp/any_pointer_list.rs
+++ b/rust/capnp/any_pointer_list.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2018 the capnproto-rust contributors
 //
 // Permission is hereby granted, free of charge, to any person obtaining a copy
diff --git a/rust/capnp/capability.rs b/rust/capnp/capability.rs
index 7cff20bbbcb9..fbe778791c38 100644
--- a/rust/capnp/capability.rs
+++ b/rust/capnp/capability.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/capability_list.rs b/rust/capnp/capability_list.rs
index 083794e073d1..b139d566a58d 100644
--- a/rust/capnp/capability_list.rs
+++ b/rust/capnp/capability_list.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2017 David Renshaw and contributors
 //
 // Permission is hereby granted, free of charge, to any person obtaining a copy
diff --git a/rust/capnp/constant.rs b/rust/capnp/constant.rs
index fdd1edf487ff..9f174366d89d 100644
--- a/rust/capnp/constant.rs
+++ b/rust/capnp/constant.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2017 Sandstorm Development Group, Inc. and contributors
 //
 // Permission is hereby granted, free of charge, to any person obtaining a copy
diff --git a/rust/capnp/data.rs b/rust/capnp/data.rs
index 89e0c6c19ea4..d777f1d626b0 100644
--- a/rust/capnp/data.rs
+++ b/rust/capnp/data.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/data_list.rs b/rust/capnp/data_list.rs
index f5fee2575fd2..7771ea4bb04d 100644
--- a/rust/capnp/data_list.rs
+++ b/rust/capnp/data_list.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/dynamic_list.rs b/rust/capnp/dynamic_list.rs
index f2c93e1cbe16..0b60674cdeab 100644
--- a/rust/capnp/dynamic_list.rs
+++ b/rust/capnp/dynamic_list.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 //! Dynamically-typed lists.
 
 use crate::dynamic_value;
diff --git a/rust/capnp/dynamic_struct.rs b/rust/capnp/dynamic_struct.rs
index d0244fc29f40..9da5a1e5df33 100644
--- a/rust/capnp/dynamic_struct.rs
+++ b/rust/capnp/dynamic_struct.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 //! Dynamically-typed structs.
 
 use crate::introspect::TypeVariant;
diff --git a/rust/capnp/dynamic_value.rs b/rust/capnp/dynamic_value.rs
index 83646e26de31..aaca4d82453f 100644
--- a/rust/capnp/dynamic_value.rs
+++ b/rust/capnp/dynamic_value.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 //! Dynamically typed values.
 
 use crate::introspect::{self, TypeVariant};
diff --git a/rust/capnp/enum_list.rs b/rust/capnp/enum_list.rs
index 8fa713029250..0192732fe16b 100644
--- a/rust/capnp/enum_list.rs
+++ b/rust/capnp/enum_list.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/introspect.rs b/rust/capnp/introspect.rs
index d994b180c93a..a3494935b4d5 100644
--- a/rust/capnp/introspect.rs
+++ b/rust/capnp/introspect.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 //! Traits and types to support run-time type introspection, i.e. reflection.
 
 use crate::private::layout::ElementSize;
diff --git a/rust/capnp/io.rs b/rust/capnp/io.rs
index 59d149b37c26..82c429f8c263 100644
--- a/rust/capnp/io.rs
+++ b/rust/capnp/io.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 //! Custom I/O traits that roughly mirror `std::io::{Read, BufRead, Write}`.
 //! This extra layer of indirection enables support of no-std environments.
 
diff --git a/rust/capnp/lib.rs b/rust/capnp/lib.rs
index daafc23c19d5..d3aa0f9f3451 100644
--- a/rust/capnp/lib.rs
+++ b/rust/capnp/lib.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/list_list.rs b/rust/capnp/list_list.rs
index 7c31560958d3..ec7e830df7e1 100644
--- a/rust/capnp/list_list.rs
+++ b/rust/capnp/list_list.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/message.rs b/rust/capnp/message.rs
index fe40e0a7c313..595f6975c489 100644
--- a/rust/capnp/message.rs
+++ b/rust/capnp/message.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/primitive_list.rs b/rust/capnp/primitive_list.rs
index 4ea31a7b50eb..a761320788b5 100644
--- a/rust/capnp/primitive_list.rs
+++ b/rust/capnp/primitive_list.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/private/arena.rs b/rust/capnp/private/arena.rs
index 46626c1f0ce3..40c539d72142 100644
--- a/rust/capnp/private/arena.rs
+++ b/rust/capnp/private/arena.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2017 Sandstorm Development Group, Inc. and contributors
 //
 // Permission is hereby granted, free of charge, to any person obtaining a copy
diff --git a/rust/capnp/private/capability.rs b/rust/capnp/private/capability.rs
index ba725fb60535..522d0b1b0418 100644
--- a/rust/capnp/private/capability.rs
+++ b/rust/capnp/private/capability.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/private/layout.rs b/rust/capnp/private/layout.rs
index 02ecb6e7bfb5..dbfe97235cd9 100644
--- a/rust/capnp/private/layout.rs
+++ b/rust/capnp/private/layout.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/private/layout_test.rs b/rust/capnp/private/layout_test.rs
index 8715e9edab43..fb5a8de9bb44 100644
--- a/rust/capnp/private/layout_test.rs
+++ b/rust/capnp/private/layout_test.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/private/mask.rs b/rust/capnp/private/mask.rs
index dfa211521ca7..70937b802bf6 100644
--- a/rust/capnp/private/mask.rs
+++ b/rust/capnp/private/mask.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/private/mod.rs b/rust/capnp/private/mod.rs
index 1e6bcdab6d6e..2126235199fe 100644
--- a/rust/capnp/private/mod.rs
+++ b/rust/capnp/private/mod.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/private/primitive.rs b/rust/capnp/private/primitive.rs
index 00e41ce40f08..f70f3a7486f3 100644
--- a/rust/capnp/private/primitive.rs
+++ b/rust/capnp/private/primitive.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 pub trait Primitive {
     type Raw;
 
diff --git a/rust/capnp/private/read_limiter.rs b/rust/capnp/private/read_limiter.rs
index 0bb6a7a8415c..f4f0cf348af1 100644
--- a/rust/capnp/private/read_limiter.rs
+++ b/rust/capnp/private/read_limiter.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/private/units.rs b/rust/capnp/private/units.rs
index 90fbf663f777..37782edeef56 100644
--- a/rust/capnp/private/units.rs
+++ b/rust/capnp/private/units.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/private/zero.rs b/rust/capnp/private/zero.rs
index 00769cfebafc..12e4a723105a 100644
--- a/rust/capnp/private/zero.rs
+++ b/rust/capnp/private/zero.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/raw.rs b/rust/capnp/raw.rs
index 5883b1207be9..3127b6adc0fc 100644
--- a/rust/capnp/raw.rs
+++ b/rust/capnp/raw.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2018 the capnproto-rust contributors
 //
 // Permission is hereby granted, free of charge, to any person obtaining a copy
diff --git a/rust/capnp/schema.rs b/rust/capnp/schema.rs
index 4120868f4051..b7677056cc10 100644
--- a/rust/capnp/schema.rs
+++ b/rust/capnp/schema.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 //! Convenience wrappers of the datatypes defined in schema.capnp.
 
 use crate::dynamic_value;
diff --git a/rust/capnp/schema_capnp.rs b/rust/capnp/schema_capnp.rs
index 4f92ee288821..820a1187bf59 100644
--- a/rust/capnp/schema_capnp.rs
+++ b/rust/capnp/schema_capnp.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // @generated by the capnpc-rust plugin to the Cap'n Proto schema compiler.
 // DO NOT EDIT.
 // source: schema.capnp
diff --git a/rust/capnp/serialize.rs b/rust/capnp/serialize.rs
index ad9e130e5ed7..025bcd45ee61 100644
--- a/rust/capnp/serialize.rs
+++ b/rust/capnp/serialize.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/serialize/no_alloc_buffer_segments.rs b/rust/capnp/serialize/no_alloc_buffer_segments.rs
index d3837738d702..de902a0ee4d4 100644
--- a/rust/capnp/serialize/no_alloc_buffer_segments.rs
+++ b/rust/capnp/serialize/no_alloc_buffer_segments.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 use core::convert::TryInto;
 
 use crate::message::ReaderOptions;
diff --git a/rust/capnp/serialize_packed.rs b/rust/capnp/serialize_packed.rs
index 286a36950981..63ed7264848e 100644
--- a/rust/capnp/serialize_packed.rs
+++ b/rust/capnp/serialize_packed.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/stringify.rs b/rust/capnp/stringify.rs
index d11bfbeb7b14..426025fea0e8 100644
--- a/rust/capnp/stringify.rs
+++ b/rust/capnp/stringify.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 use crate::dynamic_value;
 use core::fmt::{self, Formatter};
 
diff --git a/rust/capnp/struct_list.rs b/rust/capnp/struct_list.rs
index 5c2775ddc1fd..7133e69560bc 100644
--- a/rust/capnp/struct_list.rs
+++ b/rust/capnp/struct_list.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/text.rs b/rust/capnp/text.rs
index fa2a72701444..406ddb5ba8ac 100644
--- a/rust/capnp/text.rs
+++ b/rust/capnp/text.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/text_list.rs b/rust/capnp/text_list.rs
index 72cbd2647ba9..222521a6741e 100644
--- a/rust/capnp/text_list.rs
+++ b/rust/capnp/text_list.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
diff --git a/rust/capnp/traits.rs b/rust/capnp/traits.rs
index 39e050ab4abf..e12c38346d56 100644
--- a/rust/capnp/traits.rs
+++ b/rust/capnp/traits.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: MIT
+
 // Copyright (c) 2013-2015 Sandstorm Development Group, Inc. and contributors
 // Licensed under the MIT License:
 //
-- 
2.34.1


