Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0D70AC16
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 04:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEUCtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 22:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjEUCtX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 22:49:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90381107
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 19:49:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53487355877so1697412a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 19:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684637362; x=1687229362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U4CmIoMNb5RGTtBWysZDeW/jRh4muNV9pKU+hLoKMv8=;
        b=nsamtAPRT51Xf1sCC78d0FFqiBP3AxVH+T1ODoSta+Nx+rEGKR+HZi6qBgosIuwp8W
         CCqs0qLKciMjgv1lOZa3lDwTOsQ0K7zuAWIvCyPQvhJVV1ZA1Z2WOGT39wEznX5bHX6X
         KEIeGJapJBB0WQHtsUY62hOdQd3VQN7Vu0fpJdYrJi7AOdn9zxq5yvNod9YBar9X2mu2
         tkMYFCQJ0DFPHFmB0AzlIlczDmYIYgEhWQD2v5kB4O6/6OVLSMaMWlcjNNrcuqNaC3kM
         bjwFEHa2Da40ooAERT0qUFvColxX1CE4oDj6vx9uTvYtZK0SOeUjNYosI+26SHuIYgt1
         bg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684637362; x=1687229362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4CmIoMNb5RGTtBWysZDeW/jRh4muNV9pKU+hLoKMv8=;
        b=Ho/2vTEW1AVT4M6JdTkXFOBixfEY5PpmOQidnc5WVqIxhmlKtqKJViwK2KIN5dxGz5
         xXjbeOw6jc+NK/ij8Jw9SBGPpgu91b4vfhmkWAGq3A8aP/l2x3TgJNywJ79Q1fZcz40I
         JmL3QErdixWG90lt+cdVHaW5J4w4/y+2Y9ftG8jjl4LSo3RztrerOIZXQBI1x4ATlhBa
         LlwBbY9gj1473UrjusKf0TYcWOR3ikaG8pWZauaaq/Yoll8W+ELoRbO2Dht9pj+C4mfV
         7UaWq5fSbag1/t5IIyoQro4zKTmKPliG8ckBtz20MhUQMQPdPsEBsU4i36FHgRd5XJL6
         Warw==
X-Gm-Message-State: AC+VfDw0jAe3ahV9syaNLeSIh3A+d6dJfEWGS1IA7r4HaCt+fDmZstIn
        48OqrKzj1moAjiHZf0XXTlvbLatfSoqQtpRGT6M=
X-Google-Smtp-Source: ACHHUZ6VDqnI1Ix5LSZFm33BRLHdcoFWGY8mKDg+gOxy/r8h/7uG1lDWMzTg7JSlMg7SBkRzF4+5EA==
X-Received: by 2002:a17:902:f549:b0:1a6:ff51:270 with SMTP id h9-20020a170902f54900b001a6ff510270mr9097319plf.29.1684637362069;
        Sat, 20 May 2023 19:49:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902ed5300b001a9873495f2sm2152335plb.233.2023.05.20.19.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 19:49:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q0Z8I-001ygJ-2A;
        Sun, 21 May 2023 12:49:18 +1000
Date:   Sun, 21 May 2023 12:49:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 0/3] Create large folios in iomap buffered write path
Message-ID: <ZGmGrtnYF8Z1InD4@dread.disaster.area>
References: <20230520163603.1794256-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520163603.1794256-1-willy@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 05:36:00PM +0100, Matthew Wilcox (Oracle) wrote:
> Wang Yugui has a workload which would be improved by using large folios.

I think that's a bit of a misrepresentation of the situation. The
workload in question has regressed from ~8GB/s to 2.5GB/s due to
page cache structure contention caused by XFS limiting writeback bio
chain length to bound worst case IO completion latency in 5.15. This
causes several tasks attempting concurrent exclusive locking of the
mapping tree: write(), writeback IO submission, writeback IO
completion and multiple memory reclaim tasks (both direct and
background). Limiting worse case latency means that IO completion is
accessing the mapping tree much more frequently (every 16MB, instead
of 16-32GB), and that has driven this workload into lock contention
breakdown.

This was shown in profiles indicating the regression was caused
by page cache contention causing excessive CPU usage in the
writeback flusher thread limiting IO submission rates. This is not
something we can fix in XFS - it's a exclusive lock access
issue in the page cache...

Mitigating the performance regression by enabling large folios for
XFS doesn't actually fix any of the locking problems, it just
reduces lock traffic in the IO path by a couple of orders of
magnitude. The problem will come back as bandwidth increases again.
Also, the same problem will affect other filesystems that aren't
capable of using large folios.

Hence I think we really need to document this problem with the
mitigations being proposed so that, in future, we know how to
recognise when we hit these page cache limitations again. i.e.
I think it would also be a good idea to include some of the
analysis that pointed to the page cache contention problem here
(either in the cover letter so it can be used as a merge tag
message, or in a commit), rather than present it as "here's a
performance improvement" without any context of what problem it's
actually mitigating....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
