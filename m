Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AD1340C34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 18:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhCRRys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 13:54:48 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:45584 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhCRRy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:54:26 -0400
Received: by mail-pf1-f176.google.com with SMTP id h3so4010489pfr.12;
        Thu, 18 Mar 2021 10:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zw9NDxhZI9qzGWmlzDIZRAJNmsg1FVsGW1vH7/3lAzE=;
        b=Uov5OHL0eXHyfEHVhZCeCACF4bIG4jlTj8VtVvfzrGu5btOKbi3O5piYbBxoUHcLqT
         WJjkXihnma+c88xNRn3O+MYV4TgmEGvtjcVtwwTMseI6JjgtwP30QkYhv0Ct0S/huEje
         zI7BIvKNBu7juvRljsnZmi6YXSlVT3dS62Pyf0VN+9+CLYnMSRDHEtbWlxQJEaHkQmLp
         tIOYJe2i7/RgrsnorKzgvZ3iyOpphuUXkXhW0TTtdoklNxpYnntbgA4GVYpR4cttT4Su
         k7ZP6Xrdb5cO/JECplAfo1CsJeaj0cCx/ptm9aq+ov4Z+hpIni44Xoc8vM/6ln/XV+8s
         Cn/g==
X-Gm-Message-State: AOAM533RxF1vnDaZPMvHVeqnIYwJ+W382P93wm3yavtckjJFHMDLzDC6
        WDmzAzwBCt6bUdg6c+LkkZOCHy85uMZTPg==
X-Google-Smtp-Source: ABdhPJxEZsgqX5znjy5cHX8VUcyqPfqRya34MwqfUBV/oA0KXRbq+gFLGOZDV+d4RYHUWWgu2TmJ/w==
X-Received: by 2002:a62:fc10:0:b029:1ef:141f:609 with SMTP id e16-20020a62fc100000b02901ef141f0609mr5077001pfh.78.1616090066177;
        Thu, 18 Mar 2021 10:54:26 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u22sm2812190pgh.20.2021.03.18.10.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 10:54:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3A27740244; Thu, 18 Mar 2021 17:54:24 +0000 (UTC)
Date:   Thu, 18 Mar 2021 17:54:24 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-block@vger.kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: blktests: block/009 next-20210304 failure rate average of 1/448
Message-ID: <20210318175424.GR13911@42.do-not-panic.com>
References: <20210316174645.GI4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316174645.GI4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding linux-fsdevel as folks working on fstests might be
interested.

On Tue, Mar 16, 2021 at 05:46:45PM +0000, Luis Chamberlain wrote:
> My personal suspicion is not on the block layer but on scsi_debug
> because this can fail:
> 
> modprobe scsi_debug; rmmod scsi_debug
> 
> This second issue may be a secondary separate issue, but I figured 
> I'd mention it. To fix this later issue I've looked at ways to
> make scsi_debug_init() wait until its scsi devices are probed,
> however its not clear how to do this correctly. If someone has
> an idea let me know. If that fixes this issue then we know it was
> that.

OK so this other issue with scsi_debug indeed deserves its own tracking
so I filed a bug for it but also looked into it and tried to see how to
resolve it.

Someone who works on scsi should revise my work as I haven't touched
scsi before except for the recent block layer work I had done for the
blktrace races, however, my own analysis is that this should not be
fixed in scsi_debug but instead in the users of scsi_debug.

The rationale for that is here:

https://bugzilla.kernel.org/show_bug.cgi?id=212337

The skinny of it is that we have no control over when userspace may muck
with the newly exposed devices as they are being initialized, and
shoe-horning a solution in scsi_debug_init() is prone to always be allow
a race with userspace never letting scsi_debug_init() complete.

So best we can do is just use something like lsof on the tools which
use scsi_debug *prior* to mucking with the devices and / or removal of
the module.

I'll follow up with respective blktests / fstests patches, which I
suspect may address a few false positives.

  Luis
