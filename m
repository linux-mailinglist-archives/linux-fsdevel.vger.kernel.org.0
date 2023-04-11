Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D5C6DDF23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 17:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjDKPMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 11:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjDKPLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:11:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6DC5FF6;
        Tue, 11 Apr 2023 08:11:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a5126f2518so9416935ad.1;
        Tue, 11 Apr 2023 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681225875; x=1683817875;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cYdbMuKbz2AWVUScgphBvlBfR6VPMC0L/y0+Ihsi3Ws=;
        b=Fz9yxGUtAqYWwZoV66Jroc9oyeqPRW7okN4pQyQHzPd//qxBXw5inRz7Hy3P6NAOvD
         m6ViDBiuN1KQ4E9O7p0NsAKW/MSZMNi3svzg4+1icSwrwNjirCzj3qVdfqINyjS4gyMh
         GOlJIODlDEEt6ECHHo5cM/dYxjkxA01I8M599pv1eGJmwAqYmetZrHOn8Ek/hGTJMs2B
         zAz2YMkBDeh6I/3oWC9lQImohOQwbndZi30VxOcnTF7/j1HfImsD/fTMuNUPcSd/HFkV
         dCxpwtmNBs/iR+8a3jaNxog1dEeUourlWa1FMXK3f9lJA0AwouDFuw5w5d0KePqeBrLX
         ZgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225875; x=1683817875;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYdbMuKbz2AWVUScgphBvlBfR6VPMC0L/y0+Ihsi3Ws=;
        b=Oo4RcoKZz2KiFIl/loSby4sEu4ffhyYau6USE6qYj6O9xqff3O/N56w6wFrXeBoWm9
         oZkQgQrn2m9xnNP5TvVubbEp3ZyHMoBio/IN3/TIab7S4LTN7XD+0Pnimu8z3DnGp/a5
         lm01aavX0qpLLEojBa/C1ul5NLfW/RI11/jgZVaoZRbhwZCmthRmm3FNM5H8IQ2cz6fN
         OZAZ2TB/JOWg7+qiUU4VFJjFV3OuTC+sGtGxlfYppnDmWLpYUObIvL5FDzfzhepzrj12
         vMBwmcut1dfQLxxjRWqQjpwO2+GhdqWaqBtlSM/7QREiagkC0LvR04toxaQA9hcXoalb
         n36w==
X-Gm-Message-State: AAQBX9eq//7VGzmOGDZs7M4JIIh44nIUHRoEZr8qZgth4xChad0R6kBt
        qAx6FA8jpaeG078zcEQm43puQQXnhjE=
X-Google-Smtp-Source: AKy350Z5uHRbQ0byiW6hiy6//aERhKWCe2CUS8vdFslnFpiZr0PWNKRSp3YddYPUkkh4uPgRN4J1uQ==
X-Received: by 2002:aa7:9adc:0:b0:625:e77b:93b2 with SMTP id x28-20020aa79adc000000b00625e77b93b2mr3497506pfp.5.1681225875463;
        Tue, 11 Apr 2023 08:11:15 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b0062d859a33d1sm9899007pfn.84.2023.04.11.08.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 08:11:15 -0700 (PDT)
Date:   Tue, 11 Apr 2023 20:41:05 +0530
Message-Id: <8735561mk6.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 8/8] ext2: Add direct-io trace points
In-Reply-To: <20230411143433.GE360895@frogsfrogsfrogs>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Mon, Apr 10, 2023 at 10:38:38PM -0700, Christoph Hellwig wrote:
>> On Tue, Apr 11, 2023 at 10:51:56AM +0530, Ritesh Harjani (IBM) wrote:
>> > This patch adds the trace point to ext2 direct-io apis
>> > in fs/ext2/file.c
>>
>> Wouldn't it make more sense to add this to iomap instead?
>
> Yes please. :)

Sure. Let me also add a trace event for iomap DIO as well in the next revision.
However I would like to keep ext2 dio trace point as is :)

-ritesh
