Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BA33F50F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 21:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhHWTDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 15:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhHWTC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:02:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486D2C061757
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 12:02:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b9so6354573plx.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vq24WZbvZaeS/j6ldFMsVI1j+zKK5/FPuVsdEfF/56k=;
        b=TOwz77agxsX/Z6vHOfh3RsJJK/W+1zHnCyvXzIPPHH0ETLgijhzZ2KHfvVbfuBZXUU
         W7RxLzFOomU+omO1e7IJYkHSpOfBocIITKkP0hoCz7hrwaeTv/tHtIBs6v3Qm1cEeE3s
         BYWjlByN+DL2fqSBW2lTF4DMrC4azMiQx3p9eHngsI1+Y3jv87+8I3LNkxBTXJjANr30
         7CEN4njK3Ii27U1oagG8VmxC/Istn9iIJA2ak6hRDgtGP9+kbeGZMFxY8r8X94jb6OyD
         b+D1ylmnZf9dGOEPKHqAEyi5YLYmwJwKoN8RwMIlZbI80xPi4ZwIXBDd+RneAdyVTz/1
         hQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vq24WZbvZaeS/j6ldFMsVI1j+zKK5/FPuVsdEfF/56k=;
        b=EW6bHdmem0OZGbN61TSqVdueDTXcWj3S+JWdmVcSAK+WVqxZNvivU4g2hfTuv1jZe9
         MnJiUrmG2aPJ5qgrG6Ysf9/GPvBY+yfWd+Clw6QZWw3W08tGb3YqbNmsJfeEfVypPCa7
         1YgNHx7de1k/93xuofFg0bkdUaL6tT48n+VpcS3eKleXWJ1O7wc2ZWIf0CSMNHdj408g
         UdfW7+jAx/3Mmmpgvo5s6ExndmZEZHtv9vMNpaVcOfJnN2nRwMJc+mPwmPystp7zsrfK
         AKw16duGqkRr2+3ycTE9FuN9tEaY3XlSoXJhv/d7LD6c+cDXLt0X6drFZYLnvzBYM7at
         ATbA==
X-Gm-Message-State: AOAM5331YnylzXkH1rEmqQJby60pyqWai+eR7RJWeIfQSgWOyBa8pNoj
        LayiQVnzWTpJabU7CHmMXGFRDNJXkgbFvT1qhAN+lg==
X-Google-Smtp-Source: ABdhPJw4ffFVirjni1kbtamzxeZlOeZAU2Wfrl9BJ1rGaHZkFmiEzD+T7HoyhzHN8ZFTf8oDeKzbEe1A35lBSTzbMnU=
X-Received: by 2002:a17:902:9b95:b0:130:6a7b:4570 with SMTP id
 y21-20020a1709029b9500b001306a7b4570mr18038564plp.27.1629745334855; Mon, 23
 Aug 2021 12:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210823123516.969486-1-hch@lst.de> <20210823123516.969486-4-hch@lst.de>
In-Reply-To: <20210823123516.969486-4-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 12:02:04 -0700
Message-ID: <CAPcyv4ifoEi3E65yb3OOwwiY2aMyrSap=e7PohN-5w_K4RgKrg@mail.gmail.com>
Subject: Re: [PATCH 3/9] dm: use fs_dax_get_by_bdev instead of dax_get_by_host
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 5:39 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no point in trying to finding the dax device if the DAX flag is
> not set on the queue as none of the users of the device mapper exported
> block devices could make use of the DAX capability.

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
