Return-Path: <linux-fsdevel+bounces-46201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D104EA84265
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 14:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19D07A736B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 12:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3772283C9B;
	Thu, 10 Apr 2025 12:03:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC21E25E3;
	Thu, 10 Apr 2025 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286636; cv=none; b=mQXMDPQtdl6p9GbAqn/PB8x8Db7d6QDlPmnYIaTf/y28crANqAkwJ0fsQVZVe41Y3ELMzKImyXdm7EPRPD1JLdPtGWx0kl8IUaszR/3hb3m87/NLtAGpLsTAOY+ftNhWYypYcV/ZJXKbAG2bTf/iqa2X9P4F3UQwMi7hGbrfOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286636; c=relaxed/simple;
	bh=6JRMMXKfVq+zPqoypSPNjKKxb+VJ2BadUFQRCRNAAIs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=pFfgMQJ4FLrAUs+dw0VEUhqyNU1+pKDK8Fb5gp42MhSWfdg/ft4v5hxJu/cbfgUOMCvXaqzB5WwCy3Ru0fAr9sfv56Fsn0RvACwu3sFjEzxPsPxIKh1vJbd6CKt3JbXSNOcAt1X2NS3/flEFP28RDyLdkgbRDPHK24kSnfLM8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ZYJ2B5G8jzsRxd;
	Thu, 10 Apr 2025 19:46:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 8BDFF1402F5;
	Thu, 10 Apr 2025 19:47:20 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXzd++r_dnszPFBQ--.30447S2;
	Thu, 10 Apr 2025 12:47:20 +0100 (CET)
Message-ID: <fb9f7900d411a3ab752759d818c3da78e2f8f0f1.camel@huaweicloud.com>
Subject: Credentials not fully initialized before bprm_check LSM hook
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	 <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Paul Moore
	 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
	 <serge@hallyn.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Date: Thu, 10 Apr 2025 13:47:07 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAXzd++r_dnszPFBQ--.30447S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw18ZFykZF18ZFW8XFWxCrg_yoWkAFg_CF
	Z8GrWjkw1qqrZ3Jay5Ar1Yva9rXF40g3s8Za4Fqr9xW3y8Jws7Wa4qgryavry8Gr4kArnF
	9Fnxta9xZw1fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBGf3bdwDzAABsn

Hi everyone

recently I discovered a problem in the implementation of our IMA
bprm_check hook, in particular when the policy is matched against the
bprm credentials (to be committed later during execve().

Before commit 56305aa9b6fab ("exec: Compute file based creds only
once"), bprm_fill_uid() was called in prepare_binprm() and filled the
euid/egid before calling security_bprm_check(), which in turns calls
IMA.

After that commit, bprm_fill_uid() was moved to begin_new_exec(), which
is when the last interpreter is found.

The consequence is that IMA still sees the not yet ready credentials
and an IMA rule like:

measure func=3DCREDS_CHECK euid=3D0

will not be matched for sudo-like applications.

It does work however with SELinux, because it computes the transition
before IMA in the bprm_creds_for_exec hook.

Since IMA needs to be involved for each execution in the chain of
interpreters, we cannot move to the bprm_creds_from_file hook.

How do we solve this problem? The commit mentioned that it is an
optimization, so probably would not be too hard to partially revert it
(and keeping what is good).

Thanks

Roberto


