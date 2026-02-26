Return-Path: <linux-fsdevel+bounces-78599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGEXDS6EoGkDkgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:34:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA41AC838
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8855D37237DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5EA3603FE;
	Thu, 26 Feb 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="VU78AH1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF4368974;
	Thu, 26 Feb 2026 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124246; cv=none; b=s59F1QFZb3xknDXeN6LKD5rNGmnqVK80fxJf+RTATK7/NnjjEusjvz7qMOU8GnPiXRA4PWtkxYdPDzLWmtJv/C0pJ6fQM82hQdeLtMyDZa/ln/IomH77NGh2pIEUofLduOpQhkFTS9gywnyTo9dunAi+U2x/i6bMymoE6yIZv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124246; c=relaxed/simple;
	bh=udtgNQd1mz2KxThAyQPN6PFxCfS47eDTr/tnmFRr29Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JvnPsJdxE3T3GP+JLfhuw1On14hbrEVqO3r9qXY40oTzRDn95xe7sgK180Iqyq0aNmODOnl477Olo2yGyyFMOuxoHujxdVaxn0aA9esXe2xBWgbOKMH3aX8zMdJ/y5WheEwCSuqAVqN7Z+w5F7gIgCn7kzzkcBPPCTYi+77BJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=VU78AH1E; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from fedora.fritz.box (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id 57E5CE0351;
	Thu, 26 Feb 2026 17:43:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1772124236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aJZSlvlVhTNL57DQLfx7dLjf4OuHSukoafTN8QV/vuc=;
	b=VU78AH1EDV/TZ9GEemFaqo9QVTRxiLFlvJuQUaxYdQX4P0FDqHkaqVFHvpeYLse3nbRtjI
	hGi+Ngf1QPk2KCmQ4X6qDlcrOHFZYt8ljtv/SHbJlIZqgN9S6mwJPIIeQi4FWkbgo/zmz1
	lP9iyGNAGPbcJglVdw7rYtDlyfHqoL5sR3uDrU30kVEh/hqv5ejndxS8Vtwyu8qq8vvuFZ
	cn+vE6xUDlSKUsyeYduj7MLkyxOAgqg5V43B0NfONCazFpeIRseYCkBau8ndDliM6PjDDk
	MZnyW055KleCYepJHK9kt2BiCw9R4LXTmW10P4H20nz71zqqNy1pUSq9PK/i4w==
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Subject: [PATCH v6 0/3] fuse: compound commands
Date: Thu, 26 Feb 2026 17:43:52 +0100
Message-Id: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OwW7DIAwG4FepOJcJMBDSU99j2gFi03JoEkETb
 ary7iOVpi6HaDv+lv35f7BCOVFhp8ODZZpTSUNfgz0eWHf1/YV4wpqZEspIpYDHqRDvhts4TD0
 WPo3lnsnfeOdM0ARtAARWr8dMMX0+5fePmq+p3If89Xw0y3X6tzlLLngTPJK10OomnBH7t7rIV
 nFW/1RUVURsgtZG1pq0VeBHsUIKt69AVRx2raQQodFiq+jfSruv6LULQnDKa2tt3CrmpSgp9hV
 TFfLCOBOtQu9fyrIs3+Vi+c3UAQAA
X-Change-ID: 20251223-fuse-compounds-upstream-c85b4e39b3d3
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772124235; l=4178;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=udtgNQd1mz2KxThAyQPN6PFxCfS47eDTr/tnmFRr29Q=;
 b=PhNvUcBFKyNOw27nKCJU/w5CX/gn6yPagXuC74a6WxZQuFxn5RhQXVCcTpbbU8VK9Uan3SG04
 lyYmCgujo0qCRDzrDwyF7IOse/7Ou8C3L/fPS0z8U/mh0SGqa8uFB2y
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[birthelmer.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[birthelmer.com:s=uddkim-202310];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78599-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[szeredi.hu,ddn.com,gmail.com,igalia.com];
	URIBL_MULTI_FAIL(0.00)[ddn.com:server fail,birthelmer.com:server fail,sea.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[birthelmer.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birthelmer.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ddn.com:mid,ddn.com:email]
X-Rspamd-Queue-Id: 8CDA41AC838
X-Rspamd-Action: no action

In the discussion about open+getattr here [1] Bernd and Miklos talked
about the need for a compound command in fuse that could send multiple
commands to a fuse server.

This can be used to reduce the number of switches from user to kernel
space but also to define atomic operations that the fuse server can
process as one command even though they are multiple requests combined.

After various dscussions in the previous versions I have added an
automatic sequencialization in case the fuse server does not know
the compound. In this case the kernel will call the requests one
after the other.

In case the requests have interdependent args there is the possibility
to add an arg conversion function that has to be provided which 
can handle the filling of the args right before the request is called.
This function has access to the whole compound, so basically to all the
requests that came before including their results.

The series contains an example of a compound that was already discussed
before open+getattr.
    
The pull request for libfuse is here [2]
That pull request contains a patch for handling compounds 
and a patch for passthrough_hp that demonstrates multiple ways of
handling a compound. Either calling the helper in libfuse to decode and 
execute every request sequencially or decoding and handling it in the
fuse server itself.

[1] https://lore.kernel.org/linux-fsdevel/CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com/
[2] https://github.com/libfuse/libfuse/pull/1418

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
Changes in v6:
- got rid of the count in the compound header
- added the automatic calling of the combined request if the fuse
server doesn't process the compound and the implementation allows it
- due to the variable max operations in the compounds request struct 
fuse_compound_free() had be brought back
- Link to v5: https://lore.kernel.org/r/20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com

Changes in v5:
- introduced the flag FUSE_COMPOUND_SEPARABLE as discussed here
- simplify result parsing and streamline the code
- simplify the result and error handling for open+getattr
- fixed a couple of issues pointed out by Joanne
- Link to v4: https://lore.kernel.org/r/20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com

Changes in v4:
- removed RFC 
- removed the unnecessary 'parsed' variable in fuse_compound_req, since
  we parse the result only once
- reordered the patches about the helper functions to fill in the fuse
  args for open and getattr calls
- Link to v3: https://lore.kernel.org/r/20260108-fuse-compounds-upstream-v3-0-8dc91ebf3740@ddn.com

Changes in v3:
- simplified the data handling for compound commands
- remove the validating functionality, since it was only a helper for
  development
- remove fuse_compound_request() and use fuse_simple_request()
- add helper functions for creating args for open and attr
- use the newly createn helper functions for arg creation for open and
  getattr
- Link to v2: https://lore.kernel.org/r/20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com

Changes in v2:
- fixed issues with error handling in the compounds as well as in the
  open+getattr
- Link to v1: https://lore.kernel.org/r/20251223-fuse-compounds-upstream-v1-0-7bade663947b@ddn.com

---
Horst Birthelmer (3):
      fuse: add compound command to combine multiple requests
      fuse: create helper functions for filling in fuse args for open and getattr
      fuse: add an implementation of open+getattr

 fs/fuse/Makefile          |   2 +-
 fs/fuse/compound.c        | 308 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c             |  26 ++--
 fs/fuse/file.c            | 137 +++++++++++++++++----
 fs/fuse/fuse_i.h          |  49 +++++++-
 fs/fuse/ioctl.c           |   2 +-
 include/uapi/linux/fuse.h |  52 ++++++++
 7 files changed, 541 insertions(+), 35 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20251223-fuse-compounds-upstream-c85b4e39b3d3

Best regards,
-- 
Horst Birthelmer <hbirthelmer@ddn.com>


