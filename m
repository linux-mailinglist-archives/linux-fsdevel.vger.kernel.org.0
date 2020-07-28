Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAEE230670
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 11:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgG1JU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 05:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgG1JU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:20:57 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD6AC061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 02:20:57 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t4so15568606iln.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4G0UIdXvdfEe7BLoStoOOEm3B3msSm8+A+vrC8xZEA=;
        b=Icdw2gd+HEU0qGMWI5eGivTWRwHQongPrjGFOf0TA0gtG1EnYqqHmJ87QGmCG3oswT
         im6OIsQ03P5rVAcRYn2fEBKaaoDy74KUUt6PDqI1GcVUqTJQm95LnusQqNIFstX+c/Cm
         aQ9uu5QbHL2ogKRBJ5C1X/7sglkvqQ4o3vQ9v+2e4aPadr+0RO3h0Cb3pkFR2cViXhCO
         3E3FqvPjJjgaY35brMRxPjjle3OqrvlXQZQfHENuqgmlUIgwUxHmyd/7/4qNX4C6+O2e
         9PHIu56P7K2MHtPWFsBkeBD7e10IkCrw7KaIWLVESD0DeU74iwjjAhHuR2OcOSZL3dI4
         J30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4G0UIdXvdfEe7BLoStoOOEm3B3msSm8+A+vrC8xZEA=;
        b=llu6zFopue3TPenTeTrmxVQvKqBGeV5RQ3pncJM0MnMVT3Q67ZCIrFhLSabxOo83CN
         x5PePBxxbDEHm3aFNMMw19Gd7vu8g9R6+0tWPcHpMTJhRg/Z+6uI0vC9C7U+8kdjx3AT
         anrOtrQpz+KXIDaMS/0sL6Jc2ky8K0c+fu1SbVeVl3GUBQTp+dqhTj50reN8nOTnZ0/V
         YLIhE9VmoG7eBekAl8GcCEHTUvZ5df8CjcNswMK99aiwN3qozgt9rp0AyXSvJaDDAqju
         fwoAxXOey7bRIR3jOpA/oGzF4J9eNw/I9R4mK8G2p1F3yiuX2hT9kDZThm+oDxrDXHmd
         uH4Q==
X-Gm-Message-State: AOAM5306S5oZ6cALJG7Pn4t7UW3pXqPY6V2ICDtEhYvehGzCMTimKCMm
        xTe5PePxAgqcKH6uQ/T/LRNwohzCO03tNuMQyK5+SA==
X-Google-Smtp-Source: ABdhPJyMzW/EOIpet3yXwvET3u/Tz3ccTXh5/PLQN76jb/Q1ly/4m7FzoHdcMWAvPhmiHrl/TSTiDq9/khGKIJE9P0I=
X-Received: by 2002:a92:b6d4:: with SMTP id m81mr21614296ill.72.1595928056749;
 Tue, 28 Jul 2020 02:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200728065108.26332-1-amir73il@gmail.com> <20200728074229.GA2318@quack2.suse.cz>
 <CAOQ4uxg+R0wGq6O_qCw2EmzgJbNjbTP_6V0sVoxvXf1O=SOdFA@mail.gmail.com> <20200728090436.GC2318@quack2.suse.cz>
In-Reply-To: <20200728090436.GC2318@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Jul 2020 12:20:45 +0300
Message-ID: <CAOQ4uxg6d7u5o-fGBzs79qLiSz5OFV4cm-QSXT_00LXi0a_Qcg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: compare fsid when merging name event
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:04 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 28-07-20 11:06:25, Amir Goldstein wrote:
> > On Tue, Jul 28, 2020 at 10:42 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 28-07-20 09:51:08, Amir Goldstein wrote:
> > > > This was missed when splitting name event from fid event
> > > >
> > > > Fixes: cacfb956d46e ("fanotify: record name info for FAN_DIR_MODIFY event")
> > > > Cc: <stable@vger.kernel.org> # v5.7+
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > OK, but given we never enabled FAN_DIR_MODIFY in 5.7, this is just a dead
> > > code there, isn't it? So it should be enough to fix this for the series
> > > that's currently queued?
> >
> > Doh! you are right.
> > So you can just work it into the series and remove the explicit stable tag.
> > If we leave the Fixes tag, stable bots will probably pick this up, but OTOH,
> > there is no harm in applying the patch to stable kernel, so whatever.
>
> Attached is what I have pushed to my tree.
>

Excellent.

Thanks,
Amir.
