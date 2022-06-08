Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4669C5425E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiFHDta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 23:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbiFHDtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 671AD232340
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 17:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654649863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vPTB/7bKS227d/qHuHLFt/85sZuUpC11PLW3IwyD5sM=;
        b=KfE3Cg+g650gp/xmL4hYUS+AgO9oEwsC2i89Xh7eEoOQDWadQFzw+d9la2A7I/oQtAaBtv
        ZC1ewi0Sal/iXo2+XngImThV7vivksWv+t4DSrXIpFy0mrk0GCzgXN0KEU+eJoBxp3wp4U
        jJUw4/RwnFRnPvpLs+qk9zoPup6auXI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-ctHPKVURO3qn2sO5bj8SKA-1; Tue, 07 Jun 2022 20:57:37 -0400
X-MC-Unique: ctHPKVURO3qn2sO5bj8SKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D8C23C01D82;
        Wed,  8 Jun 2022 00:57:37 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F62C2166B26;
        Wed,  8 Jun 2022 00:57:36 +0000 (UTC)
Date:   Wed, 8 Jun 2022 08:57:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rburanyi@google.com,
        Greg Thelen <gthelen@google.com>, viro@zeniv.linux.org.uk,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] fs/kernel_read_file: Allow to read files up-to
 ssize_t
Message-ID: <Yp/z/f1IUaqS3qbe@MiWiFi-R3L-srv>
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
 <20220527025535.3953665-2-pasha.tatashin@soleen.com>
 <Yp1qO70pdxLx4h1H@MiWiFi-R3L-srv>
 <CA+CK2bACmbW9saepkMy6G5FtssBhCv2NsoLGeFdF0XosKg5A-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bACmbW9saepkMy6G5FtssBhCv2NsoLGeFdF0XosKg5A-g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/07/22 at 11:52am, Pasha Tatashin wrote:
> On Sun, Jun 5, 2022 at 10:45 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 05/27/22 at 02:55am, Pasha Tatashin wrote:
> > > Currently, the maximum file size that is supported is 2G. This may be
> > > too small in some cases. For example, kexec_file_load() system call
> > > loads initramfs. In some netboot cases initramfs can be rather large.
> > >
> > > Allow to use up-to ssize_t bytes. The callers still can limit the
> > > maximum file size via buf_size.
> >
> > If we really met initramfs bigger than 2G, it's reasonable to increase
> > the limit. While wondering why we should take sszie_t, but not size_t.
> 
> ssize_t instead of size_t so we can return errors as negative values.

Makes sense. Thanks.

