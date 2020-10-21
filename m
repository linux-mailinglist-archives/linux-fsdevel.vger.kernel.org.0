Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F7E294F90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443877AbgJUPJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 11:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501914AbgJUPJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:09:35 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B712C0613CE;
        Wed, 21 Oct 2020 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=JogALXxUhOTRDSLNlL38sulkhzXdXhR1YKEuIv/wTTQ=; b=UfbClxFM2J/bWwfotALuJETGVH
        jn8HBocgzQdLffV6pdJAjLEEVYVrCgiZp8xPR1xHVEAsmLizuXFdCJV6YENInuttJbaeaYHlk22OO
        UBzPF5mjIIafZPLgqPibLYQXfFmtbAltRpVavsaBA0EKU6MBZRMkgn09O7FG5flBpXeNUynkBAzl8
        68XHs+y4SpbfEPAWnsBp6TfEt+s1cCo9baXPi2IMqg6ZrL9pV0XgPVeDlIY4pHLPYF5p1mAUsG7vA
        1fuaJE1u7TrB8IsQbSu+Ev6Vvcyqcv9LzNj24oJqDQNrRbiMZZyv9KSBXuRQ9V5j9AXV+S0xixArw
        7yW/feRw==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVFjz-0003Y7-MR; Wed, 21 Oct 2020 15:09:27 +0000
Subject: Re: [PATCH 1/2] Block layer filter - second version
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, hch@infradead.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, akpm@linux-foundation.org,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, jack@suse.cz,
        tj@kernel.org, gustavo@embeddedor.com, bvanassche@acm.org,
        osandov@fb.com, koct9i@gmail.com, damien.lemoal@wdc.com,
        steve@sk2.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <1603271049-20681-2-git-send-email-sergei.shtepa@veeam.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7bd31238-0c7c-ed6f-d0b9-680fcaa54513@infradead.org>
Date:   Wed, 21 Oct 2020 08:09:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1603271049-20681-2-git-send-email-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/21/20 2:04 AM, Sergei Shtepa wrote:
> diff --git a/block/Kconfig b/block/Kconfig
> index bbad5e8bbffe..a308801b4376 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -204,6 +204,17 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
>  	  by falling back to the kernel crypto API when inline
>  	  encryption hardware is not present.
>  
> +config BLK_FILTER
> +	bool "Enable support for block layer filters"
> +	default y

Drop the default y. We don't add modules to a default build without
some tough justification.

> +	depends on MODULES
> +	help
> +	  Enabling this lets third-party kernel modules intercept

	                lets loadable kernel modules intercept

> +	  bio requests for any block device. This allows them to implement
> +	  changed block tracking and snapshots without any reconfiguration of
> +	  the existing setup. For example, this option allows snapshotting of
> +	  a block device without adding it to LVM.


-- 
~Randy

