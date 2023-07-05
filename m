Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2575747AD0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 02:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGEAwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 20:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjGEAwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 20:52:20 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2104D10DD
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 17:52:19 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3942c6584f0so4184005b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jul 2023 17:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688518338; x=1691110338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xCkzZ7pNqHs6SfNWx54nXU3O/GrqA2EtHMcutv2usrA=;
        b=br2NjzGGG4yn6FD1RRXAtTlQUAzuhkQaOLTSAfhxUKM0ZqXN3vxPSUIu08auE4QHun
         Ci9DhC0YX6k7hzS8i6/uYcao/N9K6o5SJ0+t4CTlRot8Jafz3X6d/h6Kv9xOdbeJk52t
         NKzaQOj6GzGgRc5SRo3bjX+bHIK3X5cJ9tT/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688518338; x=1691110338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCkzZ7pNqHs6SfNWx54nXU3O/GrqA2EtHMcutv2usrA=;
        b=ARPAOO8gV0BX2u17r0qeBK/KZB1OqABFpoaHT6gcVubNhD/bg1fF3huTJnwXbRQ6AN
         urhsCKYVJBB42N2ypkbCidmCRgjtGGhvvbgBLIxPdTwZiFkG5H+fw07Zbz1RyOeZrQ8u
         BqArpzUjo9svKe9VgP7tVLx/qSJvbrsR3AU6xLRWpwZIB9PTfbV624moZIZO1ZBtWgFi
         FsEkEXn9XvTQGogURH9euiG/okA53Gvp8QJqkJsYJIGH0av/wk4ilYbi4aikNGHAOAUF
         w5QyXhYU9JzNV2I5odFsM3pGVlBK+fbDntdt4LSi8jQ3zNXXz5sdWveHASzOQ+ABz1mm
         zqcA==
X-Gm-Message-State: AC+VfDwjaYooxO1LeshhUsrzYCpFODPfuCTZCTJMBGTWP8KdDBGjMFJZ
        2NpIaIbZMizE3USKM4RD/g7fvg==
X-Google-Smtp-Source: ACHHUZ6hpbnHy56T5xz/ZPxeKzJBrTDRy0kcHBkGMdzOMsJA0CevdsSJ5IJ2bGLftPs4NfoIts24ZA==
X-Received: by 2002:a05:6808:1895:b0:3a1:e796:d961 with SMTP id bi21-20020a056808189500b003a1e796d961mr17420567oib.2.1688518338483;
        Tue, 04 Jul 2023 17:52:18 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001b03c225c0asm17640763plr.221.2023.07.04.17.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 17:52:17 -0700 (PDT)
Date:   Wed, 5 Jul 2023 09:52:13 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 09/32] zram: Convert to use blkdev_get_handle_by_dev()
Message-ID: <20230705005213.GD283328@google.com>
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-9-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704122224.16257-9-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (23/07/04 14:21), Jan Kara wrote:
> 
> Convert zram to use blkdev_get_handle_by_dev() and pass the handle
> around.
> 
> CC: Minchan Kim <minchan@kernel.org>
> CC: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Jan Kara <jack@suse.cz>

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
