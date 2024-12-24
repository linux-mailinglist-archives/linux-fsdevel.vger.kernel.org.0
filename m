Return-Path: <linux-fsdevel+bounces-38093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0BA9FBC79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 11:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A311885CBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1DD1B6D1F;
	Tue, 24 Dec 2024 10:26:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F218FDCE
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735035984; cv=none; b=rHswxemNGYlM54MMssBzPy7xe2L58KNWqbf7bYAQQ3h6nUZBeTPh2fwlv0HX9ttrXWX+0h91yHTVSXyqijkE5NcQmAsK2NvMqS6TGUxo4ttskPyU4OjYpW0QxY/C7AjFDVNinJARGzppTC7HgvDOM4hpL+kL4KwfzzQZXqY1g9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735035984; c=relaxed/simple;
	bh=BMB8r6HdFV6bI8fRrq7ynETtZtQQnZbltFC5sw0wpY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoupI4ZVSYSn8CUbcPkas2DME67AmbpvZZ9il06datHfJLeOLlVyF708Xy9nsnbi/1sBXImoazxjCk6PdMWN345flYymS1gr5UOMRvlJyogKa0Lc+3bNT19g85RQgYR/wqBCVTavn0+XlD5MS1pILSCw1cDEEwNmtVgLgDrFZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.87])
	by sina.com (10.185.250.24) with ESMTP
	id 676A8C4700001F5D; Tue, 24 Dec 2024 18:26:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5097010748498
X-SMAIL-UIID: AE2174EE62B14E91B529A2B5C040665F-20241224-182617-1
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
Date: Tue, 24 Dec 2024 18:26:11 +0800
Message-ID: <20241224102614.424-1-hdanton@sina.com>
In-Reply-To: <173498616860.11072.11978717859547245956@noble.neil.brown.name>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Dec 2024 07:36:08 +1100 NeilBrown <neilb@suse.de>
> On Mon, 23 Dec 2024, Hillf Danton wrote:
> > On Mon, 23 Dec 2024 14:10:07 +1100 NeilBrown <neilb@suse.de>
> > > On Sat, 21 Dec 2024, Hillf Danton wrote:
> > > > Inventing anything like mutex sounds bad.
> > > 
> > > In general I would agree.  But when the cost of adding a mutex exceeds
> > > the cost of using an alternate solution that only requires 2 bits, I
> > > think the alternate solution is justified.
> > > 
> > Inode deserves more than the 2 bits before such a solution is able to
> > rework mutex.
> 
> I'm sorry but I don't understand what you are saying.  Could you please
> give more details about your concern?
> Are you concerned about correctness?  Performance?  Maintainability?
> Something else?
>
It is that you are adding a pair of honey bee wings to A380, so no takeoff
can be expected.

