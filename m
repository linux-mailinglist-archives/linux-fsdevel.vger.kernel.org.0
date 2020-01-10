Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC570137298
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 17:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgAJQNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 11:13:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42795 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728397AbgAJQNZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578672803;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gbNvw7DusZ3sQwul8iryEZTFdBmNVR9bva3qUdYsY4=;
        b=hpJMIR5F13OCbazDTsOdxkQoKSUeMkiGJDxIgSQDcxhCItCPIOGbwEUWPy6m7hsNWEhvH2
        1PWKyZgHyqCOY2JH2Q2zWfXMgx/ING3mEhmQXSX9GCF7QlnhDXv1HCCRdEalajfOAXsD6l
        e4lPh3KD2NSbTzRSPKmc4TIVWVH2O4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-OBVkk_1dMDibbmxfoD4nWQ-1; Fri, 10 Jan 2020 11:13:22 -0500
X-MC-Unique: OBVkk_1dMDibbmxfoD4nWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12B7A800EBF;
        Fri, 10 Jan 2020 16:13:21 +0000 (UTC)
Received: from [10.3.112.35] (ovpn-112-35.phx2.redhat.com [10.3.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18F177C40A;
        Fri, 10 Jan 2020 16:13:18 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: [RFC 9/9] __xfs_printk: Add durable name to output
To:     Dave Chinner <david@fromorbit.com>,
        Sweet Tea Dorminy <sweettea@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191223225558.19242-1-tasleson@redhat.com>
 <20191223225558.19242-10-tasleson@redhat.com>
 <20200104025620.GC23195@dread.disaster.area>
 <5ad7cf7b-e261-102c-afdc-fa34bed98921@redhat.com>
 <20200106220233.GK23195@dread.disaster.area>
 <CAMeeMh-zr309TzbC3ayKUKRniat+rzurgzmeM5LJYMFVDj7bLA@mail.gmail.com>
 <20200107012353.GO23195@dread.disaster.area>
 <4ce83a0e-13e1-6245-33a3-5c109aec4bf1@redhat.com>
 <20200108021002.GR23195@dread.disaster.area>
 <9e449c65-193c-d69c-1454-b1059221e5dc@redhat.com>
 <20200109014117.GB3809@agk-dp.fab.redhat.com>
From:   Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Cc:     David Lehman <dlehman@redhat.com>
Message-ID: <2e6a3baa-44af-dac0-5e0c-2bf9a4723e72@redhat.com>
Date:   Fri, 10 Jan 2020 10:13:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109014117.GB3809@agk-dp.fab.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/8/20 7:41 PM, Alasdair G Kergon wrote:
> The goal of this particular project is to maintain a record of the
> storage configuration as it changes over time.  It should provide a
> quick way to check the state of a system at a specified time in the
> past.

This helps with one aspect of the problem, it leaves a bread crumb which
states that at this point in time /dev/sda was the attachment point for
some device, eg. wwn-0x5002538844580000.

> The initial logging implementation is triggered by storage uevents and
> consists of two components:
> 
> 1. A new udev rule file, 99-zzz-storage-logger.rules, which runs after
> all the other rules have run and invokes:
> 
> 2. A script, udev_storage_logger.sh, that captures relevant
> information about devices that changed and stores it in the system
> journal.
> 
> The effect is to log the data from relevant uevents plus some
> supplementary information (including device-mapper tables, for example).
> It does not yet handle filesystem-related events.
> 
> Two methods to query the data are offered:
> 
> 1. journalctl
> Data is tagged with the identifier UDEVLOG and retrievable as
> key-value pairs.
>   journalctl -t UDEVLOG --output verbose
>   journalctl -t UDEVLOG --output json
>     --since 'YYYY-MM-DD HH:MM:SS' 
>     --until 'YYYY-MM-DD HH:MM:SS'
>   journalctl -t UDEVLOG --output verbose
>     --output-fields=PERSISTENT_STORAGE_ID,MAJOR,MINOR
>      PERSISTENT_STORAGE_ID=dm-name-vg1-lvol0
> 
> 2. lsblkj  [appended j for journal]
> This lsblk wrapper reprocesses the logged uevents to reconstruct a
> dummy system environment that "looks like" the system did at a
> specified earlier time and then runs lsblk against it.

You've outlined how to view and filter on the added data and how to
figure out what the configuration looked like a some point in the past,
that adds one more piece of the puzzle.

However, how would a user simply show all the log messages for a
specific device over time?  It looks like journalctl would need to have
logic added to make this a seamless user experience, yes?

Perhaps I'm missing something that makes the outlined use case above work?

