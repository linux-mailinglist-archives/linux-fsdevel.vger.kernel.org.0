Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6304519CDEA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 02:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391226AbgDCAuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 20:50:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36848 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391222AbgDCAuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:50:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id i7so7094837edq.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 17:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUEYZjWWMHJXst4WV8j9nCyjHYIXBDcN6VSpUw0gbVM=;
        b=baZTVQAnqXrBYnPvbXACvucvZIqe3nb211Ui8JkJb0UkViSzAmrwCJVFgAThAA7LUq
         TYxNyqG1d5Ax04ruNlBPKhd8lngk95Ttq89x96XPiX6WWNIBLSXgLSaOfos7WTAN25Ob
         akiflooGILFKGYq2Dy2bjY4PsFYJqIa96MQ/Ans8NRaUbjvUCJyQTvALe2eOTyh1OaUL
         UI9HiZUMObenTvz03XA2DjIor7zKcpDEM92HJMgXNZnMK09gX/hw1eFFkVvfvGwbmeUo
         udAmMPnRhTCfHED0pm0jOoF7PoRI6329FseRgegybGeV9GvlzHgndbtgR0bOgeo7jnGf
         ztug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUEYZjWWMHJXst4WV8j9nCyjHYIXBDcN6VSpUw0gbVM=;
        b=MGvfQ0f12wGJpyv94v0D3dFy/jj0g2joamjeG/zyKAHQD9kTD2SyY4i4cXCwLrn9sa
         E/nNf8z2v8v6LZpdBP+w5KLdx8ZEir56vqmkMKEKDhtdxIVT8q56P/DK0+aGgbCiSgRR
         qLocf9KEhHn4twztCHWVfQJEeWWSaTFWVo9hIsi/kd5qjqoeGhzDfFdVZqyVZaGwgWEh
         W4WNGEO+6a82p7e4E5zHB2Oazk3urAAEBmOuXytrnRCEe5LyUyqBRzjjZ7GvMdkTsdkR
         NutMa5R8zpvjEPMcQTacjCs4MzbHCTDNOzPVtla+lLGsxgRTG+U79KIR/A0fqWaR28HT
         JesA==
X-Gm-Message-State: AGi0PubYIZ6PAkE2GznwR7hu4cIvVINEqrVNJiIZ6YGgqxewUAsmYNH+
        l04zlQfaewtZUTsR9LixReIOSbMwtsrJAuNXAktJqw==
X-Google-Smtp-Source: APiQypKk0+do2txTWB61ucVZLOkss2cjeqGQGndVxlcxXmIo/3Jb4DnDa+Nd/nrjffQoH5hYIo7FhAXp030eLnr8+iU=
X-Received: by 2002:a05:6402:b17:: with SMTP id bm23mr5520314edb.165.1585875007220;
 Thu, 02 Apr 2020 17:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200228163456.1587-1-vgoyal@redhat.com> <20200228163456.1587-5-vgoyal@redhat.com>
 <CAPcyv4iWfL+KQjjUXqrTKOL8F4M05Vu=imm5tqsD6MO=XLzoMA@mail.gmail.com>
In-Reply-To: <CAPcyv4iWfL+KQjjUXqrTKOL8F4M05Vu=imm5tqsD6MO=XLzoMA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 Apr 2020 17:49:56 -0700
Message-ID: <CAPcyv4h=xQRPBwfy6xMjUONk41aO0xBYHpu9auSHdG17CWdv=g@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] dm,dax: Add dax zero_page_range operation
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        david <david@fromorbit.com>, jmoyer <jmoyer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Mike Snitzer <msnitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 12:34 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> [ Add Mike ]
>
> On Fri, Feb 28, 2020 at 8:35 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > This patch adds support for dax zero_page_range operation to dm targets.
>
> Mike,
>
> Sorry, I should have pinged you earlier, but could you take a look at
> this patch and ack it if it looks ok to go through the nvdimm tree
> with the rest of the series?

I'm going to proceed with pushing this into -next to get more exposure
and check back later next week about pushing it to Linus. It looks
good to me and it unblocks Vivek on his virtio-fs work, but still
don't want to push device-mapper bits without device-mapper maintainer
Ack.
