Return-Path: <linux-fsdevel+bounces-19572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D028E8C73A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 11:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841DD283F5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 09:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8040D14389E;
	Thu, 16 May 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="vfGCEB+3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JzWG76IW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E2142E98;
	Thu, 16 May 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851275; cv=none; b=i1IsjE7aAX1c32xbxqOTCnKq5FOVn6WY+TDYLFqyUfnDNZacq98UFNNHOJiE1oo9L+ao7poHUqa4NukmMYlUV/R2aahjAVOIkrAwiMrxgH0R4P8xLtsAw81C5qhuFiWeLpUGjs6T5yTwzaZUcYlxe25Cj9p8+QWSnwBOD4VS3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851275; c=relaxed/simple;
	bh=WlFpsPSmyjZIBGHuDRdxoUw1jX7zjzbZNZ4acDEAtqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=War/u7N5xhb5E7GeJQxxOGB99p5dsvDfopSpII11BEfxyzZi+Ir3Mz1JI4hOhDtvOL4AUGEJwA13/08qXFbXm2w2AO/J8QibAlJjWOZwAwwQGbwTgBhXGa4N4Kk6DgvjhTUYKK7QLrvVa5MT56PnNaVXRlRkhCFZYuobfCmfKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=vfGCEB+3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JzWG76IW; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 1CEFA2005EA;
	Thu, 16 May 2024 05:21:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 16 May 2024 05:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1715851273; x=1715854873; bh=Cs
	PwxtNEboc97nItRTvXzU9jOSiXL4Xlxrbhmp4vl5I=; b=vfGCEB+3HkxMxLp9FO
	ipmSzmXydZqFu1zVtJKehBPGsoVPOpBt7iJY2K72FdMMy3GPgrhwsTgSdJdhl/Wm
	hufbpODk7CL30uk43gFZz7HMHQnmo9zaSDiOv2gO1o//Zxp6ljpeQwxIdNewmuKj
	q+IbHE3E0IkZJ4lxfJulTMROPt43AlVGy5WXi+6Zst/KcoXtCxo39BklTb4Xj6nI
	BJ76+5aSPBHiQqcpfxRZCl2rpl/UqhWvfl49Oqd2dMSgdhr8zpR3FrNcDnwpxW08
	wSiyggz5KPuBWT8z/5vdteJvMAGcphPeTq7sqqT5g61HnTZ1PwQQRwGWtFm/0bLg
	WfDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=i76614979.fm3; t=1715851273; x=1715854873; bh=CsP
	wxtNEboc97nItRTvXzU9jOSiXL4Xlxrbhmp4vl5I=; b=JzWG76IW4ZLozth+n20
	1az3Ny4Xt2CyZqw499vfBo2mgA6JRYjUEJ3Xajb4U+gOERt0glG0G18M5+6AspZK
	CmeOYDM2e/PQ8d3ebrGYF979HJReR4jmEKZ2UB9h10vm1aESDbdKltbCp3oQyV3t
	E0fuf6DhmTBYS8uXJkA3oDlQD+7M8kQcjBya8xEVhyzgRtjsXvXVowVbnSAUBxYB
	/qeVi9jQxoBFtgRXaGY04xurE2QPbARUodbw4OKxUjaRhRe32n3yrTFO+uXQEjK+
	IZNDEhuOGW4C64/2HyFOAHl9s+jQB3B31bxh0TLeNHrOjHL5dhwJKdcn+/pc2DZB
	ZSw==
X-ME-Sender: <xms:B9BFZiHJqT7YDFHlGCDvq2lu4QdBaXJ4RldxzRx62U8QJfl_tfV-5Q>
    <xme:B9BFZjVlYImEY28SX9dDH7XrMAdfDHqUth9nh2yD8e-5j4Qgixf5-33nqCVj6CkKl
    2NkXge0KOIos24aQGY>
X-ME-Received: <xmr:B9BFZsINNVN0FqQuhAljpd7Yhu8F9XPPgkU03J9vNNrv-YiTdQ1b9JJMRn0-rYMWZp4ezJtXBcMDQFuxWZU3az18aWqCbwaV_yZV9IDeAjocyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhnrght
    hhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenucggtf
    frrghtthgvrhhnpeeugeehkeegteeugfekkeehgfejvdetueelffeluddutefhiedvudel
    heehheegjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:B9BFZsGTrkdQfNOM7eYbvwjTc3LANegLpivoWFttOnQtjxWutNIuVQ>
    <xmx:B9BFZoUTRC4raHIE87jjZB5fc17SWlBQUe7dhSaN3c5GBSmTso0_0Q>
    <xmx:B9BFZvNpCLLkHwv8gfJDMVkREq0eQ6cXyQgX6t6VnIQUs-ZNjjhtVg>
    <xmx:B9BFZv3_ZjXZBmyvvzoKl702p9Sgs5Jceedvn2QDpcmhgszehQpFcg>
    <xmx:CdBFZpUEL0BCn81TtsDEabx4MVf0uLOLvuvIC1yEAnuTiLIiOx_cuTCI>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 05:21:10 -0400 (EDT)
From: Jonathan Calmels <jcalmels@3xx0.net>
To: brauner@kernel.org,
	ebiederm@xmission.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: containers@lists.linux.dev,
	Jonathan Calmels <jcalmels@3xx0.net>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: [PATCH 0/3] Introduce user namespace capabilities
Date: Thu, 16 May 2024 02:22:02 -0700
Message-ID: <20240516092213.6799-1-jcalmels@3xx0.net>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It's that time of the year again where we debate security settings for user
namespaces ;)

I’ve been experimenting with different approaches to address the gripe
around user namespaces being used as attack vectors.
After invaluable feedback from Serge and Christian offline, this is what I
came up with.

There are obviously a lot of things we could do differently but I feel this
is the right balance between functionality, simplicity and security. This
also serves as a good foundation and could always be extended if the need
arises in the future.

Notes:

- Adding a new capability set is far from ideal, but trying to reuse the
  existing capability framework was deemed both impractical and
  questionable security-wise, so here we are.

- We might want to add new capabilities for some of the checks instead of
  reusing CAP_SETPCAP every time. Serge mentioned something like
  CAP_SYS_LIMIT?

- In the last patch, we could decide to have stronger requirements and
  perform checks inside cap_capable() in case we want to retroactively
  prevent capabilities in old namespaces, this might be an overreach though
  so I left it out.

  I'm also not fond of the ulong logic for setting the sysctl parameter, on
  the other hand, the usermodhelper code always uses two u32s which makes it
  very confusing to set in userspace.


Jonathan Calmels (3):
  capabilities: user namespace capabilities
  capabilities: add securebit for strict userns caps
  capabilities: add cap userns sysctl mask

 fs/proc/array.c                 |  9 ++++
 include/linux/cred.h            |  3 ++
 include/linux/securebits.h      |  1 +
 include/linux/user_namespace.h  |  7 +++
 include/uapi/linux/prctl.h      |  7 +++
 include/uapi/linux/securebits.h | 11 ++++-
 kernel/cred.c                   |  3 ++
 kernel/sysctl.c                 | 10 ++++
 kernel/umh.c                    | 16 +++++++
 kernel/user_namespace.c         | 83 ++++++++++++++++++++++++++++++---
 security/commoncap.c            | 59 +++++++++++++++++++++++
 security/keys/process_keys.c    |  3 ++
 12 files changed, 204 insertions(+), 8 deletions(-)

-- 
2.45.0


