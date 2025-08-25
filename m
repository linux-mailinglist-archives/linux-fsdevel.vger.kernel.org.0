Return-Path: <linux-fsdevel+bounces-59041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4011DB33FE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0116C3B2C2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E52E481CD;
	Mon, 25 Aug 2025 12:48:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1138155322
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126084; cv=none; b=KNI3LFfQidixmPEqme5/ufY3Pm+viBZ24f/WdoNPVOa/9udaEFJE3/TAeCo0jRWuz+9gHmJLipE9ANjjMe1xDn+o/E3GuttX4nkX/NYxc+Eg4d/LrJ1zv9plEhPJSyy6F+L6lMULoizfmZaU0a6U/PkOH3HqbXPiDSAUoUrPbR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126084; c=relaxed/simple;
	bh=155Gdfu/kdzNgzZ8Nxcy8d0Iv0YJSCeNUkBjLDf4w2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcFI4dF7NL+UXCej3cxQAPJzv1Xe6QQurKOwFxIZefkWMqSciObTR3PzW/7jWxD6RcHNDwv72+mABhEQ0uPnUUA5wBh8TTNbDD64In9Fe/O0Yd3m6JHCl3nzrFC5/h6iZ6f//+K3+y/TpUg2G3ZhAwNsPI21ZLWT8T5lk9FJcZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c9Vtq6y4vzYlpS8;
	Mon, 25 Aug 2025 20:47:31 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 20:47:47 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 20:47:46 +0800
From: wangzijie <wangzijie1@honor.com>
To: <lpmichalik@gmail.com>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <ast@kernel.org>,
	<kirill.shutemov@linux.intel.com>, <linux-fsdevel@vger.kernel.org>,
	<rick.p.edgecombe@intel.com>, <viro@zeniv.linux.org.uk>,
	<wangzijie1@honor.com>
Subject: Re: [PATCH] proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al.
Date: Mon, 25 Aug 2025 20:47:46 +0800
Message-ID: <20250825124746.1954611-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250825123107.61980-1-l.michalik@livechat.com>
References: <20250825123107.61980-1-l.michalik@livechat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a011.hihonor.com
 (10.68.31.243)

> Hello!
> 
> This change makes /proc/net/dev a non-seekable file.  There is
> software that depends on it to be seekable (1), surprisingly some
> other files in /proc still work fine after this change.
> 
> Minimal C testcase:
> ==
> #include <fcntl.h>
> #include <stdio.h>
> #include <unistd.h>
> 
> int main() {
> 	int fd = open("/proc/net/dev", 0);
> 	off_t o = lseek(fd, 0, SEEK_SET);
> 	if (o == -1) {
> 		perror("lseek");
> 	}
> }
> ==
> 
> 1) https://github.com/scottchiefbaker/dool/issues/111
> 
> --
> ŁPM

Thanks for your testcase, I have submitted a patch to fix this:
https://lore.kernel.org/all/20250821105806.1453833-1-wangzijie1@honor.com

