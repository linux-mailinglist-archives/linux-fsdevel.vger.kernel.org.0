Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF3F3F3713
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Aug 2021 00:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhHTW5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 18:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhHTW5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:57:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C6C061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 15:57:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so8291902pjl.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 15:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1Z8mu8s2sgn0mbpfu7ra3LWl3tk+2BaXWQ56zeT5Qo=;
        b=Nt2BeHwjtlSFrM6oUpAp0AEOX1AjgKzHiyuRB0Rdt/NkFHq54pda5iNS/61TJ/a9/M
         WtZ0MUvUAuWfZAkHqP5am1wnus8fD2MJNtfRLgOK5BYxEamRAJy68cbjkG3kKLjc3e6m
         1Ms6ALCk+o8RdYAJUX1suKOU3XJBE72luJok+nKUgFIRJIUiL3D3N2uTn1bOzfRiMLOg
         KTpdgQvnGWwmB9bFrP9a2SK0ZENdHfLcqPa9QmnSQFNoo7bwvdnxzejlRyQ87R+YTrTU
         B+QeZ8y+BYNCRMX0yjp8cW2G7BvJIJhPtgqnqBhSC+lI+hPbKn/JWXQ3x6bi1O+SAZol
         L3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1Z8mu8s2sgn0mbpfu7ra3LWl3tk+2BaXWQ56zeT5Qo=;
        b=q+3pY28ngC0OxoJ2qG83YwHHonJxCIZVO/0vpP8kySYddEDExYWbIYPhLQsL6v+Dkd
         57Gcx4MnEbgqt7YXvdvGpYZYTSHYwcb4uBesEDHdpBzJ8DBoTIVOBzFfzxSPexlwtN6E
         0Ovu1i+RQSpoAtH1th6KbYEWw9tsYq7+8Q07CVkgrKsEAYXn0JReni2eAahB/TgCUCDA
         tqBhTEqSCe+g0Gf8ydTyJlaoziW68FS3lPbEqQHNcCVMW5j1bwqoiS6T9Zoihbwt13OY
         iUraJSDHHBz7vM/VN7EclRePmmacXlICXkd+3RW1Hi5IlR+fbR2lZteZCO6PnuIw7jHE
         iLxA==
X-Gm-Message-State: AOAM532JnGMctFDKg/K+fJPcHcIgX6DFXg8q8AXR8YpO691nvivP4GAy
        UrTDlaaTPzAdasjSmNCuLicPSMgh/J+bY2fbXCu7LA==
X-Google-Smtp-Source: ABdhPJxmXpLQCDOV4p/qDFeGVDmICU8dPEjZ+Gjrsjl1tuFZXHOKRbvy6d0ZC+yE1xwMVSAlTTyashdIzkFcEanj6Qo=
X-Received: by 2002:a17:90b:18f:: with SMTP id t15mr6777302pjs.168.1629500225798;
 Fri, 20 Aug 2021 15:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-7-ruansy.fnst@fujitsu.com> <ec5dd047-a420-8e17-d803-729e052b2377@oracle.com>
In-Reply-To: <ec5dd047-a420-8e17-d803-729e052b2377@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 Aug 2021 15:56:54 -0700
Message-ID: <CAPcyv4hitKKPByHkX-syRmc1rmF8B4sGRsGdUDsBAE5-yoBvXw@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 6/9] xfs: Implement ->notify_failure() for XFS
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 5, 2021 at 5:50 PM Jane Chu <jane.chu@oracle.com> wrote:
>
>
> On 7/30/2021 3:01 AM, Shiyang Ruan wrote:
> > +     mapping = VFS_I(ip)->i_mapping;
> > +     if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
> > +             for (i = 0; i < rec->rm_blockcount; i++) {
> > +                     error = mf_dax_kill_procs(mapping, rec->rm_offset + i,
> > +                                               *flags);
> > +                     if (error)
> > +                             break;
> > +             }
> > +     }
>
> If a poison is injected to a PMD dax page, after consuming the poison,
> how many SIGBUS signals are expected to be sent to the process?

I think it should only get one. I.e. just like the the generic code
does one shootdown per mapped page regardless of whether that page is
4K, 2M, or 1G. Once the application is notified it should be able to
query the filesystem to determine the full extent of the damage to
files.
