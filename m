Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50292691B9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 10:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjBJJiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 04:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjBJJit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:38:49 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877815ACEE
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 01:38:46 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hx15so14154744ejc.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 01:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+CSs87Bv4X9FdOPYmZI8I7ZXN+lGBiiiGHWUaDXWUyA=;
        b=TC+YKkjyiydGRtrpmt7wSjvM/iGER/SrtSoz1eGq5Dh+7INoGE3CAvWyT6gFuHJw0+
         a+sJLH1pyilAt0mtGhC3FfEB5gEjShtpNWb2dwOI6qQYjTGCc03QzygAayckUSGy9sNH
         EFRK6CyM68LY8wjf+82mfK7pKtnF3BNXmwkjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CSs87Bv4X9FdOPYmZI8I7ZXN+lGBiiiGHWUaDXWUyA=;
        b=0Vsgekxv7odiQRKeviwCmMm95AGnaQ64ra6Zo7rrDhqeYBBbOPNCsclL0KmQFnDxul
         iOYhaho7Pk8ObMXBPY+OaazOVkV3jSSfbVl1ZleyQ2cKHDz/ErTWM+7c/GC+8CIymW8n
         8eb9rFCbgIFSOU8aDvd1w1nGEuXBugNDcoBr9JAbQf8dC1w4AFl94bEGfqmsykHjMZjU
         ceR5jOOQUtgYhNM6DUzpNMSUeJ41WTqT1BbwPW1Y68M7qJuUP+yJFtb4XKptyP3zo0oH
         u20cZDAZ0GpAKCsle2RA08ZVVSCKMOBSOIECmA62L4xZP2lP/gBbefypqZUt8VQO/AkE
         tKqQ==
X-Gm-Message-State: AO0yUKUVcI2Pilr41pnJD3JWIH7csl5GYdraDSTeNVeNRO08t/6c/lfx
        FN4S5vUZbQfhRcWjPe0NnIDd8zfUGKUlHEH1ekJuyXrLsX9DMg==
X-Google-Smtp-Source: AK7set8/uxRNe2y4k4ko7foqw0oR4bOtlspjtdSF2d3Obo3NZCeZRWVf990nwhUQ7Rv9MBGaypXSr2ym9HkQHAkPwKM=
X-Received: by 2002:a17:906:7242:b0:889:a006:7db5 with SMTP id
 n2-20020a170906724200b00889a0067db5mr3229286ejk.138.1676021925106; Fri, 10
 Feb 2023 01:38:45 -0800 (PST)
MIME-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com> <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
 <CA+PiJmRLTXfjJmgJm9VRBQeLVkWgaqSq0RMrRY1Vj7q6pV+omw@mail.gmail.com>
 <2dc5e840-0ce8-dae9-99b9-e33d6ccbb016@fastmail.fm> <CAOQ4uxiBD5NXLMXFev7vsCLU5-_o8-_H-XcoMY1aqhOwnADo9w@mail.gmail.com>
 <283b5344-3ef5-7799-e243-13c707388cd8@fastmail.fm> <CAOQ4uxjvUukDSBk977csO5cX=-1HiMHmyQxycbYQgrpLaanddw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjvUukDSBk977csO5cX=-1HiMHmyQxycbYQgrpLaanddw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 10 Feb 2023 10:38:34 +0100
Message-ID: <CAJfpegvHKkCn0UnNRVxFXjjnkOuq0N4xLN4WzpqVX+56DqdjUw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] FUSE BPF: A Stacked Filesystem Extension for FUSE
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Daniel Rosenberg <drosen@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@android.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 3 Feb 2023 at 12:43, Amir Goldstein <amir73il@gmail.com> wrote:

> > Thanks a lot Amir, I'm going to send out an invitation tomorrow. Maybe
> > Nikolaus as libfuse maintainer could also attend?
> >
>
> Since this summit is about kernel filesystem development, I am not sure
> on-prem attendance will be the best option for Nikolaus as we do have
> a quota for
> on-prem attendees, but we should have an option for connecting specific
> attendees remotely for specific sessions, so that could be great.

Not sure.  I think including non-kernel people might be beneficial to
the whole fs development community.  Not saying LSF is the best place,
but it's certainly a possibility.

Nikolaus, I don't even know where you're located.  Do you think it
would make sense for you to attend?

Thanks,
Miklos
