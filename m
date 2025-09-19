Return-Path: <linux-fsdevel+bounces-62267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5048CB8B960
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 00:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2263A8836
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 22:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A43A2D24BA;
	Fri, 19 Sep 2025 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IjAmv8zb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BU6gxaOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D9D7464
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322482; cv=none; b=INexZwHS9Rf6gmhxPU96LWo3nz+x/iirfKRPSkquUFnU0bdrTkQr/cPGYJXfXO9R4B8BFDk/lQlFAqAOvDUcmiIhkq2YProqtI+RiUTfKICj0Msjzfa7pq2tFvU2kxiCE5lt4srTDaegufs1tlai8XhM/9jmA8OOOEvdT034HAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322482; c=relaxed/simple;
	bh=3aHctRbLW2CdKJ20Ze03nRwxuUZEv8uRnGhZXKvc1mo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=G4R8IbM4rqKhE9ICWWwiyuR0+vCm9ICtW6fq5crMsKvVY/IAaoYt9BZRzXeOr/YqBSfbcMigzO1maK292Z1qLWgBw2HD4M2EhP6Z+VIXrd5W8e+aTJFfze0xeHOdmRXgkkn4eJVYQwcOoJYcG4mf3EKjNoXSgiwGdMJrbArqF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IjAmv8zb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BU6gxaOj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1227214000F8;
	Fri, 19 Sep 2025 18:54:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 19 Sep 2025 18:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758322480; x=1758408880; bh=fMJc3PZJITBf2alFOExq/UupaN+n5OwQuP9
	zj7hwbko=; b=IjAmv8zbsBcZFw4RR7dYZntQJIeHXy9ehEgV4pMK0NWnofWEUT3
	zevkWwdiIx7hMPwCPasRVPB0vgqu04VWb0y8/KMJ9D9a023m1KuW1sjbC31xiPDj
	/6VZ+kvhjzKUdaodSMjfsnY6skae6uc1sHgIX5qBr23R9dorgj+DX/BTOvuFqvCD
	VpXro7z6/8ywDWiumAv33PkhhGho8u441hWTtdvyYVe9KMj8b5ZtUhJmeddOxdQz
	TQffnHkQujqOjGZcZgdla/D7JX6w3f8Wi2Pi0K6icX0M7U0xlIPk+rPgDUNISoCJ
	xB44JVyaM2JgUWwla0HrxQEVGU0WscPLjAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758322480; x=
	1758408880; bh=fMJc3PZJITBf2alFOExq/UupaN+n5OwQuP9zj7hwbko=; b=B
	U6gxaOjerQRrAObc56D9zsg8DcfsoE15d2AsHTIo6gdXdwRAiCe1/DfO0zu9kX1Z
	0l46QKaM2NyyVElCN5Sj/CFm3yyRIum/QmFWSw8fUn8tQ3wpzKu44Zw1Gbfkw88U
	w59Tt3kVqlpVZ4s4m2o+BPfH2u+9NyTfFywVrVvjNHf4ITb42tDlI+a3XODlLBuU
	SRLyYthllR8/UDzpkIkTy/yQQH35jXyrjuyUmEUttcgXrmEhB/WjPc7CQw1HLoQa
	LiduUVchCC4Wvp5/HyG59xF/o2y7Ezw8oYtBjuYVUfXnRFIWPdSm9Am8UGXAFBH1
	ZUlQ62CjmtZu8eVzF1UIQ==
X-ME-Sender: <xms:L9_NaFJvgSsJR47AjIf4vqtgEIiccAAFlgm7qGFtqTrr3lg1t4Hinw>
    <xme:L9_NaPFZ8eGwkxjbdM8qE80xWUojmBcgG08EFsxRM-YctDVaaL_VjCQ6ZeOOlUPus
    ideK-iq9P2olg>
X-ME-Received: <xmr:L9_NaAATL-r8tumIfLeQ0i3YpImJeCWgwVogzb0qOSlG9JU4p6qboHQHavtkv16q_AojLa99T8E_C-5SeMfNe3yZfSJfExEuKvnqpZk_eKyK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    egheefveehheetteduheejudeihfeuheeivedvjeekueefveekleeiffffudfhveenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhoseiivg
    hnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhfshguvghv
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvg
    drtgiipdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:L9_NaK9x4M0WpSpu0Pthv-LBionLYiQfhBYrjJYLppbveMUZwOdBWw>
    <xmx:L9_NaEAR9cHl-1JhbfopsnqhvOqp6_3esBTYkpGM4CpNaqhAynILRQ>
    <xmx:L9_NaHSnTZCjAYkJlLMkIUgRQUX2zEnasmGAAfQqiZmQURiDMb8bNQ>
    <xmx:L9_NaDujorv8z1S3Xn3Ww3tGsjZhSLNhEkHhSv-jzMjoVx7fmdghHw>
    <xmx:MN_NaCOuR8G5KtCymnp0xcN78oD2cNGTqjRRmt8rqj0oq3iCF2T2bEsD>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 18:54:38 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH 4/6] VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
In-reply-to: <20250915-prasseln-fachjargon-25f106c2da6b@brauner>
References: <20250906050015.3158851-1-neilb@ownmail.net>,
 <20250906050015.3158851-5-neilb@ownmail.net>,
 <20250915-prasseln-fachjargon-25f106c2da6b@brauner>
Date: Sat, 20 Sep 2025 08:54:36 +1000
Message-id: <175832247637.1696783.9988129598384346049@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 15 Sep 2025, Christian Brauner wrote:
> On Sat, Sep 06, 2025 at 02:57:08PM +1000, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > A rename can only rename within a single mount.  Callers of vfs_rename()
> > must and do ensure this is the case.
> > 
> > So there is no point in having two mnt_idmaps in renamedata as they are
> > always the same.  Only one of them is passed to ->rename in any case.
> > 
> > This patch replaces both with a single "mnt_idmap" and changes all
> > callers.
> > 
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> 
> Hah, thanks. I'm stealing this now.
> 

I was hoping you would steal the whole series - v3 of it.

 https://lore.kernel.org/all/20250915021504.2632889-1-neilb@ownmail.net/
 
Is there anything preventing that going into vfs.all now?

But maybe I misunderstood what you meant by "stealing" - I don't even
see this one patch in vfs.all.

Thanks,
NeilBrown

