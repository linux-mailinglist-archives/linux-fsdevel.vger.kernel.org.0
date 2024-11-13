Return-Path: <linux-fsdevel+bounces-34588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B439C6760
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 03:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9464B2590F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 02:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8D3143C4C;
	Wed, 13 Nov 2024 02:37:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wangsu.com (mail.wangsu.com [180.101.34.75])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B74D13B298;
	Wed, 13 Nov 2024 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.34.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465426; cv=none; b=Z1EbI//9xL8VhoFcQRQsl4TZyomIdAow6J8QSMO6Ksn2Gc2WvXyovo0xAmFP4YXEOZNP+UKuCPW6FkQlqiISiW/8+dg/PM7af6VlZancujQ1v67TN9hl1ULvpD5Qbffd5PJYwJNch2MV/CXzCLb053OeIduZlROrNkckZjS+LnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465426; c=relaxed/simple;
	bh=oB0JvUZo8wFvnKXDflP33tQ7CYflFhFggZG5PiVAOgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLcEWlDL2FpxKFVn9YnKyA5zdRwOFLoKjOR4ctSBDwITl1DXscD9Whbq4XV8dBbjMsRR2v4vMfyUE/6DmmH1LxEcj8lhjyda4Clgqbd7gTdzfvZCA50okydZdr9PZpaQtWgo6LewVH1oIdxS+V/4+3o3et7wt0SYsn7wcYJQgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com; spf=pass smtp.mailfrom=wangsu.com; arc=none smtp.client-ip=180.101.34.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wangsu.com
Received: from [10.8.162.84] (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltAAHDpaEEDRnpJ58AQ--.278S2;
	Wed, 13 Nov 2024 10:35:49 +0800 (CST)
Message-ID: <af2a2a7e-1604-4e24-bee6-f31498e0b25d@wangsu.com>
Date: Wed, 13 Nov 2024 10:35:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] coredump: Fixes core_pipe_limit sysctl proc_handler
To: nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org
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
Content-Language: en-US
From: Lin Feng <linf@wangsu.com>
In-Reply-To: <20241112131357.49582-2-nicolas.bouchinet@clip-os.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:SyJltAAHDpaEEDRnpJ58AQ--.278S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1xXryxGr18uw1xuFW7Jwb_yoW5Xw4Dpr
	17Ka47KFW8CF1Iyr1IyF43Za4rurWFkFyfWw47GF4IvFnxWr1rXrnFkryYgFsrKr1v9w1Y
	vrnxKas8WFyYyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Yb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v2
	6r4j6F4UMcIj6x8ErcxFaVAv8VW8GwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK
	67AK6r4UMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjxUqVcEUUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/

Hi,

see comments below please.

On 11/12/24 21:13, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> proc_dointvec converts a string to a vector of signed int, which is
> stored in the unsigned int .data core_pipe_limit.
> It was thus authorized to write a negative value to core_pipe_limit
> sysctl which once stored in core_pipe_limit, leads to the signed int
> dump_count check against core_pipe_limit never be true. The same can be
> achieved with core_pipe_limit set to INT_MAX.
> 
> Any negative write or >= to INT_MAX in core_pipe_limit sysctl would
> hypothetically allow a user to create very high load on the system by
> running processes that produces a coredump in case the core_pattern
> sysctl is configured to pipe core files to user space helper.
> Memory or PID exhaustion should happen before but it anyway breaks the
> core_pipe_limit semantic
> 
> This commit fixes this by changing core_pipe_limit sysctl's proc_handler
> to proc_dointvec_minmax and bound checking between SYSCTL_ZERO and
> SYSCTL_INT_MAX.
> 
> Fixes: a293980c2e26 ("exec: let do_coredump() limit the number of concurrent dumps to pipes")
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  fs/coredump.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 7f12ff6ad1d3e..8ea5896e518dd 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -616,7 +616,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		cprm.limit = RLIM_INFINITY;
>  
>  		dump_count = atomic_inc_return(&core_dump_count);
> -		if (core_pipe_limit && (core_pipe_limit < dump_count)) {
> +		if ((core_pipe_limit && (core_pipe_limit < dump_count)) ||
> +		    (core_pipe_limit && dump_count == INT_MAX)) {

While comparing between 'unsigned int' and 'signed int', C deems them both
to 'unsigned int', so as an insane user sets core_pipe_limit to INT_MAX,
and dump_count(signed int) does overflow INT_MAX, checking for 
'core_pipe_limit < dump_count' is passed, thus codes skips core dump.

So IMO it's enough after changing proc_handler to proc_dointvec_minmax.

Others in this patch:
Reviewed-by: Lin Feng <linf@wangsu.com>

>  			printk(KERN_WARNING "Pid %d(%s) over core_pipe_limit\n",
>  			       task_tgid_vnr(current), current->comm);
>  			printk(KERN_WARNING "Skipping core dump\n");
> @@ -1024,7 +1025,9 @@ static struct ctl_table coredump_sysctls[] = {
>  		.data		= &core_pipe_limit,
>  		.maxlen		= sizeof(unsigned int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_INT_MAX,
>  	},
>  	{
>  		.procname       = "core_file_note_size_limit",


