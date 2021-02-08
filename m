Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071E6312B32
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 08:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhBHHki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 02:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBHHke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 02:40:34 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4194DC06174A;
        Sun,  7 Feb 2021 23:39:53 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id c18so15742466ljd.9;
        Sun, 07 Feb 2021 23:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3qO9XtGjtAL1hXm5+HTnDd4FC41lJytDGSMy8XTKh0Y=;
        b=SSzgvzvhKMHtU5nb6Uvar2B0cFRNGCAJDt/7VgieRpNZPcSNm5GGig1mk0SSqzTwFj
         zJDkYA9ndFHjAJRcbHa8BQGsi6Fe0cWyufMI6X7IrCx8hcDAISa8ezTItBL0b3EmqyNJ
         n07+NgyhAW/o2QS50he7tNgpbyWLSojPttwgPgryE/1EypL4Q1HqSbqOX1UVUh3ldn2W
         5RPASflWE8bki5+i6LZcOt7V2c1E9wxxQPSNq3oaDJJjLJBk3Nh9SCi/HQqmDdRB8zyc
         JxkYHlUjnSojUZ+OZkKJujlHLO98oH8UClFBmkn5arBZfE0VNrax0wnaou9xuKc4VfHE
         6/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qO9XtGjtAL1hXm5+HTnDd4FC41lJytDGSMy8XTKh0Y=;
        b=XJlrWoVCiQlBRFm/mOtMN2/XZGAm9fCGhkWpYG2BFDzeUs2HNwBXKeeXAlp9wo3157
         RjJ0E63llz1CWXjbErvw49ZcMtNDnntp3qO7VP1QcvFoKeYvYyckeKdvI1BGHT7AHfNe
         np3YlaNMaKB7risVZk0SUB2ciexm3Ab0CZc+9bwCGIA/XHnIrKFInQbuPaEcdD0mHtJN
         GxFOf/cRiTX+dgjMDUsUh6K89dmx3OIqQLdsMB/b7XlbYWCtTA6aado6R/wbwMqGetp6
         6O7Vu6PRdB1MEFYYD7GzXZovQWylCbpG3fG8YoEaeLdXT33j4WZXj/vjuiqsT7hYhzsy
         LmnQ==
X-Gm-Message-State: AOAM532Zn85/1d2L2GAwLFvz+8/r5U4nzOu41o/VZz3haw4XLRB6TMcb
        /xZXvHkVgVy4bz7+pY7js40=
X-Google-Smtp-Source: ABdhPJxqpCLTaXiL+9+ZXD3CJD6SAwIS5h7wnlRva1TXgfXvHkKWU59aqVSBjTillqyxRnyEbSxz1Q==
X-Received: by 2002:a2e:bc1a:: with SMTP id b26mr10238231ljf.294.1612769991678;
        Sun, 07 Feb 2021 23:39:51 -0800 (PST)
Received: from grain.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id r136sm1971361lff.247.2021.02.07.23.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 23:39:50 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 94ED2560163; Mon,  8 Feb 2021 10:39:49 +0300 (MSK)
Date:   Mon, 8 Feb 2021 10:39:49 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Jeff Layton <jlayton@poochiereds.net>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH] fcntl: make F_GETOWN(EX) return 0 on dead owner task
Message-ID: <20210208073949.GL2172@grain>
References: <20210203124156.425775-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203124156.425775-1-ptikhomirov@virtuozzo.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 03:41:56PM +0300, Pavel Tikhomirov wrote:
> Currently there is no way to differentiate the file with alive owner
> from the file with dead owner but pid of the owner reused. That's why
> CRIU can't actually know if it needs to restore file owner or not,
> because if it restores owner but actual owner was dead, this can
> introduce unexpected signals to the "false"-owner (which reused the
> pid).
> 
> Let's change the api, so that F_GETOWN(EX) returns 0 in case actual
> owner is dead already.
> 
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: "J. Bruce Fields" <bfields@fieldses.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Cyrill Gorcunov <gorcunov@gmail.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

I can't imagine a scenario where we could break some backward
compatibility with this change, so

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
