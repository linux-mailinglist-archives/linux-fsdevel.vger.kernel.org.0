Return-Path: <linux-fsdevel+bounces-58301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 812E2B2C5AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 15:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAFC1683A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CDD22615;
	Tue, 19 Aug 2025 13:27:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBBB2EB84E;
	Tue, 19 Aug 2025 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610057; cv=none; b=b8X5cgmk9TALLtfQBckzNyy5ZIw4/FA8Q6iExiNmDNW46KJDGRM3Cs1RjBMN3TSE6DAtQA6AeGS5qAKXCQ9lGJp979j4DeJ9kvke3K3w4hSlK/VTig9E94WPGJB68vWxhz/WrlrvemFs6m6y48/+Jeg4AeqGx4bQA2fnSS+KlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610057; c=relaxed/simple;
	bh=TpRj8vHAZFWNXYc4ffjIewJw/0AxhglDFbUbRX9Yl8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbceL6sGHC47ajuJzz7PnYX/4KT5YZf7PqNzIbicZ79ZPNI4P+RE8nBtprRMPWHD4qM+FO3pokfodj3krFvfVrD51U0ntUJQBiBpYNgSe1PR3JTwqBCrgshz1yGc0W3YXHXj9vj0M3bd95F14I/ujV5FwjVrpjcCNQnOFEvsSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.165])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fe378c2a;
	Tue, 19 Aug 2025 21:22:16 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: luochunsheng@ustc.edu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu
Subject: Re:[PATCH] fuse: Replace hardcoded 4096 with PAGE_SIZE
Date: Tue, 19 Aug 2025 21:22:15 +0800
Message-ID: <20250819132215.861-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819130817.845-1-luochunsheng@ustc.edu>
References: <20250819130817.845-1-luochunsheng@ustc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98c27ea45403a2kunmfd51ba9c3fe998
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGBkYVhkaTh9LTk5PSU9JGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTU5ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVUtZBg
	++

Hi everyone,

I have a question about the historical use of hardcoded 4096 values for 
max_read and max_write defaults in FUSE code, rather than using PAGE_SIZE.

fc->max_read = max_t(unsigned, arg->max_read, 4096);
fc->max_write = max_t(unsigned, arg->max_write, 4096); 

Is there any historical reason or compatibility concern for keeping the
hardcoded 4096? Would it make sense to use PAGE_SIZE?

Any insights would be appreciated.

Thanks
Chunsheng Luo

