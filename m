Return-Path: <linux-fsdevel+bounces-22632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E428A91A8E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 16:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7731F28DF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5AB196455;
	Thu, 27 Jun 2024 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqQF+swf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEBA195F17
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497516; cv=none; b=oS1emZE/OOOLlh4oDHy2U3hXSIEovsVBc2bYaSoeir8KyF/0FhpxR0gYrlXZ7UuWY0q6SZBV2KYIt0dm3dXRZlkXJS9CtKDQQLmFvOpcz7iIPzSbjFIzayevWiXMJ1qCCsTBno1u3cqhoy/WP4CY7jRjtRKdAkAFFfSPtO5ShLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497516; c=relaxed/simple;
	bh=fLI5VNnaW1p1VE6zABm5LJKcIFdO+DuZlRAxkVGTW34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tvFiDkCwMSPk9+tQGauxUEB2pt1dFgHXuqQ5LLLbOFW0EOMI2+ZBGNGq6aXR675pyyVpB7ctkYGhWKI771CsRu7jXNNbrAdHLPd1bqwDGfp8i/FS0the34YhbLvjuPB9IBgDF61dPfjsq4cjHpkglA1v/LndFCoa36ehemqp0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqQF+swf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966DAC32786;
	Thu, 27 Jun 2024 14:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719497516;
	bh=fLI5VNnaW1p1VE6zABm5LJKcIFdO+DuZlRAxkVGTW34=;
	h=From:Subject:Date:To:Cc:From;
	b=OqQF+swfOPLUC74mmu2jCekWS9SLbLncX/zhSBr1/EedcWiui6dr4zJ78ZgqhmH1A
	 RtZfMEpt48bkal5mRzpyIGAm34YMMFd5IxIeJ8Tk8+fK3HxSpRf1Z1olndmE333tP8
	 lFpblm3E5ZpV6qVEJiQT3f4BZoRXYI7WZNLttBfhG3TduL4nsFyTUfTh3bp5gApAPF
	 8d2wPFOkc4DKPJlyza7t1u9Dd75cbPwuXSVw29IFzTqtD2Dt26FZcMGkNuV+dZzWoC
	 qcL1s++TKtOGHBPEBZQYUCfBgDYmcJ7Mhza48MYUls/OhQk/Ex6laYB7H06Sl/2G7t
	 IH6DtcKGbapLg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/4] pidfs: allow retrieval of namespace descriptors
Date: Thu, 27 Jun 2024 16:11:38 +0200
Message-Id: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABpzfWYC/x3MQQrCMBCF4auUWTvaxKjgVvAAbsVFmkzawZKUG
 VCh9O6mXf4P3jeDkjApXJsZhD6sXHINs2sgDD73hBxrg22ta8/2gt8ib5w4JsUUnTklF48hGqi
 HSSjxb8Oe8Ljf4FXHzithJz6HYXWKcM8Z/TgeVmm/SbAsf/F/dCaJAAAA
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Seth Forshee <sforshee@kernel.org>, 
 Stephane Graber <stgraber@stgraber.org>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=587; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fLI5VNnaW1p1VE6zABm5LJKcIFdO+DuZlRAxkVGTW34=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTVFms2iqiU1r1c2Hm3omTf2buL+58YBE+akW/0YObTH
 uNA0Vy/jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk08zL8TztaULj3xYnln4u8
 gx9bnbUKyDiQMnVvxpZppoKzP615ls3wP9N8GnufzuRT4oeclh/c9kRfN2lq4FMNVp1QgdctSxx
 6uQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In recent discussions it became clear that having the ability to go from
pidfd to namespace file descriptor is desirable. Not just because it is
already possible to use pidfds with setns() to switch namespaces
atomically but also because it makes it possible to interact with
namespaces without having procfs mounted solely relying on the pidfd.

This adds support from deriving a namespace file descriptor from a
pidfd for all namespace types.

Thanks!
Christian

---
---
base-commit: 2a79498f76350570427af72da04b1c7d0e24149e
change-id: 20240627-work-pidfs-fd415f4d3cd1


