Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F375D75F403
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjGXK7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjGXK66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47519FF
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 03:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690196293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F6TumHjbvlMGzO4xVYnJBJFbMI9Ohdrrske9/1R3NiY=;
        b=cev9ycAickBsItKoAGqdT5qlT5o1gneS05xhjvz2H6+FZSQUt89bCKV+pg2K8y/wTQ4+LK
        bAkdgzBRU+79jslFdnFNrxpOQ0XaUIZkfM0W7w2g5IXaRYeeEmVyoYU0YsX0XTWuSvtSMD
        toEgDT4KDkMi+hklOa9Nj/whd4FT6sY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-e7U0xzw8PMuN085D6-7lqA-1; Mon, 24 Jul 2023 06:58:12 -0400
X-MC-Unique: e7U0xzw8PMuN085D6-7lqA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fc07d4c2f4so26155195e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 03:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690196290; x=1690801090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6TumHjbvlMGzO4xVYnJBJFbMI9Ohdrrske9/1R3NiY=;
        b=RwgxJpM464sfRA5QZbF9mh/z7+BQfX7OOHHFJvHLRE9L7v2t6rrjVmDegg8dMjxCjY
         4YvKSI6SZ5JnyHOGYZLCiEJJioK0egFVfG0OyjrPGF2eeSoV/iRK/zcTv+QF4aNf8uaK
         y1iGQpzNeq9yT4+2mdG8xZ5yCmS8WaBYpe2E8sOSMGnlkA7HA5fbN95RpmuKaUR6BTfa
         /BbukktUH95cI2mby4YtUXA9HPzszQBUchIKuh/1386KhyJL80DtVYxkAex1aaCZWO04
         jmMH9Ps8JIkojvK6QcpjA0ipIYyiIzo+8Py4sbDfCvDE4UazKGEsz6SMOt5HBghMuNt0
         Uw4A==
X-Gm-Message-State: ABy/qLYSCw2ICgy/5DUwNgiltSoixiK3i45vjWq8YQC9j3QDgWryCLBW
        PVULVMt6/LRDhUWQ4RK3LA8t7xycGUZQInSKarQ4TrhtOg30Q+0UctB+3NBWxkNBcaGFUCQPhyO
        2EXvjV+XqIxUTMaEVwAOp1Eahj5fth9TF
X-Received: by 2002:a05:600c:2116:b0:3fa:8fb1:50fe with SMTP id u22-20020a05600c211600b003fa8fb150femr7689286wml.15.1690196290620;
        Mon, 24 Jul 2023 03:58:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG3j1Ad2yvF+UnMLXv/6Lw2FRlTF06c6lZtWHJGzEdkPdJIwnZ5I9t8OadERNj+baxM+ax9jQ==
X-Received: by 2002:a05:600c:2116:b0:3fa:8fb1:50fe with SMTP id u22-20020a05600c211600b003fa8fb150femr7689274wml.15.1690196290272;
        Mon, 24 Jul 2023 03:58:10 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bcbcb000000b003fba92fad35sm12576469wmi.26.2023.07.24.03.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:58:09 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:58:08 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] fstests: add helper to canonicalize devices used to
 enable persistent disks
Message-ID: <20230724105808.dxyszzkzcwf7y7od@aalbersh.remote.csb>
References: <20230720061727.2363548-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720061727.2363548-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-07-19 23:17:27, Luis Chamberlain wrote:
> The filesystem configuration file does not allow you to use symlinks to
> devices given the existing sanity checks verify that the target end
> device matches the source.
> 
> Using a symlink is desirable if you want to enable persistent tests
> across reboots. For example you may want to use /dev/disk/by-id/nvme-eui.*
> so to ensure that the same drives are used even after reboot. This
> is very useful if you are testing for example with a virtualized
> environment and are using PCIe passthrough with other qemu NVMe drives
> with one or many NVMe drives.
> 
> To enable support just add a helper to canonicalize devices prior to
> running the tests.
> 
> This allows one test runner, kdevops, which I just extended with
> support to use real NVMe drives. The drives it uses for the filesystem
> configuration optionally is with NVMe eui symlinks so to allow
> the same drives to be used over reboots.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

