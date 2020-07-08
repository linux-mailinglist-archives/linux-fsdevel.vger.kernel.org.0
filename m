Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85F421896D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 15:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgGHNpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 09:45:08 -0400
Received: from casper.infradead.org ([90.155.50.34]:35430 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgGHNpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:45:07 -0400
X-Greylist: delayed 1266 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 09:45:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ALoTRUWpyoJ5TLvh/u0ihRx9QLx7mqPr8euUVwU9fWg=; b=vz1Ro+dufJWwWA7UmwzBycaTV9
        /0RiH/WHQ+aVbPep3jyOFfC+FP1u5tkkrzFk3s7JyMNkln5i3pV7RpQjenFkFTWyUGqMRVwvT//JA
        7Ln8LUzELu+B67MOLF21c7RKpsTDp0q2wmslj7Ntk3r4uH00aI6JobFDMismYfceQWmV8votbz/S4
        ZQt9RxMwIp7yniwMoRc8Yt83jF6EcSNpJy6aQnT765vpDWP5Pteo+uRvy+NPp2rx6eaewh0NRee7v
        XZWFjNktt65gVlkKlUHpxi37RmmbPgb+4++oEwChZy60usK+sCyjg2DVm/YCEOAtnEF7FdFI3hTee
        WeMGORlw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtA31-0004Tm-CW; Wed, 08 Jul 2020 13:23:41 +0000
Date:   Wed, 8 Jul 2020 14:23:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] md: switch to ->check_events for media change
 notifications
Message-ID: <20200708132338.GO25523@casper.infradead.org>
References: <20200708122546.214579-1-hch@lst.de>
 <20200708122546.214579-2-hch@lst.de>
 <09cd4827-52ae-0e7c-c3d3-e9a6cd27ff2b@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09cd4827-52ae-0e7c-c3d3-e9a6cd27ff2b@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 08, 2020 at 03:17:31PM +0200, Guoqing Jiang wrote:
> On 7/8/20 2:25 PM, Christoph Hellwig wrote:
> > -static int md_media_changed(struct gendisk *disk)
> > -{
> > -	struct mddev *mddev = disk->private_data;
> > -
> > -	return mddev->changed;
> > -}
> 
> Maybe we can remove "changed" from struct mddev since no one reads it
> after the change.

You missed this hunk:

+static unsigned int md_check_events(struct gendisk *disk, unsigned int clearing)
 {
        struct mddev *mddev = disk->private_data;
+	unsigned int ret = 0;

+	if (mddev->changed)
+               ret = DISK_EVENT_MEDIA_CHANGE;
        mddev->changed = 0;
-	return 0;
+	return ret;
 }

