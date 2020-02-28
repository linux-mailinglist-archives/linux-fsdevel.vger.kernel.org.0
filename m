Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412DB173C18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgB1PrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:47:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33182 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727124AbgB1PrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582904839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M5VyH6QG78kcYA9fsol/765vHxQ9ZwPBQuyaapR5VWs=;
        b=JVg/n2sIcC4IqXWiBfR9uLTCNULrI0+Vf20qfHIfrCtL3fW2OEOBMWhc6bOWE5LDSKCCXB
        a8f90gbhO4svQ3rEoEG7xByaAafSkxniwCLU8J4+9klQG/0dujCsEWEkrxXAUNV5JN09FC
        qs0A97rdAzw9XYPhhJLWGVz0byOIS/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-mQ_0rQDoOnSMA1s8I2K5_w-1; Fri, 28 Feb 2020 10:47:14 -0500
X-MC-Unique: mQ_0rQDoOnSMA1s8I2K5_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51DB4107ACC5;
        Fri, 28 Feb 2020 15:47:12 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-107.rdu2.redhat.com [10.10.123.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C300390793;
        Fri, 28 Feb 2020 15:47:08 +0000 (UTC)
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
To:     Dave Chinner <david@fromorbit.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Sandeen <sandeen@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200227083029.GL10737@dread.disaster.area>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e9625cae-ee3f-3e58-903d-dabc131c8c9b@redhat.com>
Date:   Fri, 28 Feb 2020 10:47:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200227083029.GL10737@dread.disaster.area>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/27/20 3:30 AM, Dave Chinner wrote:
> On Wed, Feb 26, 2020 at 11:13:53AM -0500, Waiman Long wrote:
>> As there is no limit for negative dentries, it is possible that a sizeable
>> portion of system memory can be tied up in dentry cache slabs. Dentry slabs
>> are generally recalimable if the dentries are in the LRUs. Still having
>> too much memory used up by dentries can be problematic:
> I don't get it.
>
> Why isn't the solution simply "constrain the application generating
> unbound numbers of dentries to a memcg"?
>
> Then when the memcg runs out of memory, it will start reclaiming the
> dentries that were allocated inside the memcg that are using all
> it's resources, thereby preventing unbound growth of the dentry
> cache.
>
> I mean, this sort of resource control is exactly what memcgs are
> supposed to be used for and are already used for. I don't see why we
> need all this complexity for global dentry resource management when
> memcgs should already provide an effective means of managing and
> placing bounds on the amount of memory any specific application can
> use...

Using memcg is one way to limit the damage. The argument that excessive
negative dentries can push out existing memory objects that can be more
useful if left alone still applies. Daemons that run in the root memcg
has no limitation on how much memory that they can use.

There can also be memcgs with high memory limits and long running
applications. memcg is certainly a useful tool in this regards, but it
doesn't solve all the problem.

Cheers,
Longman


