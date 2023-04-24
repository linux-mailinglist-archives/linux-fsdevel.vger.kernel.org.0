Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC2D6EC39E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 04:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjDXCgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Apr 2023 22:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDXCgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Apr 2023 22:36:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162E8210A
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Apr 2023 19:36:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b620188aeso4983116b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Apr 2023 19:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682303790; x=1684895790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Er9IodKAhu5Xy/24MmuM3ISnj8SFsqKhcDcV85YYtd4=;
        b=Myis4J2Z9lmx+G/UGHQV666UFM6OJ8EKtdAre2rvRUUjU2E+rQLKwJ+D0eYgmT72Z9
         5SaX6H/C77vylvdgFXO4tn7m7ArVvZvZSOxiW6NiLDX5h8w4cEfp1YoxEuHlyRXPz09e
         5JgUmEmUJwM1H8XEmuezqPmJ+lzP8zXU2UJcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682303790; x=1684895790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Er9IodKAhu5Xy/24MmuM3ISnj8SFsqKhcDcV85YYtd4=;
        b=eBKxgYULEDSpd625DsAigdOdqF906D0TVnE1+iBoxFPYkXFjPKiBcW6txZfahdRq+p
         MQK9PrfkFvq8dVZWYpjXLigsNgqoAJC9DjaGRhPr+K3V2hV0RFhMSWCxn+edK/1CQiNB
         8OTDy8boaE1QgD3eij11zx0bm6hcRoeVIIYBiftw4ZGF4tIpmoO9l5jq7Q5SgqbvKEC4
         5TSrmqzILw23+MdboZ0P9evvQctgwHPugNPSJLBbvraej50RAMNOJCYx9KcqkeAmHuOy
         ST6AS443PTVlaAfDvq3lpCUNYGmJ/rtHUQR27inW4fmV24pPXWaBBDXrtHQSbFlDOWC8
         U8cQ==
X-Gm-Message-State: AAQBX9cIKtedUW5wZ8AVRutmzKK8ECDs9OuuuLZkVhZ83KNPR684srCd
        4yZB9d9ltUw+Xap7gfupbIA1og==
X-Google-Smtp-Source: AKy350a438RODTsIQbvbOZb4mhoGqhZ1pvzPivBPJ5Ra5hjJQnsR6/IRQqkIVQmM+kaUu2d3rd1IMA==
X-Received: by 2002:a05:6a00:2406:b0:63d:38aa:5617 with SMTP id z6-20020a056a00240600b0063d38aa5617mr12656579pfh.6.1682303790512;
        Sun, 23 Apr 2023 19:36:30 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id h8-20020aa786c8000000b0063b8279d3aasm6183422pfo.159.2023.04.23.19.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 19:36:29 -0700 (PDT)
Date:   Mon, 24 Apr 2023 11:36:23 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, hch@infradead.org,
        djwong@kernel.org, minchan@kernel.org, senozhatsky@chromium.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, hare@suse.de, p.raghav@samsung.com,
        da.gomez@samsung.com, kbusch@kernel.org
Subject: Re: [PATCH 5/5] zram: use generic PAGE_SECTORS and PAGE_SECTORS_SHIFT
Message-ID: <20230424023623.GC1496740@google.com>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
 <20230421195807.2804512-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421195807.2804512-6-mcgrof@kernel.org>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (23/04/21 12:58), Luis Chamberlain wrote:
> 
> Instead of re-defining the already existing constants use the provided ones:
> 
> So replace:
> 
>  o SECTORS_PER_PAGE_SHIFT with PAGE_SECTORS_SHIFT
>  o SECTORS_PER_PAGE       with PAGE_SECTORS
> 
> This produces no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
