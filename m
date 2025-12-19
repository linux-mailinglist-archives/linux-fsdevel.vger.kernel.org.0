Return-Path: <linux-fsdevel+bounces-71732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11367CCFC1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64D88306CF4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F1C33A016;
	Fri, 19 Dec 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Osy8ePDi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA019328618;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146571; cv=none; b=ASquL/lpJ8cotZdN5p2jDTKod9tbAHOGGa3/5gBcFgUYN1U+AdiTGuKrN/Ky8kHQgrYFa3U5TNHYBv0kB0sOLxmQcrxd/6bcMoWn/ZLTpo3BzeHbpcwmBU1vHJEy8VOdQrngkEXsyxtkoYEETIJ80x83pRBWVBjmu01QI8fcb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146571; c=relaxed/simple;
	bh=m3fwFPb4CWuGiTg3M7ayJA8LFi+6Cjo0y/adMkfUc6c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gPBpbGbIFu/E5N1tXp8wqifuaZRCWFiaX6uWR1IPbfXjoLEiAtVbRSoH+x/v7p8CVnhVGI7XQcNXONlOXmGsMCVQwixsgCJ6mV0h16DeDd5AnZoKRGZE4AEANiRRe0VuVEsRWUdTXEhLMcMVBXCswxj34390vPBTIcrLZ6/i+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Osy8ePDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 876CCC4CEF1;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766146571;
	bh=m3fwFPb4CWuGiTg3M7ayJA8LFi+6Cjo0y/adMkfUc6c=;
	h=From:Subject:Date:To:Cc:From;
	b=Osy8ePDilf0UJLa/Koft55V4jTOlM7yz2p15DnzV09pmBwLN+IJ3uukwXUGi1VFyi
	 XkqLA+ZmZSQVlvf/PDJTnUVSev86Ldlw75W2kHQb9isPCEV0QohBUDdM/mzUoMdZ4y
	 Fao2ArVDFpCs9aSzS/y5qcmR39mS1nrT6kd78c99Falnflqg5Ikz1WQbzEOQPSm+9S
	 m+l5RJQyVCyYG6RmTdd0IAqqYFS7ryp+bcn3aKBPIHLkLgnzPXvphANseOLNNhyFQj
	 YgA5X8KCA9yiFpg5Ks0YdeVCEvQ9eoOT5h+W5eQ+yISjuohyJtvXyf+enJm370Xe26
	 WSLQ6nCiVCvvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D63BD767D7;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH 0/9] sysctl: Consolidate do_proc_* functions into one macro
Date: Fri, 19 Dec 2025 13:15:51 +0100
Message-Id: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPhBRWkC/x3MTQqAIBBA4avErBPSin6uEhGTjjURGhoRRHdPW
 n6L9x6IFJgi9NkDgS6O7F2CzDPQK7qFBJtkUIWqpZKt2HARxl+kJ+1d9DsbPEnU2BSVVVjabob
 UHoEs3/93GN/3A8C+JU9nAAAA
X-Change-ID: 20251218-jag-dovec_consolidate-5a704f2a3f9b
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2984;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=m3fwFPb4CWuGiTg3M7ayJA8LFi+6Cjo0y/adMkfUc6c=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlFQgRj+CGIHht2T9bLmyPUEqxs2layAJNkP
 hfKlwSzbzi5EokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpRUIEAAoJELqXzVK3
 lkFPnSQL/2fjwpC0rct/GD5o2RDVMK3cyFJEBOK4SA/vhp4zIJqJxhO82Zn8qaIOCIcnMOwdFsl
 crY+XtkufikPyICrxAIoztCzHv8Oxloy/Gpf1upUneco/KpXFNPgHpHHcg5mIbFIpAUxp1KQO7o
 wtR4puOQ6w8j1XWFdNR+5kYDoLVqQBX5NARJ5tlly4VI3my9gcWVJHWpZO2GCSKsm5ftsI5+We8
 3nMfCDXnI6LaBolXEM1zyM/imUBPC58QKyD1SqYPuY1V2fZjiSlRcZI4lISVJSOHauS5tn+FWuN
 22XIhPkrzin8Kptie47MeteD+NrjpNVCH8tseUcYXy90e4hsLHsBcayBdnY2LkYP5STsSA94w8z
 6731R2vNafQfnubRKyNTZFKv/pSAP1SUu5iNZnyCDzvZPQ/98yVNwv9ZTMfFgO/2nAe+RIki85/
 mOrHqv9N3RQJNpdZ4R6nlE5WnOd3puUzgCVaUZRkfcFA4WjH0KO5B7WzkavG6kKClZeaDMK7dO4
 4g=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

What
====
Generate do_proc_{int,uint,ulong} with the new do_proc_typevec macro.
Removed small differences between each implementation and put it all
under one roof. This macro is meant for internal (to sysctl.c) static
functions; it should not be used from the outside.

Groups and document the proc handler and converter functions in
include/linux/sysctl.h. Document how to create custom converters
with examples for every converter type.

This series sits on top of [1], you can see the working branch here [2].

Why
===
Working with one instead of three slightly different implementations of
the same thing makes more sense to me for three reasons: 1. I don't have
to think about the different types separately (less context switches) and
2. One place to begin debugging proc_handler issues and 3. A fix for
one type, fixes all types.

A word on macros
================
I have mixed feelings about the use of macros here, especially because
it is such a long function. But I see it as the first step. Having this
in mainline will validate that the three types **indeed** have the same
logic (I have tested extensively, but linux-next & mainline are the
ultimate tests). Once this is established in mainline, implementing an
alternative way of parametrizing becomes easier.

A word on checkpatch
====================
* It does not like that ENOSYS is returned for the no-op functions. I'm
  just following the pattern that was initially there. Does -EINVAL
  makes more sense?
* It has a false positive on a spacing around a pointer.

Testing
=======
Ran sysctl selftest/kunit on x86_64 and 0-day.

Comments are greatly appreciated

[1] https://lore.kernel.org/20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org
[2] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/log/?h=jag/dovec_consolidate

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Joel Granados (9):
      sysctl: Move default converter assignment out of do_proc_dointvec
      sysctl: Replace do_proc_dointvec with a type-generic macro
      sysctl: Generate do_proc_doulongvec_minmax with do_proc_dotypevec macro
      sysctl: Add negp parameter to douintvec converter functions
      sysctl: Generate do_proc_douintvec with a type-generic macro
      sysctl: Rename do_proc_dotypevec macro to do_proc_typevec
      sysctl: Group proc_handler declarations and document
      sysctl: Rename proc_doulongvec_minmax_conv to proc_doulongvec_conv
      sysctl: Update API function documentation

 fs/pipe.c              |   2 +-
 include/linux/sysctl.h | 123 +++++++----
 kernel/sysctl.c        | 539 +++++++++++++++++++++++--------------------------
 kernel/time/jiffies.c  |  28 ++-
 4 files changed, 371 insertions(+), 321 deletions(-)
---
base-commit: 0616c77e5d877006efe3bea27ca195d396de08dc
change-id: 20251218-jag-dovec_consolidate-5a704f2a3f9b

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



