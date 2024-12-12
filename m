Return-Path: <linux-fsdevel+bounces-37147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423439EE60B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E63286529
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4247212D8A;
	Thu, 12 Dec 2024 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4KiaQzm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B165212F84
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004577; cv=none; b=sseGvOj0DVclsi+tmYb4Rqps1FMZIYtqmrDpIAIMldrsz6eZsTy44ypFGhAeRHSbVFYC0AvOU2uJfBdyDGLC4IBojyMpQcXaCfymGv0sFw2/M7I3HETf2vGmya+iqV5hOclLH3GfkyC4q5EH5eSetQeruqscp7nvypf8H0Wy+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004577; c=relaxed/simple;
	bh=fU88zLcq6ecPFqxhMBQ+2G9JGuR1hEfsB9CdeCQqDmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ln5DLGKKcU21lb0AYYbliqxksoFSjx5sijhbtOhdDlRvP/Htq4ZxhjSS7DUKuwu0mr8p7U/Mu3XsQUXeB5NT67C3YB8dMmj4VyoY6oVdol7um5LY3BISPLAg59gKgk1+v21rjqEe1rqyKQeu3EDdvTR6AD71F+QMWF8i7o20hgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4KiaQzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E01C4CED0;
	Thu, 12 Dec 2024 11:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734004576;
	bh=fU88zLcq6ecPFqxhMBQ+2G9JGuR1hEfsB9CdeCQqDmY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l4KiaQzmKUsYHc4h/FleA3LUDUmBIDPrenQAy14MNEc2KqxQt/mwArQCi1ztB0OJW
	 XQkM/DO+fvAX8VjIqR3VhZk33sj0P436sU1UZPm0CPdZB+Y/u9fAsoSxeIJxor0YEp
	 Zbm1phv6crPceXcpd030KZJK/5wW/hkWi9jdQaUM8Glg8vpH/zlLE6Hy3J7Uz86D9i
	 ADd+agxpAWnAV8/fnazHJ/LbXRb4JBdfZ/RLYyt1DEZqam85eM0Wfe1i+DED+fGrE9
	 GZLNC5b2VInweNgpXWOTqGFJo5a5uv7zsB9l/7i3xfTlseVLB7zg8LMw6hyjWGzK7A
	 ae3ex28RmfSvg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Dec 2024 12:56:00 +0100
Subject: [PATCH v2 1/8] mount: remove inlude/nospec.h include
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-work-mount-rbtree-lockless-v2-1-4fe6cef02534@kernel.org>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
In-Reply-To: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=545; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fU88zLcq6ecPFqxhMBQ+2G9JGuR1hEfsB9CdeCQqDmY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHnY+Zfe+Zw754Px5NRuY8lT0Ht6/U9/8x+0dWW7DR9
 3lz+K04OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbi/JLhN8s/pZMWV/7EfvXf
 U/VIMqZA/fyX5I319zbLqZuKPcs7cJ6R4SXvo8tTHs3ayGiar6dppHrZ3La3SdVpuYtzpd1zo+v
 /eQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It's not needed, so remove it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 23e81c2a1e3fee7d97df2a84a69438a677933654..c3dbe6a7ab6b1c77c2693cc75941da89fa921048 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -32,7 +32,6 @@
 #include <linux/fs_context.h>
 #include <linux/shmem_fs.h>
 #include <linux/mnt_idmapping.h>
-#include <linux/nospec.h>
 
 #include "pnode.h"
 #include "internal.h"

-- 
2.45.2


