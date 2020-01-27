Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB814A312
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgA0LdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 06:33:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52286 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729764AbgA0LdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580124782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PlXx4GCmusHDyEhr1tc9UGO1kB0k8P75h0J2Af90Eb0=;
        b=A9hPJ8RtIVEC8gjkpIoWwyV7FkbDcO9J57D5P1KR1dL8vCv79pwW8bSNsT1zp5CK4VbY/Q
        H4eR15Ow2t54M1vOkJKRPL8cUGMbE0mA2NDljAhxZ4kBDLR6bCsD8bm1YMbJDNpbgMVsRg
        c4Os02fKk4XsMcgke5iJPFnLy1Whzao=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-EEBJ4y_6MAKZnovth0346w-1; Mon, 27 Jan 2020 06:33:00 -0500
X-MC-Unique: EEBJ4y_6MAKZnovth0346w-1
Received: by mail-ot1-f72.google.com with SMTP id d16so5992986otq.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2020 03:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlXx4GCmusHDyEhr1tc9UGO1kB0k8P75h0J2Af90Eb0=;
        b=KAccL0qiDVm/FmhOMMx+Q5bDvdlSfsObKwOwoJdpdEZ5hMC30Nvfi7kL+OZofInTqR
         TOmnzLo1e4S+xwRwOWv/C7292KqlNo2OHezLCG97T3Ve0Wlwu9MEwFTJ+Sj0XThYv++N
         FZ2smTps8Hp8YqSaZ7nRpGD7zu0O/SOLiDFVmDy4Vqwy/+Sxa4COWiVKbmJ3Vm+wSVEH
         P14UN/E0HyzqD0XlcEBqkhTvaRE0AK3iFdVbtF2ITVohSulGSSUGdHHBuMAsTsQWj+bV
         HeHBxUEYmlnT8gCQygfCydK46GKNMQjT2psqGYLpviA1oLhEgiIwBQ41GgmZCkB48F1O
         g5mQ==
X-Gm-Message-State: APjAAAUBOsM3YDWsEVZROWvZXWXH594d+TFuYSb2lT6BkRQyqUBgQxnZ
        vBtATZZiApKRZ1ODq5ffRG0IjuVtGQCRexyKibQx5Lbz/xBCu48I5GHOdzTPDnVS0Xc0OgSCLWJ
        51iYLEFtYCrpXcsgqFGM7WLVmbsJd8n2bqEae4C0agw==
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr12833306oth.48.1580124780169;
        Mon, 27 Jan 2020 03:33:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2WCKL3TcEQWLEGBx1bgWgRFFUvo6KJVLgtkrNqpfuMHkeNAswCT3gA+Mrw2sEoru3XQgdgZuxdIpa/3I3A0I=
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr12833293oth.48.1580124779964;
 Mon, 27 Jan 2020 03:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20200127101100.92588-1-ghalat@redhat.com> <063e702f-dc5f-b0ca-fe26-508a9f1e8e9a@I-love.SAKURA.ne.jp>
In-Reply-To: <063e702f-dc5f-b0ca-fe26-508a9f1e8e9a@I-love.SAKURA.ne.jp>
From:   Grzegorz Halat <ghalat@redhat.com>
Date:   Mon, 27 Jan 2020 12:32:48 +0100
Message-ID: <CAKbGCsfyiLfvwi1iYuTu2Gg5=TXQwUQ3iv73PdNvY8o_NZJ7aQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: sysctl: add panic_on_mm_error sysctl
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Stan Saner <ssaner@redhat.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Vratislav Bendel <vbendel@redhat.com>, kirill@shutemov.name,
        khlebnikov@yandex-team.ru, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 27 Jan 2020 at 11:43, Tetsuo Handa wrote:
>
> Maybe panic_on_inconsistent_mm is better, for an MM error sounds too generic
> (e.g. is page allocation failure an error, is OOM killer an error,
> is NULL pointer dereference an error, is use-after-free access an error) ?
>
yes, panic_on_inconsistent_mm is better

> Also, should this be in /proc/sys/vm/ than /proc/sys/kernel/ ?
Agreed

I will wait a day or two for more feedback and send V2 with sysctl
named as 'vm.panic_on_inconsistent_mm'.

Thanks,
--
Grzegorz Halat

