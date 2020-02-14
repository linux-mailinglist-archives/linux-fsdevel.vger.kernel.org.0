Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F47B15FA0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 23:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgBNW6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 17:58:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46138 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727620AbgBNW6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581721097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OWliOsRxIKNiFNho4oh4+wts83SWOyOAOqk9oizakvY=;
        b=EtblxpTrHvZmc8nvRxLyuEXBFdMX5Eq7/AaS94aotBauIfl/jPdZZbafj1E+o2fnwJ7YD0
        TXeA2ecH6gU+/4sqwfVpTdzfYTxbrX/1VdYgw4TpmOhITEnouNWlrLV+qZfYZnGGG4cnZc
        ewM52DNCBztqLkHAQobZNZp+YDCMzLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-Nx6Ov-baMo2qne_n4W3WXg-1; Fri, 14 Feb 2020 17:58:14 -0500
X-MC-Unique: Nx6Ov-baMo2qne_n4W3WXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09D98800D5E;
        Fri, 14 Feb 2020 22:58:12 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E073E90509;
        Fri, 14 Feb 2020 22:58:10 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
References: <x49imke1nj0.fsf@segfault.boston.devel.redhat.com>
        <20200211201718.GF12866@iweiny-DESK2.sc.intel.com>
        <x49sgjf1t7n.fsf@segfault.boston.devel.redhat.com>
        <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
        <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
        <20200213195839.GG6870@magnolia>
        <20200213232923.GC22854@iweiny-DESK2.sc.intel.com>
        <CAPcyv4hkWoC+xCqicH1DWzmU2DcpY0at_A6HaBsrdLbZ6qzWow@mail.gmail.com>
        <20200214200607.GA18593@iweiny-DESK2.sc.intel.com>
        <x4936bcdfso.fsf@segfault.boston.devel.redhat.com>
        <20200214215759.GA20548@iweiny-DESK2.sc.intel.com>
        <x49y2t4bz8t.fsf@segfault.boston.devel.redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 14 Feb 2020 17:58:10 -0500
In-Reply-To: <x49y2t4bz8t.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
        message of "Fri, 14 Feb 2020 17:06:10 -0500")
Message-ID: <x49tv3sbwu5.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Ira,

Jeff Moyer <jmoyer@redhat.com> writes:

> I'll try to get some testing in on this series, now.

This series panics in xfstests generic/013, when run like so:

MKFS_OPTIONS="-m reflink=0" MOUNT_OPTIONS="-o dax" ./check -g auto

I'd dig in further, but it's late on a Friday.  You understand.  :)

Cheers,
Jeff

