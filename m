Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A34A28D537
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 22:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbgJMULA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 16:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727778AbgJMUK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602619858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4AsuAeW43yYH580MNgHZBroKVMxw341h9un2tF2+5Y=;
        b=d379uYVbC97GdyuqQJiUCLJHlEt5Y+/77TbviqF53BC1h3gSv2N5lpVK9szrp6LQeU2gkx
        ohcBFWSYCXWVoOu6zt0VWw9i7oGT9D5j2y5kS217DTFmuY4ruVQcqFMeXZXUGkj38Z1YTH
        7OmRuMbkWnBHtpESB8Td5moIGF9p8Ow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-7qAJ9brcNluHxBWpjaV3Tw-1; Tue, 13 Oct 2020 16:10:53 -0400
X-MC-Unique: 7qAJ9brcNluHxBWpjaV3Tw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 663FA1015CAE;
        Tue, 13 Oct 2020 20:10:52 +0000 (UTC)
Received: from ovpn-118-16.rdu2.redhat.com (ovpn-118-16.rdu2.redhat.com [10.10.118.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05FCB10013C4;
        Tue, 13 Oct 2020 20:10:45 +0000 (UTC)
Message-ID: <0e2424983d6772f24374c9f3b06295bed8327b96.camel@redhat.com>
Subject: Re: Unbreakable loop in fuse_fill_write_pages()
From:   Qian Cai <cai@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Date:   Tue, 13 Oct 2020 16:10:45 -0400
In-Reply-To: <20201013195719.GD142988@redhat.com>
References: <7d350903c2aa8f318f8441eaffafe10b7796d17b.camel@redhat.com>
         <20201013184026.GC142988@redhat.com> <20201013185808.GA164772@redhat.com>
         <d14f6a08b4ada85289e70cbb34726fd084ccac05.camel@redhat.com>
         <20201013195719.GD142988@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-10-13 at 15:57 -0400, Vivek Goyal wrote:
> Hmm..., So how do I reproduce it. Just run trinity as root and it will
> reproduce after some time?

Only need to run it as unprivileged user after mounting virtiofs on /tmp
(trinity will need to create and use files there) as many as CPUs as possible.
Also, make sure your guest's memory usage does not exceed the host's /dev/shm
size. Otherwise, horrible things could happen.

$ trinity -C 48 --arch 64

It might get coredump or exit due to some other unrelated reasons, so just keep
retrying. It is best to apply your recent patch for the virtiofs false positive
warning first, so it won't taint the kernel which will stop the trinity. Today,
I had been able to reproduce it twice within half-hour each.



