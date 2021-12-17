Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9920478F95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 16:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbhLQPZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 10:25:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232151AbhLQPZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639754705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FviPWC0h7ykzScWuoPcCgzTa6MtP/DKINNKXLLap8zk=;
        b=Ag9QvgVLBgZqegL9Sv38gc4TaWvN7YPAmfL7hxLKdrZdcSgNAQukg7/47ErWkrdT+pOG8Q
        /QmCWwqREGWljBlu5ieFYmd/ZLJySEX6dSmJjAAdHfLDuVG7/0ehtoy5aCrayBs32ioWVh
        MVsEWI4BbLmN3eqzHdFVLtQU0m4NxSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-fEzM4cmuOTuEpynCYMmRtA-1; Fri, 17 Dec 2021 10:25:02 -0500
X-MC-Unique: fEzM4cmuOTuEpynCYMmRtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66861801B0C;
        Fri, 17 Dec 2021 15:25:01 +0000 (UTC)
Received: from work (unknown [10.40.194.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F3A61037F5E;
        Fri, 17 Dec 2021 15:25:00 +0000 (UTC)
Date:   Fri, 17 Dec 2021 16:24:56 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Problem with data=ordered ext4 mount option in linux-next
Message-ID: <20211217152456.l7b2mbefdkk64fkj@work>
References: <b5817114-8122-cf0e-ca8e-b5d1c9f43bc2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5817114-8122-cf0e-ca8e-b5d1c9f43bc2@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 17, 2021 at 04:11:32PM +0100, Heiner Kallweit wrote:
> On linux-next systemd-remount-fs complains about an invalid mount option
> here, resulting in a r/o root fs. After playing with the mount options
> it turned out that data=ordered causes the problem. linux-next from Dec
> 1st was ok, so it seems to be related to the new mount API patches.
> 
> At a first glance I saw no obvious problem, the following looks good.
> Maybe you have an idea where to look ..
> 
> static const struct constant_table ext4_param_data[] = {
> 	{"journal",	EXT4_MOUNT_JOURNAL_DATA},
> 	{"ordered",	EXT4_MOUNT_ORDERED_DATA},
> 	{"writeback",	EXT4_MOUNT_WRITEBACK_DATA},
> 	{}
> };
> 
> 	fsparam_enum	("data",		Opt_data, ext4_param_data),
> 

Thank you for the report!

The ext4 mount has been reworked to use the new mount api and the work
has been applied to linux-next couple of days ago so I definitelly
assume there is a bug in there that I've missed. I will be looking into
it.

Can you be a little bit more specific about how to reproduce the problem
as well as the error it generates in the logs ? Any other mount options
used simultaneously, non-default file system features, or mount options
stored within the superblock ?

Can you reproduce it outside of the systemd unit, say a script ?

Thanks!
-Lukas

