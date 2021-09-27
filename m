Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E2541A3BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 01:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbhI0XQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 19:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbhI0XQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:16:35 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F363C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 16:14:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h3so19226399pgb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 16:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yklOyy30D62v19t7f4DS6gYqmLXHdu1oIrAz/DF1m/E=;
        b=XVqqMZgvRWXvCBguR3iF0XZYGmEtnzuU1gy3Bk6lAxYOi62v5AeKqLXlXcuoNvsmEw
         R9Nw+iLqx4vjMiLegeWJ4LjHGKsYELG1zVTBrCPcLegOEax4P4zLoeOgVZSfEbIiNUSd
         YvGF7oyZ+6ke/vXqL1XCccaBFoPK61QSFC9tz3b8WcbJCgHXOsPmQW2JvDVGl3lFVMkl
         LwfcxW/buLUOe/v1UZAjeoETg0fkL3VYkPeVWF5VRjRgB5wDRHWUfk5yArp+rr0svYtu
         BwI7DFXP5PBnIUwuxDGWtQSGzbAOpXR1gqOx1OAXlPCDBUu5GgtaWq53sNmEk2d1nO8O
         i/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yklOyy30D62v19t7f4DS6gYqmLXHdu1oIrAz/DF1m/E=;
        b=0uoTklYpRw1i+z72DZ0IY1pnu6qROUhcx4NWO6fHhVDromXh5kQxKrGAPiX6fq2e1n
         VAbU7yYb8Xa2Kj0et7Qte34WOn2HCWvxOZpwDKvOzhry+LR38ktARs9X9TIhM4+E6S2m
         Q0+ucOFKJC2PxpXkstIs/+uZiZVqaiW623k6DP9/m5Sq2pSy9eSpO0+5dzjozoAeZDwk
         R7fk5DAwEOugbIHSfCQ65Kw7T0a4IsiSQ8+98E4bH+vDzgvTeHslm3i1XEEMsW4tOsH8
         ICskQ5F3erXY/wmxHWSmLiIK2ynmVAP29egiU2E1pODKoB6WS0eIzNxFFuhqyusQmfB+
         xK0Q==
X-Gm-Message-State: AOAM531DJuQtqm2G5UWj3F1kbPRbgquxxpFKFLCA7zlpt/7S/OT4Axch
        9SiqgqR8HCJAXhzddv8+pFT8Fw1yKFkLdF0PSVjhYg==
X-Google-Smtp-Source: ABdhPJyhWl093lPVzlkES7mn7oFLNORaprmrPwbT9BKAFkKYfowUUrVexS8J6403Wp6pLWvkiOpFd35mu7KrR5i7c2Q=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr2189120pfb.3.1632784496737; Mon, 27
 Sep 2021 16:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210927061747.rijhtovxafsot32z@xzhoux.usersys.redhat.com>
 <20210927115116.GB23909@lst.de> <20210927230259.GA2706839@magnolia>
In-Reply-To: <20210927230259.GA2706839@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 27 Sep 2021 16:14:48 -0700
Message-ID: <CAPcyv4j1jSSQNBw991_PPu72Q3he=ctYpaLTSh3AjbJ5nA3UVQ@mail.gmail.com>
Subject: Re: [regression] fs dax xfstests panic
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 4:03 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Mon, Sep 27, 2021 at 01:51:16PM +0200, Christoph Hellwig wrote:
> > On Mon, Sep 27, 2021 at 02:17:47PM +0800, Murphy Zhou wrote:
> > > Hi folks,
> > >
> > > Since this commit:
> > >
> > > commit edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba
> > > Author: Christoph Hellwig <hch@lst.de>
> > > Date:   Mon Aug 9 16:17:43 2021 +0200
> > >
> > >     block: move the bdi from the request_queue to the gendisk
> > >
> > >
> > > Looping xfstests generic/108 or xfs/279 on mountpoints with fsdax
> > > enabled can lead to panic like this:
> >
> > Does this still happen with this series:
> >
> > https://lore.kernel.org/linux-block/20210922172222.2453343-1-hch@lst.de/T/#m8dc646a4dfc40f443227da6bb1c77d9daec524db
> >
> > ?
>
> My test machinse all hit this when writeback throttling is enabled, so
>
> Tested-by: Darrick J. Wong <djwong@kernel.org>

Thanks Darrick, I've added that.
