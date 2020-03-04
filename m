Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB43D17969A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgCDRWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 12:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgCDRWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:22:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EF8F217F4;
        Wed,  4 Mar 2020 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583342544;
        bh=59/11F8FK+NgHEqVfA1CIFRhJRwwbcCjpLhWz66g7tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ze4VX0GD2G5O4jX1r48ZRIOgSdG8neWKYYRrOmbOUEcPyHVsa07VUMb1eunVOehg/
         ZH0CTDurZL2PhkUAo8i7Du4Lsd5znb5Wggps9wMuLP7QcXmtLOFTisJRRZyXNVi0s/
         zNq8jOjyiegmR7xyhjzXl0S6P/ecOe/1cXdK7oNU=
Date:   Wed, 4 Mar 2020 18:22:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu
Subject: Re: [PATCH v2 3/7] bdi: protect device lifetime with RCU
Message-ID: <20200304172221.GA1864270@kroah.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200226111851.55348-4-yuyufen@huawei.com>
 <20200304170543.GJ189690@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304170543.GJ189690@mtj.thefacebook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 12:05:43PM -0500, Tejun Heo wrote:
> Hello,
> 
> It might be better to put this patch at the end rather than in the
> middle so that when this patch is applied things are actually fixed.
> 
> > +struct bdi_rcu_device {
> > +	struct device dev;
> > +	struct rcu_head rcu_head;
> > +};
> 
> (cc'ing Greg)
> 
> Greg, block layer switches association between backing_device_info and
> its struct device and needs to protect it with RCU. Yufen did so by
> introducing a wrapping struct around struct device like above. Do you
> think it'd make sense to just embed rcu_head into struct device and
> let put_device() to RCU release by default?

Ugh, I was dreading the fact that this day might sometime come...

In theory, the reference counting for struct device shouldn't need to
use rcu at all, right?  what is driving the need to use rcu for
backing_device_info?  Are these being destroyed/used so often that rcu
really is the best solution and the existing reference counting doesn't
work properly?

Some context is needed here.

thanks,

greg k-h
