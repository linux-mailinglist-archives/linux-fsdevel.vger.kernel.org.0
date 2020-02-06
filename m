Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97828153C52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 01:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgBFAhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 19:37:53 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46303 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgBFAhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 19:37:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id g64so3837281otb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2020 16:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CgZnEXyLY0Syv8bqgt/nY2nliVOx+eludqj9JOuXxQ=;
        b=pwboQQ6dDYepvw2yHSZ7z5GQ8dklJBoUgx6mY+1GPFCvi6qF7pwQwc1HBoxE94l5uf
         FrRuw63gYQSxkeL3yQDQ6w7haexXzC6nuTHkR7cM3WV2kJv3Cm7yWLHrKRN5K01Aldul
         cFm1aR5dBNJdzGk8yRek/jMlS4F3T/nHtX9o7QwHj6Kbyi2SN/oGstf5MIdDjbCg3TRV
         wgsAqsKwlwyeCYbG9OQRCBR4XKQiIDPJTpRuT8ZRLpv2IJ1nxl/xZ01+KPD9rFacJTbS
         1acZ0CEKWMpXWzhWtO66EURrfyINvc7RfsZ4/QSiyKI7ixNk6at3DcYSK2pqh3un6DdX
         Prdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CgZnEXyLY0Syv8bqgt/nY2nliVOx+eludqj9JOuXxQ=;
        b=JFIhCuD91onCoRPqNemDp1KOjEfmRi1OChcfEo9CVwMwOCSjW+Y7ibOXyT6uRnBQZW
         nFmR4xuA7YXFGPhNtPXNIZPO31rln3MTnFe5Buxn+0Z6UZ00Q1rH6vUJu1yxrG/tIjJJ
         b2eHLqIAYxDIGVb/m41oWDuklQEhGXv/6BQ6foEL2Mvmy8iT4z0/n6zk7ujDc2sab+Fd
         2UblR3zrvR7Mu7qwxBzXi2kucacqxVBWRRc8raabooxsR3SHgmJOU0h9xi4Lc6cb1bVx
         0jxA9Bmx1a7ikxfr5vYMcIVkOkNdkhNJKyfwnQbUPI+FCKnRGXjp/pRWIxd/zQSxFVXg
         3D/A==
X-Gm-Message-State: APjAAAU9jB6t+WnX2G+wvnA+Mpm2qbVDPCJEYzYQa4An6iGGLxYwh8Yb
        vsLv19eI+oJA9OgygKLCJyvk+t9QNBTbHFXGQ+ROx7fL
X-Google-Smtp-Source: APXvYqxt4gAkv1hvtAuccfBn1VDSYiNjQ3JyFMqiBZWssfDAFC+d5vqWE5smrRjpV1xIeHW8XfSCsOK0aAAeNKsk2fM=
X-Received: by 2002:a9d:1284:: with SMTP id g4mr27696911otg.207.1580949471777;
 Wed, 05 Feb 2020 16:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20200129210337.GA13630@redhat.com> <f97d1ce2-9003-6b46-cd25-a908dc3bd2c6@oracle.com>
In-Reply-To: <f97d1ce2-9003-6b46-cd25-a908dc3bd2c6@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 5 Feb 2020 16:37:40 -0800
Message-ID: <CAPcyv4ittXHkEV4eH_4F5vCfwRLoTTtDqEU1SmCs5DYUdZxBOA@mail.gmail.com>
Subject: Re: [RFC][PATCH] dax: Do not try to clear poison for partial pages
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 5, 2020 at 12:27 PM <jane.chu@oracle.com> wrote:
>
> Hello,
>
> I haven't seen response to this proposal, unsure if there is a different
> but related discussion ongoing...
>
> I'd like to express my wish: please make it easier for the pmem
> applications when possible.
>
> If kernel does not clear poison when it could legitimately do so,

The only path where this happens today is write() syscalls in dax
mode, otherwise fallocate(PUNCH_HOLE) is currently the only guaranteed
way to trigger error clearing from userspace (outside of sending raw
commands to the device).

> applications have to go through lengths to clear poisons.
> For Cloud pmem applications that have upper bound on error recovery
> time, not clearing poison while zeroing-out is quite undesirable.

The complicating factor in all of this is the alignment requirement
for clearing and the inability for native cpu instructions to clear
errors. On current platforms talking to firmware is required and that
interface may require 256-byte block clearing. This is why the
implementation glommed on to clearing errors on block-I/O path writes
because we at least knew that all of those I/Os were 512-byte aligned.

This gets better with cpus that support the movdir64b instruction, in
that case there is still a 64-byte alignment requirement, but there's
no need to talk to the BIOS and therefore no need to talk to a driver.

So we have this awkward dependency on block-device I/O semantics only
because it happened to organize i/o in a way that supports error
clearing.

Right now the kernel does not install a pte on faults that land on a
page with known poison, but only because the error clearing path is so
convoluted and could only claim that fallocate(PUNCH_HOLE) cleared
errors because that was guaranteed to send 512-byte aligned zero's
down the block-I/O path when the fs-blocks got reallocated. In a world
where native cpu instructions can clear errors the dax write() syscall
case could be covered (modulo 64-byte alignment), and the kernel could
just let the page be mapped so that the application could attempt it's
own fine-grained clearing without calling back into the kernel.
