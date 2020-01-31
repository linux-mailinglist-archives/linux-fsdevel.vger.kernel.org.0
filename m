Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E0A14ECD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 14:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgAaNBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 08:01:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33770 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgAaNBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:01:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so7032995lji.0;
        Fri, 31 Jan 2020 05:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=91NDgBxMOUQX+FZ1BTJVVc6qCU+Cj8++hqqh0GnmSfM=;
        b=nRpXut7VNzzYjKTPl/iBVkARA1nKKVM2JLhHDU6YEEmxvCw+80Dwl5xODlKBFKjHAB
         CUsx1vVxYWyG2VTJdeKVLBCPn2qEv8o2mOlJMAiTPMpOUjxTTYJGf4g7DlsoIDZb1dKh
         e9ybWVTkHB2JKVFao2EeOL/eKD1voyl6aCIVgdgQepoBkXqVrhlzZIZM6zcN8LBWqa/L
         fRV9PdIdhm+jfSSWv2niorSh3N0IxpcUt0Zu/lham/DwECpLPVGT5fjTgnW3lxp9AhuS
         bCz7c1d0EyDiPLUu5iEoymetjYYbhwNFRsbq1T6ntHgBt1bLeH0roMA97LCS7QhJmTH3
         F4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=91NDgBxMOUQX+FZ1BTJVVc6qCU+Cj8++hqqh0GnmSfM=;
        b=H8PVV6C4cNc+LmFxrLtdcZ74VVbBpvQMxe+Nt3d/I/Zcvc1VHBwZuXEEvCKPtf3BFr
         /1M4XA56LSO70MGIOMBaS1z5fDboNg4pQToZ6YW8r3wOQNo+sIQHtjluXahaPd2BJge9
         0KNb8xVQjf42QCj8ygmiM95yBjjRAFRLlw/EXm2HttKANH8PYo9LnaVUmX/es5l7RIOF
         PheL/59aaUhQF4KalSguAEGcxKLzLBx+OpMujXcApVZjkkEX1YTFWbZBMJGUk20j6k62
         fDo4yNNcrZy1R7cWNnEZXcgB4Gu0jnSu/xSrLQroP4gd/U15F2b3YqIGbZcsAi9+U/DW
         lWsg==
X-Gm-Message-State: APjAAAV6NKmWU1PGhXfXG/2UpQa0Oc10QC49Xi/+ol+4oIDqiihW15L4
        DFT9gLjU80XaUu8PcxyoRcmWl9G55fs=
X-Google-Smtp-Source: APXvYqxa6ny9Hj92Ow3m4QBwi5HVWBuTJM/cFloRyJixABbPoSnn/IRUdm7Q0Xpdu2uwPGjHzHXNgg==
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr5870631ljk.186.1580475702053;
        Fri, 31 Jan 2020 05:01:42 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id w71sm5430896lff.0.2020.01.31.05.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 05:01:41 -0800 (PST)
Subject: Re: [PATCH v2] fs: optimise kiocb_set_rw_flags()
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8cecd243-38aa-292d-15cd-49b485f9253f@gmail.com>
 <5328b35d948ea2a3aa5df2b1d740c7cb1f38c846.1579224594.git.asml.silence@gmail.com>
Message-ID: <14929e52-9437-e856-7eff-4e5b45968f89@gmail.com>
Date:   Fri, 31 Jan 2020 16:01:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <5328b35d948ea2a3aa5df2b1d740c7cb1f38c846.1579224594.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/17/2020 4:32 AM, Pavel Begunkov wrote:
> kiocb_set_rw_flags() generates a poor code with several memory writes
> and a lot of jumps. Help compilers to optimise it.
> 
> Tested with gcc 9.2 on x64-86, and as a result, it its output now is a
> plain code without jumps accumulating in a register before a memory
> write.

Humble ping

> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> v2: check for 0 flags in advance (Matthew Wilcox)
> 
>  include/linux/fs.h | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 98e0349adb52..22b46fc8fdfa 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3402,22 +3402,28 @@ static inline int iocb_flags(struct file *file)
>  
>  static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>  {
> +	int kiocb_flags = 0;
> +
> +	if (!flags)
> +		return 0;
>  	if (unlikely(flags & ~RWF_SUPPORTED))
>  		return -EOPNOTSUPP;
>  
>  	if (flags & RWF_NOWAIT) {
>  		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
>  			return -EOPNOTSUPP;
> -		ki->ki_flags |= IOCB_NOWAIT;
> +		kiocb_flags |= IOCB_NOWAIT;
>  	}
>  	if (flags & RWF_HIPRI)
> -		ki->ki_flags |= IOCB_HIPRI;
> +		kiocb_flags |= IOCB_HIPRI;
>  	if (flags & RWF_DSYNC)
> -		ki->ki_flags |= IOCB_DSYNC;
> +		kiocb_flags |= IOCB_DSYNC;
>  	if (flags & RWF_SYNC)
> -		ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
> +		kiocb_flags |= (IOCB_DSYNC | IOCB_SYNC);
>  	if (flags & RWF_APPEND)
> -		ki->ki_flags |= IOCB_APPEND;
> +		kiocb_flags |= IOCB_APPEND;
> +
> +	ki->ki_flags |= kiocb_flags;
>  	return 0;
>  }
>  
> 

-- 
Pavel Begunkov
