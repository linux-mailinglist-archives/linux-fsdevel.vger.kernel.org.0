Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57FB768249
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 04:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfGOCeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jul 2019 22:34:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42907 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbfGOCeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jul 2019 22:34:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so6683440pff.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jul 2019 19:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j1D3jAEemUPemgo3Jj5nb6GS6101sWhcpLMgfsoNq8g=;
        b=QrISUnxCSscxlNiF2KqrOgYSELv84+I/OVPUsZDhEuEi4r7R8YUKcUPEfdayuPSfK0
         wrQ3Q089jqbmouyR+NoH07yfRGBgepPs66CHFe5siqBvErBCrBMbICucDPWVzgWos38b
         Wf2Rms1UOmhDfsHeziRBcVVeqhPowRnyQF6ZIirk9sqy61+7brb3XjH5WSXDOqEwMkq3
         q0U1QstYRjrFeTUkIvslQ7dopjLzTMUk5/MTR7wo3HmTm88DIkL2jdeSCkahHTIsS0XU
         2mC5wBJ5eaM50hskzzZTjH7Ed3Xloa++ONtGgIN+sj2f13lAUYZHfj/Zj0wydtFoffX+
         bJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j1D3jAEemUPemgo3Jj5nb6GS6101sWhcpLMgfsoNq8g=;
        b=I4NaJw+vPW8LgbTeOEOcm3aH3pOwYWjE6NSrF1nwH5Sl1THX07ToeYyWYdrXgGxW6E
         /e6TgBGZI/5FBbekAYkQCBJM0ma4Gbbc4IYc9zh3J/RaNE+UeavD/4NQsTOdsCcnPv51
         fum/MS2BFzB40RrdoiySXnc97os3w8d1pJLUx47NWGTUHjt0TKSAswvLwuOb1rETiI5Z
         8ZnO9/uH0x2wiHvd3TBIcRlgxe8ZWTXIgA1VLBMtekkj8va7veOxrOVT7erKyvsCW6eY
         BMZyyOaNeeqjXQwRUwgVV29oJRXMnNvAkb9/YIGD+rT2UaanVz61GS30l12YRXziSd+h
         lZ4g==
X-Gm-Message-State: APjAAAWD4FgnG1zxEWBBn9kjVull7l2OXCw9pvQP0wBNCkzBCOZzfYWj
        m+AL8tZJn0rBCyiU7tUX0CM=
X-Google-Smtp-Source: APXvYqwy96VWEm0MA4ILQTD2TtjFzmkAMeu1HQIcFyR05bl5hBBOCB7OmlKryt9SnBNgiGdMCiKl3g==
X-Received: by 2002:a63:7a01:: with SMTP id v1mr25024594pgc.310.1563158042768;
        Sun, 14 Jul 2019 19:34:02 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id d129sm16418490pfc.168.2019.07.14.19.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 19:34:01 -0700 (PDT)
Subject: Re: [PATCH] mm/gup: Use put_user_page*() instead of put_page*()
To:     Bharath Vedartham <linux.bhar@gmail.com>,
        akpm@linux-foundation.org, ira.weiny@intel.com, jhubbard@nvidia.com
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Matt Sickler <Matt.Sickler@daktronics.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kvm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org
References: <1563131456-11488-1-git-send-email-linux.bhar@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <018ee3d1-e2f0-ca12-9f63-945056c09985@kernel.dk>
Date:   Sun, 14 Jul 2019 20:33:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563131456-11488-1-git-send-email-linux.bhar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/14/19 1:08 PM, Bharath Vedartham wrote:
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 4ef62a4..b4a4549 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2694,10 +2694,9 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
>   			 * if we did partial map, or found file backed vmas,
>   			 * release any pages we did get
>   			 */
> -			if (pret > 0) {
> -				for (j = 0; j < pret; j++)
> -					put_page(pages[j]);
> -			}
> +			if (pret > 0)
> +				put_user_pages(pages, pret);
> +
>   			if (ctx->account_mem)
>   				io_unaccount_mem(ctx->user, nr_pages);
>   			kvfree(imu->bvec);

You handled just the failure case of the buffer registration, but not
the actual free in io_sqe_buffer_unregister().

-- 
Jens Axboe

