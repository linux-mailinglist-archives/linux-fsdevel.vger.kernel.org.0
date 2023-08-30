Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8056078D23C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 04:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbjH3C4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 22:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241792AbjH3C4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1481D110
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 19:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693364113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cXMQxOZw+4RO1BfknY9LPnO6Mr+W9O/v0m+R+BZEjk4=;
        b=KC0fag54pwaMpVCkIBawYnwY0An4rVtWyyaW+aEAHBFMEwThYdohVEw0YEsgw9AG0vgqMc
        tddevdTVkdmHd6Ni5BXJ5RfJ1yjQaayopCTdnEkuB9/ZLzWWyci2uy7HRXHCtZ1tH1cmsW
        t6AHV4ZxHg7dWV9ESt+RComLSrcWrvE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-pIhqRxEdNrabUNBWGOjNmg-1; Tue, 29 Aug 2023 22:55:09 -0400
X-MC-Unique: pIhqRxEdNrabUNBWGOjNmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52796185A791;
        Wed, 30 Aug 2023 02:55:09 +0000 (UTC)
Received: from yoyang-vm.hosts.qa.psi.pek2.redhat.com (yoyang-vm.hosts.qa.psi.pek2.redhat.com [10.73.149.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A5042166B25;
        Wed, 30 Aug 2023 02:55:07 +0000 (UTC)
Date:   Wed, 30 Aug 2023 10:55:03 +0800
From:   Yongcheng Yang <yoyang@redhat.com>
To:     zlang@redhat.com
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH fstests v3 2/2] generic/578: add a check to ensure that
 fiemap is supported
Message-ID: <ZO6vh5+ZLdLSFbB7@yoyang-vm.hosts.qa.psi.pek2.redhat.com>
References: <20230825-fixes-v3-0-6484c098f8e8@kernel.org>
 <20230825-fixes-v3-2-6484c098f8e8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825-fixes-v3-2-6484c098f8e8@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Zorro,

Can we assume all the FIEMAP tests need this check first?
If so, there are some others need the same patch.

I.e.
[yoyang@yoyang-vm xfstests-dev]$ grep url .git/config
        url = git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
[yoyang@yoyang-vm xfstests-dev]$ git pl
Already up to date.
[yoyang@yoyang-vm xfstests-dev]$ git grep _begin_fstest tests/ | grep fiemap | wc -l
101
[yoyang@yoyang-vm xfstests-dev]$ git grep _require_xfs_io_command tests/ | grep fiemap | wc -l
86
[yoyang@yoyang-vm xfstests-dev]$

Best Regards,
Yongcheng

