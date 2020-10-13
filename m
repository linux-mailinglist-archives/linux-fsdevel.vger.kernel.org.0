Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF728C58A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 02:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgJMAJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 20:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbgJMAJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 20:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602547741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAP1T1JAnG2HJETBGKHtI+zO8NC5NvDJAklkJA95KlI=;
        b=RkaHlUGRt6n4mr7sB4+32VnILxdwUrixAQkcZIBSOwaMwNFsmySWDPgFeno34DY2i5TI6Q
        XRsbj/96gLYSuQoVCp3FFyQ5R8AcpCN8lYzF/elRn2anoxu9X2LDG4eP+axyrILEotWfzI
        idrwNNICQfVKE+JbraQgWw+btVsYIJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-XEu3x5wSOryDNKrHD3xpGA-1; Mon, 12 Oct 2020 20:08:59 -0400
X-MC-Unique: XEu3x5wSOryDNKrHD3xpGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4CE71018F63;
        Tue, 13 Oct 2020 00:08:57 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B0B65C269;
        Tue, 13 Oct 2020 00:08:56 +0000 (UTC)
Subject: Re: [PATCH v3 RESEND] fcntl: Add 32bit filesystem mode
To:     Linus Walleij <linus.walleij@linaro.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Peter Maydell <peter.maydell@linaro.org>,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20201012220620.124408-1-linus.walleij@linaro.org>
From:   Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e395753a-115c-57d1-4312-b28e5f0d6ebf@redhat.com>
Date:   Mon, 12 Oct 2020 19:08:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012220620.124408-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/12/20 5:06 PM, Linus Walleij wrote:
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
> 
> This adds a flag to the fcntl() F_GETFD and F_SETFD operations
> to set the underlying filesystem into 32bit mode even if the
> file handle was opened using 64bit mode without the compat
> syscalls.
> 
> Programs that need the 32 bit file system behavior need to
> issue a fcntl() system call such as in this example:
> 
>    #define FD_32BIT_MODE 2
> 
>    int main(int argc, char** argv) {
>      DIR* dir;
>      int err;
>      int fd;
> 
>      dir = opendir("/boot");
>      fd = dirfd(dir);
>      err = fcntl(fd, F_SETFD, FD_32BIT_MODE);

This is a blind set, and wipes out FD_CLOEXEC. Better would be to do a 
proper demonstration of the read-modify-write with F_GETFD that portable 
programs will have to use in practice.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

