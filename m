Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BDD3ABC41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 21:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhFQTFO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 15:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhFQTFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:05:14 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D84CC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 12:03:05 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d9so4330051ioo.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z5HnvT/He5wc3TvnthB+gn47ASzuP6Mrw+2VFf4NedE=;
        b=Pb62KYRBeElY2ztdpi7/Ce7DZpkujCDbD+V/8X81ma/6we4T/Kf/0jEB1+jyhIIWoX
         /D2gD58C0RKfOSFx+qeT8TbNuWFETsaJBwsO8GpFK4LVLq5zloewkkx4BkX72w60Xy25
         vVaxmOWBvvlyVMykVvn/EEL4KNLLjzwIS+tOSomO96IyzJvNFD3Z6l8cEXUqMuhtCH0I
         RRo6bQ3U/OiYv9+xGNDhHioojbh2F72rwuEHNNpS6eEGosVe7Ws4+PqLgPFt9zLgq5b7
         ZcIdzoCSTftpNx/UHPGZg2tFc5gO3g8wzbD548kvrOW2tBPeTyQbx/dry9zAIU1gwe1e
         MKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z5HnvT/He5wc3TvnthB+gn47ASzuP6Mrw+2VFf4NedE=;
        b=e08oLYklg0GkS9XslHbaRTn/LcOOA4zzC5UtpsgrkUCg+dl7GsMMaWwgFq3SMhbl4h
         1AELoGZdmFJ0CCh3Mqspgc3wKQi/Z5i/VT5dPkayj8/rwhCBlQfB0TQpcyw0wr0c60vW
         mGVLOSbucJQppcLmq/WgCJ/uYOkTbtLEnlDIt1Dg1HRQbjkHdsgvu30o8XgdRmCjuVjN
         N15Qx2Ee34N/mhGF1PpQ32kGJAwyht8tHJWCsYDHhuD2PsqobsFA4HhdtvGSblorsj+i
         vLBCh6RYA5H9azXkrb+n+1l9RWNcoJvk1PAdZPvku4bwdPGU7rUU37wbyzVyeq3oz11i
         mZBQ==
X-Gm-Message-State: AOAM533FhFTsElMt1Jhlw5twcgI4jkcyrSX7SH/tP/qwQWb3S0BKKddT
        kERugBDct6gwpOAUXMt21iQlzRE/a/HrJkm5
X-Google-Smtp-Source: ABdhPJy/kwv4NUTHIDAUjNd02dj23d6Gtc1ZR7vuk2YvdExt7gxWBv4fnp2rWu8y48q8Ju1yUenelQ==
X-Received: by 2002:a05:6638:349f:: with SMTP id t31mr6141911jal.95.1623956584261;
        Thu, 17 Jun 2021 12:03:04 -0700 (PDT)
Received: from google.com ([2601:285:8380:9270:9b02:154:406f:ca4c])
        by smtp.gmail.com with ESMTPSA id m17sm3335510ioc.42.2021.06.17.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:03:03 -0700 (PDT)
Date:   Thu, 17 Jun 2021 13:03:00 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/2] mount: Support "nosymfollow" in new mount api
Message-ID: <YMucZCMJB/NzhG7N@google.com>
References: <20210601135515.126639-1-brauner@kernel.org>
 <20210601135515.126639-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601135515.126639-2-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 01, 2021 at 03:55:14PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Commit dab741e0e02b ("Add a "nosymfollow" mount option.") added support
> for the "nosymfollow" mount option allowing to block following symlinks
> when resolving paths. The mount option so far was only available in the
> old mount api. Make it available in the new mount api as well. Bonus is
> that it can be applied to a whole subtree not just a single mount.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Mattias Nissler <mnissler@chromium.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Ross Zwisler <zwisler@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Ross Zwisler <zwisler@google.com>
