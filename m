Return-Path: <linux-fsdevel+bounces-23531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C10B392DD5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 02:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE94B23F23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B8020E3;
	Thu, 11 Jul 2024 00:30:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2D383
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720657852; cv=none; b=e3bSCEFQZmKBDU9jy61NtfqNbngnqRPDVx8+KIYU6gQ7HQbPxOo6PfmZ8ijtiqdkj+ljCdKIAtbdP4lvL2ZF1Nqw6yLtLcnwHZIk9FDbAA9nNxWm2DO1ZoWODdZVII/EOlI14Lh+yznRGqebR8X9cvkZ3d5FJTv4oQt+Hyc0IMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720657852; c=relaxed/simple;
	bh=R1eWCf+xDDaaLpjiSlzZKkDxJqqQrr9CIxeOsr1lQBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5z7bfTq6JM6pbgtaeNOA1fnyEoCZ6bplBnfXSt92Ye41DGqQijCiHb7+CNlhoRY8b9crfGIRedeaZ20VnsTi+O4AV0e/FtVnV6OtEcTouj9ad5SNtKegVNKF5/zarZAVMlwmM6wRa/g6qE4bzjFRiXL7/1Fp3TDkl3ufbotS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46B0Uf7F092623;
	Thu, 11 Jul 2024 09:30:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Thu, 11 Jul 2024 09:30:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46B0UefJ092620
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 11 Jul 2024 09:30:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <eb168f2f-948b-4a3b-9237-92902f0c7438@I-love.SAKURA.ne.jp>
Date: Thu, 11 Jul 2024 09:30:40 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [lsm?] general protection fault in
 hook_inode_free_security
To: Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org
References: <00000000000076ba3b0617f65cc8@google.com>
 <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net> <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net>
 <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/28 3:28, Paul Moore wrote:
> It's also worth mentioning that while we always allocate i_security in
> security_inode_alloc() right now, I can see a world where we allocate
> the i_security field based on need using the lsm_blob_size info (maybe
> that works today?  not sure how kmem_cache handled 0 length blobs?).
> The result is that there might be a legitimate case where i_security
> is NULL, yet we still want to call into the LSM using the
> inode_free_security() implementation hook.

As a LKM-based LSM user, I don't like dependency on the lsm_blob_size info.

Since LKM-based LSM users cannot use lsm_blob_size due to __ro_after_init,
LKM-based LSM users depend on individual LSM hooks being called even if
i_security is NULL. How do we provide hooks for AV/EDR which cannot be 
built into vmlinux (due to distributor's support policy) ? They cannot be
benefited from infrastructure-managed security blobs.


