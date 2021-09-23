Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15672415512
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 03:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbhIWBTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 21:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWBTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:19:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D69C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 18:17:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 145so4203097pfz.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PqnMCSlTFVHv+VO0Sbw2IcFVHDdiU24jf3V+0bq7IUM=;
        b=JYiY9knZ+D4IA/xw9LdBe9qhW6scgwdFcL0yYl3y0dx0pnlK5ZK6oaAx/AtEHW0y18
         AB6o0y36plz1cECvcnim0IWsEPJBET4kkBv5j5uzMni2jRKvMMHsEE0BLa48NYQ1WhUM
         ftsCORWkttFQnb5NEeFWVxDNIhlLlkB1H2TaKP77y56xCsJrAIHKzMlVgAHbh0R//Aew
         6vTKFz/hDSgTs5h7QqOHKTtvsPSaLS+S/wFSEb7xJvQ531tJt+CmcOrCmfMEhtJzXuPt
         npRDFiyO9vqRvzpYpIpQD8GdlvxdKSEEL/hcZuWuU8s2DolGggSVaQERe7R+HfermIwZ
         GToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqnMCSlTFVHv+VO0Sbw2IcFVHDdiU24jf3V+0bq7IUM=;
        b=WNfrToD2/7o/FBmnlhPLm+oCielnf8GloZEYkpvpIjiJ2YQyniB6vJQSi1LahPEKff
         HcMN1HYYtm4L+yRiyHjU2e5SPaOEqfiB28zYTmxW9vy81ISDTA7un+9eC2sykHZqldqv
         pdgMYC/n5GoIKod9sJDgetS7cj78/tnraVyef9VDz9Sc5tMephnJ6gGapimPimuNZW5A
         1oKZLJyYgoiAlzN9bj5WpKWCHQCVaNxw9mVssut8fO1SYb/WVelamXl/LWv9XAP4TGtk
         xZK++65yclg7YdHShv92AeTY9ogrJJ0FkuBeRzlXXZm2BT/dM5T0L9UD85ij0KghoyEj
         MlMw==
X-Gm-Message-State: AOAM533k1+xWxW9EXWG4T1k6Xycjq6eJdpcE4rVcqcT244Zxkskv6JJQ
        uFUcOTo6NvfFaB19B07k3kws6li16jUSLYtPzBqYoQ==
X-Google-Smtp-Source: ABdhPJwOUgDQpJIJ79YVQdLCz8UX1H4WYKxDvhfzHqtCtQUmDD+os3LI8Xj5ubcod/mYbE2ucuwks0Sk+bxHI9Wj/8k=
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr1754024pge.5.1632359865333;
 Wed, 22 Sep 2021 18:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <163192864476.417973.143014658064006895.stgit@magnolia> <20210923005144.GA570577@magnolia>
In-Reply-To: <20210923005144.GA570577@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 22 Sep 2021 18:17:35 -0700
Message-ID: <CAPcyv4iiKbOBt_6gZrOQkgUD2SAXuYtSJkAFeaxEbuah=99XFA@mail.gmail.com>
Subject: Re: [PATCHSET RFC v2 jane 0/5] vfs: enable userspace to reset damaged
 file storage
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jane Chu <jane.chu@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 5:52 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> I withdraw the patchset due to spiralling complexity and the need to get
> back to the other hojillion things.
>
> Dave now suggests creating a RWF_CLEAR_POISON/IOCB_CLEAR_POISON flag to
> clear poison ahead of userspace using a regular write to reset the
> storage.  Honestly I only though of zero writes because I though that
> would lead to the least amount of back and forth, which was clearly
> wrong.
>

Sorry Darrick, you really tried to do right by the feedback.

> Jane, could you take over and try that?

Let's just solve the immediate problem for DAX in the easiest way
possible which is just Jane's original patches, but using the existing
dax_zero_page_range() operation in the DAX pwrite() failure path. The
only change would be to make sure that the pwrite() is page aligned,
and punt on the ability to clear poison on sub-page granularity for
now.
