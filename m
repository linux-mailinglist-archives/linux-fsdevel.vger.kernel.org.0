Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9563D438D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbfFMPJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:09:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45131 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbfFMN6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:58:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id j19so22600594qtr.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yl3u9OHniWwozrwRg8MwFXqj/tcVXwxH/GoIuJ/+cgI=;
        b=Pi7rcOcllDzY4YtuAORwjevLbfVYkp9i72ie6hKY1hOBpeYxeYRsynLD/r+GX+1WgH
         9jmz/Q4qLoLPj8DMkRMmocG1HkWaTtBqtjIbD09vscOFJJ4QDtmbpw0e3U1fLQ4Phs/R
         mm87AwBXyWcfet3drfxfBbP4UMYRvWbQj0PMUFxSthTBZjkcOo6tXgvizMr/hUkl/13I
         aI0yGb3dmtIfyR9EUbCQqe1oj4prYz6e3G20ui0X2KQIm8ieYwI2Xg+7728d6x5yRuS6
         FF+5aN9S5RAfYTLprSlp/cc73PjoMmLzraZlJPIxZSsVnzTk6h1W29S/oRgRORNWjD2Y
         Kp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yl3u9OHniWwozrwRg8MwFXqj/tcVXwxH/GoIuJ/+cgI=;
        b=G3dAYPiV48gumORibRpn+FWmgKYOya0cehUIfLOjRHSeXQCSkYovRIyNUHoUNeMTyV
         qt1pCmkcvXhN1Rwcx3QbV/LUitkcMNHmgV/swe03ReczhJYpU+8owtW+nsrNV7yFyjaR
         EOxIqnCKdqp/MPzMkdHxOeURwP74o9Ta3Bu5JyvDtnp5yypM5hWxTwaMthDoX4ecoRhi
         byGn6KEYTApuOWJsHha7VtXvOuoUF2yBXpLkVYK3jGzxO4OG5Kbpdu/LDDT4iKwcVGhj
         3EpdParOQDY06ZrIyiYC078M0sulukXJtp+nYzBBaxqB+8sW+kJScQXK7GvCOJjR/Wxp
         QBZw==
X-Gm-Message-State: APjAAAXrpka9z62ee4+W18iPBw+4qJF3wmhcH+ei7Gveatk/W8eW6YwC
        ai8swkOUQR/OXkkUFaOzR8tVWQ==
X-Google-Smtp-Source: APXvYqyGSXoBxGa8QqcJkIXSj6Xo5CkCBbBgl8mWo01DB6W1NBo5ZdtvNDRttPqNV+iCW5y6FGjixA==
X-Received: by 2002:ac8:38d5:: with SMTP id g21mr74358612qtc.52.1560434282173;
        Thu, 13 Jun 2019 06:58:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id v41sm1699059qta.78.2019.06.13.06.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 06:58:01 -0700 (PDT)
Date:   Thu, 13 Jun 2019 09:58:00 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 02/19] btrfs: Get zone information of zoned block devices
Message-ID: <20190613135759.22siaadm7l4gz2ri@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-3-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-3-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:08PM +0900, Naohiro Aota wrote:
> If a zoned block device is found, get its zone information (number of zones
> and zone size) using the new helper function btrfs_get_dev_zonetypes().  To
> avoid costly run-time zone report commands to test the device zones type
> during block allocation, attach the seqzones bitmap to the device structure
> to indicate if a zone is sequential or accept random writes.
> 
> This patch also introduces the helper function btrfs_dev_is_sequential() to
> test if the zone storing a block is a sequential write required zone.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/volumes.c | 143 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h |  33 +++++++++++
>  2 files changed, 176 insertions(+)
> 

We have enough problems with giant files already, please just add a separate
hmzoned.c or whatever and put all the zone specific code in there.  That'll save
me time when I go and break a bunch of stuff out.  Thanks,

Josef
