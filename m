Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81A92310B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 19:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbgG1RQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 13:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731796AbgG1RQp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:16:45 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 704C52083E
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956604;
        bh=FPl2g9z95O/j9qakMr1cGWs3U8+LQVfszTzNisgkf+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KPnMEN7iCF/xEO6QsEaxqYO2GzTsDtB7AMcRLK6l/UjK4oIn/F4JOGSXZUvYW44s1
         jEFlyTCl3P3MEFUQeNfubHYCCc9zG74UqQBTODvN2LzJ4uy4XxTnjTnNBbEJ2yMVj4
         PZjnIsRaELUQ0yXk6Deqthsuj/8xNzoMTptFK1So=
Received: by mail-wm1-f44.google.com with SMTP id 3so300472wmi.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 10:16:44 -0700 (PDT)
X-Gm-Message-State: AOAM532u9OZ/RNoUdYP7WSfpFf2L6oKN4xTwdjU66M/AXUnHhFXVSMGa
        HG/iMHSlwRaLUcTckoCdWt7IObbr3bq6kNzzaTwymQ==
X-Google-Smtp-Source: ABdhPJwu7N9kRRQbUR+VvYTCTVOAiGMuB+0+ywLntE8sEkStNuXDIJbnbwFAt4moiWmwHpSI57u5zJetZtfyZAKrhS8=
X-Received: by 2002:a1c:de86:: with SMTP id v128mr4734767wmg.36.1595956603047;
 Tue, 28 Jul 2020 10:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <c23de6ec47614f489943e1a89a21dfa3@AcuMS.aculab.com> <f5cfd11b-04fe-9db7-9d67-7ee898636edb@linux.microsoft.com>
In-Reply-To: <f5cfd11b-04fe-9db7-9d67-7ee898636edb@linux.microsoft.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 28 Jul 2020 10:16:32 -0700
X-Gmail-Original-Message-ID: <CALCETrUta5-0TLJ9-jfdehpTAp2Efmukk2npYadFzz9ozOrG2w@mail.gmail.com>
Message-ID: <CALCETrUta5-0TLJ9-jfdehpTAp2Efmukk2npYadFzz9ozOrG2w@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 9:32 AM Madhavan T. Venkataraman
<madvenka@linux.microsoft.com> wrote:
>
> Thanks. See inline..
>
> On 7/28/20 10:13 AM, David Laight wrote:
> > From:  madvenka@linux.microsoft.com
> >> Sent: 28 July 2020 14:11
> > ...
> >> The kernel creates the trampoline mapping without any permissions. When
> >> the trampoline is executed by user code, a page fault happens and the
> >> kernel gets control. The kernel recognizes that this is a trampoline
> >> invocation. It sets up the user registers based on the specified
> >> register context, and/or pushes values on the user stack based on the
> >> specified stack context, and sets the user PC to the requested target
> >> PC. When the kernel returns, execution continues at the target PC.
> >> So, the kernel does the work of the trampoline on behalf of the
> >> application.
> > Isn't the performance of this going to be horrid?
>
> It takes about the same amount of time as getpid(). So, it is
> one quick trip into the kernel. I expect that applications will
> typically not care about this extra overhead as long as
> they are able to run.

What did you test this on?  A page fault on any modern x86_64 system
is much, much, much, much slower than a syscall.

--Andy
