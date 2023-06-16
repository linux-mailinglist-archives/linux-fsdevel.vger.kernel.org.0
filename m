Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4073732523
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 04:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjFPCTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 22:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbjFPCTW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:19:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879B126B8
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 19:19:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-256712d65ceso241203a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 19:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686881961; x=1689473961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HQDcn9tZwM6dJWJSarO3qZdUTtjx5HJEKAidy6nCHT0=;
        b=j2Bjm6kf5Eqktbi2p/5amdCmf/zA3T1CQ2B0xd9dhgAyt49o66qLgnbEGlDoFlO5tV
         LevH1j2L06gW9RJZr4cm7eYHevPQwswKT0pOKZ/4hNcw5KprhsnRZ2MW2RMbUY+UWHAK
         eixBMvC3sKNypLBkgHhbcGNAta0gjGRAyx+POa2JxyUOJ4MURgJ+CTJN9fEsviIxXdVv
         K/1e8id1/NlEyTDG7SOVa/P6q4PrT4EWT5RBqkfChkSQ5IdfzHkpZpdvAabkLafgP0Vm
         E+fU1Y6Iy1Sg89e5edKssqBl7bR8R5/j/HQApYctj2KE5Tvssms1+IrmAjV1Q9kKPOD+
         9zKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686881961; x=1689473961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQDcn9tZwM6dJWJSarO3qZdUTtjx5HJEKAidy6nCHT0=;
        b=an6d7jMMkBplWMBI9sEpMDsRw9BNZi/LfCBQ54KWShi4HyzrG59K8u4oXeXqZ4n1oN
         jzFMgHfj8JDpkuW7FM0XQhDRHLD2FlAMBa7CBCaUvngybC/Q++X5yyxve1Go3ZXNUeT/
         S5cg3Et47BrKJzedq0/Qw+eeQ7AmWw8m0IdvKQXANrrz1TNQ/oYOGFZizgaFzouseLMK
         8aRcFve6QRj8FtgnB5a1ZSg/piF2LvvFGxmTSB6ZEg5GUS8TX2/FOcSpFWx6Ni0RYFsA
         0C1QPN8/offAsjBsn+CgSXFTGHcjK7MzHWlWa3PLMdN4H8OddXBz9+cKuAW+fTuseyzV
         ascw==
X-Gm-Message-State: AC+VfDwONbfnJUkwPug8jN3BFN6S9CHSQzx6d6bKwGGJ8Q/LFDPwEiPv
        jyxpJxWqSv83V/k6nEl1+ccv4A==
X-Google-Smtp-Source: ACHHUZ5gdqKB8aPPzmlVp9TXL0vRSZ6J5bLE9MDUGnPpw7n/6lr01gdGxkb417+pntnNBOxPU177+A==
X-Received: by 2002:a17:90a:3903:b0:246:634d:a89c with SMTP id y3-20020a17090a390300b00246634da89cmr445509pjb.41.1686881960993;
        Thu, 15 Jun 2023 19:19:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d70500b001ac94b33ab1sm5965687ply.304.2023.06.15.19.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 19:19:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9z3W-00CIkU-0c;
        Fri, 16 Jun 2023 12:19:18 +1000
Date:   Fri, 16 Jun 2023 12:19:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, jack@suse.cz, hch@infradead.org,
        ruansy.fnst@fujitsu.com
Subject: Re: [PATCH 2/3] fs: wait for partially frozen filesystems
Message-ID: <ZIvGpuS5is6Sc6ln@dread.disaster.area>
References: <168688010689.860947.1788875898367401950.stgit@frogsfrogsfrogs>
 <168688011838.860947.2073512011056060112.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168688011838.860947.2073512011056060112.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:48:38PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Jan Kara suggested that when one thread is in the middle of freezing a
> filesystem, another thread trying to freeze the same fs but with a
> different freeze_holder should wait until the freezer reaches either end
> state (UNFROZEN or COMPLETE) instead of returning EBUSY immediately.
> 
> Neither caller can do anything sensible with this race other than retry
> but they cannot really distinguish EBUSY as in "someone other holder of
> the same type has the sb already frozen" from "freezing raced with
> holder of a different type".
> 
> Plumb in the extra coded needed to wait for the fs freezer to reach an
> end state and try the freeze again.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/super.c |   34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)

Simple enough. I was going to comment about replacing wait_unfrozen
with a variant on wait_for_partially_frozen(), but then I looked at
the next patch....

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
