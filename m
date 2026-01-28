Return-Path: <linux-fsdevel+bounces-75710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Cn7FkDweWnY1AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:17:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 032CAA02A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47E4D300E0C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DF533F38C;
	Wed, 28 Jan 2026 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioWZMzb/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE78274B51
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599010; cv=none; b=k8ExXi2LR4WyfnLRnIEAV90fDS3n/t7kuVSVLF5jv2dWN9vdMvxblJaOY8e4tnfyLqV3X84BtoTjeQ6JP4xjWmtFN10ks5oCm9LH9gBO+tOrERHY/UInY+R5irc8CGbpPFGIognLHB9b9+nWRw8Ko2DcZN6H/Rha+OJ/uRIzMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599010; c=relaxed/simple;
	bh=wGCY4bS5bxdyEjE28JW1gZnzqX+vO5Uux8mFkcXxF5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WaU1hFyah0S5XBMAH7KrO14DhEqqLn4SMrCsU24nRq9wdft+7A8FfS9bvihBI4ZBJ6PuX5UA8/0TAf0J6+g9OX0DjyH/IyCD/gvTzNDA7PSqKz17vPnWtn1q34THps4HP2D3cgDIXbT799Z72IxwQGdCC6MW7NhHxgt7l8QP2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioWZMzb/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b88593aa4dcso734523266b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 03:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769599007; x=1770203807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToKWdSItVHI53efzOxtWevg4AOceET8oQ5ajtU8G+Jk=;
        b=ioWZMzb/hs80v9XHgH7rJPJImmnrOM5Pb5MZHWhAxlhaU7HGif1qIvg8uy6jDrF3o2
         jz4RhdXYevT8wxdvGJdbAurRBn715qLe4q3mZHu5vhV3ZLmnaQbKOxEi/M2r7lrqHyrR
         4okx/Y7G1JiIfBQ+5M2bdApG0HVRbkH/DVYNJs/d7Uo32XBppuWhzNf5k3cofrvyewTy
         DrokeOeIycbwwswlfo3XI8k3j2xCC6gIRC68lW26V9W1bcf1edxR9e2+FI9WPQGL1tNZ
         A+cYhhL2W+LXkSpkVJBl+4CDMlGU9jHebqH1888MObU3cyQ5d+afcJ+GoQuxz83p759a
         V1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599007; x=1770203807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToKWdSItVHI53efzOxtWevg4AOceET8oQ5ajtU8G+Jk=;
        b=KnDfoZVhwym/XIV17UIlD3MaHc/E55VBe/mrPbrqtkeTNN0+Kbyo2NQ0Cq0TcVnNkX
         QaxaLLzYD90RP/tbsTeIjX4R1E7NTtTqXDJgF100JhzV0NFvEqibiDWQ0dGL3dfimOV/
         hzi0U3/xEc5/6bH6QSQ46NVDYvMz+tZLQ8w/qntCI0ASB7RvyfvE7TZn4SGUmnMbe4rb
         msk+KIvV+1ef0VEx7WovqaqkmtmvItPd5D2g7FTpGoSC9/LE83/MLRSEx8vTbBC6T6fe
         uBit/nn1KDQ3lRd1PPfTBW0zywSIR14q7ppLRIQLeartOlR+OdESj/Rop6zyZU2QZd0G
         A9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpfK5C6jFlbi7QBalMzy8JVa0Za/FGi7VJc8JWq3I/tREwARAzVjwnI6DDECQ1BzL0WfDzdRePVKQN7zrQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1DDYsS+MzQybaS4VmiSNv5TR/UOgL/l65gf6lsCtBxZNAL2+
	buk+AKc31Obqly9QsBOPXHs0DAWn1MpkdFc75Mj6aQiMEH+ParvdvmbZ
X-Gm-Gg: AZuq6aKkq38DaDYKB98ySvvF9DXuXyalfPJ58kmc22OxdoJT3Y6CwI1nWLiNnT3WLTy
	zAuYA/NkF1e+7SD6aLXEXAkpk9aOwIuByy9wWTi7xvbWYFDxzzZWuluwGYk+Nv0RNUL8VX4tbbN
	wdDQLbj9a19qt1m3ND18Trab8Ic0jEr87riq2gkLmE0kxbDDu1CZQUF0XJPlmePgdP+B3sFtZ5T
	fYX+CjpksdI7yyIXMdBSCtnhi6YWunzwRdCddhFEfiY12U/8HjGwKrWB4ssjsEg8ekcypODAms1
	PVbY3JwehZqeMN2kvVS308Mj+/0RFU1us97DSBvYMreOyX5YG0qxPpXxxNKGj5JsCm46MCa1dZq
	B38/pKgG5Mi7UbJJyvx4VGsLymYINnG/41y8LIhCLhMvKz63ZRkiOsXtmmI6NMMdut/UWqicYoK
	nFoe8mIuQT7X2q+m8crG3sCXAeUd7Lf2BcHMMmL3uSHZtR+da3dlrsgrTlkRMTbdwcSUkLdh6U+
	dZ2XneR69Lb3LgP
X-Received: by 2002:a17:906:209a:b0:b8d:cbb5:c072 with SMTP id a640c23a62f3a-b8dcbb5c7c6mr64727966b.57.1769599007089;
        Wed, 28 Jan 2026 03:16:47 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-970d-2293-1f03-db81.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:970d:2293:1f03:db81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2ed500sm114462866b.63.2026.01.28.03.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:16:46 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/2] nfsd and special kernel filesystems
Date: Wed, 28 Jan 2026 12:16:43 +0100
Message-ID: <20260128111645.902932-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-75710-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 032CAA02A1
X-Rspamd-Action: no action

Christian,

I noticed that the kernel-doc refactoring queued on vfs-7.0.misc was
going to conflict with v2 [1], so I rebased over vfs-7.0.misc and split
it into doc update and nfsd fix patch that could be backported.

RVBs by Chuck and Jeff were removed due to the slight changes in wording.

I'd like to acknowledge that Christoph wrote on v2 that:
"As last time I'd be happy to help write documentation, but even
 after looking at the methods, their documentations and the commits
 adding them I do not understand them.  So getting an explanation
 from Christian would be really helpful to move forward here."

IMO, further clarifications of the new methods is very much welcome,
but should not be blocking the merge of this patch set, which at least
clarifies the WHAT (to use them for) if not the HOW (to use them).

Thanks,
Amir.

Changes since v2:
- Rebase over vfs-7.0.misc
- Split to doc/fix patches
- Remove RVBs

[1] https://lore.kernel.org/linux-fsdevel/20260122141942.660948-1-amir73il@gmail.com/

Amir Goldstein (2):
  exportfs: clarify the documentation of open()/permission() expotrfs
    ops
  nfsd: do not allow exporting of special kernel filesystems

 fs/nfsd/export.c         |  8 +++++---
 include/linux/exportfs.h | 25 ++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.52.0


