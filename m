Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E672C486C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 20:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgKYTbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 14:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgKYTbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:31:44 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC25C061A51
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 11:31:43 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id oq3so4612632ejb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 11:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NbGEEdyiGb6W/O88ADJQK8rzA0fmkfkXXMTB0VeQSp4=;
        b=aHiB780fX4O+H26PT704iIHKBv1W1Bk2L0OefcT5JXt8+Hv5F6hBhZBHqgeWAi5FFL
         w5TU/JpalJlMySQzGAD5ia6tyPhqLGSzb2GfL89UK+fZrlt0gzw+T2bZ0f63mN2vPE5B
         JYLqbnx22vTYxiNzMFLbCfTSLiU8yKX4coYdjlDP31Kv0jkrInUlO+RcUAitNtNG7F7x
         BytLrRhfLBT2TmskEkFnQNBAqMiy2BtpAmcS28mgq9tWn+2obHxDdVYTLFjIvitqttBB
         N80Ynt1vLBvPzPzs3o4+ASsrnZHMPqGFom6Kfk9gULq/KG1n84V0DtbOg/2BrEUQdein
         X/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NbGEEdyiGb6W/O88ADJQK8rzA0fmkfkXXMTB0VeQSp4=;
        b=GTcCosPqvBI15p51x9TdobHVgrC6eI7tz3pFu3CJQlwtG0YcemRoNRPaMEjqt6kCob
         +RCQOdxzoO8av6kR1PP8cPauFDVLDCPHsPt+QA0HguVEtCYW20Ogvvl0SJP9F4SJ3zNN
         8uOMEYOujYgTpDbSyeqXjsJcphPWjP90OKxJp8PMuhr57yZK0do2tJtsemWzNWZmOrAJ
         xB9sfm88xZ0k4tDZrVa2W2fhISjrSaadmhgm5mOi4YZB24XEDpr0Gjiv3uJ+BHGSzKQO
         yyFIKVroRiOOlJY6oiw/o/DW9+r4wPq3J7cNBA+WjW4sYnJVuJmGQTqhkU1h3l48hBdH
         dEFg==
X-Gm-Message-State: AOAM532Z6j4ViabXtjrmJwU1mRmjvAxXSyeNJqwdtDXVR5SXn5pVkcv1
        BaR9d/oSa+nkrxLfrzzOp1jDs6FGHDUod3FGcBI+8w==
X-Google-Smtp-Source: ABdhPJxMCv1rZBl4mt1S2ByNOVSyjZUYE/JO5kBoma6Gb2FbY/xaMAVlp+6u+8OAc7U55YryrQkhwTzE7KvD+K7/GZA=
X-Received: by 2002:a17:906:4c85:: with SMTP id q5mr4514377eju.375.1606332702253;
 Wed, 25 Nov 2020 11:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20201101212738.GA16924@gmail.com> <20201102122638.GB23988@quack2.suse.cz>
 <20201103211747.GA3688@gmail.com> <20201123164622.GJ27294@quack2.suse.cz>
 <20201123224651.GA27809@gmail.com> <20201124084507.GA4009@zn.tnic> <20201124102033.GA19336@quack2.suse.cz>
In-Reply-To: <20201124102033.GA19336@quack2.suse.cz>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 26 Nov 2020 01:01:30 +0530
Message-ID: <CA+G9fYtKKmoYUJpPFLBtFVB6MRJwJTsVjtYtRcXmJxc5PbHAZA@mail.gmail.com>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
To:     Jan Kara <jack@suse.cz>
Cc:     Borislav Petkov <bp@alien8.de>,
        =?UTF-8?Q?Pawe=C5=82_Jasiak?= <pawel@jasiak.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 24 Nov 2020 at 15:50, Jan Kara <jack@suse.cz> wrote:
>
> On Tue 24-11-20 09:45:07, Borislav Petkov wrote:
> > On Mon, Nov 23, 2020 at 11:46:51PM +0100, Pawe=C5=82 Jasiak wrote:
> > > On 23/11/20, Jan Kara wrote:
> > > > OK, with a help of Boris Petkov I think I have a fix that looks cor=
rect
> > > > (attach). Can you please try whether it works for you? Thanks!
> > >
<trim>
>
> Thanks for checking! I didn't realize I needed to change the ifdefs as we=
ll
> (I missed that bit in 121b32a58a3a). So do I understand correctly that
> whenever the kernel is 64-bit, 64-bit syscall args (e.g. defined as u64) =
are
> passed just fine regardless of whether the userspace is 32-bit or not?
>
> Also how about other 32-bit archs? Because I now realized that
> CONFIG_COMPAT as well as the COMPAT_SYSCALL_DEFINE6() is also utilized by
> other 32-bit archs (I can see a reference to compat_sys_fanotify_mark e.g=
.
> in sparc, powerpc, and other args). So I probably need to actually keep
> that for other archs but do the modification only for x86, don't I?
>
> So something like attached patch?

I have tested the attached patch on i386 and qemu_i386 and the reported pro=
blem
got fixed.

Test links,
https://lkft.validation.linaro.org/scheduler/job/1985236#L1176
https://lkft.validation.linaro.org/scheduler/job/1985238#L801


--=20
Linaro LKFT
https://lkft.linaro.org
