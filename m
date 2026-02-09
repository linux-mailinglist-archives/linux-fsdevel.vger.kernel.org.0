Return-Path: <linux-fsdevel+bounces-76743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBfmLbIyimkPIQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:17:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4635E11405C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4852D30238F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A26441B34E;
	Mon,  9 Feb 2026 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ccjb8ky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018452FB997
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664617; cv=none; b=jCbBOxDJv/SfCE7uLtRkNu9WakAss4bwNHNOE+PaLbPHmuRC9fcvPg/1GoWszJ3aISCsSklo70HVnJHViaQpfu4Rd5Hmfjx1FCk1+rDkUwbw/jyw/1zWRAHeOE1bcwXuGXYbBACoZFDK5NNBTW+OJ1au+1O3I6qj8Hp9hUOgfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664617; c=relaxed/simple;
	bh=Y/ATvj9EL3uMV7cAC+NHqra7mdo2DGKjs4juhNkrkeM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QhXuM81lxD7LMVJPRrBU7wR97iYufK2Ge7fVmVlz7/TpFcC19jS3D2NKV+XQPverr7wlPUp29jNGwU78o8isoKkrpMoe5bz/J6vT74T3XxWjtbXbVFg82KKQ/gbUtx7z8+/evdjUKoMLuXroGmkeqV4ycC0x6IJK0oxbCAfhezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ccjb8ky; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aaf2ce5d81so17034475ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 11:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770664616; x=1771269416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gltt6Xe6DQ/hUW9baNp0LT+ih0woRx1cYGTgZsKwvqs=;
        b=4ccjb8kyEt9T4BA4+EcCgeTQO6el9ShKhAdQS9xdYB8zcIvboQMieuA8JSwU83QeKZ
         lU69gH2BEHYKEp//nAgUbyJEn3R+hG+HjFm6TNYBJggCElpIKMPY1kk1hWYCeF6BxVvl
         C3DBBn0hPgOEzXSPk2HrWocG+fGu4AgSMuXS4OsoPElLfC50PDmsIDZ8x1P6FkV5oo4X
         kRrtX/hflThMt2nI/eWO/+oXkGyURZiBDPthug2azcDkyQoPcBL+PuZgNbvFxUZhc7HU
         J0GVg87OP1+Qk9iSrZ0GFgRqGiBcXol8jOXqQD5/HlRiDT6+9yguB3iUifaAmYXT/V/N
         zbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770664616; x=1771269416;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gltt6Xe6DQ/hUW9baNp0LT+ih0woRx1cYGTgZsKwvqs=;
        b=tA2WAT8OAdQmiP6xuJNJvxcF2Py458nBDA0MPU6H9vXO8zAhiQwHuPpRml4v6v5TTu
         jUMNQypC6PES1kHXxvGT01u7OGKLPYSWvSruEoe8ZftgGP+FGLTKwOyz8AuKBshV/E3R
         WeYbU7lskexW2WjjVd69bOrwdFpTB/7L3rKlogrkYEXMCoYuLTx66b2vTTNt85B/mF0E
         V93CSmPUrE5kUnwppIeF/QlYYbkTut53WYdgNcObR50S9ka99u1GiO75TJgmh0SkH9La
         4q4jh4CYmOp5y/btt6tTD0YAMciOVr88sEO7XRaDl/caHW5oaap5wp/mlDGXNN813Uir
         wmmg==
X-Forwarded-Encrypted: i=1; AJvYcCXIg/Nl6TlsAa53NERkoFkLgdwc31wl7bdTK1WX3OFAYkFS2u+t4zFlzL3GYHtSp3/z7SSjyt8kWRrbwSh3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4H7QDEHlRCmzWsBaafvW/Ik/ckWqnToaEqfU3wj/RmeRpHN2+
	aGV5DsuKva8hNnPj5rEoCAdrFrQENtazVWYmcp1CTtcFyws5FYlCEUrjDVZ4GLIZKEQF6rFdhjx
	xaGewrHnTqc7yx61Ama9OiRXBYQ==
X-Received: from plbjy6.prod.google.com ([2002:a17:903:42c6:b0:2a9:628c:cd39])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f54e:b0:2a4:8cd:c3cf with SMTP id d9443c01a7336-2a951926c4dmr98825655ad.49.1770664616237;
 Mon, 09 Feb 2026 11:16:56 -0800 (PST)
Date: Mon,  9 Feb 2026 11:16:42 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <cover.1769818406.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 0/2] Fix storing in XArray check_split tests
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@redhat.com, michael.roth@amd.com, dev.jain@arm.com, 
	vannapurve@google.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76743-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4635E11405C
X-Rspamd-Action: no action

Hi,

(resending to fix Message-ID, also gently nudging for feedback!)

I hit an assertion while making some modifications to
lib/test_xarray.c [1] and I believe this is the fix.

In check_split, the tests split the XArray node and then store values
after the split to verify that splitting worked. While storing and
retrieval works as expected, the node's metadata, specifically
node->nr_values, is not updated correctly.

This led to the assertion being hit in [1], since the storing process
did not increment node->nr_values sufficiently, while the erasing
process assumed the fully-incremented node->nr_values state.

Would like to check my understanding on these:

1. In the multi-index xarray world, is node->nr_values definitely the
   total number of values *and siblings* in the node?

2. IIUC xas_store() has significantly different behavior when entry is
   NULL vs non-NULL: when entry is NULL, xas_store() does not make
   assumptions on the number of siblings and erases all the way till
   the next non-sibling entry. This sounds fair to me, but it's also
   kind of surprising that it is differently handled when entry is
   non-NULL, where xas_store() respects xas->xa_sibs.

3. If xas_store() is dependent on its caller to set up xas correctly
   (also sounds fair), then there are places where xas_store() is
   used, like replace_page_cache_folio() or
   migrate_huge_page_move_mapping(), where xas is set up assuming 0
   order pages. Are those buggy?

[1] https://lore.kernel.org/all/20251028223414.299268-1-ackerleytng@google.com/

Ackerley Tng (2):
  XArray tests: Fix check_split tests to store correctly
  XArray tests: Verify xa_erase behavior in check_split

 lib/test_xarray.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

--
2.53.0.rc1.225.gd81095ad13-goog

