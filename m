Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713701E69A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 20:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391501AbgE1Snf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 14:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391488AbgE1Snd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 14:43:33 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC62C08C5C6
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 11:43:32 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z6so34665443ljm.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9I7snvnyR6f67pT5aVMg4qxsNA0F9Vag9hIROGL8vg=;
        b=P8nw8P71cxagqSPVUA9Kzi2wkC951thaYnOwz/e4kiPGKd2Zew+YultOwwJeyFp5h7
         zM7l8zOFEFg42p7pHhMVJLHi7CpftdQASS+eM/OM/B4nVtTeHsdqVgzMglyZy3GmUpst
         EXyW/r86HANnDshbNT+Vi8bmm9fl991ACFIhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9I7snvnyR6f67pT5aVMg4qxsNA0F9Vag9hIROGL8vg=;
        b=hHtnvhlBvqv356cQF2qNYluGcckhVlTE8ZVgbQRca4owELbF/5GeNvInyYrrx7Kfse
         Yr4drCR3NLULBvWTM0xSnz4XSfnLKg0l0iETFiGlHZu4M4nDarFVD4OwpoIT+iSgRTPs
         GLYQanhGsB+JJJznGqQ1+ZDeV9Y642Uvgw193T7SH5hQQA9ttPVd19flbsND4S9sUFho
         7FXTrLInCsaNaS915uFm4ji/Kh3xne9FcKoSAU/yuaEBo3hYNM8Ll6YeSeo5pdKElZE/
         x8ykH2i3nz3TpHEuwwDGEBC6bDZEP7V602wPEzEPRMBnamtNo5/Lh0NNALBW6Ur6GTER
         eViA==
X-Gm-Message-State: AOAM531egaI4jeftjuoINhVo5cA2Stu6PQoiwyg5In+r+IzVWA8Gdj+y
        UaiZzSFq3SGDySmgecKDAge8iaGP128=
X-Google-Smtp-Source: ABdhPJzs91Kcp+43rrwDSzat63W2iLdyk6mYhybm3osCwSWMN7E0yJQSbVyayYaJRFVhSGnpNSg8Zg==
X-Received: by 2002:a05:651c:502:: with SMTP id o2mr2108572ljp.434.1590691410657;
        Thu, 28 May 2020 11:43:30 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id l8sm1581925ljg.93.2020.05.28.11.43.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 11:43:29 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id m18so34674646ljo.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 11:43:29 -0700 (PDT)
X-Received: by 2002:a2e:b16e:: with SMTP id a14mr2040017ljm.70.1590691409213;
 Thu, 28 May 2020 11:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200528054043.621510-1-hch@lst.de> <20200528054043.621510-10-hch@lst.de>
In-Reply-To: <20200528054043.621510-10-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 11:43:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpnR9sBeie_z0xA3mYzG50Oiw1jZjyHt0eLX6p45ARvQ@mail.gmail.com>
Message-ID: <CAHk-=wgpnR9sBeie_z0xA3mYzG50Oiw1jZjyHt0eLX6p45ARvQ@mail.gmail.com>
Subject: Re: [PATCH 09/14] fs: don't change the address limit for ->write_iter
 in __kernel_write
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 10:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> -ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
> +ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
> +               loff_t *pos)

Please don't do these kinds of pointless whitespace changes.

If you have an actual 80x25 vt100 sitting in a corner, it's not really
conducive to kernel development any more.

Yes, yes, we'd like to have shorter lines for new code, but no, don't
do silly line breaks that just makes old code look and grep worse.

             Linus
