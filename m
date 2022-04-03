Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E864F06BB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Apr 2022 03:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiDCB1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 21:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiDCB1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 21:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D23A32FA
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Apr 2022 18:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648949129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GkShY0RQCVDzpld9Dx78CpGoYVHJSOJe2lJeCKAVfbs=;
        b=HxtMw8k0XFqhPdDiIQug955PxFVM7wrHp0wrwRMovJnu0tmmSkJ+ksI1znzhkMnVtE7xgE
        +56jK6ranqLXiCfvDoUVORQ79HwUIFBo4mXFtOD+tAFPlJvxrlOeH7QqSsdlcxejlwz8KR
        Noor763F9ifWpMk9ghQs5zPY/cTqk/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-Ow0vpX3IOd-srYzu03thdQ-1; Sat, 02 Apr 2022 21:25:28 -0400
X-MC-Unique: Ow0vpX3IOd-srYzu03thdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3DEA811E75;
        Sun,  3 Apr 2022 01:25:27 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 033DF10EC2;
        Sun,  3 Apr 2022 01:25:25 +0000 (UTC)
Date:   Sun, 3 Apr 2022 09:25:22 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, yangtiezhu@loongson.cn,
        amit.kachhap@arm.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 1/3] vmcore: Convert copy_oldmem_page() to take an
 iov_iter
Message-ID: <Ykj3gsRD7il4KCLW@MiWiFi-R3L-srv>
References: <20220402043008.458679-1-bhe@redhat.com>
 <20220402043008.458679-2-bhe@redhat.com>
 <YkffO7QHuR2vq3gI@MiWiFi-R3L-srv>
 <Ykh3FVUFQH0x11Zw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykh3FVUFQH0x11Zw@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/02/22 at 05:17pm, Matthew Wilcox wrote:
> On Sat, Apr 02, 2022 at 01:29:31PM +0800, Baoquan He wrote:
> > On 04/02/22 at 12:30pm, Baoquan He wrote:
> > 
> > It's odd. I cann't see the content of patches in this series from my
> > mailbox and mail client, but I can see them in lore.kernel.org.
> 
> Yes, Red Hat have screwed up their email server again.  David Hildenbrand
> already filed a ticket, but you should too so they don't think it's
> just him.
> 
> https://lore.kernel.org/linux-mm/6696fb21-090c-37c6-77a7-79423cc9c703@redhat.com/

I see. It could be the same issue. I just filed an internal ticket to
request a fix, thx.

> 
> > https://lore.kernel.org/all/20220402043008.458679-1-bhe@redhat.com/T/#u
> > 
> 

