Return-Path: <linux-fsdevel+bounces-29732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D2D97CFF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 04:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080711C22B84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 02:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFCD101C8;
	Fri, 20 Sep 2024 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="KKeIXorr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E00F9CF;
	Fri, 20 Sep 2024 02:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726800585; cv=none; b=IjgTYHfbTqR0EOgc0IK4+aGJ023Ur9R7D6rJJL9LsdVSlNLe6eSYNc2VocG3IGqbUPaUmc5OlMoeSn9rHagm45gH9VbJ0iJY/1tJ59KqkjL/p2robOE6E5x98oYk6io7RBwA5+hEzixarT4IbPZENEwkBLiS5NAhipAkTPEulCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726800585; c=relaxed/simple;
	bh=lMFubXXsL0PKhnM343sH+K8ASfwAxFFtuaILaZWDW44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVJon7O1JOJ0/P1XbexTQyXwSVbLPuZqcd0aE1/bbpED/PvXOG+PHH9i2J62AEdIC76bgvtJ8YtQWYIpLrNFfvcbie2mCZxD4sFl/stpqy/pdhH5qb9BwJ/+IXwpdmfbizwDH+E3QxfHJ/kEXzPfljOqV7VBr1hVd/IhidnUfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=KKeIXorr; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A5D2697C9;
	Thu, 19 Sep 2024 22:49:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726800580; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=NBsLeq/4sQ8AcrTmee8ysml0OejfPujGQbZMIO2X+mA=;
	b=KKeIXorrvFDJLDxpZIcA7qDlcoQGYZzomYUsQiIAyHfsNrjYHg+d4jZTHZtR941rdmKV8G
	Tg6FK6zsqDERv8Jfo/2GUfbWa4PZa/gYOzirfWmMOCSxn5dcCb0BjG5UYVjU4A6D4UejF3
	RbVfiblfSLvzOgo3vZQkekALufyWiRt7bzew03FVylWXsb/8hPNLrJw8TZ5Mdbd5p9zzhF
	2Oi9DKGrkUABOaVv1o6GT3P38SbxxaTQWlywGZOk1OpeZDPxUyxFLEtrqm8sldNJkiUUhD
	9fsgG1pGieiifkxmgsYsc/RsQBl8tohmzY8Ek3g5wBfCBsjRW9hs7hdrt8d68A==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: rust-for-linux@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	xiang@kernel.org,
	gary@garyguo.net,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 0/1] rust: introduce declare_err! autogeneration
Date: Fri, 20 Sep 2024 10:49:18 +0800
Message-ID: <20240920024920.215842-1-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024091602-bannister-giddy-0d6e@gregkh>
References: <2024091602-bannister-giddy-0d6e@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Currently, the error.rs's errno import is done manually by copying the
comments from include/linux/errno.h and uses the declare_err! to wrap
the constant errno.

However, this reduces the readability and increases difficulty of
maintaining the error.rs if the errno list is growing too long or
or if errno.h gets updated for new semantics.

This patchset solves this issues for good by introducing a rule
to generate errno_generated.rs by seding the errno.h and
including the generated file in the error.rs.

This patch is based on the rust-next branch.

Yiyang Wu (1):
  rust: error: auto-generate error declarations

 rust/.gitignore      |  1 +
 rust/Makefile        | 14 ++++++++++-
 rust/kernel/error.rs | 58 +++-----------------------------------------
 3 files changed, 18 insertions(+), 55 deletions(-)

-- 
2.46.0


