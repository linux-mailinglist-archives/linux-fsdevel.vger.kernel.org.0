Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192066E0B3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 12:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDMKQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 06:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDMKQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:16:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF0F7D85;
        Thu, 13 Apr 2023 03:15:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso5942146pjc.1;
        Thu, 13 Apr 2023 03:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681380951; x=1683972951;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S9iYcg2BPN3bHY7EYcbXcn+k5C7okniPPaLCAniOVXU=;
        b=e8fEskhDmmTK0DJ1oBrL3ziEv37fDjpnueIiKcD006PA5pcbDfJNx3/xQAjKlXMT6f
         hWdws7qjvAVan/WkRYoZSMICv86wrB5WRIbM/A0yclfIifGUxzYmXux8C7hqGTdvl64p
         q/HEUcvqQNxhvof7vtYtkhP5Vot3Em542XsY65lExEZDAnYOaiFR5Bp6FKmKt3drhoJg
         PGkoGWX7fjoTTXEIsSsluT/kDHiaImSA9gniNmoJjWvRVIWYxkNPvZTLM6siDCRDvsxx
         9zumh6GjUnSt35fJp+IFgPPr5y5aAKl/Ho3rF5OugpYseyahkGiSDhztepqY7m1EWAuR
         s9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681380951; x=1683972951;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9iYcg2BPN3bHY7EYcbXcn+k5C7okniPPaLCAniOVXU=;
        b=JMd1FTM42s8r8SqhEqd4vVRsOF5wzFuLLsMyJrsmywILB5ytE0w8c8CFRL+g0Zw5xQ
         6X+neOEZ4luxr1l5shsW5czIb/Od3tcb1nGvx+cGBcs2RdtiI/Iij82faiHbl/kLjHbc
         DVoTWoOnQRsDMnEGU4hK07nyydkfzq1kaRDyk1qcZ4KdfY9AH3SRKivsH9fz5gHtgvU2
         i7b/HeJmgzikYfWpzRUR0TbL85BbSdqMw29ZAcTN32UivDSnBZqMX2Tao5BuFuWPEvra
         GNMkWyPtgoO7S3w93/I8PMVvaCuTb6AuJvlRFTxoJtP8f8XXJ3pRZ9O0lADPHhbYYdxZ
         sZYw==
X-Gm-Message-State: AAQBX9dTxQbgCcOnW0Sp4AvwSczh2vMP9/0fImdRna56nkBJI9AWvJ/1
        3+iSbCEi47tggJpcwprw1BY=
X-Google-Smtp-Source: AKy350Y+zizGgwPqx0FfFitqrgGRpcFVhY0i4y6TpVjxjS+KXbFI/fFSbz1tTzryEbzmU1MsqdEIAQ==
X-Received: by 2002:a17:90b:4d81:b0:246:5f9e:e4cf with SMTP id oj1-20020a17090b4d8100b002465f9ee4cfmr1389970pjb.43.1681380951441;
        Thu, 13 Apr 2023 03:15:51 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090a588a00b00247126a9fb7sm1011835pji.37.2023.04.13.03.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:15:51 -0700 (PDT)
Date:   Thu, 13 Apr 2023 15:45:37 +0530
Message-Id: <87ile0yto6.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFCv3 06/10] fs.h: Add TRACE_IOCB_STRINGS for use in trace points
In-Reply-To: <20230413-rauchen-gesalzen-f15b4be69248@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

Hi Christian

Thanks for your review!

> On Thu, Apr 13, 2023 at 02:10:28PM +0530, Ritesh Harjani (IBM) wrote:
>> Add TRACE_IOCB_STRINGS macro which can be used in the trace point patch to
>> print different flag values with meaningful string output.
>>
>> Tested-by: Disha Goel <disgoel@linux.ibm.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>
> Fine, but fs.h is such a dumping ground already

Ok, 3205 lines in fs.h.

> I hope we can split more stuff out of it going forward...

Any first thoughts/suggestions like what?

>>  include/linux/fs.h | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 9ca3813f43e2..6903fc15987a 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -340,6 +340,20 @@ enum rw_hint {
>>  /* can use bio alloc cache */
>>  #define IOCB_ALLOC_CACHE	(1 << 21)
>>
>> +/* for use in trace events */
>> +#define TRACE_IOCB_STRINGS \
>> +	{ IOCB_HIPRI, "HIPRI"	}, \
>> +	{ IOCB_DSYNC, "DSYNC"	}, \
>> +	{ IOCB_SYNC, "SYNC"	}, \
>> +	{ IOCB_NOWAIT, "NOWAIT" }, \
>> +	{ IOCB_APPEND, "APPEND" }, \
>> +	{ IOCB_EVENTFD, "EVENTD"}, \
>
> s/EVENTD/EVENTFD/

Oops an oversight. Thanks for catching it.

-ritesh
