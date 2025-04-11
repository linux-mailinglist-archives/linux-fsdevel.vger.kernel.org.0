Return-Path: <linux-fsdevel+bounces-46242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18381A8578E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 11:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C006F4E08E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 09:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EF129AAF7;
	Fri, 11 Apr 2025 09:07:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BBF1C5F09;
	Fri, 11 Apr 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362472; cv=none; b=QNydIlDvqIA/GhtCZKybYzvM0ejp75j2/YO9AnD0/mXihl7GFC66qOdLHxK62NloTNJrwmyXqo0FqfadVO4s1wPP7UjejUf68VY9kSrnQBNuqkG5np1pKdILrBkq8tGkiB3ArjqWU+wlMXTXT1N0pP3Pmavz9SmDs28QZIdphW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362472; c=relaxed/simple;
	bh=Jo2tAz7jSOJP2ymYZNDVVXeqvPedMX0dp5rX56/2HEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gvt+kv7tDSAPT50eJzobtavBPIHO1fiATDb2Cn0ehMtO8ZBgZRRGWo88hbmVfWPnt0iEaGILYInAp0tBRAdPt4gE57CAfxKyNk7DU5/6eT9k5DdPyKnZRCb87mFiNgSHa7Hxqe7foOAKYbV3qXiC6vJIXqdIDh+bQitu7xlWAnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ZYrRb5fGTzsRr2;
	Fri, 11 Apr 2025 17:07:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B0E651402F6;
	Fri, 11 Apr 2025 17:07:45 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3vUvX2_hnBgnbBQ--.19774S2;
	Fri, 11 Apr 2025 10:07:45 +0100 (CET)
Message-ID: <bbc39aec812383f836ad51bc91b013fa8de8a410.camel@huaweicloud.com>
Subject: Re: Credentials not fully initialized before bprm_check LSM hook
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: sergeh@kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, "Eric W. Biederman" <ebiederm@xmission.com>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org,  zohar@linux.ibm.com
Date: Fri, 11 Apr 2025 11:07:31 +0200
In-Reply-To: <Z_f-uBGhBq9CYmaw@lei>
References: <fb9f7900d411a3ab752759d818c3da78e2f8f0f1.camel@huaweicloud.com>
	 <Z_f-uBGhBq9CYmaw@lei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwA3vUvX2_hnBgnbBQ--.19774S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryrCr15ZrWrAw43Zw1DZFb_yoW8tr4kpF
	WftF15tF4vgrySkr12q3WUXayayrZ5G398Jr98WFy5u3yDGr1vkrWxt3y5uFy5GrWrK3W2
	yay3ZwnavFyDC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBGf4v18BWQAAst

On Thu, 2025-04-10 at 17:24 +0000, sergeh@kernel.org wrote:
> On Thu, Apr 10, 2025 at 01:47:07PM +0200, Roberto Sassu wrote:
> > Hi everyone
> >=20
> > recently I discovered a problem in the implementation of our IMA
> > bprm_check hook, in particular when the policy is matched against the
> > bprm credentials (to be committed later during execve().
> >=20
> > Before commit 56305aa9b6fab ("exec: Compute file based creds only
> > once"), bprm_fill_uid() was called in prepare_binprm() and filled the
> > euid/egid before calling security_bprm_check(), which in turns calls
> > IMA.
> >=20
> > After that commit, bprm_fill_uid() was moved to begin_new_exec(), which
> > is when the last interpreter is found.
> >=20
> > The consequence is that IMA still sees the not yet ready credentials
> > and an IMA rule like:
> >=20
> > measure func=3DCREDS_CHECK euid=3D0
>=20
> "IMA still sees" at which point exactly?

IMA sees the credentials in bprm->cred prepared with
prepare_bprm_creds(), where the euid/egid are taken from the current
process.

> Do I understand right that the problem is that ima's version of
> security_bprm_creds_for_exec() needs to run after
> bprm_creds_from_file()?

IMA's version of security_bprm_check(). security_bprm_creds_for_exec()
is for checking scripts executed by the interpreters with execveat()
and the AT_EXECVE_CHECK flag.

Uhm, it would not be technically a problem to move the IMA hook later,
but it would miss the intermediate binary search steps, which are
visible with security_bprm_check().

> Given that Eric's commit message said that no bprm handlers use
> the uid, it seems it should be safe to just move that?

Well, we just found one :)

Thanks

Roberto

> > will not be matched for sudo-like applications.
> >=20
> > It does work however with SELinux, because it computes the transition
> > before IMA in the bprm_creds_for_exec hook.
> >=20
> > Since IMA needs to be involved for each execution in the chain of
> > interpreters, we cannot move to the bprm_creds_from_file hook.
> >=20
> > How do we solve this problem? The commit mentioned that it is an
> > optimization, so probably would not be too hard to partially revert it
> > (and keeping what is good).
> >=20
> > Thanks
> >=20
> > Roberto
> >=20


