Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94291459AFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 05:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhKWETU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 23:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhKWETU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 23:19:20 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A7CC06173E
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 20:16:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p18so15908532plf.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 20:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
        b=wbQ/MsU1SlEZ9iPye0o5lHnBo9k9LahEnJdnyRzgTrQak+nTOXkgXVWM7OQWluPbzr
         HkVEy2FdigRG5kYOuK1opEJwN/rn7TguLqcAFU7ncMwpwdXChRFN2sqd+bTf3F8BInaK
         fFwg0qsn775RNQiqooEO5yKgWsV+2wtj+cp01Q2NasJFqL66eojelACeKHvYSEfu8Xag
         ROr6vP/wogp7HYAtlyseVafxuCM7Uz2wx46f9H1VqNuffEtgZng2NeCkac5Ick13DKCh
         KqqsG7JaJle4G2RoQ9CsAKmA2/ICYEEBHwUPSN/D+pEwjOibiGCRqmiwftUbhvO4xY/f
         BPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
        b=dTDrpRtp96kk2P1/jLq3a6sCPjDu35TBDBl+duV6ZTp7zLaMzjXQX25fCo3dYZOh1l
         tQMJWc6GAgQVHS6cyTpc1eSGpRsmzbxZhxzOPOzfaoC6dUqhlaJqHiQdDp2n+LDaRE85
         lq9U+FCwAWx5wK8o+hd009uPH44+wtcWiHj+aRBFwJZjxB9WMNOIc9gdhIqL9Ki6E6Th
         eJAvsBficaLc3I/GX0jkmjrirxVsM8L8d5oFMSmCPwQ/m7RCIxgLt2+vk5tAh6CjBLfS
         7W9wDFYAcU7njIgsPQTPm0h6ylskzr/sMGrX8LvK0P6Nx+qpDPT8Lwthc1P30LW0fiBC
         jW3w==
X-Gm-Message-State: AOAM532lmgHgp16SpYhc1FwxQI569qiGY9bFfXw+8zlEVV0pmegZap0X
        PeQxz6Dt1SFkxwYk2RWG6GIw9OwxxVOTOFCeW+ZYcA==
X-Google-Smtp-Source: ABdhPJxjpKB9AmBnKHF1Qu0JurlIqhEs9/usKwuqw/rWaPu+iQDfW+wdKRq+mST3BpRIgHuCjkJcQHKsTKAjjneenA4=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr2831805pjb.220.1637640972493;
 Mon, 22 Nov 2021 20:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-12-hch@lst.de>
In-Reply-To: <20211109083309.584081-12-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 20:16:01 -0800
Message-ID: <CAPcyv4hG7npC3K-5th7qFNHuNt=dT-atUwvMEwbH_DHqzVhi=Q@mail.gmail.com>
Subject: Re: [PATCH 11/29] dm-stripe: add a stripe_dax_pgoff helper
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
