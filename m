Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25314E94EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 03:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfJ3CAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 22:00:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40154 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfJ3CAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 22:00:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id 15so353128pgt.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 19:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+MFuJEA0Abfc0BYSugK5QCECCFztGc+UpgkCBaCDRK8=;
        b=fgO3Pqs6mepR/Q1ADIIzRRDRabX5HGiRznS3H3iWGB0591WjjkdosfKg1Uj/2nc/n/
         +2K0FwRGe+Y8FbwUOPMMCOdaa4/aSkAIWgOXFIatnh3BSY02Z452ZIdh+6H96lypDBXk
         1AOZb2bUD3y+aGVn6HaHr0Eqi9QZBH+kPwFs8EcyCnkhKN+7qHJGk6qAHdO1lsMux7rl
         vGgbxB4ZiIg7uUnWIcMOrtlZreoZAG1oYnHPIeDkMIQ62YG4hNFxd+GG+EtXOI7aqlWy
         /QJwPiIyq91RAfyeDOwZOZ5JowNN1ouMBrf6Yo2XTmOp6SSa+2lAH5QXjy4f1TnRa6PX
         xC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+MFuJEA0Abfc0BYSugK5QCECCFztGc+UpgkCBaCDRK8=;
        b=RJE/SzjY3b0rvDNxW6IXgY8NzmQq8tdxAa3rkLNmvWiUr4Er/e6tPx8dni8lFGKmGI
         gaJArnjlC68luec8sqspdGLy07npzHQNnlrgAJibC+QvyJ2AtplDn1NgdHJ+M+lBbhAf
         fCS6kF5mNCjJ+8p+XjVeAaAyP32m9K0cwQLyPomzus/LnY3+O9tfx1awWgT24CspVchy
         AbPZhbzuKxhuhm/qmWu/KvNHF3js4UkHZZ31yYP2YBe5gUjSk9bocOgNCOkO4NNbGAii
         tQwH2z+8Js2+rIip74yjPim7frsuTpcuNe2YSi3kdpdmcrfc4KsT8wxArKz1Hzet1H5u
         waxA==
X-Gm-Message-State: APjAAAWh6+btkTyOEGpRklrjDue13qCpc1/xJympSXTVeK7u3E57m3tC
        bEQY7VDM0Imlep646AVHpvqX
X-Google-Smtp-Source: APXvYqwMRGHkQJcKkmkYFJABIsetu63g01mriWzxjnaIIIr/JovfYplLc4QkVnsWMR/Li2IGa5q8Kg==
X-Received: by 2002:a17:90a:d993:: with SMTP id d19mr10404290pjv.26.1572400831998;
        Tue, 29 Oct 2019 19:00:31 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id f25sm429242pfk.10.2019.10.29.19.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 19:00:31 -0700 (PDT)
Date:   Wed, 30 Oct 2019 13:00:24 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v6 00/11] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191030020022.GA7392@bobrowski>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <20191029233159.GA8537@mit.edu>
 <20191029233401.GB8537@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029233401.GB8537@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 29, 2019 at 07:34:01PM -0400, Theodore Y. Ts'o wrote:
> On Tue, Oct 29, 2019 at 07:31:59PM -0400, Theodore Y. Ts'o wrote:
> > Hi Matthew, it looks like there are a number of problems with this
> > patch series when using the ext3 backwards compatibility mode (e.g.,
> > no extents enabled).
> > 
> > So the following configurations are failing:
> > 
> > kvm-xfstests -c ext3   generic/091 generic/240 generic/263

This is one mode that I didn't get around to testing. Let me take a
look at the above and get back to you.

--<M>--

