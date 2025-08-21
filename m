Return-Path: <linux-fsdevel+bounces-58625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 981A8B3009D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 18:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91141CE5C71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 16:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4C62E62A4;
	Thu, 21 Aug 2025 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2pFq3sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4DB2E1F11;
	Thu, 21 Aug 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795365; cv=none; b=ub+vuWw/3aKSPop+UwpnANDXZ01CFiovCHkrp1wFpLcWfY5cpDen/wYIYzkH4P+lF/IX6mIMrceAzecZeu+7ew3XmhTxRZEFvH3/UkqU2MEC7m2Z7jYHJ8t/T2Ob02yVO662WW+37CzG5BtOgxszibvaqnwjIoCSyuGGhkfHy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795365; c=relaxed/simple;
	bh=OTJfMD5H4cDT5DeZwBC9vrpTKC9XBlJdn8JVZTk0OfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQg+5fz9ZmyhuoAIx3AqpXk8nuxUTRMGJ6cndZSleR66wqFAHvrfRnXyDLwqdmS0pOrzUd8o1VENpMR2jSBSMO0+EEAKQTG3OdKGzFSWetb9abP7j/Oxtf/QF//i05DjxqOezjjxpv1hc9ng6INkf8OwEFKiR1ia+NVHBRcNlgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2pFq3sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C4FC4CEF4;
	Thu, 21 Aug 2025 16:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755795364;
	bh=OTJfMD5H4cDT5DeZwBC9vrpTKC9XBlJdn8JVZTk0OfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2pFq3swWLYIK/fEgSYiOtTYtShp4zuzf3sugfUz5NkK2zy+tphCNy/d/MvkUV5/l
	 qFPdgdCYcUco0Hsy/E87K25hxzrJSQ31SToOjB/EDos+/4n0w6rK+chN1ioL48MHSe
	 cOc5MJ6stgKBkcNayHxqqXcg8aqP6QVytAEXPOyhG5RaxxZ0QvEQbRMCvNLn88Jt8F
	 1/zMcIHH7gpllTV7BrZG/PzZfyVGS6HQ3RO6p+MTrHHYJw3elBu54+axH4A+Wr4Ent
	 XIxATolM0fhS3WrWQaGvf0yC85rJjWG5KjW/yH6esL8uKfzbkPthPD699lY0fSp/rN
	 3mZePrUrR0Jsg==
From: SeongJae Park <sj@kernel.org>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ming.lei@redhat.com,
	skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] selftests: centralise maybe-unused definition in kselftest.h
Date: Thu, 21 Aug 2025 09:56:02 -0700
Message-Id: <20250821165602.79023-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821101159.2238-1-reddybalavignesh9979@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 15:41:59 +0530 Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com> wrote:

> Several selftests subdirectories duplicated the define __maybe_unused,
> leading to redundant code. Moved to kselftest.h header and removed
> other definition.
> 
> This addresses the duplication noted in the proc-pid-vm warning fix
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Link:https://lore.kernel.org/lkml/20250820143954.33d95635e504e94df01930d0@linux-foundation.org/
> 
> Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

