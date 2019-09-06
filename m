Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C30FABA9B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 16:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394281AbfIFORv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 10:17:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394275AbfIFORv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:17:51 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3934F85A03
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2019 14:17:51 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id z4so6477779qts.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 07:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tzDszuqoBQ88xDVaM9hs1cwB75PSJweaPTjm/VD0ZjM=;
        b=IUxI45s9PxObQsXQe5r/n33VoQ/hFAqUsL/m8HF8qfg2M8GWIMyaZDMSQzbF05gCoz
         SnnxoWuUX73jZ0SEZhToN8L6vb/9CTZWs4Orou+u/xUsJPOm4haaNhddhpWE78/gxq2v
         mjbCClwUxKlc6PoXpTSoLv1v5NKC25haNjBMUUIghvGwrz3SMwajQi5WPDzSKZC02h6T
         ne6uVh8GzO/xQczi3ye98iqIXr4pmDFw5rXUPWc3NWpmbh4jvBizDO8CA5vh12cF76DE
         V4YuZixqjWq0s3A7wFjUZ4Vq7YJ++wybI5JqBYB6fn9ZRNt3mh8dSBJDrxS3HM3fmeYy
         t9rg==
X-Gm-Message-State: APjAAAXCtIAMrjZ+QJC0N/49QL/+XObXSG27pmLrhG86stwszyIi32br
        aEzpdhoGJkGn7E79v/4lQsgH9c66X2xoVbqTNI1E7E3HXWnHSQjJDYK0fbHbRyCZ4332vkLaQIq
        kbrGgRRLSpn4F/pcUhj9ztcDG4g==
X-Received: by 2002:ac8:4510:: with SMTP id q16mr8952804qtn.247.1567779470610;
        Fri, 06 Sep 2019 07:17:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQiC3PC9TmfSYzvcGUcmmMs1BRVachZAgmwDWOQxgs/xawnMqIPU9mszTB1/u4msJYq21W3A==
X-Received: by 2002:ac8:4510:: with SMTP id q16mr8952787qtn.247.1567779470471;
        Fri, 06 Sep 2019 07:17:50 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id z5sm3254157qtb.49.2019.09.06.07.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 07:17:49 -0700 (PDT)
Date:   Fri, 6 Sep 2019 10:17:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
Message-ID: <20190906101339-mutt-send-email-mst@kernel.org>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain>
 <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
 <20190906120817.GA22083@redhat.com>
 <20190906095428-mutt-send-email-mst@kernel.org>
 <CAJfpeguVvwRCi7+23W2qA+KHeoaYaR7uKsX+JykC3HK00uGSNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguVvwRCi7+23W2qA+KHeoaYaR7uKsX+JykC3HK00uGSNQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 04:11:45PM +0200, Miklos Szeredi wrote:
> This is not a drop in replacement for blk and scsi transports.  More
> for virtio-9p.  Does that have anything similar?

9p seems to supports unplug, yes. It's not great in that it
blocks until we close the channel, but it's there and
it does not crash or leak memory.
