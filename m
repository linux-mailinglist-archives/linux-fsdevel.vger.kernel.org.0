Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393B32C4873
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 20:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgKYTcw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 14:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728661AbgKYTcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606332770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2OmJMqccrYipc5YlyjAqjjjE2k4YgF45uxCd/ALBWJw=;
        b=bT0M/uyqT+JKPaprAt71aewN7cPZWUQbXRDc3Yr9oqkMjj+pALtkKvieaB9PzAssFCzh9b
        Ua2XopKTDTWBmU9X+oB2tBb+ufAVGWxn/Uav6fkYutK9WJ+FH+c2yL+NnhwAMf7qptFttE
        0qXCnj8BSsocqc2i14acCURc5K/kHuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-gbp_SDrxMeiC9AYr7l2ygw-1; Wed, 25 Nov 2020 14:32:48 -0500
X-MC-Unique: gbp_SDrxMeiC9AYr7l2ygw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7BD956C60;
        Wed, 25 Nov 2020 19:32:46 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02C455D6AC;
        Wed, 25 Nov 2020 19:32:45 +0000 (UTC)
Subject: Re: UAPI value collision: STATX_ATTR_MOUNT_ROOT vs STATX_ATTR_DAX
To:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1927370.1606323014@warthog.procyon.org.uk>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <fdf89cef-1350-e387-4d59-e6951255dbf0@redhat.com>
Date:   Wed, 25 Nov 2020 13:32:45 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1927370.1606323014@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/25/20 10:50 AM, David Howells wrote:
> Hi Linus, Miklos, Ira,
> 
> It seems that two patches that got merged in the 5.8 merge window collided and
> no one noticed until now:
> 
> 80340fe3605c0 (Miklos Szeredi     2020-05-14 184) #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
> ...
> 712b2698e4c02 (Ira Weiny          2020-04-30 186) #define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
> 
> The question is, what do we do about it?  Renumber one or both of the
> constants?
> 
> David

Related to this, nothing sets STATX_ATTR_DAX into statx->attributes_mask,
anywhere in the kernel.

The flag is set into statx->attributes in vfs_getattr_nosec(), but that
does not know whether the particular filesystem under query supports dax
or not.

This is related to my other email about exactly what attributes_mask
means, so should STATX_ATTR_DAX be set in statx->attributes_mask only
in the filesystems that support dax?

(And should that be done only if CONFIG_DAX is turned on, etc?)

-Eric

