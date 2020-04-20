Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850F91B0FEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 17:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgDTPYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 11:24:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39945 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726385AbgDTPYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587396246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8ey1M/uqJZkOtKQsKP7oHVU1isoUNVylcTf7jiJ2so=;
        b=PKw/ZR98T8aAgf06kkFnNwRb0mJAWs3374H8+mg+imo9wxNRqFrvjFkx5dbYw1aFjM1SsB
        3lW5290kER7tXkf/HPf0Shmy4dF+iPe6DtsbtG/O69qcIAxh4SI3OaHnRdj4FbHMfNRXA7
        1/jFRfK2EQ2UyhsWkCnduiVKs84idzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-MHXz6fomNpKIbV05wZeu1A-1; Mon, 20 Apr 2020 11:23:51 -0400
X-MC-Unique: MHXz6fomNpKIbV05wZeu1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 697AD149C5;
        Mon, 20 Apr 2020 15:23:49 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79012129F8E;
        Mon, 20 Apr 2020 15:23:47 +0000 (UTC)
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Peter Maydell <peter.maydell@linaro.org>,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Florian Weimer <fw@deneb.enyo.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andy Lutomirski <luto@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <20200420151344.GC1080594@mit.edu>
From:   Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d3fb73a3-ecf6-6371-783f-24a94eb66c59@redhat.com>
Date:   Mon, 20 Apr 2020 10:23:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420151344.GC1080594@mit.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/20/20 10:13 AM, Theodore Y. Ts'o wrote:
> On Tue, Mar 31, 2020 at 03:35:36PM +0200, Linus Walleij wrote:
>> It was brought to my attention that this bug from 2018 was
>> still unresolved: 32 bit emulators like QEMU were given
>> 64 bit hashes when running 32 bit emulation on 64 bit systems.
>>
>> This adds a fcntl() operation to set the underlying filesystem
>> into 32bit mode even if the file hanle was opened using 64bit
>> mode without the compat syscalls.
> 
> s/hanle/handle/
> 
> The API that you've proposed as a way to set the 32-bit mode, but
> there is no way to clear the 32-bit mode, nor there is a way to get
> the current status mode.
> 
> My suggestion is to add a flag bit for F_GETFD and F_SETFD (set and
> get file descriptor flags).  Currently the only file descriptor flag
> is FD_CLOEXEC, so why not add a FD_32BIT_MODE bit?

Also, POSIX is proposing standardizing FD_CLOFORK, which would be 
another file descriptor flag worth considering in Linux (Solaris and BSD 
already have it):

https://www.austingroupbugs.net/view.php?id=1318

It will be interesting to find how much code (wrongly) assumes it can 
use a blind assignment of fcntl(fd, F_SETFD, 1) and thereby accidentally 
wipes out other existing flags, when it should have instead been doing a 
read-modify-write to protect flags other than FD_CLOEXEC.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

