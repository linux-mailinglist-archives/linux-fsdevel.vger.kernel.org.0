Return-Path: <linux-fsdevel+bounces-21437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E446903CC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 15:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8AC1C20DBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574C017C7CB;
	Tue, 11 Jun 2024 13:10:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA1178CCF;
	Tue, 11 Jun 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111431; cv=none; b=s4ipW7O94gZ5NpczVHsnGHhPw0tvdXmGuI5IjXnU1lcg72IcLzgzIUpKScHZz8gy47T7JRRa+SB1D1cMuN6ggTH05t/eSMvPTSbLvxF+bhM6BRdLSSY8qeYtsYbjfV+y05ndWNQ15tC+03vQINgHrMtA5YmvZbH+x9AC3Vat+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111431; c=relaxed/simple;
	bh=4/JI6GzeEj5PipE+7i23EKE4kPcLb2GblTyi4MDIlXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgU0b20t+XqEVwRXIppP66xDNbhB08rsOkstu/ZvkSdH5HjICFhohXmkUv8nGw2mZmfqIgadjFbsVLelLhSDMUAsHqZDK94VFL/BZ9Ah51hMmTBq5OWrUcssOGK0lsYT5Dfwl+yv3WxOmSeaq/8rioZyfp8VL9P+uoH4B1fFncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45BDA8tV052697;
	Tue, 11 Jun 2024 22:10:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Tue, 11 Jun 2024 22:10:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45BDA8J5052694
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 11 Jun 2024 22:10:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7445203e-50b1-49a6-b7a3-8357b4fe62ab@I-love.SAKURA.ne.jp>
Date: Tue, 11 Jun 2024 22:10:06 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Biederman <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Serge Hallyn <serge@hallyn.com>, Kees Cook <keescook@chromium.org>
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com>
 <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
 <202402070631.7B39C4E8@keescook>
 <CAHC9VhS1yHyzA-JuDLBQjyyZyh=sG3LxsQxB9T7janZH6sqwqw@mail.gmail.com>
 <CAHC9VhTTj9U-wLLqrHN5xHp8UbYyWfu6nTXuyk8EVcYR7GB6=Q@mail.gmail.com>
 <76bcd199-6c14-484f-8d4d-5a9c4a07ff7b@I-love.SAKURA.ne.jp>
 <202405011257.E590171@keescook>
 <CAHC9VhTucjgxe8rc1j3r3krGPzLFYmPeToCreaqc3HSUkg6dZA@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhTucjgxe8rc1j3r3krGPzLFYmPeToCreaqc3HSUkg6dZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/11 5:44, Paul Moore wrote:
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 40073142288f..7ec13b104960 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1532,6 +1532,7 @@ static void do_close_execat(struct file *file)
>>
>>  static void free_bprm(struct linux_binprm *bprm)
>>  {
>> +       security_bprm_free(bprm);
>>         if (bprm->mm) {
>>                 acct_arg_size(bprm, 0);
>>                 mmput(bprm->mm);
>>
> 
> Tetsuo, it's been a while since we've heard from you in this thread -
> are you still planning to work on this?  If not, would you object if
> someone else took over this patchset?
> 

You are going to merge static call patches first (though I call it a regression),
aren't you? For me, reviving dynamically appendable hooks (which is about to be
killed by static call patches) has the higher priority than adding
security_bprm_free() hook.


