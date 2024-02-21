Return-Path: <linux-fsdevel+bounces-12217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869FB85D1DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 08:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CF31C24BF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23243BB34;
	Wed, 21 Feb 2024 07:55:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B14E3B198;
	Wed, 21 Feb 2024 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502140; cv=none; b=l8tOJ/ifRf4NmacQAcPDdcRD3CTBgG24R1jLv1jnENRAgx7nMFE/wB6lNJUbO7g+EDx3L6bo+GO8iAAPKnofE7cXErXOz4esMPIWULjigDDwa6quEueyqb3SgCt/C1Q1G/yup2u47amXBNu0gthlHS7LQlUl0vbY2jiakFUKLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502140; c=relaxed/simple;
	bh=ZpkTh5RzdIMSX32mbztekXwH7Tdmb6Jgk4BnMOCtVos=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RYuZ748BkpsYQnLL+HBitgyimNy52SOMHaMQElXj8ZwOStwUoTSMk1MUDBW5ar1cHQKug+ziRjSJOQ9SDKxrYN2AoCLIKpZ/PXHpVaqbCRis+kBjaSynqHPN9Y09fXW8ekVHgxmjuYXmWqY48CQ6Qxx8X3isGifh/V/9VAmtM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41L7riDs061389;
	Wed, 21 Feb 2024 15:53:44 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TfpRT1Q4Dz2KH9yT;
	Wed, 21 Feb 2024 15:53:09 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 21 Feb 2024 15:53:42 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang
 Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH 0/2] *** introduce content activity based ioprio ***
Date: Wed, 21 Feb 2024 15:53:36 +0800
Message-ID: <20240221075338.598280-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 41L7riDs061389

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Currently, request's ioprio are set via task's schedule priority(when no
blkcg configured), which has high priority tasks possess the privilege on
both of CPU and IO scheduling. Furthermore, most of the write requestes
are launched asynchronosly from kworker which can't know the submitter's
priorities.
This commit works as a hint of original policy by promoting the request
ioprio based on the page/folio's activity. The original idea comes from
LRU_GEN which provides more precised folio activity than before. This
commit try to adjust the request's ioprio when certain part of its folios
are hot, which indicate that this request carry important contents and
need be scheduled ealier.

Zhaoyang Huang (2):
  block: introduce content activity based ioprio
  fs: introduce content activity based ioprio

 block/Kconfig          | 15 +++++++++++++++
 block/bio.c            | 34 ++++++++++++++++++++++++++++++++++
 fs/iomap/buffered-io.c |  3 +++
 fs/mpage.c             |  2 ++
 include/linux/bio.h    |  1 +
 5 files changed, 55 insertions(+)

-- 
2.25.1


