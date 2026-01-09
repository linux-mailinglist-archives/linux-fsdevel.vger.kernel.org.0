Return-Path: <linux-fsdevel+bounces-73079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC1BD0BD27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 19:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80F233033B8D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 18:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C58366DB7;
	Fri,  9 Jan 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="TaW7+gp6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6903644D3;
	Fri,  9 Jan 2026 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983237; cv=none; b=gelVQrukSJgYECVLvoi3iWuhg5PNYBH8mf7g3oAtOLnB80mFe2EnAN1pYciS1kkAerwkr8YSTeFyqld4I5Htf4ZoMdL153sQWJ2ZHp5f+WvlZHn68XaSXVxwemOrpTvkuLKx0HGlplWVQDIV/brZ9VfZH83ZlQGIsQBeURpRsQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983237; c=relaxed/simple;
	bh=RvkDWUMJ1eEAAMqmgy3bq2SUbdenVAP6juuX8So4DPA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EpeZrQi8regpWAX+ky5IavPNc6X9/1wno3UtcFchULjvUjdFBQ0Y3t3QbShf+UUV2SEKkYDrgytIh1Bs+CpRHSYer5admKAW7eho9VfEMTY7WU2suFc6JAhs67IR3rOgMezaDgXSYG0Bsiqg4Msy7jYdfWLNyw337f56JFUEEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=TaW7+gp6; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from [127.0.1.1] (049-102-000-128.ip-addr.inexio.net [128.0.102.49])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 633C0E01CF;
	Fri,  9 Jan 2026 19:27:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1767983228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IneEb5OVGfDJV1cJf2leTPg1b9IBzKXecxAFZD+OTN4=;
	b=TaW7+gp6JiQ+C9Wjgq+0Q9gBO4VCbCMj0GdYh++4Zypt2jikW/iX10y/rFtEt+wtwyaAbE
	nEdecCesimgs7RLCIyDt6OAQ1KKIZ9TQ7PTkB0lHhUOgpXi2nXC/nL7P1tV0UTYOtL2rSq
	cqd6y/Jr0+YDBJNLwEOc6iJ3eVtf+VkzT8U3KJrVGq/sfhNF38dDexvLYhxpPHS/o7WibT
	sCEnxxb8KLXaqkpfprIUMQ7zpL29RuNskFGbH2XxXOETszWYk7/E1jBzyHokb364GcrK7S
	WYRPuykZgFeGZguu4/fNd0TKcpVfqcmVYWqOB6vM7qWzl17qa6z1wXJEBCjo/w==
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Subject: [PATCH v4 0/3] fuse: compound commands
Date: Fri, 09 Jan 2026 19:26:58 +0100
Message-Id: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJIYWkC/43OTQ6CMBAF4KuQrq3pHxRceQ/jgrZT6YJCWmg0h
 LtbSIxxYXT5JvO+mQVFCA4iOhULCpBcdIPPQRwKpLvW3wA7kzNihJWUMY7tHAHroR+H2ZuI5zF
 OAdoe67pUAnijuOEot8cA1t13+XLNuXNxGsJjP5ToNv1tJooJlqo1UFW8EVKdjfHHvIg2MbE/F
 ZYVYqUSoqT5TfhU+EupCCX1d4VnpTa6oaAsl4K8lXVdn5X5eZxIAQAA
X-Change-ID: 20251223-fuse-compounds-upstream-c85b4e39b3d3
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767983227; l=2588;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=RvkDWUMJ1eEAAMqmgy3bq2SUbdenVAP6juuX8So4DPA=;
 b=jxxUIvCb4ddGzRHtWx/06dhRhHeSijH/l2zHMBIQbtaCTeI3/WmSfjIZxxSU2F4QACK6Z1KeC
 uyi0WuAWITjBiprqo3FEDEF3ZuZCJDYcy8Aojz/D2kd63YIxbxFRv9A
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

In the discussion about open+getattr here [1] Bernd and Miklos talked
about the need for a compound command in fuse that could send multiple
commands to a fuse server.
    
Here's a propsal for exactly that compound command with an example
(the mentioned open+getattr).
    
The pull request for libfuse is here [2]
That pull request contains a patch for handling compounds 
and a patch for passthrough_hp with a trivial implementation
of compounds that will decode and call the requests sequencially.

[1] https://lore.kernel.org/linux-fsdevel/CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com/
[2] https://github.com/libfuse/libfuse/pull/1418

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
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
 fs/fuse/compound.c        | 270 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c             |   9 +-
 fs/fuse/file.c            | 152 +++++++++++++++++++++-----
 fs/fuse/fuse_i.h          |  27 ++++-
 fs/fuse/inode.c           |   6 ++
 fs/fuse/ioctl.c           |   2 +-
 include/uapi/linux/fuse.h |  37 +++++++
 8 files changed, 470 insertions(+), 35 deletions(-)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251223-fuse-compounds-upstream-c85b4e39b3d3

Best regards,
-- 
Horst Birthelmer <hbirthelmer@ddn.com>


