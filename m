Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A523143D8AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 03:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhJ1Biv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 21:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhJ1Biu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:38:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EC0C0613B9
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 18:36:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id t184so4494803pfd.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 18:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7Igm7cptJn/BPiAKOvXNcYjYvau2fVkwbEBPR40Qac=;
        b=nDN9pMycEij+MvvSNlzKvOXo8vpzX9jkSPwoFJ+o4gm3MZL73HDZVz6xJnzjMcbY/h
         uxqb8I8SZcSxzyFyBYzX7/LIRnqjurLkxyKCXt7vyn4OmQMNyDT08nPuKyqwzm30Iyl3
         YY7ptNRp5CFdB0o2rG3ZcydKtS+P5TBWxjp9noe/kCn6hPByhWq1BSGoPPpBqB7Delwx
         7OpBf+W0FVyg/SVq09iZbg3g6KwhgjDGpF6ftYJKhyxVAQrctr7Lax8JbvRVtA2fECbQ
         ljET309ufBhSYyMPecwX45v0eqgX6tTFFZvO7U3Ppi7VtOy0tKDgD/ePUmL2riKDB8uo
         7IaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7Igm7cptJn/BPiAKOvXNcYjYvau2fVkwbEBPR40Qac=;
        b=g14y1B0TFD2kkhUF2EpCFGh5cnK7Hx8QIw/aApvzLIUttOpuSaQCViGuo8sNlqKmYc
         uPVmaFV3svlY/OZJtrJth92iw3pXL1XP/1CuMI5lYNyhkUCQFnJLnhGL1BxXuNpWM+4d
         nNH+i6Vcs+YPThnnL0XUOf9YEg+6TEBC9ecxoFkjyvsKdPrfkMuXVdAl4JJBoNMtepm1
         ftiM62xsNRaCCzvB9/4bOLx2ttbXmUknA+r4K3ruxT1HORhz4vqVm0cN1KY0wPweXbC8
         KQsY/iwUD+qKab808eqzVR6LtHBh/UMK6WKG+xBWDqiGmmIWX9BHSKk3sFLjFFhXcYhy
         mlMQ==
X-Gm-Message-State: AOAM530mFJarnQPjX20KNPOE4b3dPywJ6gK8Y19+nJf5EeOAND3pQ3h0
        WJHFBtPEwm4swP4sM0ifXnblropguxyWIwXLBP4+Pg==
X-Google-Smtp-Source: ABdhPJyDv7rjKjhKzGrFppXBu1eyKYCO/S0EEDW+vfLySK20rv/agORLXNPU8PUP/nGzDZcfnIyFx3qV7wWhC+ogeBA=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr1317245pfu.61.1635384983516; Wed, 27
 Oct 2021 18:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <20211018044054.1779424-10-hch@lst.de>
In-Reply-To: <20211018044054.1779424-10-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Oct 2021 18:36:11 -0700
Message-ID: <CAPcyv4iaUPEo73+KsBdYhM72WqKqJpshL-YU_iWoujk5jNUhmA@mail.gmail.com>
Subject: Re: [PATCH 09/11] dm-log-writes: add a log_writes_dax_pgoff helper
To:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
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

On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Add a helper to perform the entire remapping for DAX accesses.  This
> helper open codes bdev_dax_pgoff given that the alignment checks have
> already been done by the submitting file system and don't need to be
> repeated.

Looks good.

Mike, ack?
