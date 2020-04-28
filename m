Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4B21BB406
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 04:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgD1CfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 22:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbgD1CfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:35:22 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6122C03C1A8;
        Mon, 27 Apr 2020 19:35:21 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e8so18799171ilm.7;
        Mon, 27 Apr 2020 19:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqzJSOJpdYSsCChr8x81qTvX8o/i/uPADfwV9zdGIhg=;
        b=WPXiYjyy/GSVdx9UjBPdU18nw9d7u5oIETB4xefgzpWWUC8eD9epCjJasJKHSMji85
         to5QrauuYvBJaoQ7vZfyX4DtNs2z1O1NFW156HA96mt1/WwUyfpAN81WEJdghuZaHjqY
         VOYhQ0NlZr2MfHcn2M9tnEQPWHKBKi3dvxYfE1NIjo5i6HiJDwbESkX/nvpxEkKVHYdZ
         4obs7f8EDe4Eu+K+zoJjsjAhBTZi12cl46tJiLjOFAcxZpXLIsBwf9MccW+8LN7Sq0Or
         DeAkS1SHK7kT56YRTzK2rsI4HHxfUG5dkMxkM0FV/yIxu/2LMHsGIGXHEDXdOykm5IGY
         mhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqzJSOJpdYSsCChr8x81qTvX8o/i/uPADfwV9zdGIhg=;
        b=aW/z2li81jxR2j5L70FMkhbWyja7/OMIqt6tbvywvXAark9Fb1Qr7r6XBkQ0j9aGNg
         +z7Liv3KzqYPruQv6cdo62pSBAFvqDuA3jWxqR+yQXkZpKsAQgjImnv6qhPvFZplOB/0
         +bJ1G+CoM02kLGIyTx8ubZ7ebfXn00VF8YJAftVETH4xHq+vY2V90lUL8sySerJAy0J7
         6hOxA8Aw6eqJJi1Vl7hwV8+bATW3yYuWUKvo7tx0LLUGR8QLFNScFKyZmBiloN55P5YR
         sl7KjU2QIYtp4Q4kCGHuRoJkXhIh5lkQAPqy/ZBVAVvxZRVS3GZyCHSwD546wx0qCVNO
         JXVQ==
X-Gm-Message-State: AGi0PuYIqfh6bhJiMxZ0sI/Kb3wyp1Y3/i/Hn67ht9IFT0rvQTuRcSkH
        I/2UKY9oiRdwr8gaQkr00qpYO/6H+3qqkpvojis=
X-Google-Smtp-Source: APiQypLEYtAFe7MUWhoRnfEmnQC6Qku7YQncL0Rd1TbTnZCJk8AAKqo26HyBj1sptVPxVMSV3HfbTl+V7O/cRIcxEM4=
X-Received: by 2002:a92:9e11:: with SMTP id q17mr25022469ili.137.1588041321115;
 Mon, 27 Apr 2020 19:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200427181957.1606257-1-hch@lst.de> <20200427181957.1606257-9-hch@lst.de>
In-Reply-To: <20200427181957.1606257-9-hch@lst.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Apr 2020 05:35:10 +0300
Message-ID: <CAOQ4uxhY28otTkkkN7=2QQaONu6GwLcePE=q6J+po9Fv=HXFSw@mail.gmail.com>
Subject: Re: [PATCH 08/11] fs: move fiemap range validation into the file
 systems instances
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ext4 <linux-ext4@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 9:20 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Replace fiemap_check_flags with a fiemap_validate helpers that also takes

Leftover fiemap_validate

> the inode and mapped range, and performs the sanity check and truncation
> previously done in fiemap_check_range.  This way the validation is inside
> the file system itself and thus properly works for the stacked overlayfs
> case as well.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks for fixing this,
Amir.
