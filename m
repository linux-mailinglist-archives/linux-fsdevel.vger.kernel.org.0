Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0734B2D1E84
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 00:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgLGXlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 18:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgLGXlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:41:21 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0A2C061793
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Dec 2020 15:40:41 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n7so10477294pgg.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 15:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=njww8wdOAs3c2LJAiwttGgPqgreyJHyS7l0+MnjKLfw=;
        b=2MyHFSN/4n9ghMXwGSk+drV4HoRHvG3jFFMhxmHoX9Roy4R3puhAlLcleYaQQpeNha
         Eor4ohgQW+pNG95rcJIUeza7tPuaXEMZ5KvqcsmjF++ujbLTN9fIr7w+/cNQ5c1gf5iL
         /eG/i8cAa8kN8x2yNbE2SNhSEJ/Wl5ublphFILO2kJ0iTOLLoCRgFKGlVWLUd5VacE50
         JOcZ2B2XxqvhOKRFfnJnlTpjekeMxH1UQsQtShXd1Wp0Gh2bN9YTe+RKpb5KkdNaneOZ
         ajzt7NA1c361/UYAbnf6quvvli90vFWM8H4XvOQwv/42p7Ocw9F1ol8dsFbJDOYl41xc
         3Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=njww8wdOAs3c2LJAiwttGgPqgreyJHyS7l0+MnjKLfw=;
        b=r1FqHNNTdslBJgXnyuksVWjIjkcDxRM8aQHc8mFdkR9kP1n5/B75q8lR1F0JTUu9C6
         tothvZYgiyUc9vZS5Jb0FKpimyw03+h1WH/ehqGAOm8bdgRU8iNRUgIIq/gbTuIdiV6G
         iNbCcAO2vOq0J1m/kBOomFDFVrLkeZ/UVEoe7qw45PjGb+5Z0t639eF+YcIPVE4vL8zo
         2+T2NdH2nKnWFjqdTu8+JtAihQT3z5hq/Pa/kwc9KPrCZBUykmOEDVxSsgZXkYT6LAmp
         GZSx1KSDGqNIbPPFTDBIF5apyPuioIllxgvRK6XmGO3DNdbl24etclUVUzt2By36xdri
         03Zw==
X-Gm-Message-State: AOAM531qOnqSIb7aIKucBTKxxLhqKbojgGwVyvuE5CXCs8HAo1OYV/wK
        oonatfU8ESJu8w+XgZ8RG0EsiA==
X-Google-Smtp-Source: ABdhPJynO9TVJizpThFZTWdx29BIYKEgLvpOxoRfTornfAohoa5Jfi06PhwTenU216+aeedn4KBSoQ==
X-Received: by 2002:a17:902:b783:b029:da:6567:f244 with SMTP id e3-20020a170902b783b02900da6567f244mr18251809pls.45.1607384440797;
        Mon, 07 Dec 2020 15:40:40 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id h17sm5098063pgk.25.2020.12.07.15.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 15:40:40 -0800 (PST)
Subject: Re: [PATCH v3 RESEND] iomap: set REQ_NOWAIT according to IOCB_NOWAIT
 in Direct IO
To:     Dave Chinner <david@fromorbit.com>,
        Hao Xu <haoxu@linux.alibaba.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        io-uring@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>
References: <1607075096-94235-1-git-send-email-haoxu@linux.alibaba.com>
 <20201207022130.GC4170059@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3b33a9e3-0f03-38cc-d484-3f355f75df73@kernel.dk>
Date:   Mon, 7 Dec 2020 16:40:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207022130.GC4170059@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/6/20 7:21 PM, Dave Chinner wrote:
> On Fri, Dec 04, 2020 at 05:44:56PM +0800, Hao Xu wrote:
>> Currently, IOCB_NOWAIT is ignored in Direct IO, REQ_NOWAIT is only set
>> when IOCB_HIPRI is set. But REQ_NOWAIT should be set as well when
>> IOCB_NOWAIT is set.
>>
>> Suggested-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
>> ---
>>
>> Hi all,
>> I tested fio io_uring direct read for a file on ext4 filesystem on a
>> nvme ssd. I found that IOCB_NOWAIT is ignored in iomap layer, which
>> means REQ_NOWAIT is not set in bio->bi_opf.
> 
> What iomap is doing is correct behaviour. IOCB_NOWAIT applies to the
> filesystem behaviour, not the block device.
> 
> REQ_NOWAIT can result in partial IO failures because the error is
> only reported to the iomap layer via IO completions. Hence we can
> split a DIO into multiple bios and have random bios in that IO fail
> with EAGAIN because REQ_NOWAIT is set. This error will
> get reported to the submitter via completion, and it will override
> any of the partial IOs that actually completed.
> 
> Hence, like the recently reported multi-mapping IOCB_NOWAIT bug
> reported by Jens and fixed in commit 883a790a8440 ("xfs: don't allow
> NOWAIT DIO across extent boundaries") we'll get silent partial
> writes occurring because the second submitted bio in an IO can
> trigger EAGAIN errors with partial IO completion having already
> occurred.
> 
> Further, we don't allow partial IO completion for DIO on XFS at all.
> DIO must be completely submitted and completed or return an error
> without having issued any IO at all.  Hence using REQ_NOWAIT for
> DIO bios is incorrect and not desirable.

What you say makes total sense for a user using RWF_NOWAIT, but it
doesn't make a lot of sense for io_uring where we really want
IOCB_NOWAIT to be what it suggests it is - don't wait for other IO to
complete, if avoidable. One of the things that really suck with
aio/libai is the "yeah it's probably async, but lol, might not be"
aspect of it.

For io_uring, if we do get -EAGAIN, we'll retry without NOWAIT set. So
the concern about fractured/short writes doesn't bubble up to the
application. Hence we really want an IOCB_NOWAIT_REALLY on that side,
instead of the poor mans IOCB_MAYBE_NOWAIT semantics.

-- 
Jens Axboe

