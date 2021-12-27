Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0947F9AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 02:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhL0BqL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 20:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234936AbhL0BqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 20:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640569570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EP0DZntuIs2zJtRh06L63X/Ovho8Wrnvc0Bdbp3iNls=;
        b=QHOmJfhIZfol+8qcCvrKZjIIUwVLY2UqwF6gxYWVc/nwW9TFZXg7eVkR9aNUfq432Ijx7P
        kUOoUQ1SXCxjy6GZUdCrBVqEx710VA12+UVFRYznNOAWkwqzYFZOfny1zE6wSIuIbmIZDW
        v3LNBKt+hHGH+hznzWtzw2MYfjfK/hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-Uk4TCJ8XNeOZr6PFhd7-cw-1; Sun, 26 Dec 2021 20:46:04 -0500
X-MC-Unique: Uk4TCJ8XNeOZr6PFhd7-cw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C69821006AA4;
        Mon, 27 Dec 2021 01:46:01 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-8.pek2.redhat.com [10.72.13.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7DCD45D8E;
        Mon, 27 Dec 2021 01:45:54 +0000 (UTC)
Date:   Mon, 27 Dec 2021 09:45:51 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net,
        kexec@lists.infradead.org
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on
 kdump
Message-ID: <Yckaz79zg5HdEgcH@dhcp-128-65.nay.redhat.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com>
 <YcMPzs6t8MKpEacq@dhcp-128-65.nay.redhat.com>
 <2d24ea70-e315-beb5-0028-683880c438be@igalia.com>
 <YcUj0EJvQt77OVs2@dhcp-128-65.nay.redhat.com>
 <5b817a4f-0bba-7d79-8aab-33c58e922293@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b817a4f-0bba-7d79-8aab-33c58e922293@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/25/21 at 04:21pm, Guilherme G. Piccoli wrote:
> On 23/12/2021 22:35, Dave Young wrote:
> > Hi Guilherme,
> > [...]
> > If only the doc update, I think it is fine to be another follup-up
> > patch.
> > 
> > About your 1st option in patch log, there is crash_kexec_post_notifiers
> > kernel param which can be used to switch on panic notifiers before kdump
> > bootup.   Another way probably you can try to move panic print to be
> > panic notifier. Have this been discussed before? 
> > 
> 
> Hey Dave, thanks for the suggestion. I've considered that but didn't
> like the idea. My reasoning was: allowing post notifiers on kdump will
> highly compromise the reliability, whereas the panic_print is a solo
> option, and not very invasive.
> 
> To mix it with all panic notifiers would just increase a lot the risk of
> a kdump failure. Put in other words: if I'm a kdump user and in order to
> have this panic_print setting I'd also need to enable post notifiers,
> certainly I'll not use the feature, 'cause I don't wanna risk kdump too
> much.

Hi Guilherme, yes, I have the same concern.  But there could be more
things like the panic_print in the future, it looks odd to have more
kernel cmdline params though.

> 
> One other option I've considered however, and I'd appreciate your
> opinion here, would be a new option on crash_kexec_post_notifiers that
> allows the users to select *which few notifiers* they want to enable.
> Currently it's all or nothing, and this approach is too heavy/risky I
> believe. Allowing customization on which post notifiers the user wants
> would be much better and in this case, having a post notifier for
> panic_print makes a lot of sense. What do you think?

It is definitely a good idea, I'm more than glad to see this if you
would like to work on this! 

> 
> Thanks!
> 

Thanks
Dave

