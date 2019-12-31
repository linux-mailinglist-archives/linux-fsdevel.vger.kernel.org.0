Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D6112DC35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 23:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLaWyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 17:54:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42026 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727054AbfLaWyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 17:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577832863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slmh9bW+4V4Ot0eIs6GceXv6tZVqhiaH5L3lUPXogb8=;
        b=bSPsof3VSiUSFHQmxeZt0xAae4y6bViTyy5n0iQq8PnxKt9Ddv3qjo1JhySAc80hgGU+bo
        n1ERcTuqe6kzNfc1gv8ffFFfxdAEnBGBstGRgHhOI7L3Skqhy0OVQxTeEYBDy8XxjivkZH
        fbzealJX2YtZYmBhLcOMsFHVht+zBSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-NwmcAXVlPQSfYh0kDQn1ZQ-1; Tue, 31 Dec 2019 17:54:22 -0500
X-MC-Unique: NwmcAXVlPQSfYh0kDQn1ZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AE21107ACC5;
        Tue, 31 Dec 2019 22:54:20 +0000 (UTC)
Received: from [127.0.0.1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8863960579;
        Tue, 31 Dec 2019 22:54:19 +0000 (UTC)
Subject: Re: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191228143651.bjb4sjirn2q3xup4@pali>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <517472d1-c686-2f18-4e0b-000cda7e88c7@redhat.com>
Date:   Tue, 31 Dec 2019 16:54:18 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191228143651.bjb4sjirn2q3xup4@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/28/19 6:36 AM, Pali Roh=C3=A1r wrote:
> Hello!
>=20
> I see that you have introduced in commit 62750d0 two new IOCTLs for
> filesyetems: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL.
>=20
> I would like to ask, are these two new ioctls mean to be generic way fo=
r
> userspace to get or set fs label independently of which filesystem is
> used? Or are they only for btrfs?

The reason it was lifted out of btrfs to the vfs is so that other filesys=
tems
can use the same interface.  However, it is up to each filesystem to impl=
ement
it (and to interpret what's been written to or read from disk.)

> Because I was not able to find any documentation for it, what is format
> of passed buffer... null-term string? fixed-length? and in which
> encoding? utf-8? latin1? utf-16? or filesystem dependent?

It simply copies the bits from the memory location you pass in, it knows
nothing of encodings.

For the most part it's up to the filesystem's own utilities to do any
interpretation of the resulting bits on disk, null-terminating maximal-le=
ngth
label strings, etc.

-Eric

