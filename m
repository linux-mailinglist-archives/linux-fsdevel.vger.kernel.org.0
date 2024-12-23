Return-Path: <linux-fsdevel+bounces-38022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003079FAD8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 12:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D771663F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 11:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EAA19993F;
	Mon, 23 Dec 2024 11:12:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB01991BA
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952362; cv=none; b=SiUGgE9SqxL010sWfF+ZCNyt87UDFq0hjJ5DxYumGiqp7+cJZzBjWFi2sgTJXimpS7C8NTCqUXA2zJZLjr1npyF0fbuPoUUyLYV6AFdyWzsDoTL3bk1uCPeNYqeddcUpejVHr/VhmCnw1lmgttNTX10NEqrLTPzynZF9roxlS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952362; c=relaxed/simple;
	bh=E4Z22IunIgmB1emC0ErQlC1s2OdI2WInS1rHRZLEAZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nz4T1seSnXj6TEqgi4cPkSXg/rfIcRputkVxdDK1JR3dGTB8lVgSROwvKq/Y7ZqCy714ldVtz7Rj+tyQvoZZyEOflpZhV9TmCxlUHgAzeMgnvMCgSSquMLzJB9bzMYNL6P4r1NjBWwx8pZGMgmOMHyGSLLxk5QVzLXWRqRryeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.169])
	by sina.com (10.185.250.22) with ESMTP
	id 6769459B0000786E; Mon, 23 Dec 2024 19:12:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2647377602532
X-SMAIL-UIID: C1708BCF3F414DED9835CD1A37FA69B7-20241223-191229-1
From: Hillf Danton <hdanton@sina.com>
To: "NeilBrown" <neilb@suse.de>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Jan Kara" <jack@suse.cz>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] VFS: add inode_dir_lock/unlock
Date: Mon, 23 Dec 2024 19:12:23 +0800
Message-ID: <20241223111225.389-1-hdanton@sina.com>
In-Reply-To: <173492340768.11072.6052736961769187676@noble.neil.brown.name>
References: <20241220030830.272429-1-neilb@suse.de>, <20241221012128.307-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Dec 2024 14:10:07 +1100 NeilBrown <neilb@suse.de>
> On Sat, 21 Dec 2024, Hillf Danton wrote:
> > Inventing anything like mutex sounds bad.
> 
> In general I would agree.  But when the cost of adding a mutex exceeds
> the cost of using an alternate solution that only requires 2 bits, I
> think the alternate solution is justified.
> 
Inode deserves more than the 2 bits before such a solution is able to
rework mutex.

