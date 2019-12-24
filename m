Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49400129C1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 01:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfLXAu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 19:50:57 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50278 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726833AbfLXAu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 19:50:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 30DE58EE165;
        Mon, 23 Dec 2019 16:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1577148656;
        bh=EYcsiwyqcB54APO4XT20NoMkSMIzW7tiIQM9tWVMeXg=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=SdMPnP5YTvTB6PX1sMj5aXTac5YpQtseN+O7rz4UXjassfwBC4K/fxghdI493lR0D
         TAZTBKAAZZWj4nQIGf3iUenpHTxWRHOEwwVixdZGIc2SJ72ssM6HLxMCAC7G1RWucA
         ALCqHZLwqsISZ79T/jUe0hzZsHr0tMNdGgL7sYiQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jnc2O5S202L1; Mon, 23 Dec 2019 16:50:56 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 840818EE092;
        Mon, 23 Dec 2019 16:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1577148655;
        bh=EYcsiwyqcB54APO4XT20NoMkSMIzW7tiIQM9tWVMeXg=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=O3DDhBBttOXBXmHsam+0cVcABRHTz6VA7vfqaCl9xe4VgcVhh5Y9HCZ9+T7R8zZqV
         De6M1Dfekt+0ZMtiMtZ+jiTsmMGIAXZksgiG+W/bQJ6AaooduT6N3lsJZiO2+BsNqk
         tkJqLRvDuGYMdiCDBtBEjgqcuLC4ayDkXNnhIZaw=
Message-ID: <1577148654.29997.29.camel@HansenPartnership.com>
Subject: Re: [RFC 0/9] Add persistent durable identifier to storage log
 messages
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tony Asleson <tasleson@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 23 Dec 2019 16:50:54 -0800
In-Reply-To: <20191223225558.19242-1-tasleson@redhat.com>
References: <20191223225558.19242-1-tasleson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-12-23 at 16:55 -0600, Tony Asleson wrote:
> Today users have no easy way to correlate kernel log messages for
> storage devices across reboots, device dynamic add/remove, or when
> the device is physically or logically moved from from system to
> system.  This is due to the existing log IDs which identify how the
> device is attached and not a unique ID of what is
> attached.  Additionally, even when the attachment hasn't changed,
> it's not always obvious which messages belong to the device as the
> different areas in the storage stack use different identifiers, eg.
> (sda, sata1.00, sd 0:0:0:0).
> 
> This change addresses this by adding a unique ID to each log
> message.  It couples the existing structured key/value logging
> capability and VPD 0x83 device identification.

I understand why, and using the best VPD identifier we have seems fine.
 However, we're trying to dump printk in favour of dev_printk and its
ilk, so resurrecting printk_emit instead of using dev_printk_emit looks
a bit retrograde.  It does seem that ata_dev_printk should really be
using dev_printk ... not sure about the block case.

You also have a couple of items which could be shorter, but I'll reply
to the individual patches.

James



