Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34063B752
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 02:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbiK2Bht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 20:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiK2Bhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:37:48 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C9D6354
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 17:37:48 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w129so12266040pfb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 17:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hwYJmo88IBZZEvj8mXF/0I11UwksQNJX5xkLBkjDU8=;
        b=AnfbiLN7xR3/GZjMV0uhgr5gu/e3NfLfkw2rZo1fJDOCFUQOnFY1xapvJmiyFPbFRm
         St9CEKN4Z/rpnFVdXj4d9N6puN2kKmZuUu1peGzmIgTbGeXF+1f3fI1og4OMEqiImMm0
         yPe/Yqtj4ckn+cc2IfmKcGd9T0LJyzCEHCSw3IdJzZj5oxUbDTGoUMiby4yy+Y4qpuRK
         NIxfe7Siz1YNh8vN2sWMHH0IWpXBy4B6BrPlyh+Xs286Je3v8j97XQ3+5CI4kIxlF6TL
         vhtWyG3r6WGjTyMmUyP+85cbhAbfpVL9BQDdTCMuoqm1BDJvhyPSexeQIXH9raqTv4i7
         nPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hwYJmo88IBZZEvj8mXF/0I11UwksQNJX5xkLBkjDU8=;
        b=wyI4FGrT0tZ2TL2VQPczQM3n8MR9sAHyqD/4s7k2m1ARSRGvnXNO+blfdbVgXrW/2G
         9hG7Pr5hlAMEqkujZjzmBBSVplRuhhvTiYk2kFQ2HzUX/kKjZzNQftgrxo//RjepYRxw
         V5s3KObCwS0rbzCuIMBjgsAe+My4pVkLCQZANDz/m9H3Bve18VXeTHGo+HryjSj08ZcA
         nhOKldoMJ93qhwQE9IqtBxOo7o0v0qhH3Y+mDcsL9SE5w/K/736OQg8MaubSwDh2fy4y
         yg1U4/jRIXO5FJyX/9WogyiDHGURNXtnkJZ11IPiDlCZraml9oi12eumMYE3ERHIq03X
         HuWg==
X-Gm-Message-State: ANoB5pmqShOLmOylMj0d3ozTfoIivfEhTtvyLh3+WcuOVBX8gUdRWCwR
        QTZcYv53nbqyEec89JGDW6XBPA==
X-Google-Smtp-Source: AA0mqf52yWf09g6//BZNdN+q+Xm6N2wkCRZ7/Hv1TUwLnAdnsBUZGEQLBDW8mxB0sfBZLP8a7o9XXw==
X-Received: by 2002:a63:d21:0:b0:438:c2f0:c2cf with SMTP id c33-20020a630d21000000b00438c2f0c2cfmr15236566pgl.116.1669685867794;
        Mon, 28 Nov 2022 17:37:47 -0800 (PST)
Received: from dread.disaster.area (pa49-186-65-106.pa.vic.optusnet.com.au. [49.186.65.106])
        by smtp.gmail.com with ESMTPSA id q100-20020a17090a1b6d00b00218ddc8048bsm106025pjq.34.2022.11.28.17.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 17:37:47 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ozpZA-002FYx-S2; Tue, 29 Nov 2022 12:37:44 +1100
Date:   Tue, 29 Nov 2022 12:37:44 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 11/9] xfs: add debug knob to slow down write for fun
Message-ID: <20221129013744.GZ3600936@dread.disaster.area>
References: <20221123055812.747923-1-david@fromorbit.com>
 <Y4U3dj5qvpKSQuNM@magnolia>
 <Y4VeuqfVBU4/x9aB@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4VeuqfVBU4/x9aB@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 05:22:02PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new error injection knob so that we can arbitrarily slow down
> pagecahe writes to test for race conditions and aberrant reclaim

pagecache

> behavior if the writeback mechanisms are slow to issue writeback.  This
> will enable functional testing for the ifork sequence counters
> introduced in commit XXXXXXXXXXXX that fixes write racing with reclaim
> writeback.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
> v2: this time with tracepoints
> ---

Looks OK to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
