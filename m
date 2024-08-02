Return-Path: <linux-fsdevel+bounces-24898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB518946547
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 23:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC0D283965
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404A813A252;
	Fri,  2 Aug 2024 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZAQkd1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F08F47;
	Fri,  2 Aug 2024 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635122; cv=none; b=r6naRdagQEUMJFyhIhMbePtikqjUw2snrnrg653ADqMJEcoPcPovwCkzDnvJmfUbUFgYyOuDt9uJCKE9WYZC/7gGDyEyHlANySF8dFXrX9csCiFR+/KqX8M6F6j1cgclgp6GaL9Jf84q0NUKYuKHnpThBwbJKVuhHpvnhWKSnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635122; c=relaxed/simple;
	bh=3kCp6tq+goBSUagn1CoWudN0Fkm3bJKYcFmLaK8ckKw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EYYsDC0FqVBMu4eRSh9U7JxAoTbu74R/jK+XF3NAwjiy23kjMv5K8xfZTk/2m8bjZgr+VsczwSAP5a9m+KH6OeenoyOFjpydh6DFBIvbjLtv7ShLhuSV49770IG42gD3z8KmuR84BGqq22U/R01VXNHZEv5bL+C1WJAWJyDnYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZAQkd1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B818EC32782;
	Fri,  2 Aug 2024 21:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635122;
	bh=3kCp6tq+goBSUagn1CoWudN0Fkm3bJKYcFmLaK8ckKw=;
	h=From:Subject:Date:To:Cc:From;
	b=IZAQkd1yYixrB40duMKhM6vpcOLOodCbowEMfWZdPnt4BXnt4l3dc0FzFpelBP9ni
	 QziIgTKwke1Gn9JmsElKHpljSGoZ40N8oBTyGvFb6P3ELiJre8aBOnzCiTDVGkkLM4
	 pKGFlz8mnLT9uv75ADXW3OscKVwmG4isZnuuONyAgSrbhGd/2LtA0aeyX0XIOiad5J
	 b759ECjRZ+LP3e8laYVWcaEjAbPgfAaq8k5p/j5rJA3WMX4jr1CeNvdpIGp5zxmWB6
	 xuA0gHTnoevdxutOnmj/xcg0SVU8P2D+7p7gY5g7fkPYGyr9G8+89tOmXbVzr5jnuD
	 BmTDCPVkBeHaw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH RFC 0/4] fs: try an opportunistic lookup for O_CREAT opens
 too
Date: Fri, 02 Aug 2024 17:45:01 -0400
Message-Id: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF1TrWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNj3fyC1Ly0xOIS3cRkE8tE8ySzxJRUIyWg8oKi1LTMCrBR0UpBbs5
 KsbW1AO/rH8lfAAAA
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2264; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3kCp6tq+goBSUagn1CoWudN0Fkm3bJKYcFmLaK8ckKw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmrVNw2zAs9BOoSujnDfa6qUhLagRXocrDdN5Vb
 wwpuz/wMhOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZq1TcAAKCRAADmhBGVaC
 FX+VEACbCvCV+qMt1C9ymNxamQDz/V64GfHrhPIKQ2ashIQog+lLmlrWqrSDNYud/HVkt3KK1po
 WnGuhoN4e2YqRv79abZ440mMVsOMBf82SMkg0l3xTRJyhUhNUrd/kkkLGaJ6eogESIWghw4VUDv
 s/AmSKqyl7b1Hsk481YGu7mp2Szxwg1Sp+M52/F4xilm6x3hkSTmgoy3c0K3TL85F+u8vhCWi3G
 I6VmSCG9fmmW4qnKOaHr3LnBWF+qM6+B7Wasn+P08Uo+QhusAx/QpMAS5qdVc56f5WpCM00dGFa
 nFXNC6s7BsODA9/GWK02fMwA0KrdNvYIZGz5oUhUhmxWvArHvocYb9940Ei5FmlP3HckZV8yq6Z
 w+c5gu1DM/m6WOFsnDK2ZmCxvNZqC92J/uepFcYpDLO+c2h86mg9T5dTumUFws6nnCopZN/sX4o
 OXV6fCvavEfHR/4RtJ4gY5feqaC0AjEQUx2+HQQr8AENXT06wwDB/24RfhPM9CJdJVdvjTmYs1T
 +9oBoGxULkS/I+44IntB0uEiA/S6HXRuJ4GS71kAfJddrFq74F1vUk+7ABx4lnVKktNbl57MLOl
 Nq1nfHkJtHoeuq137rCo6DcxSTYNACQQTeyu4aQJ8cc0hv3s3mAOOUJU5lTInAsWxv8avG7G2xa
 L+q8PTvnioTsqsA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We've had some reports of i_rwsem contention in some workloads. On an
open with O_CREAT set, it always takes i_rwsem for write when handling
the last component. This patchset is intended to alleviate some of that
contention, and to generally speed up opens when O_CREAT is set and the
file already exists.

I have a simple benchmark that forks a bunch of processes that then do
O_CREAT opens and closes of a file in the same directory as their peers.
This test runs in about 18s on v6.10 kernels. With this patchset, it
runs in about 10s.

The basic idea is to do an opportunistic dcache lookup even in the
O_CREAT case, which allows us to avoid taking the inode_lock altogether
when the file already exists. The last patch does this, but it turns out
to perform worse under heavy contention than taking the i_rwsem for
write.

The problem is that that moves the contention to the parent's d_lockref,
which rapidly devolved to plain old spinlock contention. So, there is an
earlier patch in the series which changes how lockrefs work to perform
better under heavy contention. Locking primitives aren't my area of
expertise, so consider that one a starting point for discussion.

I also wrote a second testcase that just attempts to create and delete a
file in a loop (trying to hit the pessimal case where the fast_lookup
never helps). That test runs in about the same amount of time with both
kernels. A Linux kernel build seems to run in about the same amount of
time both with and without this patchset.

Many thanks to Josef for his help with this.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (4):
      fs: remove comment about d_rcu_to_refcount
      fs: add a kerneldoc header over lookup_fast
      lockref: rework CMPXCHG_LOOP to handle contention better
      fs: try an opportunistic lookup for O_CREAT opens too

 fs/dcache.c   |  3 ---
 fs/namei.c    | 57 ++++++++++++++++++++++++++++++++++-----
 lib/lockref.c | 85 ++++++++++++++++++++++-------------------------------------
 3 files changed, 82 insertions(+), 63 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240723-openfast-ac49a7b6ade2

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


