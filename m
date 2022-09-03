Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939995ABDA7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Sep 2022 09:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiICHUf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 03:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiICHUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 03:20:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EDA474C7
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Sep 2022 00:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662189631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHFFj9vepk7u9EoGJKlFbytlhoGP7nwiP3Wn6nevpP8=;
        b=QdR4vlkLxFy72WQhiXQX5cpc7OwJngfaFXBH40XmWkF0a+d8puw1nAC73crmeIUMMQik40
        T2gWIKyGWDj/Fn9+SukeMSG0+ssSpc3LbL4+sFFPViXk+FByj216qgX8S7Y9eKOGj+cwDZ
        VM8zdtmCZXACtl0ZD4qwMb3/K4PS+1E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-ppu4bCiwMhe62PT5SwKPug-1; Sat, 03 Sep 2022 03:20:28 -0400
X-MC-Unique: ppu4bCiwMhe62PT5SwKPug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BED7811E76;
        Sat,  3 Sep 2022 07:20:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id 33575422E3;
        Sat,  3 Sep 2022 07:20:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat,  3 Sep 2022 09:20:26 +0200 (CEST)
Date:   Sat, 3 Sep 2022 09:20:19 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Will Deacon <will@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Stephen Kitt <steve@sk2.org>, Rob Herring <robh@kernel.org>,
        Joel Savitz <jsavitz@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Renaud =?iso-8859-1?Q?M=E9trich?= <rmetrich@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, Qi Guo <qguo@redhat.com>
Subject: Re: [PATCH] core_pattern: add CPU specifier
Message-ID: <20220903072018.GA15331@redhat.com>
References: <20220903064330.20772-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220903064330.20772-1-oleksandr@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/03, Oleksandr Natalenko wrote:
>
> Statistically, in a large deployment regular segfaults may indicate a CPU issue.
>
> Currently, it is not possible to find out what CPU the segfault happened on.
> There are at least two attempts to improve segfault logging with this regard,
> but they do not help in case the logs rotate.
>
> Hence, lets make sure it is possible to permanently record a CPU
> the task ran on using a new core_pattern specifier.
>
> Suggested-by: Renaud Métrich <rmetrich@redhat.com>
> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 1 +
>  fs/coredump.c                               | 5 +++++
>  include/linux/coredump.h                    | 1 +
>  3 files changed, 7 insertions(+)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

