Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B526A5E72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 18:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjB1Rzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 12:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjB1Rzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:55:37 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D21C32533;
        Tue, 28 Feb 2023 09:55:28 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y11so7155262plg.1;
        Tue, 28 Feb 2023 09:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XTC6bQyuSs549RjQT6+OsOQFKTFLzjpX9Xd6nTGaLvk=;
        b=b9SY4p+5vh9iiYLx70tJUCwPIijpYr8oVPhdl5nvFOVD4kBXE5VhOlP2QGCWjQxGex
         8eJq14Pw8Urjqgcf+tkImekcCwMzgrqV5iX3r3rEYSS/0mRXHuQ4aOflUjNi01qfN6FP
         880gCk84oqPmdG2GuTBNiYkwFdrLdZiBLqmZckI44JLovSlbgHCpVzkXyVBAcZNLRtTg
         n5croYlx6+puZfCnaa8OtpOl2FhHC2vVdRGB/ulrByMKe0x10kKepYRMOdcEOY959XdZ
         S8SScPTQcBh2kwX5iVNdP5xEPMDU7tAKNT3R/L+h4EZfm85BGztqqYPtVtTk4edJtWzM
         Ouvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTC6bQyuSs549RjQT6+OsOQFKTFLzjpX9Xd6nTGaLvk=;
        b=Lm2TGNvjE/KP61nFXT3R18Oz4UBUSJjCdWE6VdzsfPBZLocu8lnJXR2zQtWLRxb+nt
         aXvRpSORzX4z/tFjmagdWLdyOMiwbLADV+uIgxirs2PJnLTXejvmOere0Gs8J9WICGYB
         giBt2YUINJg34axp6dVcTzpfYCK0scqrkwgzdHM0wVxeufPUUKURzD9ZpOLnPzh4AXT3
         DfhQ3ElM6+A0JJP299QC9BZtlofEkHIoaj3AnPeChxZp6v7UNglkaCvPtwf1ajMYcn7/
         zmSHHTlQO4ZsNLpg+mAoPgRQ4PU2mZwuNQU7abSy4qgr7D90Ke+4YXNOiOySlyyoRdPE
         K3Rg==
X-Gm-Message-State: AO0yUKWqJRz+Fx1iF39VKNnMG8+E17I2WqKmBcfRXYvvClIY/U3zS4NA
        XRFHH+PDjLXQw6hFppsWALnZsGihBZcyfg==
X-Google-Smtp-Source: AK7set90ojxiyHnRnB8DjYepFYJgnV6Y7NsHFuGbPdFMVyMF4NFRp8uCuLW1VDs9nA9FXEFGj4c6ww==
X-Received: by 2002:a17:90a:194a:b0:237:50b6:9838 with SMTP id 10-20020a17090a194a00b0023750b69838mr4025833pjh.45.1677606927253;
        Tue, 28 Feb 2023 09:55:27 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a588800b0022bf4d0f912sm8284135pji.22.2023.02.28.09.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 09:55:26 -0800 (PST)
Date:   Tue, 28 Feb 2023 23:25:09 +0530
Message-Id: <87o7pdoete.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFCv3 1/3] iomap: Allocate iop in ->write_begin() early
In-Reply-To: <20230226224124.GV360264@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner <david@fromorbit.com> writes:

> On Mon, Feb 27, 2023 at 01:13:30AM +0530, Ritesh Harjani (IBM) wrote:
>> Earlier when the folio is uptodate, we only allocate iop at writeback
>> time (in iomap_writepage_map()). This is ok until now, but when we are
>> going to add support for subpage size dirty bitmap tracking in iop, this
>> could cause some performance degradation. The reason is that if we don't
>> allocate iop during ->write_begin(), then we will never mark the
>> necessary dirty bits in ->write_end() call. And we will have to mark all
>> the bits as dirty at the writeback time, that could cause the same write
>> amplification and performance problems as it is now (w/o subpage dirty
>> bitmap tracking in iop).
>>
>> However, for all the writes with (pos, len) which completely overlaps
>> the given folio, there is no need to allocate an iop during
>> ->write_begin(). So skip those cases.
>>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/iomap/buffered-io.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 356193e44cf0..c5b51ab1184e 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -535,11 +535,16 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>>  	size_t from = offset_in_folio(folio, pos), to = from + len;
>>  	size_t poff, plen;
>>
>> +	if (pos <= folio_pos(folio) &&
>> +	    pos + len >= folio_pos(folio) + folio_size(folio))
>> +		return 0;
>
> This is magic without a comment explaining why it exists. You have
> that explanation in the commit message, but that doesn't help anyone
> looking at the code:
>
> 	/*
> 	 * If the write completely overlaps the current folio, then
> 	 * entire folio will be dirtied so there is no need for
> 	 * sub-folio state tracking structures to be attached to this folio.
> 	 */

Sure, got it. I will add a comment which explains this in the code as
well.

Thanks for the review!
-ritesh
