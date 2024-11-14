Return-Path: <linux-fsdevel+bounces-34717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C049C8008
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 02:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62710B23B72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 01:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD61E3DC9;
	Thu, 14 Nov 2024 01:34:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wangsu.com (mail.wangsu.com [180.101.34.75])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49DA2746B;
	Thu, 14 Nov 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.34.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548073; cv=none; b=FfPZVp35kYzpDDIo5bTf24M26G01fnXo76PKdYtZWSm4JSl3GVpop5PAL4XbeDEtoQqzDAyJ69iNH0mimD10ReLASrWYtvnwENymD3RBlOuZgelnGmjQDJGSwdO8pNl9TxEdppRqHuvydmzTmcvz4oxMDIhpc8Piqd4aKppLBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548073; c=relaxed/simple;
	bh=jcarAB/yWQIChUPLz2l5DjoCp1p9s+1gZ6oTLHGr9uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enh2dFCFSOG5YAW63UfCrmqqN8hlM8ytftIs1jB8K2clY6E1HYZGsNYRXrWFgVLAGUR4126N2wrD9DalLI7Vcmtm+aH9mycsHGzsBU0+ekOPu+1OUI1Kss17y08dzxV7eqB5pmm2DxUxbEyEmQcyWTt5fddPoz4YipvQh6KmIMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com; spf=pass smtp.mailfrom=wangsu.com; arc=none smtp.client-ip=180.101.34.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wangsu.com
Received: from [10.8.162.84] (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltABnb3OSUzVn7Ax+AQ--.297S2;
	Thu, 14 Nov 2024 09:34:11 +0800 (CST)
Message-ID: <7454ba19-6c78-4318-8164-21d4b14bee08@wangsu.com>
Date: Thu, 14 Nov 2024 09:34:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] coredump: Fixes core_pipe_limit sysctl proc_handler
To: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
 Joel Granados <j.granados@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Neil Horman <nhorman@tuxdriver.com>, Theodore Ts'o <tytso@mit.edu>
References: <20241112131357.49582-1-nicolas.bouchinet@clip-os.org>
 <20241112131357.49582-2-nicolas.bouchinet@clip-os.org>
 <af2a2a7e-1604-4e24-bee6-f31498e0b25d@wangsu.com>
 <f616c1aa-65e7-44e8-90ac-5be8e3f88927@clip-os.org>
Content-Language: en-US
From: Lin Feng <linf@wangsu.com>
In-Reply-To: <f616c1aa-65e7-44e8-90ac-5be8e3f88927@clip-os.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:SyJltABnb3OSUzVn7Ax+AQ--.297S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF15Ar4kAw1UZw1kKryxGrg_yoWrJrW7pr
	W7KFy7KFW8uF1xAw1xtr42v348urWFkFy3Ww4DGr47ZFn8Wr13ZrnrCryYgFsrKr10k34Y
	vr4qgasF9FyYyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r48
	McIj6xkF7I0En7xvr7AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxAI
	w28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU6g4SDUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/

Hi, 

On 11/13/24 22:15, Nicolas Bouchinet wrote:
> Hi Lin,
> 
> Thanks for your review.
> 
> On 11/13/24 03:35, Lin Feng wrote:
>> Hi,
>>
>> see comments below please.
>>
>> On 11/12/24 21:13, nicolas.bouchinet@clip-os.org wrote:
>>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>>
>>> proc_dointvec converts a string to a vector of signed int, which is
>>> stored in the unsigned int .data core_pipe_limit.
>>> It was thus authorized to write a negative value to core_pipe_limit
>>> sysctl which once stored in core_pipe_limit, leads to the signed int
>>> dump_count check against core_pipe_limit never be true. The same can be
>>> achieved with core_pipe_limit set to INT_MAX.
>>>
>>> Any negative write or >= to INT_MAX in core_pipe_limit sysctl would
>>> hypothetically allow a user to create very high load on the system by
>>> running processes that produces a coredump in case the core_pattern
>>> sysctl is configured to pipe core files to user space helper.
>>> Memory or PID exhaustion should happen before but it anyway breaks the
>>> core_pipe_limit semantic
>>>
>>> This commit fixes this by changing core_pipe_limit sysctl's proc_handler
>>> to proc_dointvec_minmax and bound checking between SYSCTL_ZERO and
>>> SYSCTL_INT_MAX.
>>>
>>> Fixes: a293980c2e26 ("exec: let do_coredump() limit the number of concurrent dumps to pipes")
>>> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>> ---
>>>   fs/coredump.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/coredump.c b/fs/coredump.c
>>> index 7f12ff6ad1d3e..8ea5896e518dd 100644
>>> --- a/fs/coredump.c
>>> +++ b/fs/coredump.c
>>> @@ -616,7 +616,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>>   		cprm.limit = RLIM_INFINITY;
>>>   
>>>   		dump_count = atomic_inc_return(&core_dump_count);
>>> -		if (core_pipe_limit && (core_pipe_limit < dump_count)) {
>>> +		if ((core_pipe_limit && (core_pipe_limit < dump_count)) ||
>>> +		    (core_pipe_limit && dump_count == INT_MAX)) {
>> While comparing between 'unsigned int' and 'signed int', C deems them both
>> to 'unsigned int', so as an insane user sets core_pipe_limit to INT_MAX,
>> and dump_count(signed int) does overflow INT_MAX, checking for
>> 'core_pipe_limit < dump_count' is passed, thus codes skips core dump.
>>
>> So IMO it's enough after changing proc_handler to proc_dointvec_minmax.
> Indeed, but the dump_count == INT_MAX is not here to catch overflow but 
> if both dump_count
> and core_pipe_limit are equal to INT_MAX. core_pipe_limit will not be 
> inferior to dump_count.
> Or maybe I am missing something ?
> 
Extracted from man core:
       Since Linux 2.6.32, the /proc/sys/kernel/core_pipe_limit can be used to
       defend against this possibility.  The value in this  file  defines  how
       many  concurrent crashing processes may be piped to user-space programs
       in parallel.  If this value is exceeded, then those crashing  processes
       above  this  value are noted in the kernel log and their core dumps are
       skipped.

Since no spinlock protecting us, due to the concurrent running of
atomic_inc_return(&core_dump_count), even with the changing above
it's not guaranteed that core_dump_count can't exceed core_pipe_limit).
As you said, suppose both of them are equal to INT_MAX(0x7fffffff),
and before any dummping thread drops core_dump_count, one new thread
comes in then hits atomic_inc_return(&core_dump_count) and now
(unsigned int)core_dump_count is 0x80000000, but original codes checking
for core_pipe_limit still works as expected.

Please correct me if I'm wrong :)

Thanks,
linfeng


