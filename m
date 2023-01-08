Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B6F661A48
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 22:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjAHV7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 16:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjAHV7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:59:17 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC223A1BC
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 13:59:16 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 17so7596416pll.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jan 2023 13:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRwtLPQVjsAJ21UOF2AH7QhDRVRLxvztJgAiY0hGtps=;
        b=DsZ97qPfn+vhMdmHYEQPR03qcl9I5p3jIShJCNMi//ZMrFVxdOkuAoJXqcs+tB5RSn
         QcB2rzxaDJsmmMHCrqxeHYghKoFZvvg7wB5mLhGYKV48tedYlwkoEzx1s/m70EOBI2w2
         klEp7yZCwCm88twDimFpRT6cC1lu+7jbwr+H0MoQAMbdhgTr3zn/4TglQJI7SViU4JGk
         1KCpRBlXvfMm4ES6Pvk1YmnXNDU6K9Sy6JqxdOe3BWz24QSH3ChdaqmtlBtzXkPUiJ2c
         s3DclSILRi9x57F4Db/3FKDA4w5rvwJooG2wdUG1z3gpMr3HgweiKuBc9blESspj6yTD
         E6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRwtLPQVjsAJ21UOF2AH7QhDRVRLxvztJgAiY0hGtps=;
        b=MxY2oj5fPDWXPx18YXAgMKp5gEs95wmxTpSk8Kk2tK0cMHYvvsfEwRPG1p+SYwp71u
         LusDVwtZKvcKF+ny5ndtdGD3Cjp/ES83VZPoSkxgp1hF//CIuhDZUStfI6frscrcNZGa
         gTPuRqX5X2BWUNOLRQRe2m2us4OrIzt85dGyNih5N45tXJ9TCDaAyG8//F0GBg3Esm0i
         8JdX1jQIa4mgBm6Inh1GN6930qfPPZxTfiqW4uFMiX6RTSgyJxP6ErvbmHzXlN6+pl+S
         dqOmpKhxwVUIPzpRzki5K5HJrQ+6uv4mCx6esLXQ/saUfTCiwJwKA1LLoKHeBF/ijE3C
         qaFQ==
X-Gm-Message-State: AFqh2krz2WNnGR2B7F41c8GFobw1XzsJ8uSW4vVFjua4kFdyMtOSG/rX
        REt6ZZwfjylhBMgU1b6h15P6pA==
X-Google-Smtp-Source: AMrXdXsAIiWjmygk2jewqgV/cdCOSCNGl0lDa8UBdYidyZcmWqor2Pq9z7XkwyQwco4bwJjylZIz9g==
X-Received: by 2002:a17:90a:aa92:b0:226:b425:3540 with SMTP id l18-20020a17090aaa9200b00226b4253540mr16679445pjq.36.1673215156237;
        Sun, 08 Jan 2023 13:59:16 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id jx12-20020a17090b46cc00b00225a8024b8bsm4127825pjb.55.2023.01.08.13.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:59:15 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pEdh9-000l2I-TM; Mon, 09 Jan 2023 08:59:11 +1100
Date:   Mon, 9 Jan 2023 08:59:11 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v6 08/10] iomap/xfs: Eliminate the iomap_valid handler
Message-ID: <20230108215911.GP1971568@dread.disaster.area>
References: <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-9-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108194034.1444764-9-agruenba@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 08:40:32PM +0100, Andreas Gruenbacher wrote:
> Eliminate the ->iomap_valid() handler by switching to a ->get_folio()
> handler and validating the mapping there.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

I think this is wrong.

The ->iomap_valid() function handles a fundamental architectural
issue with cached iomaps: the iomap can become stale at any time
whilst it is in use by the iomap core code.

The current problem it solves in the iomap_write_begin() path has to
do with writeback and memory reclaim races over unwritten extents,
but the general case is that we must be able to check the iomap
at any point in time to assess it's validity.

Indeed, we also have this same "iomap valid check" functionality in the
writeback code as cached iomaps can become stale due to racing
writeback, truncated, etc. But you wouldn't know it by looking at the iomap
writeback code - this is currently hidden by XFS by embedding
the checks into the iomap writeback ->map_blocks function.

That is, the first thing that xfs_map_blocks() does is check if the
cached iomap is valid, and if it is valid it returns immediately and
the iomap writeback code uses it without question.

The reason that this is embedded like this is that the iomap did not
have a validity cookie field in it, and so the validity information
was wrapped around the outside of the iomap_writepage_ctx and the
filesystem has to decode it from that private wrapping structure.

However, the validity information iin the structure wrapper is
indentical to the iomap validity cookie, and so the direction I've
been working towards is to replace this implicit, hidden cached
iomap validity check with an explicit ->iomap_valid call and then
only call ->map_blocks if the validity check fails (or is not
implemented).

I want to use the same code for all the iomap validity checks in all
the iomap core code - this is an iomap issue, the conditions where
we need to check for iomap validity are different for depending on
the iomap context being run, and the checks are not necessarily
dependent on first having locked a folio.

Yes, the validity cookie needs to be decoded by the filesystem, but
that does not dictate where the validity checking needs to be done
by the iomap core.

Hence I think removing ->iomap_valid is a big step backwards for the
iomap core code - the iomap core needs to be able to formally verify
the iomap is valid at any point in time, not just at the point in
time a folio in the page cache has been locked...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
