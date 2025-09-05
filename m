Return-Path: <linux-fsdevel+bounces-60334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E134B450D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 10:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2111C2064A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F079C2FB626;
	Fri,  5 Sep 2025 08:04:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C6270557;
	Fri,  5 Sep 2025 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059445; cv=none; b=u/A3X19Im7nZegLPRucGFdZoNUPSEchJUpNXKWeMHL9Bpz+3AS/9Wew8l5e87Rv54yQd6+eNjGdGBpUnNZZKverJoSTQ4DetweD62LpAFi9ih03+bgyxPOGKgbPJkYR4JY4OUfuZWYEh95DqbFayVZ3bPJx9Csb40pQjYZAgzsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059445; c=relaxed/simple;
	bh=cbxXU01GVgzyxmNZKhm6Cjgn0TAgIz4SAbFBFOPg7+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMIcaOr7u8+Q+3GNQ2HCD5bYZ3zNJdlJ2bhcGkCFGmBXGH9qWs1NP7gLoGueoD7afrNLKlOgSKmGUhixVDgJfUVMX4kVg+z4nOueOLzSvjEzhr4BENvFF9zfiwIfYMnhEIx1q6jiWlsVAT0NPGMx+qfi2iN/CYC7nSI59QcsBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cJ84909gjzYl2R8;
	Fri,  5 Sep 2025 16:03:37 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 5 Sep
 2025 16:04:00 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 5 Sep
 2025 16:04:00 +0800
From: wangzijie <wangzijie1@honor.com>
To: <akpm@linux-foundation.org>
CC: <adobriyan@gmail.com>, <brauner@kernel.org>, <jirislaby@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sbrivio@redhat.com>, <spender@grsecurity.net>, <viro@zeniv.linux.org.uk>,
	<wangzijie1@honor.com>
Subject: Re: [PATCH] proc: fix type confusion in pde_set_flags()
Date: Fri, 5 Sep 2025 16:03:59 +0800
Message-ID: <20250905080359.4063152-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250904155517.d623a254e8c25027c41e8e41@linux-foundation.org>
References: <20250904155517.d623a254e8c25027c41e8e41@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a011.hihonor.com
 (10.68.31.243)

> On Thu, 4 Sep 2025 21:57:15 +0800 wangzijie <wangzijie1@honor.com> wrote:
> 
> > Commit 2ce3d282bd50 ("proc: fix missing pde_set_flags() for net proc files")
> > missed a key part in the definition of proc_dir_entry:
> > 
> > union {
> > 	const struct proc_ops *proc_ops;
> > 	const struct file_operations *proc_dir_ops;
> > };
> > 
> > So dereference of ->proc_ops assumes it is a proc_ops structure results in
> > type confusion and make NULL check for 'proc_ops' not work for proc dir.
> > 
> > Add !S_ISDIR(dp->mode) test before calling pde_set_flags() to fix it.
> > 
> > Fixes: 2ce3d282bd50 ("proc: fix missing pde_set_flags() for net proc files")
> 
> 2ce3d282bd50 had cc:stable, so I added cc:stable to this patch.
> 
> > Reported-by: Brad Spengler <spender@grsecurity.net>
> > Signed-off-by: wangzijie <wangzijie1@honor.com>
> 
> A link to Brad's report would be helpful please, if available.  We
> typically use Closes: for such things.

Closes: https://lore.kernel.org/all/20250903065758.3678537-1-wangzijie1@honor.com/

Thanks for reminder, I'm not sure if this link is appropriate.

