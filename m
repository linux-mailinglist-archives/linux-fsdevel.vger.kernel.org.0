Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0945B2DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 04:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbhKXDye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 22:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbhKXDyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:54:33 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1459FC061746
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 19:51:25 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so3890955pju.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 19:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJJrE2V7YDKia68Ncdl0fsAelSVdGw1v9JUEXR7xY5Y=;
        b=vNWAOXzyAyZLL55qsyuCit1K8cMla9Q+I7a8HbLHArMfgpXCYh1wtjdFnUFWSDzn1/
         T1Hm88FkQaWO7xTh0mJLeCLeygQ9XisaZ/XdmwUyLak3fa4OobGb1BWM5ZwyXtbfybYZ
         AImH8X7vgDZd94f4gGyAHjFhglD+WoYohpNRn3ZnIE+uI745TpScjyc77ErLiPREiHK9
         9zQlfvf5/9sPOSgOLuvsV+WpFV/QM4YFfAdVMzyOtae7ikCAA2NGiOEOPGZF9XEqRun2
         JjRU5WwiL+LDDdZvrMhOHyatQOMmuQaQU9bgUORS8BfRoMg++/EVDk/zAuYjdunbyyUb
         o34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJJrE2V7YDKia68Ncdl0fsAelSVdGw1v9JUEXR7xY5Y=;
        b=BMGp/CgaT0jls9th8DkwN3DuV6CcSMEedAYu87WlpTBCmeD7JkHs1d070z7T33bljx
         FXuoFNK1TgF1xhUWuk/JrYm9j1nTUkoiHcr56S4/PKmeajbXqjk5TH49ScQ7JUvpittq
         DmuMfhblyEbUyszcHH9H6YM1rwC08y4IPIz5jYCHL1Hl73EuHnfcVJeQbWN8IPDI7AzJ
         glthmSMdCiSDQOb6S55pjizz8F5YQVhkFMtXeAkTvwyHR6PZarq7VvDw8dthUzXv1W4Z
         5sHqkBNcDGsXdh1p4pUKBwLLCx+ksLqRPYQQyFb0V4DW6K4ccEJjTMyV6LRVTteMiXeZ
         DTiw==
X-Gm-Message-State: AOAM532JmsKIP80Nzkt6Ltbo8JYOqV+AxCb2hJ0IOx2GxDLwmbjEw8l+
        80qMYS/QVR2zcGxRXWwW+T4XiW6yMTLjtcK0LZ/Qag==
X-Google-Smtp-Source: ABdhPJzAHmbz7abbV3IfUPlG+M3Adum2An1EImXm+0nyzeG+6b50syE8SI9jQ3gftFqA5yglDnQ0v4N9/X3Fjpc01Ms=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr4029053pjb.93.1637725884625;
 Tue, 23 Nov 2021 19:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-29-hch@lst.de>
In-Reply-To: <20211109083309.584081-29-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 19:51:14 -0800
Message-ID: <CAPcyv4iV+PTdvV+Tq5j3nR6UWFQPTeuzQrZGdS24HdVehY_OaA@mail.gmail.com>
Subject: Re: [PATCH 28/29] iomap: build the block based code conditionally
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

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Only build the block based iomap code if CONFIG_BLOCK is set.  Currently
> that is always the case, but it will change soon.

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
