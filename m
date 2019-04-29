Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5E0E975
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfD2Rql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:46:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35245 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2Rql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:46:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id g24so4825234otq.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2019 10:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XNiWMXZiJc7H/jaqikR0q3+B4O1qwVQdNrN1Gohc70=;
        b=p5lXqVOR/D46DtPe4uu9ovh6bggojh9Qcj7Nks9hML6e1RyTRHoJrNZdph0p+vs6cO
         haJzgWJyf3Rc6XUgrDdn2UqhiIpTrwWOuYOymK+px8PDmxMOOmkYPLj6KcTTaMpeJIyc
         Oe8KC5R/oHHwUhteeal56TJ7bLzp+EZMAtf6Ok0ETGMG3L6dEds7kTHYhBPomWHLkV7l
         8yu6CrZiMNRw/Bk7P2CIGKUtlz52PsmA6+ayQ6KVoYk+1rcOfHcEJrk5SK9nFwcvGDlo
         dnkbSppIrw7RVbWqHd4TQnAqXyfK5GH8DNdU0E4s+laWicdSljEKEZgnxOjI2DZLij2C
         JwNA==
X-Gm-Message-State: APjAAAUc9lJAuJb6GS8U8Y0IabFmgV1Py7KxGejDloPVTM/m8nLX7MiJ
        mvTRRKErRr2gPfoyj4AAOahG0oV+9GexsElG47vcdA==
X-Google-Smtp-Source: APXvYqwEFPov5Fcmp1Z82klYLfGXcL8lJ+7fAYAgcVryDP/nX4tHzH4FfMhdUV9XfjfQTl9aLG0Z2jy1neqZ8hWMU+s=
X-Received: by 2002:a9d:6397:: with SMTP id w23mr15429856otk.332.1556560000444;
 Mon, 29 Apr 2019 10:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190429163239.4874-1-agruenba@redhat.com>
In-Reply-To: <20190429163239.4874-1-agruenba@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 29 Apr 2019 19:46:29 +0200
Message-ID: <CAHc6FU5jgGGsHS9xRDMmssOH3rzDWoRYvrnDM5mHK1ASKc60yA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] iomap: Clean up __generic_write_end calling
To:     cluster-devel <cluster-devel@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        =?UTF-8?B?RWR3aW4gVMO2csO2aw==?= <edvin.torok@citrix.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 29 Apr 2019 at 18:32, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> From: Christoph Hellwig <hch@lst.de>
>
> Move the call to __generic_write_end into iomap_write_end instead of
> duplicating it in each of the three branches.  This requires open coding
> the generic_write_end for the buffer_head case.

Wouldn't it make sense to turn __generic_write_end into a void
function? Right now, it just oddly return its copied argument.

Andreas
