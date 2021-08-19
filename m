Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0893F21AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 22:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhHSUgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 16:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhHSUgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:36:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE6AC061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 13:35:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so5650046pjb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 13:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lq1/9dzMwse8hgj+nLsRtNNVHy5Ra8cI/pFGIqflik=;
        b=2RKmo3Q2iKNSxDasfmEsswnoQ8z3YAyLtAaZ/HjlU037dI8WGM89auY+HT0DGdfQG5
         U/MVHxJdBMIcF+Bd+xSvtL95UEX2dwFl/L/z3oPUnO/aigHxiu57hkL3swk7sYKK8eoK
         OPWWqbTNA4eO3pFQE3oPGvv1E3fjsnrOGOVy65plV9Zqf0TYsbeSGghf1ADPutP9iZR1
         5qcOPhlcQ0vwLOx7+tVxh274/kANbc4PzXIIj1zUrQt/iw6E5iILNWMZccVLZCykIsql
         szt7T9dgmeVXyvOI4dVbuIMMnv9/0iFbmrxmbHF8Fdu9z40bAQVIYwD2gzFvHS2c+7l1
         Qchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lq1/9dzMwse8hgj+nLsRtNNVHy5Ra8cI/pFGIqflik=;
        b=ax5syHGQgFln1jApNqXJFTdGFuQvc2RtjuogkD8n2pTNUXshO6GxU5l0fbX8QUDAAi
         68D4NWMfxeIkccCEUmIPZzhhNAs5iCjcIcCX5wJp5AjpEQ7DdU1P8ZtUI2LruxliwuEw
         ret6oCk15kO/iSSTq+Ow2am8lR4/v4+N/afjjY6jC11Ezc9MvvMF+B9Xtqvpuwnp/EmM
         Yydn7YEqS+W1JyFDRemU8ekHaPcUrIx2CKdmnEOmfmcvMPVYoLBzUobg2yTjjzzsUYor
         atQ/USfG8EBFtPLSeQqstABOeomiRawThEaO5rKzf07DAEJKLp5TWpssIpbHqj5/G0HE
         Gx1w==
X-Gm-Message-State: AOAM533fYj1HlplGrhOW2VVK2myOuN+N9Z47IrD1gfOtv+DVEHX7pAf+
        LeNPYdl2wAB0f+tJHq5s3b2cFOhYFAGTQAGk2tqneg==
X-Google-Smtp-Source: ABdhPJxSp6xtccEDJJJY44GOHyKJniTxZ6vHD+7V+PQJrY3uECT6oRKOpiFktsbnpDGqKIO/PuciS0G+rhFl437R2uk=
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr628765pjk.13.1629405339323;
 Thu, 19 Aug 2021 13:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210809061244.1196573-1-hch@lst.de> <20210809061244.1196573-8-hch@lst.de>
In-Reply-To: <20210809061244.1196573-8-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 19 Aug 2021 13:35:28 -0700
Message-ID: <CAPcyv4iRUYcZAMgiDLXDW-bRZxeRzAnWOgNJ4UL==CQX83_jxQ@mail.gmail.com>
Subject: Re: [PATCH 07/30] fsdax: mark the iomap argument to dax_iomap_sector
 as const
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 8, 2021 at 11:19 PM Christoph Hellwig <hch@lst.de> wrote:

I'd prefer a non-empty changelog that said something like:

"In preparation for iomap_iter() update iomap helpers to treat the
iomap argument as read-only."

Just to leave a breadcrumb for the motivation for this change, but no
major worry if you don't respin for that.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Otherwise, LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
