Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E642304E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 10:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgG1IGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 04:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgG1IGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:06:37 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C2BC061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 01:06:37 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c16so3618176ils.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6sYjMhqbr+hH0G9EWUmha9Ibqfe2c+lsBwFf14sYwk=;
        b=aTCIk6qIF7OkIb6oOjIyVQCeFm5UbdT3mqgzKN28RN+b0PkhTmiXm6fWhWy30hVAeA
         tw54xQq0L7xD2I5pQDGQhaoeY7UptxSocyfR2bQY8FM8GEEqeQUGD2p53yN8uaHeC1X3
         aGf79G5+4bMQgO7xWzczbHH4FqNqfbQiGdCHUwN/DFVNfQ7Mb/beUuo7bdP3OPkJM4Nd
         dDbptYVd9bxniVwnCrYv+lf19lmVyFe/0Rbs6TVfAATHIIUW53PnR1NF3qf602V7KD/w
         SJ9G9leKgfRorvANlrfOVep+i2QO/ITWbW+OVg/G3fTgwOGPhY36reiWDmsFoI2NnWAl
         96xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6sYjMhqbr+hH0G9EWUmha9Ibqfe2c+lsBwFf14sYwk=;
        b=HcSOnMEg7cXLzbMwlgRP+06RX5jDyHVWRgP/iJZc8nGGrVKIBXc78xUevzcM/FDEQc
         tecAOGENmebaxfFXr8NtJRmtilKJPNpGePyjDDxZF86/DgSmuP2gW/hGr68u81kQgWdn
         RjyAaeFMhes5KEMb/pRGH4l7YCRxxN53h5xT3k0+w89CACqAimAx9Boe8Og5PP1WN0IY
         eGXqf+59xPiiO+b2RKG/vZd8MXJLx/OIhS1CoC3Rg6ovIfNw+QRQLtNLoj8saejeay9r
         GzDtwpTtrLB8F6y4SBXLyER1LFdHUkS6s3w5Vsk3tSOnV2DGBE7BE5djJVnokxcYdrTq
         IwbA==
X-Gm-Message-State: AOAM5313QPkXcnxOoeAxJ+UwkU0y2SVWpVG3cV+9EcoalbevyZ0AiJHu
        BZDrZnCXY42XX80TBSyLlvQGjl4569MoK2igGwI=
X-Google-Smtp-Source: ABdhPJzcXB+JPGMvZxR06nbEHUMidb6N9koM5H8D4+eiazu14LedrRdRTsPdAq8gm2sGfDFwu4WTehxjT8tyxIZ7Gwk=
X-Received: by 2002:a92:da0e:: with SMTP id z14mr1093263ilm.275.1595923596135;
 Tue, 28 Jul 2020 01:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200728065108.26332-1-amir73il@gmail.com> <20200728074229.GA2318@quack2.suse.cz>
In-Reply-To: <20200728074229.GA2318@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Jul 2020 11:06:25 +0300
Message-ID: <CAOQ4uxg+R0wGq6O_qCw2EmzgJbNjbTP_6V0sVoxvXf1O=SOdFA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: compare fsid when merging name event
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 10:42 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 28-07-20 09:51:08, Amir Goldstein wrote:
> > This was missed when splitting name event from fid event
> >
> > Fixes: cacfb956d46e ("fanotify: record name info for FAN_DIR_MODIFY event")
> > Cc: <stable@vger.kernel.org> # v5.7+
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> OK, but given we never enabled FAN_DIR_MODIFY in 5.7, this is just a dead
> code there, isn't it? So it should be enough to fix this for the series
> that's currently queued?

Doh! you are right.
So you can just work it into the series and remove the explicit stable tag.
If we leave the Fixes tag, stable bots will probably pick this up, but OTOH,
there is no harm in applying the patch to stable kernel, so whatever.

Thanks,
Amir.
