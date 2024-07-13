Return-Path: <linux-fsdevel+bounces-23638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD09306E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 20:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1FF1C2168F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 18:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ED713C3DD;
	Sat, 13 Jul 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYrGx+8A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC351CFB6;
	Sat, 13 Jul 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720894554; cv=none; b=Ji4TakAbvlLYHcEbXF39VUJfcVW+Fo1PQa0tn0fskDFz6V7f1y9CqZ3eDLXXV8jCf9omSXhMvQ2LaN9sx3udDaoXo9MMoDtPf4z7kWRiYLGel6s/uX1wVAfsKUnoMLpNIP4PiisgcwVLDFFsy92JZGPfBSfqDzknZgTgnu92L/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720894554; c=relaxed/simple;
	bh=UQSoUz8qJ8oNpDVGR1Uf6HtiOsfJz/+ixtVRaKJlnjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZW772GJVWz0EflPTuJR+bLdyJ+J9KddZIYUkWoX1UOHQazC/b8DMnJapzMy2AhAleQ6k+5Hl6Wbys8IGnpZ/b/WM/rnIa7HBqMtfTyUbncyK4wLS0EZ0ufEgXouMRdOxv5m3VkXXh8uDhLCiq6EahNN+yQjqIjsGBAS9PNMj59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYrGx+8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926C6C32781;
	Sat, 13 Jul 2024 18:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720894554;
	bh=UQSoUz8qJ8oNpDVGR1Uf6HtiOsfJz/+ixtVRaKJlnjk=;
	h=From:To:Cc:Subject:Date:From;
	b=GYrGx+8AF0//JOt9FDMY2zeDCDHMZW6N4DSW1Nk6icNVxdvxp1dGwXFhjIJVSLdWd
	 6MtflWVbBQX66h2HZc1nd1LUcr51UJ9De3q/BdQRtmKRkDSFoEWy500XMUEgIRPohz
	 bHaVGP1pu9SrSaDmIDNTxDyyLyKYE4rmk8Fmgg+A76fh0YdH+n1yIzB7Y8m9ecKIVM
	 v7VSYAY2DUOCysxX68aBF9tuPVKC6ks+tc6tBlB3lrswEU9dIyQdbd/0yVIPWRmyma
	 K3k76Rle6j4pqyxwhMnqUAe7GWDyU1HKkWxITxX5nellAdJ0V/smskX8TVIhdoIjEk
	 z/PtEGTSz56vw==
From: cel@kernel.org
To: alx@kernel.org
Cc: linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/3] Update fanotify man pages for NFSD filecache backports
Date: Sat, 13 Jul 2024 14:15:45 -0400
Message-ID: <20240713181548.38002-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I backported a number of NFSD-related fixes to v5.15 and v5.10 LTS
kernels. The backports include some changes to the fanotify API
which need to be documented.

Changes since v1:
- Amir added a few items to the original list of updates

Chuck Lever (3):
  fanotify_mark(2): Support for FA_ flags has been backported to LTS
    kernels
  fanotify_init(2): Support for FA_ flags has been backported to LTS
    kernels
  fanotify(7): Document changes backported to LTS kernels

 man/man2/fanotify_init.2 | 8 ++++----
 man/man2/fanotify_mark.2 | 8 ++++----
 man/man7/fanotify.7      | 2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.45.1


