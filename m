Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1081C4047
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 18:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgEDQmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbgEDQmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 12:42:10 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04731C061A0F
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2020 09:42:09 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u11so13034418iow.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 09:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bOO31zCyp7KWzFdVhclDF5PA/avMx0uxJp6+DDvlojY=;
        b=lYYSqhAOi/YBrHI6goaVk9aafelTnt0zZWWXUtzSeOKygT6Drldsfb+EoH7afX5zLF
         7PTVJqxtJikt317tIgoNlX4FUDKLxBBUUvHvV2pmmtmErt6Nbn3NfYLNOofBx/HQ+18w
         dGafc6oz0Kp6cWAaKe+ImIvB82LPU0bTiowCzu0UyRROSwJANGJqH9FG8xzC4cFdSpZt
         Wx91opcI6r5kt7DdLsZ3oHILrh9mznVIMMSLIKca0Vrt1Wg/JeljWb0r9MAckHZpJpr5
         RMUq4tpRefSQyu7V/+oXe98n149PACi9LaZbPf99z7mdmBDkGqBJXP1mnuZdhRzrgNMz
         4kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bOO31zCyp7KWzFdVhclDF5PA/avMx0uxJp6+DDvlojY=;
        b=dtQTX00vWqOrVOQe056QEZdbW/5C4q6cb+yG645qKH0vxPlnbS7ftrDPgPPpELYoeH
         qrj++vyHkD/Ipt3jap08X9UzN5faxS9XQqsgJjSqW3drERsvqgI8e5BC7Q22CBZj6w1m
         XGQrvrWhG6F0WitVchAb+nJM5wGvCJVm4YbkSi/6kjn12GfdTVoGYJozo1wSy+uHVx/b
         pH0ywb455/Ubm9dUsu4JcWyuSGxkcVgLqaXp7qyvNxHmE1NfWGnOOFTYuvxRa3oWSffo
         cf5zes6nysL8wwxCkNpAx/lSA+Qk/h2cVh43DCdrA4dDjSlgyEpa+SPZ/Up+PRN39cBR
         E7Yg==
X-Gm-Message-State: AGi0PubLro53OMJP/J40onA4RaHz4FCo9lTfoqCMnWdM/KfbHgZn2jnM
        MfZtqZ8+onozCaxJBIal99lElauKCOCXJg==
X-Google-Smtp-Source: APiQypLXsv27U+YtINVyuWix6toSeHFvCR2e8RbWxck6ha2hn+n5FFfAbC4zwwBY5vbf0r/EquXz9A==
X-Received: by 2002:a5e:c814:: with SMTP id y20mr16153088iol.135.1588610528387;
        Mon, 04 May 2020 09:42:08 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y15sm5378378ilg.21.2020.05.04.09.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 09:42:07 -0700 (PDT)
Subject: Re: stop using ioctl_by_bdev for file system access to CDROMs v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200425075706.721917-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c89a895d-6bc0-c563-ad51-9204656b30b5@kernel.dk>
Date:   Mon, 4 May 2020 10:42:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425075706.721917-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/25/20 1:56 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> except for the DASD case under discussion the last users of ioctl_by_bdev
> are the file system drivers that want to query CDROM information using
> ioctls.  This series switches them to use function calls directly into
> the CDROM midlayer instead, which implies:
> 
>  - adding a cdrom_device_info pointer to the gendisk, so that file systems
>    can find it without going to the low-level driver first
>  - ensuring that the CDROM midlayer (which isn't a lot of code) is built
>    in if the file systems are built in so that they can actually call the
>    exported functions
> 
> Changes since v1:
>  - fix up the no-CDROM error case in isofs_get_last_session to return 0
>    instead of -EINVAL.

Applied for 5.8, thanks.

-- 
Jens Axboe

