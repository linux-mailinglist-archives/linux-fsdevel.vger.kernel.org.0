Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C851AF550
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 00:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgDRWUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 18:20:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46297 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDRWUg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:20:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id 145so743880pfw.13;
        Sat, 18 Apr 2020 15:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5lJaFjYcZIrKINzwKQy1R3xgWxtfsMwR6sB1R/eMtwU=;
        b=GjZJrC0w+HohLd06wIREdhZ5S2II2IlUAHtUR5RSTVKVhzT2l/MFN2Xxe79rOclr5J
         IBTtFUU+VIxsbMyHHWdNizreUTWuSddFOeEnNdiou/0xrgXMLCY3QazeCgfs0JVnRb69
         8hCfPhfxmNQzkZrBP3djaKjyrnXIN2bLDdYozW4EMEtGc5MmTJoWGPODb1jZBgIzj2T+
         biODDUBe6wsuae9PA4nf/GAOJxzCmendk0xrPybcBUpjsoA4ypDjpu0CbTUHajS798gO
         nptb9zDqeKr83hjWPb3wSM1w1oaCD8d01QgnXruCumFY3F507czKaFJ3zIO7cHjtSxrQ
         78gg==
X-Gm-Message-State: AGi0Pub4CgPoKDOIF6X+ENsYYRrxC0YWZVDKj8Nvh/uT09i69AHWCtSG
        zAM0O+F6hpr/F4KumLomSEiMCfgq9Xw=
X-Google-Smtp-Source: APiQypKrKkW1CP9zvg0HpaxgHFnkJUL1mC4k4+CRal+TZ48iPbm1ertqTrjT7jN+bYBQFGm5GWkzYw==
X-Received: by 2002:a63:554b:: with SMTP id f11mr3245678pgm.343.1587248435352;
        Sat, 18 Apr 2020 15:20:35 -0700 (PDT)
Received: from [100.124.15.238] ([104.129.198.61])
        by smtp.gmail.com with ESMTPSA id b189sm14519134pfb.163.2020.04.18.15.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 15:20:34 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] kernel.h: add do_empty() macro
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-2-rdunlap@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f097242a-1bf0-218b-4890-3ee82c5a0a23@acm.org>
Date:   Sat, 18 Apr 2020 15:20:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200418184111.13401-2-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/20 11:41 AM, Randy Dunlap wrote:
> --- linux-next-20200327.orig/include/linux/kernel.h
> +++ linux-next-20200327/include/linux/kernel.h
> @@ -40,6 +40,14 @@
>   #define READ			0
>   #define WRITE			1
>   
> +/*
> + * When using -Wextra, an "if" statement followed by an empty block
> + * (containing only a ';'), produces a warning from gcc:
> + * warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> + * Replace the empty body with do_empty() to silence this warning.
> + */
> +#define do_empty()		do { } while (0)
> +
>   /**
>    * ARRAY_SIZE - get the number of elements in array @arr
>    * @arr: array to be sized

I'm less than enthusiast about introducing a new macro to suppress 
"empty body" warnings. Anyone who encounters code in which this macro is 
used will have to look up the definition of this macro to learn what it 
does. Has it been considered to suppress empty body warnings by changing 
the empty bodies from ";" into "{}"?

Thanks,

Bart.
