Return-Path: <linux-fsdevel+bounces-19612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682F28C7CE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22930285568
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3AD15B992;
	Thu, 16 May 2024 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="mYcMPAKw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-5.cisco.com (aer-iport-5.cisco.com [173.38.203.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B915B0F2;
	Thu, 16 May 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886317; cv=none; b=snrNU6CIiP/ytC4MvhBsT+a8YNBhYa7rYhw4ZUBopv1ovI3ZbsVM5cvG8xGwCpiZIGhkIhjqtlpzJC7xswXIPxYff/22+AsYTGp4WdVZabyMOeBPcmy8lLI9bkzLdP6M7USHFHnLL10G17UZnMW7GDJjGq47IdOxpDfdF04wtf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886317; c=relaxed/simple;
	bh=Un26QMeCw3vpFkkSsLB4y9SsB1DGWGmNJr9wdtwpPVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjL9jJK2JjmR9f4kgAgk6w98sd5TckV48N1siAXxD0IhfuZArksXv83NmAup2Q0rtUJQvxEy+8i9mW66fmEA1Xqv7FYtczQr3c3/QdHwHlHbGIGRpbywmmBMXDTxy+2G/umYDgPZFRC3sHpUDmEFEXUozdzIYfYzO8ATl8VEaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=mYcMPAKw; arc=none smtp.client-ip=173.38.203.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1219; q=dns/txt; s=iport;
  t=1715886315; x=1717095915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SlAafPKrZ/klEmNYXl2TJjHIbtqsyFs7FtP+G4kmq8Y=;
  b=mYcMPAKwwJlGcEQNSMU6KA5ZwDJmJ2lq2+s45UilNjBjLK77MxSL805i
   4KueADQpyDr59etEGd9iDD2kR4dfsxiZFY7fgykQRmgFU8E8cbewcRkM0
   d8r0TVreUkI+5Ovlz0KdvcabYZt9Lt3P/8IukJ/4zFsL9LDaLUvhX9UF/
   A=;
X-CSE-ConnectionGUID: S1hSJNSaTp6Q9UX5slpTsA==
X-CSE-MsgGUID: R3iLQmPOQvSxEe8c+vp2gw==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="9839850"
Received: from aer-iport-nat.cisco.com (HELO aer-core-4.cisco.com) ([173.38.203.22])
  by aer-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:11 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-4.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4AsO006132
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:11 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 08/22] rust: capnp: return an error when trying to display floating point values
Date: Thu, 16 May 2024 22:03:31 +0300
Message-Id: <20240516190345.957477-9-amiculas@cisco.com>
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
X-Outbound-Node: aer-core-4.cisco.com

The kernel doesn't support floating point values, so return an error
when the kernel feature is enabled.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/capnp/stringify.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/capnp/stringify.rs b/rust/capnp/stringify.rs
index 426025fea0e8..f93e3521ce0b 100644
--- a/rust/capnp/stringify.rs
+++ b/rust/capnp/stringify.rs
@@ -71,8 +71,12 @@ pub(crate) fn print(
         dynamic_value::Reader::UInt16(x) => formatter.write_fmt(format_args!("{x}")),
         dynamic_value::Reader::UInt32(x) => formatter.write_fmt(format_args!("{x}")),
         dynamic_value::Reader::UInt64(x) => formatter.write_fmt(format_args!("{x}")),
+        #[cfg(not(feature = "kernel"))]
         dynamic_value::Reader::Float32(x) => formatter.write_fmt(format_args!("{x}")),
+        #[cfg(not(feature = "kernel"))]
         dynamic_value::Reader::Float64(x) => formatter.write_fmt(format_args!("{x}")),
+        #[cfg(feature = "kernel")]
+        dynamic_value::Reader::Float32(_) | dynamic_value::Reader::Float64(_) => Err(fmt::Error),
         dynamic_value::Reader::Enum(e) => match cvt(e.get_enumerant())? {
             Some(enumerant) => {
                 formatter.write_str(cvt(cvt(enumerant.get_proto().get_name())?.to_str())?)
-- 
2.34.1


