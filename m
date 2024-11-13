Return-Path: <linux-fsdevel+bounces-34589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D549C675F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 03:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255291F24C0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 02:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A21442F3;
	Wed, 13 Nov 2024 02:37:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wangsu.com (mail.wangsu.com [180.101.34.75])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002F013B298;
	Wed, 13 Nov 2024 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.34.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465469; cv=none; b=ZM9l77ctJEYkQWHZb9Z7TX0p7esS+cJoZNJ7F+3AcTHmr/nIX+DCT04iKWH7hn9pZQHsoJCIMmTSnxlLs1JjpguD9fyLAOj7BP9ArPVPMr5Yms1VQTuA0E/TjjUu8WlZVhDR5cgg+jap0Z9uOimdLAWSUBGGfc/m+5K+WK445z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465469; c=relaxed/simple;
	bh=2BdB3GPebvJRUmxzE4KrR5lqQuzWj9e3V9zMxeyhm2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4FEU1Og1KlXbZtBMlga1kak2/S0dQfSx0hc1cAr94ZVza3iLEKpnEfJxnpWVkuNqncBzKhPPchzJd6s6MJTuGKSm8ayLgCCl7uq0BwNTXQHzlmljzuVcrhj+xccHnH9LNn2eiTXR6u3xI7iuvIymmOyEARTIAXAdDTYTwxrQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com; spf=pass smtp.mailfrom=wangsu.com; arc=none smtp.client-ip=180.101.34.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wangsu.com
Received: from [10.8.162.84] (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltADn7ZXsEDRnNp98AQ--.281S2;
	Wed, 13 Nov 2024 10:37:33 +0800 (CST)
Message-ID: <97eed46f-0088-4183-aef4-d6b5c942f074@wangsu.com>
Date: Wed, 13 Nov 2024 10:37:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] sysctl: Fix underflow value setting risk in vm_table
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
 <20241112131357.49582-3-nicolas.bouchinet@clip-os.org>
Content-Language: en-US
From: Lin Feng <linf@wangsu.com>
In-Reply-To: <20241112131357.49582-3-nicolas.bouchinet@clip-os.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:SyJltADn7ZXsEDRnNp98AQ--.281S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4xWrWDJrWkWw13KryrCrg_yoW8Gry8pr
	93XryYka1UJw1SyasIkF1Svr1Igw48KFW3Ga9rKrWfX34DXryrXr1ftFWagFWIkrWIkFZI
	v3Z0qr98uw4YyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Thanks!

Reviewed-by: Lin Feng <linf@wangsu.com>

On 11/12/24 21:13, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Commit 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in
> vm_table") fixes underflow value setting risk in vm_table but misses
> vdso_enabled sysctl.
> 
> vdso_enabled sysctl is initialized with .extra1 value as SYSCTL_ZERO to
> avoid negative value writes but the proc_handler is proc_dointvec and not
> proc_dointvec_minmax and thus do not uses .extra1 and .extra2.
> 
> The following command thus works :
> 
> # echo -1 > /proc/sys/vm/vdso_enabled
> 
> This patch properly sets the proc_handler to proc_dointvec_minmax.
> 
> Fixes: 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 79e6cb1d5c48f..37b1c1a760985 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2194,7 +2194,7 @@ static struct ctl_table vm_table[] = {
>  		.maxlen		= sizeof(vdso_enabled),
>  #endif
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  	},
>  #endif


