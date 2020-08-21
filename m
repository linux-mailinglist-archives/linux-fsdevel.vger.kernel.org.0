Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3815824E257
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 22:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHUU7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 16:59:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50050 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726391AbgHUU7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598043588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2gIu98enanjK9EURmzmn9oz+VH6ZwaY11m21RBqMwdg=;
        b=iUL+h6uxNxKm0WXMm0uAbxYLol6tdTCSuQd664ftwhbCNolgTxjcSuZR6IpNk3VkHCivMp
        mzsufByLjhpK3DCuzrIMAHasHicsnXTiqfCF5ptSjoOBGlAxZS0jTDwT34Cz+2jtV9OHRe
        FW9Cf7SgIBv2zA8t/2XnBV4qt37cpI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-gVsj3GnAO2yMKN3MIcpz2A-1; Fri, 21 Aug 2020 16:59:47 -0400
X-MC-Unique: gVsj3GnAO2yMKN3MIcpz2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19C3F425DB;
        Fri, 21 Aug 2020 20:59:46 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-222.rdu2.redhat.com [10.10.114.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E91487E32F;
        Fri, 21 Aug 2020 20:59:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3A50022036A; Fri, 21 Aug 2020 16:59:37 -0400 (EDT)
Date:   Fri, 21 Aug 2020 16:59:37 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [PATCH 4/5] fuse: For sending setattr in case of open(O_TRUNC)
Message-ID: <20200821205937.GC905782@redhat.com>
References: <20200724183812.19573-1-vgoyal@redhat.com>
 <20200724183812.19573-5-vgoyal@redhat.com>
 <CAJfpegu0HKSbY53GBMWSYRYc7NJab+9NAXmfp9ekzU_QCiDCQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu0HKSbY53GBMWSYRYc7NJab+9NAXmfp9ekzU_QCiDCQg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 05:05:16PM +0200, Miklos Szeredi wrote:
> On Fri, Jul 24, 2020 at 8:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > open(O_TRUNC) will not kill suid/sgid on server and fuse_open_in does not
> > have information if caller has CAP_FSETID or not.
> >
> > So force sending setattr() which is called after open(O_TRUNC) so that
> > server clears setuid/setgid.
> 
> I don't really like the fact that we lose atomicity if
> handle_killpriv_v2 is enabled.
> 
> Let's just add a new flag to open as well.  If a filesystem doesn't
> want to add the complexity of handling that it can still just disable
> atomic_o_trunc.

Ok, will look into adding flag to open.

Vivek

