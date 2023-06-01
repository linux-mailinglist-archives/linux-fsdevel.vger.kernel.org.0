Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3E71F510
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 23:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjFAVth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 17:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjFAVtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:49:14 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346F9E6A
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 14:48:51 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6af873d1d8bso1181244a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685656130; x=1688248130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5OcnCx/pmbtKXZ7Da/cfbjcjL+zu9BSzJDqrWeCJgqM=;
        b=iJ+8KgBdIdC0fmpV+4X5AKELAx0FWqlDQWhfpsM+A7pnnV/3/dVBEBpGetyDVC4ugR
         K/OZ5yTSh2/Hk3/Ch55PUxSbD/VlFdQbMoibi19k4RKFT5WhvtOqoEUyc0wbsCeBZPLn
         Z0F/FCkSFr5gt7mnVJP7Xfej7iMQCk1AOqFuxHsYLceDp2DJbAT6BHetM17aJ+MLxOYJ
         UgBs+hheP7eKDjZ8LgeVTIRLxYXUP01QDIeck0U2kF5B40/7hUOKs3H5MIG5ilO2BK9W
         NAlDPf8Y9tnkQDg4ogyDVoFGO9CALjAVW0iifu8WadfLVGgLiIOl0VO1iuluLRKySMYv
         5x+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685656130; x=1688248130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OcnCx/pmbtKXZ7Da/cfbjcjL+zu9BSzJDqrWeCJgqM=;
        b=JXcVyRB000hhZDf+Y3zKzULEmr/N5PMevy860pNH6TeSlN931oCzipX90IXQYXtH1y
         fUUMDxE4xEcv2DVWclk+6jraWOR8kVYk8ZrooN3AOzBauO5SHRTpUGEWJpxC8TImbES9
         1YptkFYGt52wukGSgS4tdNuGu+qWypEMHdTQtXjemaZGVQeXRnMNy4sne4ktiAYcoAUo
         TkLjDNdP1/8x6hNwd4ijZsT+rIm1IHRtU0TUrgNPHuFK4v4DHE/DEzLWF6PHCZl0rQJh
         APq8t5U8xy9JnmEdXUIrdBgwRZnSTSKRslsEQDPAJ+bEaNDiNjx7E5/OwMK9c8R6JgjF
         EVpQ==
X-Gm-Message-State: AC+VfDwxfuSOuFVFEidU1+q+jVqrJol0812xPEUumSD7X0lzulUou9ah
        s7Ynl+/LGQlQgE5SxLAmkMFpcw==
X-Google-Smtp-Source: ACHHUZ415WnubrhQMrYWFgLqY3RXllLba3VYlMrHqu2QPousFmk1Hej1ZnqOsZGP095dGQGVDiGwOA==
X-Received: by 2002:a05:6358:7242:b0:123:3f75:f56a with SMTP id i2-20020a056358724200b001233f75f56amr6105303rwa.0.1685656130299;
        Thu, 01 Jun 2023 14:48:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7848a000000b00627fafe49f9sm5485376pfn.106.2023.06.01.14.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:48:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q4qA3-006f3I-0v;
        Fri, 02 Jun 2023 07:48:47 +1000
Date:   Fri, 2 Jun 2023 07:48:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: introduce bdev holder ops and a file system shutdown method v3
Message-ID: <ZHkSP0qlKQWDcStr@dread.disaster.area>
References: <20230601094459.1350643-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601094459.1350643-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:44:43AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series fixes the long standing problem that we never had a good way
> to communicate block device events to the user of the block device.
> 
> It fixes this by introducing a new set of holder ops registered at
> blkdev_get_by_* time for the exclusive holder, and then wire that up
> to a shutdown super operation to report the block device remove to the
> file systems.

Thanks for doing this, Christoph.

For the series:

Acked-by: Dave Chinner <dchinner@redhat.com>

For the XFS patches in the series:

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-Dave.
-- 
Dave Chinner
david@fromorbit.com
