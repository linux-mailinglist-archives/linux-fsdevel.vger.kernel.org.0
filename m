Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA4848C3EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 13:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbiALM3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 07:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240498AbiALM3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641990559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJjZLA05/EVAnL9glMI370u+RyOka7ubh9bOziaJLmU=;
        b=PMas6BU4e9XCbX6vH/fClw969nSO5csWabhA81FsGl/9yz9qp58WE8iga1boAqqAd1WdBl
        Q/3N3vy7NMxDiQiJyPeo/AjkiutJDL9i/yzC92Z4MKQ7qiqRb9e2za+9sFdMDPK6be726x
        b1GPTZ7hpEdxSWRAl+M2SkJg19MKjXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-s4u3pdpIN4axsi6-rARwNg-1; Wed, 12 Jan 2022 07:29:18 -0500
X-MC-Unique: s4u3pdpIN4axsi6-rARwNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFA29363A5;
        Wed, 12 Jan 2022 12:29:16 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2C1E708C9;
        Wed, 12 Jan 2022 12:29:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 20CCTCNb027823;
        Wed, 12 Jan 2022 07:29:12 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 20CCTB7j027819;
        Wed, 12 Jan 2022 07:29:11 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 12 Jan 2022 07:29:11 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Hugh Dickins <hughd@google.com>
cc:     Lukas Czerner <lczerner@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: unusual behavior of loop dev with backing file in tmpfs
In-Reply-To: <5e66a9-4739-80d9-5bb5-cbe2c8fef36@google.com>
Message-ID: <alpine.LRH.2.02.2201120725500.27581@file01.intranet.prod.int.rdu2.redhat.com>
References: <20211126075100.gd64odg2bcptiqeb@work> <5e66a9-4739-80d9-5bb5-cbe2c8fef36@google.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 11 Jan 2022, Hugh Dickins wrote:

> But what is asynchronously reading /dev/loop0 (instantiating pages
> initially, and reinstantiating them after blkdiscard)? I assume it's
> some block device tracker, trying to read capacity and/or partition
> table; whether from inside or outside the kernel, I expect you'll
> guess much better than I can.
> 
> Hugh

That's udev. It reads filesystem signature on every block device, so that 
it can create symlinks in /dev/disk/by-uuid.

If you open the block device for write and close it, udev will re-scan it.

Mikulas

