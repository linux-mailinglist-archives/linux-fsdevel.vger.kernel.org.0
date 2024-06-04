Return-Path: <linux-fsdevel+bounces-20909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EBF8FAAD9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E0C1C22621
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F4B1422C2;
	Tue,  4 Jun 2024 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov31VYfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F4140367;
	Tue,  4 Jun 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482600; cv=none; b=C0g3d5XJOhFlHfroMcZRuvu5ZmLOR0a2xh25a7+mZXpaPQrM1lc5U7rxLlyZ1PJKVFz6MXmz0Iqod+qo9fNdl/8oeGaZX53nOVj1dRgviqrO4//eXRN5LFjisvMvFK8/ITJk+Ftq1ZoOWg6z/MJPwJqxbDJt1KOtq9GjDcNpjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482600; c=relaxed/simple;
	bh=JGQT+4p7AHY1M4o7zhyH0qaV8X0DJMDz7KyqjSiOFsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fD9jSjEg5bX437HfmoE+gkwaCBDGyAFpjotEoQbtSs5RsDwV/nPZ4BLbEpimw81OEGTFKbqvymtB7O5pK8S9BukYX1+wUPDEO4mdeuDfgyGlY8woXhxq0w8sP3GUZZ7bVc98DXs/4F00urXAEhnu4FvImNSyR66oeusk8QGbpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov31VYfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDCD8C4AF4D;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717482600;
	bh=JGQT+4p7AHY1M4o7zhyH0qaV8X0DJMDz7KyqjSiOFsU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ov31VYfkZBszW6nagLY0k+JHZFiMxqJo3NcOel+En0isAe6LtNJ5y9FCZfVkctPXW
	 7LZXgH+PAQIjLBC9dyOCddavt9rrNFFKGGv6IMMcx3bY8Q7DqGre74pUdfLFZfUeNM
	 hWdD2xN6klufntacPQjGZGfzu330vz/iZu8Nc3CaU4JkedUXKFzApi9J+FforQvK3M
	 YIsRBX7BW2vwUnsRrgTn1x7qKJ1Af+hCmT3ykgBjrSZvvSwXqLZCZpZmizxPBxJYGG
	 KGkvDazh0oyOkjL0uXlmsNAYBbMUKCvHSgZAiHOeVFQsshxaeKy8d+QttD2HlqsDLO
	 QJJeoHRH5qHfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B6CC25B7E;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 04 Jun 2024 08:29:26 +0200
Subject: [PATCH 8/8] sysctl: Warn on an empty procname element
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-jag-sysctl_remset-v1-8-2df7ecdba0bd@samsung.com>
References: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
In-Reply-To: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=837;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=kiBCYRLAjKste0XuHE2np63NWadPBoIGUUndp1NrN98=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZetGXOjyV9+/Ko/a1TAa0g3yQtd6zwj6D29
 kW6R7OTXh/JPokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmXrRlAAoJELqXzVK3
 lkFPABkL/0chps6Tybj/Jceo6dk5TxaNFxxf/9U5ng/iiwgx4Aud25nQYC/AmsWbL/his/ClEv4
 8BuIUh8G4fFijVL56/El1GEAVxd9J8z8s6c3d83lZ+7po/aWsz9lvgO6nh3tTe8U6TKKV+Rh0jL
 EKXjAJ+S4/CNLT4NBhCuIY4P4LyQIjgAxHx3p/ryNWc08tJJAK0bG+L3cllECbQ7X+usHu9Q9dq
 mg5tVGmxkunsrP/nLQNrlC+xpppGWp+fc5g9y/QeTAXHVHQMCZkeV5pJfgBWVGMUv9F7juRGJAB
 B5ySh3sHHaIo8scZIIYsRqWs1/4dR8vxgpa8iXykL41Px3oJuinO01eFG2gdAht/skleaLIIW5y
 k36ZfB4mYUmXBtSq/YEGDd4IerIixbbq7Hc5F+g+l7Eby59/gbzU06uOy3mGyuXFVzB0WHcZFiz
 +zN9loEzcIEe/WaIq9hQLiHtkj3fwCmwXLuAOl6RzQgKnNf/jXmyJJL30Dsd9/INhxAp1Tc7SA6
 74=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

Add a pr_err warning in case a ctl_table is registered with a sentinel
element containing a NULL procname.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 806700b70dea..f65098de5fcb 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1119,6 +1119,8 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 	struct ctl_table *entry;
 	int err = 0;
 	list_for_each_table_entry(entry, header) {
+		if (!entry->procname)
+			err |= sysctl_err(path, entry, "procname is null");
 		if ((entry->proc_handler == proc_dostring) ||
 		    (entry->proc_handler == proc_dobool) ||
 		    (entry->proc_handler == proc_dointvec) ||

-- 
2.43.0



