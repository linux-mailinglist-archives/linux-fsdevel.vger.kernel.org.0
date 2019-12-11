Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 063A711BAF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfLKSFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 13:05:08 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:44260 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbfLKSFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:05:07 -0500
Received: by mail-pj1-f67.google.com with SMTP id w5so9211471pjh.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 10:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U6TVMZIrVU3X6d3dLhfmym7+Uk2eVUbkx4ihgzOBQ70=;
        b=oR/onN8TjGm9Sp9B92tnxnugU+SFje4O9MoxYqew/+vPFjIUf0fMDc5TF7sZ9+lxPP
         EtBwZkPAbDt3XQ28p63Zu3TKyn7PBYApNRp1Ak2id6zrkTyKG4j3KwngKuLEmrncX5ga
         CC6zgmPmCaTA8Grj6veVgetONtpLFm8HlLdZ1FH5JvmnLsUspsJrAY5sOYA4LvKrZ2Vs
         srVCmNXs17MiViZiiRY3YHZy54pNecQxnqdEKHr6urPp5U86MCsxHNjVfi64tGFXg8WW
         W/+1z6icoyJCOnJCfQ6nEppaV0KDlT+C+PVMi01QUyR7ezn5+oiU7j+qcmLfQYUYu87N
         tLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U6TVMZIrVU3X6d3dLhfmym7+Uk2eVUbkx4ihgzOBQ70=;
        b=PPVGrDsw2cYwY4lTUOg+bn7iteIDKyfD4UbW1UUFIxWfKpiVOdqqn1SizLq2oqKGh5
         JONWn7lcCFaLZAqfdboBqkkacGFpSAhfhpYUxTogaITIIwArolSVEcSreZQjGqdlbV3G
         BmGKf+n+2n0bx1gBCELpSVAVJbmqtZ9Nz6o/OCJfr5evKXl+VaW3zf5Qk/eloA6dvVC9
         cIl0XJAcvAK5Z1rN/zLh2GRP1Nt1Kj6fwrZm0kb9Chu7BXBHGbYk/t+huacTMR8Ct0h4
         sVCN+UZtcUDvtYchRfUiM2JoNW2c4jTA/qtk27nanvyYyDq0D8TiQqvRVVYaEZW1C0td
         i2SQ==
X-Gm-Message-State: APjAAAWUC4hGkDyJhYdgEWZrJLkhXaJ3YnPGYPlhGzYGrw8StdeOaJi6
        qBphbeHB2CgHTgqkkd41c1zvmw==
X-Google-Smtp-Source: APXvYqxzsNYNFGM/ykEVX0FKzhJ8CT5+QQy5QOEvfHdOS7SAr0vp/daHnlm1hKq4gJmE9sArk68cVQ==
X-Received: by 2002:a17:90b:4004:: with SMTP id ie4mr4934572pjb.49.1576087507033;
        Wed, 11 Dec 2019 10:05:07 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::1014? ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id b23sm3661708pfo.62.2019.12.11.10.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 10:05:06 -0800 (PST)
Subject: Re: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
References: <20191211152943.2933-1-axboe@kernel.dk>
 <20191211152943.2933-6-axboe@kernel.dk>
 <20191211171928.GN32169@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <34cd9ce1-da7b-ff0b-0662-c966a16962aa@kernel.dk>
Date:   Wed, 11 Dec 2019 11:05:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211171928.GN32169@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/19 10:19 AM, Matthew Wilcox wrote:
> On Wed, Dec 11, 2019 at 08:29:43AM -0700, Jens Axboe wrote:
>> @@ -670,9 +675,14 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>>  		iomap_read_inline_data(inode, page, srcmap);
>>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>>  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>> -	else
>> -		status = __iomap_write_begin(inode, pos, len, flags, page,
>> +	else {
>> +		unsigned wb_flags = 0;
>> +
>> +		if (flags & IOMAP_UNCACHED)
>> +			wb_flags = IOMAP_WRITE_F_UNCACHED;
>> +		status = __iomap_write_begin(inode, pos, len, wb_flags, page,
>>  				srcmap);
> 
> I think if you do an uncached write to a currently shared extent, you
> just lost the IOMAP_WRITE_F_UNSHARE flag?

Oops good catch, I'll fix that up.

-- 
Jens Axboe

