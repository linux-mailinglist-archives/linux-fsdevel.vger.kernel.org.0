Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF56031F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJRSHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiJRSHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:07:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061385BC3E;
        Tue, 18 Oct 2022 11:07:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d26so34219454eje.10;
        Tue, 18 Oct 2022 11:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iNmXamx2eoY/hs851axcD6yRoOOiqIKgePvZs1FJsCM=;
        b=U0pI+nqCsM4Tv91V9ggEiXtEqvG7YDFKdF4OFxJMq19tTrCFMGrSUTC3qFKOc+dYQO
         wB//QSf4SjRLmpCCftKZ+7s3OOFlzQzfCrWxt7z/tLIwRTMVpDGiIMALGUEynYZckj/O
         /hNodVNe56wZPLl46sYTuTo2sjfoZLMCRgVMmkvj67CEbNbYJw70jZTJD7uJPKF+DXfE
         9LxKRKfz2E3TIOmh/YLmjTBHGn3NkpJRXK2nBMwLl6tfFYrmfjsXXDkuyEK6vVPGGQ5e
         4XaxAx1KUX4dF3pq5WMKLXaHaqkziGHSKlWBKW1jly3mCoylLJagF2lY5Pk5PtF7c5bi
         LUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNmXamx2eoY/hs851axcD6yRoOOiqIKgePvZs1FJsCM=;
        b=bWpzBMOdm+5JxOFnlMz60H+IWIQaySvAvS74YEuIYQ1PJiE+Y60wkEMKWrFYRcdpMa
         f2GK1moIIKOQjg7oguXPegyvRaPweeDosYFIGa6yX5sL36qQrinwAtTuo+4kCbAcGj9x
         D01oIUmwJuPC8ycP/Uv1+PeHeb3nXZkZNYzbtdUrwaQIa1EOtdonGcy5LG3IJOd9g59f
         Y1OtSIxcuDSi8RSyIcWcxiWKZD91fFZs+0LYNGauw/n/ybbv7XSbcZdvwP43cW6Paunm
         RIZdyTaXXBRX2SZYOwocOnaXEWu0i5zKqJSF2pEnSMq1SjmNYin5tbqE2TtX3L/PFdBP
         WqMg==
X-Gm-Message-State: ACrzQf1j3FPPJjKyU1ZsL0lSqP5riEDaBdG+ui6RI/WcVowr0WeosAEL
        93j3lEwhz1bCUMXqX+bKxTI=
X-Google-Smtp-Source: AMsMyM5uDDPr4i2k1u7mgFkQaGrprJd8u434247VBYZGafImEOFe0yuU+VyheBJN3vIG/TzSX3CAkA==
X-Received: by 2002:a17:907:7f25:b0:78d:e76a:ef18 with SMTP id qf37-20020a1709077f2500b0078de76aef18mr3453180ejc.378.1666116418417;
        Tue, 18 Oct 2022 11:06:58 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402345100b0045cba869e84sm9344141edc.26.2022.10.18.11.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:06:57 -0700 (PDT)
Date:   Tue, 18 Oct 2022 20:06:55 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v9 00/11] landlock: truncate support
Message-ID: <Y07rP/YNYxvQzOei@nuc>
References: <20221008100935.73706-1-gnoack3000@gmail.com>
 <b8566973-63bc-441f-96b9-f822e9944127@digikod.net>
 <Y0g+TEgGGhZDm7MX@dev-arch.thelio-3990X>
 <Y0xJUy3igQXWPAeq@nuc>
 <Y0xkZqKoE3rRJefh@nuc>
 <ea8117e5-7f5c-7598-5d6a-868184a6e4ae@digikod.net>
 <CAHC9VhR8SQo9x_cv6BZQSwt0rrjeGh-t+YV10GrA3PbC+yHrxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR8SQo9x_cv6BZQSwt0rrjeGh-t+YV10GrA3PbC+yHrxw@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:12:48PM -0400, Paul Moore wrote:
> On Mon, Oct 17, 2022 at 5:16 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On 16/10/2022 22:07, Günther Noack wrote:
> 
> ...
> 
> > > Proposed fix
> > > ------------
> > >
> > > I think the LSM framework should ensure that security blobs are
> > > pointer-aligned.
> > >
> > > The LSM framework takes the role of a memory allocator here, and
> > > memory allocators should normally return aligned addresses, in my
> > > understanding. -- It seems reasonable for AppArmor to make that
> > > assumption.
> > >
> > > The proposed one-line fix is: Change lsm_set_blob_size() in
> > > security/security.c, where the positions of the individual security
> > > blobs are calculated, so that each allocated blob is aligned to a
> > > pointer size boundary.
> > >
> > > if (*need > 0) {
> > >    *lbs = ALIGN(*lbs, sizeof(void *));   // NEW
> > >
> > >    offset = *lbs;
> > >    *lbs += *need;
> > >    *need = offset;
> > > }
> >
> > This looks good to me. This fix should be part of patch 4/11 since it
> > only affects Landlock for now.
> 
> Hi Günther,
> 
> Sorry for not seeing this email sooner; I had thought the landlock
> truncate work was largely resolved with just a few small things for
> you to sort out with Mickaël so I wasn't following this thread very
> closely anymore.
> 
> Regarding the fix, yes, I think the solution is to fixup the LSM
> security blob allocator to properly align the entries.  As you already
> mentioned, that's common behavior elsewhere and I see no reason why we
> should deviate from that in the LSM allocator.  Honestly, looking at
> the rest of the allocator right now I can see a few other things to
> improve, but those can wait for a later time so as to not conflict
> with this work (/me adds a new entry to my todo list).
> 
> Other than that, I might suggest the lsm_set_blob_size()
> implementation below as it seems cleaner to me and should be
> functionally equivalent ... at least on quick inspection, if I've done
> something dumb with the code below please feel free to ignore me ;)
> 
>   static void __init lsm_set_blob_size(int *need, int *lbs)
>   {
>     if (*need <= 0)
>       return;
> 
>     *need = ALIGN(*need, sizeof(void *));
>     *lbs += *need;
>   }

Hello Paul,

thanks for the reply. Sounds good, I'll go forward with this approach
then and send a V10 soon.

Implementation-wise for this function, I think this is the closest to
your suggestion I can get:

static void __init lsm_set_blob_size(int *need, int *lbs)
{
  int offset;

  if (*need <= 0)
    return;

  offset = ALIGN(*lbs, sizeof(void *));
  *lbs = offset + *need;
  *need = offset;
}

This differs from your suggestion in that:

- *need gets assigned to the offset at the end. (It's a bit unusual:
  *need is both used to specify the requested blob size when calling
  the function, and for returning the allocated offset from the
  function call.)

- This implementation aligns the blob's start offset, not the end
  offset. (probably makes no real difference in practice)

As suggested by Mickaël, I'll make this fix part of the "Landlock:
Support file truncation" patch, so that people backporting it won't
accidentally leave it out.

—Günther

-- 
