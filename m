Return-Path: <linux-fsdevel+bounces-34590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDBD9C6764
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 03:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B78B24B7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 02:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E619E146A69;
	Wed, 13 Nov 2024 02:39:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wangsu.com (mail.wangsu.com [180.101.34.75])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CEB13B7AE;
	Wed, 13 Nov 2024 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.34.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465596; cv=none; b=GPaY9cE19+d8Tmjej8u6Et9PifXNMPJy7DZxXYH31Vi9XSENmPvqH1cMyNURkf8DgvAVSTlChSDp17BywbWePBA12PD6rHEx9fw82MzmXod86T+z9shLTnYhqtnPfl4q8WgvVqfd7z4jByyITj8T3ZugjEt5fZRMNliXzLU/mV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465596; c=relaxed/simple;
	bh=BjuOYiuSuz/ESzCTjJLwkbenhLTgNn+SRe0H01HT3PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TM4aYUdDeIXPqZXOwgokVGoNBsIVgzsi8+CsnNIDVJdKJ6TbEY8pH029IhDlh6kknp5tRg8tSbDCzBcUDzWW+M0hrJg3NFst+WneFM/2Gv44k3m1Oip21aqMVAB1YfckE2cVuANb07w+OQ/z9iq2EcGpkO7iMHWAXh7Wb+xFMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com; spf=pass smtp.mailfrom=wangsu.com; arc=none smtp.client-ip=180.101.34.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wangsu.com
Received: from [10.8.162.84] (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltADXh3BsETRn4598AQ--.281S2;
	Wed, 13 Nov 2024 10:39:41 +0800 (CST)
Message-ID: <a4c2773b-a799-4c5e-9103-43c00f110b2a@wangsu.com>
Date: Wed, 13 Nov 2024 10:39:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tty: ldsic: fix tty_ldisc_autoload sysctl's
 proc_handler
To: nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
 Joel Granados <j.granados@samsung.com>, Neil Horman <nhorman@tuxdriver.com>,
 Andrew Morton <akpm@linux-foundation.org>, Theodore Ts'o <tytso@mit.edu>
References: <20241112131357.49582-1-nicolas.bouchinet@clip-os.org>
 <20241112131357.49582-4-nicolas.bouchinet@clip-os.org>
Content-Language: en-US
From: Lin Feng <linf@wangsu.com>
In-Reply-To: <20241112131357.49582-4-nicolas.bouchinet@clip-os.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:SyJltADXh3BsETRn4598AQ--.281S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4rZF1rXr45ArWUKFyrXrb_yoW8JFyUpF
	WDW3yjkFW5Gr1Sqa42kF17uF1Sgw4xKFy3CasFy34avr1DXryrGr1rt39rWF48JrWkurWa
	vFnYy3ZxWFs2vrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Yb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
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
	nIWIevJa73UjIFyTuYvjxU7YFADUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/

Thanks!

Reviewed-by: Lin Feng <linf@wangsu.com>

On 11/12/24 21:13, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Commit 7c0cca7c847e ("tty: ldisc: add sysctl to prevent autoloading of
> ldiscs") introduces the tty_ldisc_autoload sysctl with the wrong
> proc_handler. .extra1 and .extra2 parameters are set to avoid other values
> thant SYSCTL_ZERO or SYSCTL_ONE to be set but proc_dointvec do not uses
> them.
> 
> This commit fixes this by using proc_dointvec_minmax instead of
> proc_dointvec.
> 
> Fixes: 7c0cca7c847e ("tty: ldisc: add sysctl to prevent autoloading of ldiscs")
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  drivers/tty/tty_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 407b0d87b7c10..f211154367420 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3631,7 +3631,7 @@ static struct ctl_table tty_table[] = {
>  		.data		= &tty_ldisc_autoload,
>  		.maxlen		= sizeof(tty_ldisc_autoload),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},


