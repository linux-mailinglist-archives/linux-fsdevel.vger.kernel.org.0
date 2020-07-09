Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0DB21A69D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 20:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGISJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgGISJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:09:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66015C08C5DD
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2020 11:09:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j11so3447814ljo.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLUY2+cROQWDH9LIMjuUg8XLSdiwCev/lP1hc9DwpHE=;
        b=Xw17pp3QVH4SLTeelEhTcbB9WI56tYv4leZAltXzvEIWNs50TewZI2tfSpQ7QZMxH6
         5F3rhBO6EWtqhrcf2t3KoUtkNyWFvvLaN2SzNstCrzohcqjTqUHBNcOnAIhq1Jin6fEG
         t49EF28LHN/k7FfZi6olVrtLnJMu540l0OAEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLUY2+cROQWDH9LIMjuUg8XLSdiwCev/lP1hc9DwpHE=;
        b=pu6T/BWCIq7QJ90WBeaHY8A3p7g9WksS1mD2dpTN8gs5iWxCCKeYCzH27XplAQ6QGH
         pGbVXe3z66kbuC3I2Y9Z5PYTydtTWeTI9vtzi0XrOyL1l2HOmZu1Vnt/3tbvFFyDsiHA
         CnXGBSa0MvARQmk4RQkZuNN9bBza178bg9ak3cSEPF2ZKljeVk0bNfv14Dr8uCsjlu92
         10nxkk/iogyzpbh1xKgkt7Fll+/Dofz2BUKRRN4GEwMfdxzvsOdkaVMXcVjSOhjGjE0G
         e40lmqlfIWhxuyKnRR61DfBTHGF5qL7SYYHwwxo2bXyjVpVOqYx7kCVJP9RnNkTk8vNG
         qTVw==
X-Gm-Message-State: AOAM533NvIxDXhJC4pZXY1V6/ob3dNYMANGiTHCjtApQ++2n5Nt+Gsw8
        2Dx0oxpXHDyvc8tMPHkdKsYPlhXqtys=
X-Google-Smtp-Source: ABdhPJzHQsSzthLTLlU12KFn3IB7RyOXc35mgLea033cRuEgwATWV96TrOIHTyPsa78Ml+WRVEyRlw==
X-Received: by 2002:a2e:6e0b:: with SMTP id j11mr6592639ljc.159.1594318140502;
        Thu, 09 Jul 2020 11:09:00 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id y24sm1188133lfy.49.2020.07.09.11.08.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:08:59 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id r19so3425634ljn.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 11:08:59 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr36562158ljj.102.1594318138800;
 Thu, 09 Jul 2020 11:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200709151814.110422-1-hch@lst.de>
In-Reply-To: <20200709151814.110422-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jul 2020 11:08:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibathZJc6oSfgBdw7qhW75eF1ukg9y3bMXFfmp5t_uig@mail.gmail.com>
Message-ID: <CAHk-=wibathZJc6oSfgBdw7qhW75eF1ukg9y3bMXFfmp5t_uig@mail.gmail.com>
Subject: Re: decruft the early init / initrd / initramfs code v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 9, 2020 at 8:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no really good tree for this, so if there are no objections
> I'd like to set up a new one for linux-next.

All looks good to me. I had a wish-list change for one of the patches
that I sent a reply out for, but even without that it's clearly an
improvement.

Of course, I just looked at the patches for sanity, rather than
testing anything. Maybe there's something stupid in there. But it all
looked straightforward. So Ack from me, with the hope that you'd do
that "vfs_chown/chmod()" thing.

                Linus
