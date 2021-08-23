Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7163F5283
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 22:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhHWU6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 16:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbhHWU6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:58:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE73EC061757
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 13:57:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x4so17766100pgh.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viPh+0UJyTwjrfYxnKuRCjFXOrg8d7O9dPBV2w1jhQo=;
        b=cCYTzhYCc+5UIWdSxQdJiIdjTBmUrpYexZ+GhELekTQzgUIgY8Dlfd7yL6Ff1yWKSY
         L+naw0dPpc2gr2+htpd2ZMVtVL6fG9Tag9Q1wCFypTa5ZGyxwB0wERVJtqEt63CM5I1I
         B2/BGEenOHr/Rq5xjs8wJco0+TEQyhdAs+Gfmq4gMeNTsBZNEsG2MXlT1mkdZRRAduAC
         q77L00UESyhD7X1PyDfxpaBGhcgkscRLg4DX6W3oRB93x6q+4EXuIszs6+T8iEBSquvY
         3SHmYNQGLqoiA3Afhrvk87/PYGSse1LS7/EARSP3v81J0/t2fvKNUnujNzgNxq8HOJZz
         S1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viPh+0UJyTwjrfYxnKuRCjFXOrg8d7O9dPBV2w1jhQo=;
        b=IXPzsURUuYBwF/tLiqDcXkZgMv1imP82na4wxj58BO6QALKMVNvOVK0v7jTbbgZ0DI
         WFTXswcbodv0RuHwa0pKWVv4Zi5rEPRsfgg20W9oxQ9nAj5mspbKKAIH2EODeSMy8f5F
         Hh8TFiOX7Rq77YydjMQEakpiQPeOaPbnetGYu7iwDcgh5BCA9D15fReaxspJZqbbTZGz
         6/z2ir2uajqbRH9aMXP5BcJ1wx8+KEz7G1vgUc9CYtUBugdK4B6CodKrhp17qYiItMjq
         f4++av+zoCjy/Kdf7E4Wr1TewP2DK7DJjaozno3PyKQdv/Q/Sigd7FMYb+rvn9zR9Ki3
         qcsg==
X-Gm-Message-State: AOAM531jsm7h00PQF2OVb77l99o59c+yPmFPYLoOGpxsm7kggRjwxCdG
        8G5dz037rvqzDpevdhVDvYotGvyNzUhV67KK8xWzEA==
X-Google-Smtp-Source: ABdhPJyTkPxH6f09SsHyv6amBiRJE33JmtsdOuXl3/Csrh5zhh/d00ls47dcJWNTFnZBryYWLMz+fEcPv6/HoulPba8=
X-Received: by 2002:a05:6a00:9a4:b0:3e2:f6d0:c926 with SMTP id
 u36-20020a056a0009a400b003e2f6d0c926mr28665609pfg.31.1629752279308; Mon, 23
 Aug 2021 13:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210823123516.969486-1-hch@lst.de> <20210823123516.969486-6-hch@lst.de>
In-Reply-To: <20210823123516.969486-6-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 13:57:48 -0700
Message-ID: <CAPcyv4gDm4DQY3KNY04cgdhMCp-0j5gmc9G0E3e68BGw2kHN8A@mail.gmail.com>
Subject: Re: [PATCH 5/9] dax: move the dax_read_lock() locking into dax_supported
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

On Mon, Aug 23, 2021 at 5:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Move the dax_read_lock/dax_read_unlock pair from the callers into
> dax_supported to make it a little easier to use.

Looks good:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
