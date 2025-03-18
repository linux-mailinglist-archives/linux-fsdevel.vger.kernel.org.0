Return-Path: <linux-fsdevel+bounces-44315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A61A672F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 12:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C66042198C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 11:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5823720B21F;
	Tue, 18 Mar 2025 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ae/8YiK6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51920B1E5;
	Tue, 18 Mar 2025 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298311; cv=none; b=WEUOBr6vuJfUYBHrOt6ugQVl49MqqHEH8e0SIL6SzNonrIbpORtDc3ZbqxAJxwjNCbD0fs/ljXb+M0r5RUVKjl4NZbgtXYkqoEKUHSyq42soWMxBww39R8BU8IKo6fYaS2BO86vVKz8OesCepEuLLumgA6M/ulnHm4j3L91MwiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298311; c=relaxed/simple;
	bh=djZLuLhFAbfsqGXJcK9K1IHjemzYE2KVEh60/L6iSm0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=SGXI1P8rCgrex1WQEIe7Bwgoe/g22D0LFRG14Onota0IGmVnbzPP1UwpD74MeRe5pQSVMm6e9vwveQ5dEcPaKyTed3G00dCNRdnQSbkZJ9E6CMiRUIGflbb0cKPMlcidudnLPknsr+hiaKFsNUxDXKizrm/2Q0qrJgpPtaJ0hvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ae/8YiK6; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742298002; bh=DVBkZ4W/fcutXgYsWgqDMgU4Qx/25LxZQa3j0kVZ5cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ae/8YiK6TD3G6B6JhATj9WSdfxRvk9a6rpfaIIDCax11BGSn/XdBBktsOmNlsx/no
	 hrWLgy9v3BWewBDAB4QAE47AWNuNnVsCK2reYWBHj3z1K0sY2CsvdABOk82dByq86x
	 V8+caKIWPosDJi5TCWqe9PV4cfBqas5pr+wh0FBs=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id 8663962D; Tue, 18 Mar 2025 19:33:38 +0800
X-QQ-mid: xmsmtpt1742297618th3pjxkuq
Message-ID: <tencent_AF7BAE6E502C3D6F989474EAE2ED6ACE600A@qq.com>
X-QQ-XMAILINFO: MmuCfgcSBfHxAwVHfqzUH19oS9JZCF61tXLCvTwE3naizZ44lnfbpY1y7uVtz1
	 A4DkITyEEzW2cWLISCm4ru5npCjznHUnRL5d+B87qS3+BzuAIxhyK6X0bZjyHnMrVnWmP9Q4ejdf
	 uTSka+QzUhnw2ED3fQdsLxwxk3aF/9Y6uFNaP3UHoQ+LYnGx2V2AJXLz/ee9vKk/DfLOO9o7cKuQ
	 xuuV4eqXoibKiTGv0Cl4mYnRvkK9MwYzohHy5uI29r+3k9yV3JTImv1lN7Y8RfdSYYAvqHJoLrKa
	 0DuCId+ybwpST4C0XHgjDDZ5IpmVzuRpJPyjqDyKOoq9CwrW/Bye0TeXszVL/RrpUMTbuhBpyZ3M
	 vttsXy5SZ+Yxh16td5oeUIR8/O+XZeiPD5SNKn8EB5SmaKrasDVsLpifSc36KFUCd6O7LUT7kXkk
	 SZVMMgBVx8rAf4weKT/YX2BG9Xers+pu9BP3woV4a/61Ov7ZwCBrfahCKvZV2UkxIOEjNZ5eFWvB
	 eRVHy0LC4j/rB1wm6mUhXEklaPImnwDg7gX1mtDaG7XLrQeN1sTjaVgW2eHeLCzGU+FQXDMdtTb5
	 96f+V/puqoGPI5pfHbIfjHBCqHkAp5lB+YX6+f6z+wYM8+qIFky6ZXKgiA4x7F2trLvrA5Ae6hwy
	 NrUbmWQX5onB33rv9A+Vrp5FfuxocvIi7riJZ2W2JxSnvTBcDZKNsXPcklpsMr+26qR8nWMJq7/P
	 LmA8GsFrxQCz5wL1FHtQKM+OyXCzpfJn2pLOqdyLxOZxDJLQylj8x/TQeO/MDrWeUZB8RRygUwUs
	 p6PE3fgclswS3ez1nKsu9houc+z0J9hOt0hHDo0FOgzJATbFYnivlm+dnJiCjlHxZsLRKVatiQP3
	 lIahiUyKt0Zfaua5A63XE22rfz41uSsxYWR3lEAi4KB6tiBHcav1qLL5UA2MKSqg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: dhowells@redhat.com
Cc: brauner@kernel.org,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marc.dionne@auristor.com,
	syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
Subject: Re: [PATCH] afs: Fix afs_atcell_get_link() to check if ws_cell is unset first
Date: Tue, 18 Mar 2025 19:33:38 +0800
X-OQ-MSGID: <20250318113337.3608413-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2481796.1742296819@warthog.procyon.org.uk>
References: <2481796.1742296819@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 18 Mar 2025 11:20:19 +0000, David Howells wrote:
> Fix afs_atcell_get_link() to check if the workstation cell is unset before
> doing the RCU pathwalk bit where we dereference that.
> 
> Fixes: 823869e1e616 ("afs: Fix afs_atcell_get_link() to handle RCU pathwalk")
> Reported-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> cc: linux-fsdevel@vger.kernel.org
My fix already sent, it is much earlier than your patch.
https://lore.kernel.org/all/tencent_8CA5671E3C533638973237484A0874917609@qq.com/

BR,
Edward


