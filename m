Return-Path: <linux-fsdevel+bounces-79678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFm4Oiasq2mcfQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 05:40:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAFB22A128
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 05:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDEAE303D88A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 04:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CEE33B6F6;
	Sat,  7 Mar 2026 04:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDIaLcM9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF88A1F3FED
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 04:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772858398; cv=none; b=aiJq+XlhQZjhifEnJu3bXEXHfS0tIwD0iehLKvLfXoV0P5TYNIwNK6FGKl+6BVmJFDSlCitvhvQdjJ/2GgJwdM1poNeXzzy56y0XKM9M95ZqtjoJW8BeooG1o8TCYvfy8dFTdkEnJhlYlJVMUroZxXyFyNyE+4Plj0MZs9wh5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772858398; c=relaxed/simple;
	bh=4ATwsTz8ziLAyDuWlK4KdVZopPk0DA6HM2567HiDEEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs/sBfVMsdLUjinNwrIpNrEvu9wSOHx0QwphmE+KAObM86b469wWX7eOZK3xtxhXzPrWBV51WizTuU3I1Be/RnsCO3AvQgTqzMPAht8RvXp2YtiflZzKo8+WCNt7zLXFHbZZGGvS+mOp266S4/9zDaaJdRF7wIi8fbOR0gmObQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDIaLcM9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso5093793a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 20:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772858395; x=1773463195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=enfq5btaKGYj0ZOezkkWdQHPcpQw23/+zvd7oPjvhzg=;
        b=ZDIaLcM9BAsQtceDyepqoJQsicRIJ2/U6PmuZBViRb3zfwDKnhTeMOtr6//SKpXoUv
         MzmHNCJlmj2VTi430UXjrhuT7P1Vhjz/TD/nAuYJaharrSWUenZx6Er1BbjWvh3lfJKa
         8J+BtLsLLnve2vaxC39y8uxYCGkkjOXhhQxGiq2+uSuXxYerxgVQLBfMEqOmuRUehotJ
         OfLYJXEk3Q2hB4YjpiFiKJw3lij9fmtLd1oZnT/9XXa0lijbXBLke3tcTpJNEDzGmpkl
         SIpmalu2un47YrZs0bi0i8Pwu54oGm+v9rJMdGmKwveEug5lDb1z5Wb2QokkXYsq44lZ
         7hVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772858395; x=1773463195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enfq5btaKGYj0ZOezkkWdQHPcpQw23/+zvd7oPjvhzg=;
        b=W22F+i95a04gYnhgsVkRRv4nOU3YV/mdtuiiJruqpQ+u8WYqlNLfICY1Q9njH8kfNh
         1tfktgGhcy9nmzqvAxFCnezfRRdEFeKDlJk8b3iru/cPVoM0hpFjwcMCUt6qqiXoFw5w
         60m9nSfGjBESxNYIaIhamouGQKcmW7dKGGKk0EX9e09xQj3kAJMmcmuENGnpfWD8lz14
         rSCwC7VsIcIuektnj/Pfd+g9QwEtv+RC2KenqJV0tNaouwKxVebRPz90kLn/EJZSLve5
         gDMYYTyhO7ak7KetLdR3ubnUwNijQKLWoe7wzjgCOFZa341BqVVQa6B2ZGFCRm+ixB26
         ayjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUehjMZ9EfFX1yolbKLIlxSioa+F2tyEodarI9gerVNOZFMMMCIFhCPRQOImGtLqvcxOm5nfXXWLSSmUNuu@vger.kernel.org
X-Gm-Message-State: AOJu0YxegosJbJBun0bTzrs5166hT5z4/UTa8CTwwjDRGQFjz/hEKaMg
	ZZ201KqL+/R3aniC93FxIv/wqc4J9qSqj8t01WN73jEXRJV5nYrF91J/
X-Gm-Gg: ATEYQzzLtRuZN9O+6hHhgKRgLu2NiZ1sVHX/uOEbrEo17ohuvW3Z9oy4qIm1sGYwvdG
	nOdH9nzH35Z7BG6wduRCz5rWOpoPaX9mKxL5xGYhcb1Why8i1WGvnT3kSx6Q8FvWcGkSjdcUudY
	ZQB+3UwBK7MpUi45KZe2uvstOFxf1HgrIdQiPloSDVpbSRUMiq0PdkMgGNOyqVSDGMEYO2yLRLn
	NXq/5HG8CEs2QbXVwToILbgaVjDgTEZzJLnDnPt+MLe5Ezt8sarhLJRTSOZbGydIEKsjR5zMxs+
	KzrFIYt/EN7vk3QPiO6KL4J7fhIWy3dRHixfyRMw90iNop0gMxPL4dxKDFnfeb154dutWFNV7t0
	49CnPDVNwQhvEmhG9oyleMYsVWZc44/y4NtFiY8t1yUkO10x8f1R9xJMG7zNO+SakHGe9o7qPJS
	NIyIHdpAL2z9Myw5uBLw8I8zuImCp5Z8X8dCigqBg7MZ/MCC+UWHKHwSKsxOFwh9Wd1gE+kudYX
	iR4Gaw=
X-Received: by 2002:a17:90b:498b:b0:340:be44:dd11 with SMTP id 98e67ed59e1d1-359be3536a4mr4381767a91.27.1772858395271;
        Fri, 06 Mar 2026 20:39:55 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:4191:5f1c:7dc6:bad2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d38ab8sm6809244a91.1.2026.03.06.20.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 20:39:54 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: dhowells@redhat.com,
	pc@manguebit.org,
	brauner@kernel.org
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] netfs: Fix NULL pointer dereference in netfs_unbuffered_write() on retry
Date: Sat,  7 Mar 2026 10:09:47 +0530
Message-ID: <20260307043947.347092-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6CAFB22A128
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79678-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,7227db0fbac9f348dba0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

When a write subrequest is marked NETFS_SREQ_NEED_RETRY, the retry path
in netfs_unbuffered_write() unconditionally calls stream->prepare_write()
without checking if it is NULL.

Filesystems such as 9P do not set the prepare_write operation, so
stream->prepare_write remains NULL. When get_user_pages() fails with
-EFAULT and the subrequest is flagged for retry, this results in a NULL
pointer dereference at fs/netfs/direct_write.c:189.

Fix this by mirroring the pattern already used in write_retry.c: if
stream->prepare_write is NULL, skip renegotiation and directly reissue
the subrequest via netfs_reissue_write(), which handles iterator reset,
IN_PROGRESS flag, stats update and reissue internally.

Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Reported-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7227db0fbac9f348dba0
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 fs/netfs/direct_write.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index dd1451bf7543..4d9760e36c11 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -186,10 +186,18 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 		stream->sreq_max_segs	= INT_MAX;
 
 		netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-		stream->prepare_write(subreq);
 
-		__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-		netfs_stat(&netfs_n_wh_retry_write_subreq);
+		if (stream->prepare_write) {
+			stream->prepare_write(subreq);
+			__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+			netfs_stat(&netfs_n_wh_retry_write_subreq);
+		} else {
+			struct iov_iter source;
+
+			netfs_reset_iter(subreq);
+			source = subreq->io_iter;
+			netfs_reissue_write(stream, subreq, &source);
+		}
 	}
 
 	netfs_unbuffered_write_done(wreq);
-- 
2.43.0


