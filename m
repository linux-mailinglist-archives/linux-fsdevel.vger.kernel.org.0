Return-Path: <linux-fsdevel+bounces-10616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A81084CD06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED80F1F22C45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE2C7E76F;
	Wed,  7 Feb 2024 14:41:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA982561C;
	Wed,  7 Feb 2024 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316912; cv=none; b=uLWtuMuZY4Sit98VoUj5GovDCmquVqjfSq64EsnCcgQ5Tw8JziSgfamwMwv5MXzLsEzif41VMGm3HUSW3v7bPX3DUHawgfi4y9WdikJr7CZqRFgOxmijl6ZzPyFEO9e0vF4lso2LlTJY5tlLuzQHLRs5ob7KFtdx/ViDAP+D4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316912; c=relaxed/simple;
	bh=ht5EjXVnhtYPjjYf7qPGVv/MLquyBdgjIj/mEaw7S6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1HphomtqUimjIosROa+6SFmtdCYWipy1sU9egpsI6VDmbHmPztz6uC0Fdrw43xwak7QVRFDMgJCRYJtGXc6qJEKNKoiIhz8A0s1ehzsWeov24Yu29LCmCiGJIrgofKPf+Nv4MugCBvJI21FUK0AzxKxorucz5IR0XHFfqLSO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 417Ef573028669;
	Wed, 7 Feb 2024 23:41:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Wed, 07 Feb 2024 23:41:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 417Ef5NY028664
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 7 Feb 2024 23:41:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <38e6e589-23f9-4dfd-8588-9e0d13500dfc@I-love.SAKURA.ne.jp>
Date: Wed, 7 Feb 2024 23:41:01 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202402070622.D2DCD9C4@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/07 23:24, Kees Cook wrote:
> This looks good to me.
> 
> Given this touches execve and is related to the recent execve changes,
> shall I carry this in the execve tree for testing and send a PR to Linus
> for it before v6.8 releases?

Yes, please do so. (My git tree is currently down.)

> 
> There's already an Ack from Serge, so this seems a reasonable way to go
> unless Paul would like it done some other way?
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thank you.


