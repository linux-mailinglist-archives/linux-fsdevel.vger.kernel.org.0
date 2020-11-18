Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BFA2B8066
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 16:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKRP0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 10:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgKRP0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:26:55 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B5AC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 07:26:53 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r18so1414290pgu.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 07:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1nmXoVj53UixJGdjpQg08Gvlgq4YY5Y4+b8GtsW6Kto=;
        b=SO1jquDh+lwZ29IQvlHoZl46j7RhGGs93JiouCytIyJen92SxLbjJno0Gxiu6hDRpW
         H4ZBW207sY1zbvMonuRyPmdMbQL8bHDIQb1vbLC1CI1aPw/IY0L6jIkaicHWCNCZUQVa
         JzeWodzPjFs1aSS/IQ8BEtqyh2Vs5gPWAvzJW36ntjOLCroUg+WZtWGuRDrk96omF0Fn
         lUIOySk67HXQlNeLx0lXv1a4OMcl8yCDl+wY8752CAu1bjyHNheiOKm5pOIhFu4emAGJ
         DL8OPT+jJMHCg17al333KR5IpHjarVKl826mLWXy1xuFZ0x2yVsg8eDEEQr5XXBHddBu
         aOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1nmXoVj53UixJGdjpQg08Gvlgq4YY5Y4+b8GtsW6Kto=;
        b=uXclnBCOAjKB3dqi5XZVxf6hINLiFWJ+0HaTCFT+EA9/Bnlhlf+c67HMnr6FeoPh3l
         NWqIhIvcnIwDbjL4/CLQ6SKGPCrH97ns0kMURpiQg7KFs6whaqniQp7pisOEyGvFjCvq
         Y3vpmgib1VTWp2sfFLO/qJ+kyhO3nUnvvH3Ip6dsZejFq0DRsfWo/S6rynMVKqhXxI1i
         L31xQcEJooh+UenbT+Jh9bGUN4LEiAmRVWP9EQD3onrPgiFBY+9l++0ZhfGWrTMvnVPo
         HnGefn0MwU/n3zLe5aC5sqZGlz5/pmdPKZyDD5wk2fHSBElG26r+ywrLB5TWF1EtBhST
         aAsg==
X-Gm-Message-State: AOAM532mFkzstD6XmS5AqtaSubIsOM30qBHvFwWPxE0l0M5aO0W4kZ9V
        4YBC6B1nhRD53PL5kDtemBBtv4ww4ffkkA==
X-Google-Smtp-Source: ABdhPJyn/tSwTaGdxLUsjfNmpfprJj/QYOobuPtWH2NkTORvlYGQpbX9xMKQY5AdKDwETDUqRfZLkw==
X-Received: by 2002:a63:495d:: with SMTP id y29mr769527pgk.384.1605713212972;
        Wed, 18 Nov 2020 07:26:52 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id g31sm11732004pgl.34.2020.11.18.07.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 07:26:52 -0800 (PST)
Subject: Re: [PATCH RFC] iomap: only return IO error if no data has been
 transferred
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <2a56ae95-b64e-f20f-8875-62a2f2e8e00f@kernel.dk>
 <20201118071941.GN7391@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9ef0f890-f115-41f3-15fc-28f21810379f@kernel.dk>
Date:   Wed, 18 Nov 2020 08:26:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118071941.GN7391@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/20 12:19 AM, Dave Chinner wrote:
> On Tue, Nov 17, 2020 at 03:17:18PM -0700, Jens Axboe wrote:
>> If we've successfully transferred some data in __iomap_dio_rw(),
>> don't mark an error for a latter segment in the dio.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> Debugging an issue with io_uring, which uses IOCB_NOWAIT for the
>> IO. If we do parts of an IO, then once that completes, we still
>> return -EAGAIN if we ran into a problem later on. That seems wrong,
>> normal convention would be to return the short IO instead. For the
>> -EAGAIN case, io_uring will retry later parts without IOCB_NOWAIT
>> and complete it successfully.
> 
> So you are getting a write IO that is split across an allocated
> extent and a hole, and the second mapping is returning EAGAIN
> because allocation would be required? This sort of split extent IO
> is fairly common, so I'm not sure that splitting them into two
> separate IOs may not be the best approach.

The case I seem to be hitting is this one:

if (iocb->ki_flags & IOCB_NOWAIT) {
	if (filemap_range_has_page(mapping, pos, end)) {
                  ret = -EAGAIN;
                  goto out_free_dio;
	}
	flags |= IOMAP_NOWAIT;
}

in __iomap_dio_rw(), which isn't something we can detect upfront like IO
over a multiple extents...

> I'd kinda like to avoid have NOWAIT IO return different results to a
> non-NOWAIT IO with exactly the same setup contexts i.e. either we
> get -EAGAIN or the IO completes as a whole just like a non-NOWAIT IO
> would.
> 
> So perhaps it would be better to fix the IOMAP_NOWAIT handling in XFS
> to return EAGAIN if the mapping found doesn't span the entire range
> of the IO. That way we avoid the potential "partial NOWAIT"
> behaviour for IOs that span extent boundaries....
> 
> Thoughts?

I don't think it's unreasonable to expect NOWAIT to return short IO,
there are various cases that can lead to that (we've identified two
already). There's just no way to always know upfront if we'd need to
block to satisfy a given range, and returning -EAGAIN in general when IO
has been done is misleading imho.

-- 
Jens Axboe

