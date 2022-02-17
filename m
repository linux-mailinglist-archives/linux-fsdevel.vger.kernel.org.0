Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2F84B9B36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 09:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbiBQIgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 03:36:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiBQIgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:36:50 -0500
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF12B12FA;
        Thu, 17 Feb 2022 00:36:36 -0800 (PST)
Received: by mail-pg1-f175.google.com with SMTP id d16so4391979pgd.9;
        Thu, 17 Feb 2022 00:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c0pu3AOa7Jqr4q26ebNJ4LdMU0x/lC3tR2Tx7zL6lHg=;
        b=pYdZ8fd+OgIvMVaBzVXM9G+pee4dw7B6jav7njzVGG9zRRStaVJtSKu6R3V6LclkfX
         Ndeiic8NjpynUj4xGfFljIXUxiqG1f1MA+k2Zm3yvX7WwZ96JcQZeoIxEMY4F0V7JprR
         TxbOJm6VWNZNzwnJw1xZ+7OhGCZyYjg2aVVv6sFTj1sJ8Sj7WsWoJn8vD2VK0MjAclW8
         WdmS8N/kMfc8JraWQq3KXPpVxDAKtTCuOGxy0xHTom0EVvBVVJy+E7s0lgkAs0LoY7vt
         v9VlWid4k05YYAJSsmO30U6jnxiYHsxrXdpO0gZgo/3mdJfW4+V1mbFPCt7MJ+bQ6pyY
         B/0g==
X-Gm-Message-State: AOAM531wihTeLV5VIkH2SHkaIgRHU566d73F7pAM6I5sc+JlJwWYTP1U
        iwsKYqCQiAYxoTxumUKHy28=
X-Google-Smtp-Source: ABdhPJxBt7Z+O4vFbpVhfGNT3TGbLxz1vmlCiZLvikj1oSVLWqBDGQ3nJ/8d9qgUnXxcV37sMxYLVg==
X-Received: by 2002:a05:6a00:23cd:b0:4e1:7ab2:334c with SMTP id g13-20020a056a0023cd00b004e17ab2334cmr2123595pfc.4.1645086995489;
        Thu, 17 Feb 2022 00:36:35 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
        by smtp.gmail.com with ESMTPSA id g1sm44078801pfu.32.2022.02.17.00.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 00:36:34 -0800 (PST)
Date:   Thu, 17 Feb 2022 00:36:31 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, SelvaKumar S <selvakuma.s1@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] block: make bio_map_kern() non static
Message-ID: <20220217083631.34ii6gqdrknrmufv@garbanzo>
References: <20220214080002.18381-1-nj.shetty@samsung.com>
 <CGME20220214080558epcas5p17c1fb3b659b956908ff7215a61bcc0c9@epcas5p1.samsung.com>
 <20220214080002.18381-2-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214080002.18381-2-nj.shetty@samsung.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 14, 2022 at 01:29:51PM +0530, Nitesh Shetty wrote:
> From: SelvaKumar S <selvakuma.s1@samsung.com>
> 
> Make bio_map_kern() non static
> 
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>

This patch makes no sense on its own. I'd just merge it with
its first user.

  Luis
