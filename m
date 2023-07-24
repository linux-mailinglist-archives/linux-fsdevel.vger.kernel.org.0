Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB4375EBCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 08:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGXGkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 02:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGXGj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:39:59 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3F810F8
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jul 2023 23:39:38 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7836272f36eso148440539f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jul 2023 23:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1690180775; x=1690785575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UA46JXOgesbC+Hw0WTVb9Ex0u0JFh+2lvb8Dt3Xe0GY=;
        b=JSlKugo93w0LuvvZESIAqXK6JMorSBm2Ud2Jp8AIpXbKxCfQMgtUComirCGVW/KZVh
         /RYjmhzK3M6Njr/rTrAH3a+R0mzs+vvSMxv6d+tTAf4K4fODG2Ry8ylSUQdVJwP+9xc4
         35kJ25AUs9tLxhEotHLmGZ9D7jjHqnrx9YIrLRvnVGBfvZmcTK7XN8srAYYy2CnOX5iG
         sEzePFGOAnaBsMHAJRay3/QSKhdMWUrZDj5xnqUaFK5Ja2x6tHjjNENu2DRgbNUJIhBn
         nNe0MEY9DksIp5wBk7YxeZo8BO8VEY1y4WvdlbBVSgQopiKuA2Ex5tE9HXmjBwD1lN7/
         f9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690180775; x=1690785575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA46JXOgesbC+Hw0WTVb9Ex0u0JFh+2lvb8Dt3Xe0GY=;
        b=NolonACAesmhtcqTxGI0qUZnzw1usnprxfymsDWosMB5Ea8aakdH7fVLOhxIBin0ta
         mjuduePObzahZ01m6Q7YH2rOV4bqS9ysyycly9RR7LHzdIzb/M/hnUn0V9IYr888YloX
         U+r/I4MZl0NjBKDR0DX4jwHpmeuQl1iz+trPuX1syfIJmrr1LEC0ttbxXqPy6xODL+AM
         0FNpzAY8uEBz/y64ZcAHWpsaPTPqal2rWI4eVlXhK55KM3rc520DyqoeP+ayUExZN7VO
         rYev21FBV1JmYLe9Ydv0coYO6lGaI2g5FgVcpcDw6GCHtAdb0oIzCQatPIeWq7Yl7dR4
         /syQ==
X-Gm-Message-State: ABy/qLaFpc54uSp6C8AmhrZwJpZpCu5REEooSJqBjXAq2A+PF/15sURO
        NeHbnLa1MU1mxYYPMrcpweTDig==
X-Google-Smtp-Source: APBJJlHV6rGQMRqhG8BlCwNt5/JB2Dpn4brGoL7I+r6vKYg4/PRYcUEmkkUFP/rWyfL3ZaD9uP5JmQ==
X-Received: by 2002:a5d:9f18:0:b0:783:58f4:2e2e with SMTP id q24-20020a5d9f18000000b0078358f42e2emr6459037iot.0.1690180775592;
        Sun, 23 Jul 2023 23:39:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au. [49.186.119.116])
        by smtp.gmail.com with ESMTPSA id x9-20020a056a00270900b00654228f9e93sm6933872pfv.120.2023.07.23.23.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 23:39:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qNpEC-009qt9-1h;
        Mon, 24 Jul 2023 16:39:32 +1000
Date:   Mon, 24 Jul 2023 16:39:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, hch@lst.de,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/read_write: Enable copy_file_range for block device.
Message-ID: <ZL4cpDxr450zomJ0@dread.disaster.area>
References: <CGME20230724060655epcas5p24f21ce77480885c746b9b86d27585492@epcas5p2.samsung.com>
 <20230724060336.8939-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724060336.8939-1-nj.shetty@samsung.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:33:36AM +0530, Nitesh Shetty wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
> and inode_out. Allow block device in generic_file_rw_checks.

Why? copy_file_range() is for copying a range of a regular file to
another regular file - why do we want to support block devices for
somethign that is clearly intended for copying data files?

Also, the copy_file_range man page states:

ERRORS
.....
    EINVAL Either fd_in or fd_out is not a regular file.
.....

If we are changing the behavioru of copy_file_range (why?), then man
page updates need to be done as well, documenting the change, which
kernel versions only support regular files, etc.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
