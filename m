Return-Path: <linux-fsdevel+bounces-33968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C02589C1095
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 22:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54BF1B25B5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 21:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B6A219C9D;
	Thu,  7 Nov 2024 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvTpvvXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B35216420;
	Thu,  7 Nov 2024 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013217; cv=none; b=lrdGI4LzL54yFQ41bk5kVX2QUWl19c2yyVYwmljXuopXjjy0QLszKU704IkHc5YASAclg7Ce0yQ4dFFmaHgwc2PDnz/5yfoqKmk8RfTkJ8xQ2XuQFC8N8zRC49FSAyVXsEiZ5OTqtEogecWx1bn5KXNf2qwbIku1T0OXCIlbK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013217; c=relaxed/simple;
	bh=abaUwEE9vgyuDZkMhWIDnLlkpxXpgz/cAX1JLnMW6Io=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZEI8N9KNw77a/KKSbJLQWdKKXCHtlJ8/8Mq3gyf+BVzx1I+oUxXp49xixGTunADEJenlvtYZ+AvdFpKp0v6ofpp2htB+wMq7IEBtiGd5PXym290z+gScATCAO3YK/I554N08DkVGa8tpwkeliQPUIZWYxJta26gH1FktNBjaAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvTpvvXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F82C4CECC;
	Thu,  7 Nov 2024 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731013217;
	bh=abaUwEE9vgyuDZkMhWIDnLlkpxXpgz/cAX1JLnMW6Io=;
	h=From:Subject:Date:To:Cc:From;
	b=NvTpvvXV3wiSN2wzG6XMuaLhJoQMV8fVwKUpvtQzL1tnnR/w2oNcDZ4+OHC0+sPBI
	 MCNY0B0UVV4rFboUAE5UzKEvlizirny6t5fba+P/vPrk05ZGeKF8A3aw18LMQw40He
	 UUxveFEAzRftSqElHprfsjulaARZTnKPIgsUZMAAa4bHHFUOrfKTjsCEzFNSJLT2z+
	 sfcvd8GqHBRw6Axpg1KbPAcXLn32UwicvqKNjw/itM2YLpVMktdHd81m/+CGfKgYkg
	 Q10dN2hUrB5+G06lo1jxddL58hUc+yTOHPzbEPhCaphM3ykpYrCMrL4pqR/f3unB4Z
	 fEWlTYtYM8LuQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/2] fs: allow statmount to fetch the subtype and
 devname
Date: Thu, 07 Nov 2024 16:00:05 -0500
Message-Id: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFUqLWcC/3WMQQ7CIBBFr2Jm7ZgOaGtdeQ/jgsrQEhUMINE0v
 bu0OxNdvp//3giRg+UIh9UIgbON1rsCcr2Cy6Bcz2h1YRCV2BJVNcak0t0/XUJpWlIN62ZnFJT
 /I7Cxr6V1OhcebEw+vJd0pnn9VcmEhF0rO2V029SCjlcOjm8bH3qYM1n8VQVWOJtCKS33+ludp
 ukDt3AKmt4AAAA=
X-Change-ID: 20241106-statmount-3f91a7ed75fa
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=abaUwEE9vgyuDZkMhWIDnLlkpxXpgz/cAX1JLnMW6Io=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnLSpfGyoMPss40glOgHHEY5CBLo6BC/bgPGS5K
 JS1mxPh21CJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZy0qXwAKCRAADmhBGVaC
 FTagEACky1OeObGYBFFh9gZA6EDyF8nIWUGqGPr13e+NpiiOKTq9S3rOZtxmjpazKBrzndMhlnp
 Nlb2h2oNMJEcG/PD4Z1ABF6aVUwTcWiv1xVgq+Z/ccSxeekHome7VQi/D1sEuD92ZMYExi86rSG
 waTV68gIX0SxirJJMIHiCFdFK0pvfZCFborvARR1d5MgjUuZlHNriwTR7aKFw57OCp34IP4CTgp
 HhFIGlWx7gNrtC5McOdRHaB+HTYY34QWaOmy55nBJFSbHMCvmTu9ntn+CzmdtV+o343JLkFAOwm
 dx44zAlgiXtwW7YL3nxZ5uWoywQp9bIS9r08AXVJq9CV2vXNdhA5U3Zs1OffUW4+pVI1as1+vJm
 kpSygmMDY5hD1iSL0gzcwSui0PtPGo2HeMy8VAcKXIgEIgHdzNWAK6RQZAKn1X3QF9GM+fd0fgx
 QQajohcBnV79TTsRgBZkiFnQJFo14Kag+RaM/CmmC+4VTtBKkFwsPLVorOI9HgnlWaK5p7LJggL
 AaB3A8+eI/6X5ptwfHBzMv6GO481q301fBRI9qAe3CwOY3TBdnNs5XPePn1iuPbYyPfTIHGaIwV
 Srs+VZpf39a30142VG7kis8psiOusXDgcUmyqxFG8/jfFQV6L/1Om4G3AVMwEqCxgLimzLDEdR8
 fxb+KwDC0gfvy/Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Meta has some internal logging that scrapes /proc/self/mountinfo today.
I'd like to convert it to use listmount()/statmount(), so we can do a
better job of monitoring with containers. We're missing some fields
though. This patchset adds them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- Unescape the result of ->show_devname
- Move handling of nothing being emitted out of the switch statement
- Link to v2: https://lore.kernel.org/r/20241106-statmount-v2-0-93ba2aad38d1@kernel.org

Changes in v2:
- make statmount_fs_subtype
- return fast if no subtype is emitted
- new patch to allow statmount() to return devicename
- Link to v1: https://lore.kernel.org/r/20241106-statmount-v1-1-b93bafd97621@kernel.org

---
Jeff Layton (2):
      fs: add the ability for statmount() to report the fs_subtype
      fs: add the ability for statmount() to report the mnt_devname

 fs/namespace.c             | 68 ++++++++++++++++++++++++++++++++++++++++++----
 include/uapi/linux/mount.h |  6 +++-
 2 files changed, 67 insertions(+), 7 deletions(-)
---
base-commit: 26213e1a6caa5a7f508b919059b0122b451f4dfe
change-id: 20241106-statmount-3f91a7ed75fa

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


