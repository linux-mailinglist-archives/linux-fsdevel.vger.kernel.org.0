Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAB895D8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 13:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfHTLgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 07:36:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbfHTLgZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:36:25 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4539269094
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 11:36:25 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id k10so6876173wru.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 04:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=+jTC31UoVxVyJbeKdpThaY7dIDTPTM58fPXXoh/n94I=;
        b=c9ja21nIGELWsFML7I+sub1wTx8KnPL1pRmNj29I04NLXFhztyAVSL/u46tUwTYdxT
         TZlsjaK5fiDj6g8+v08pz6XixVQqshOpHKF0USbhqw2u51k9OZHZ51lP8a+svchkaRwj
         pALAQyFABUAhIQPCU5iqe0+m4jR9e1vydZCWDZPnISqsaX8zTGRGciHuTXHwQXixXMJ0
         k1gpbfw8tbkBaWRhfjk096Ub5JapHQqJIvWFKjkF4BF8zj6isnBxmXQ4V2lWUHsCNbYn
         KieQZBs8K9tqMjOXhLJUz2OehztM6Xb7F4J/j6DChRKJIhO883jSfVicigtOerrYjr7g
         fVXw==
X-Gm-Message-State: APjAAAUl0lxyaqJF1vBnXGOlsvPuDK+bJsAS3mOW0hFPLIJMFplYq7KP
        018GhevouO5RObtUGKMqiQ/x+1peV+bI6eO9BM8J+6qKoqP6vXR6f35BudYGWqqUAbI0XhQFoM+
        ymVE93LtlDxLUolY+D9emtce+QQ==
X-Received: by 2002:adf:ef07:: with SMTP id e7mr34882015wro.242.1566300983618;
        Tue, 20 Aug 2019 04:36:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAYdlEhSdDtLN+CYcxeGMt+rxtk0Xw8GXeAg6FWlBrxY3BzmFeRyzV70cLgQ+UXhJsdubCvw==
X-Received: by 2002:adf:ef07:: with SMTP id e7mr34881989wro.242.1566300983378;
        Tue, 20 Aug 2019 04:36:23 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id v7sm2356800wrn.41.2019.08.20.04.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 04:36:22 -0700 (PDT)
Date:   Tue, 20 Aug 2019 13:36:20 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, darrick.wong@oracle.com, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/9] fs: Enable bmap() function to properly return errors
Message-ID: <20190820113619.qhvf44wyc4b2emw3@pegasus.maiolino.io>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, darrick.wong@oracle.com, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
References: <20190808082744.31405-1-cmaiolino@redhat.com>
 <20190808082744.31405-2-cmaiolino@redhat.com>
 <20190814111435.GB1885@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814111435.GB1885@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 01:14:35PM +0200, Christoph Hellwig wrote:
> Just curious from looking this again - shoudn't the 0 block be turned
> into an error by the bmap() function?  At least for the legacy ->bmap
> case so that we don't have to carry this cruft around.

I don't think so, this patch does not change the bmap interface on the
filesystems itself, and at this point, we don't have a way to distinguish
between a hole and an error from the filesystem's bmap() interface. The main
idea of enabling bmap() to return errors, was to take advantage of the fiemap
errors (in another patch in this series).

Although, I do agree that this also opens the possibility to change the
interface itself, and make ->bmap calls to really return errors, but this will
require a bigger change in all users of ->bmap(). I can work on that, but I'd
prefer to change this interface in another patchset, after this one is merged.
So, we can work only on those filesystems where ->bmap() will still be a thing.

Cheers.

-- 
Carlos
