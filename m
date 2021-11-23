Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B5459AE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 05:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhKWEGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 23:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhKWEGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 23:06:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17020C061746
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 20:02:54 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z6so14729559plk.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 20:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
        b=sflh6j00R53ITli5bO2IoAwQaIa8VR/tllaujepF7nQ0McJ6iT2CSZUK7BuB1zU6If
         9CwhHY4WZipWFFT6wSgL9NXJHKzpWx4dzREV1QewVHPXAfe3nZ2ge9ayabqAClcoOtMT
         6CWsvm27gk7VLVryyb3GQ4RxleOrmnBmuKNS+T6GLom6VfHHQqPk8G9iMZiGpJfXA6jD
         WtPXA13msMgztdGrXOYIM1Tv6bLvkl2kjxHbaH2u8afmQwOPoz4TylpBWUlzjs7RiwZQ
         Q7dRhRXUS7ma5L6pdFg1NOadjevEswoXcEKlTQmOlLvpZ8ukBNqCZ65Zu45i5yf8msAV
         Rrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
        b=edeMRnuQY5G29Nt7G8Nlus8aZ7NMSozVVbvKDcTFhVkXRY82CFEaJEWTuZdUZXqj3x
         LDQndBFKUXJAu2aX9EvVaIKosAtdnN3OtgtG31+GUp91PeC2JRRWarRiRLTTqVPBMjuv
         KlJIq7HTPL0/RRU3tGF2/P2ryD47dhbK2h/R272Bn3oYZkN2Q87WtYTTBhfY+WYYURAh
         zafu8uQkrkWtuPMHKJoYUKVV5XdkSjjSS5lqa5W0wC9ZzkcQR/HkhkZ/RdfFdgzxQYMk
         HioG8nt9rSbV0pHkYU51ZMeOPVJkdmWm+R1+IBs3cV3ODjUtsrY1lIYEzvCQEX5L7z1B
         +2wg==
X-Gm-Message-State: AOAM533j27+WJ9V301ubHT22RkZbfv5i9PRDjy9GJE+Lnx+q9+UmlRo5
        Kkmxk9evNt5nWG+VLcnKCsNGHDHI54m80sYYMqdx9A==
X-Google-Smtp-Source: ABdhPJxvSLmX3xye88c668D00uWDdnnCeZiY99i/tpK8E6hWm4PH0+Kg/6cCj46QhqqZS8+/hIjz2nKulq2NhEFbIuM=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr2663610pjb.93.1637640173575;
 Mon, 22 Nov 2021 20:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-11-hch@lst.de>
In-Reply-To: <20211109083309.584081-11-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 20:02:42 -0800
Message-ID: <CAPcyv4hUSRSVBP_G6z7fPUwvb=3F2q4mrGhmD9A4nez=DrEdWQ@mail.gmail.com>
Subject: Re: [PATCH 10/29] dm-log-writes: add a log_writes_dax_pgoff helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add a helper to perform the entire remapping for DAX accesses.  This
> helper open codes bdev_dax_pgoff given that the alignment checks have
> already been done by the submitting file system and don't need to be
> repeated.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mike Snitzer <snitzer@redhat.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
