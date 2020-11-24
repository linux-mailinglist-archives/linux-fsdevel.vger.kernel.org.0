Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE842C2EE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 18:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403940AbgKXRi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 12:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403935AbgKXRi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:38:58 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08E5C0613D6;
        Tue, 24 Nov 2020 09:38:57 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id dm12so98419qvb.3;
        Tue, 24 Nov 2020 09:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Km12pVmBeWPgkRcOQAU5l84XavjRPJ4jqz28aKaNPFE=;
        b=qMRMh73o0YdpLAudiX8NPmCDY1bWM9OqQpg0RgHiyT+mlhnf0MZE5Czy8Qf5TqqFXj
         rj0mrD0ci08BBaP1QvOdQSlNYqt4OJVZLsc2rhNHZGmlnQEUH2P7sLZGRMA7ZcG7MS17
         yG8VIyxJ1lw+SyIO+IffHqOfCRSVn1pBmEJnkOVku1COq8LlNZb39TrX/RGHB52cYbib
         i+ykMchrdGixNcqG6wF1woJvO40gLVLsETP5ex6q4w5pbpO9xSAgvvJXfB6Yw0WWCqLF
         nDEPDCAPTAHfrqXDPn19OFx798DWMB961lVkvHrRd6Il2RPmsuogUvJSPGip8MEuWX9g
         QyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Km12pVmBeWPgkRcOQAU5l84XavjRPJ4jqz28aKaNPFE=;
        b=l8VPCr0KYe/YqEMyumZI3dcVdHg9IHSvZ507PFJ+azYKaRib/icTOoQ7e/xs2w9LcQ
         O+v0n6D06phzafHhIRCG0BWoX4Dec8iwWN78FmVj+dobyaCKdAYkpHFUMTYjLkHm4pPk
         zWN4kOLf8sfxTcT9Ci5KCsj1d0zEmla8pHRpkDcohxjgMFQEyBYdvBezVwKorBYZsGzf
         22ge8u/PaE1QsjyuI6K94n2a4qJgLSkhbkEjYcDDcMM+V3FTMygGBz14PzOnpKchdSUp
         EugErCxpPaFJLVAPoZv1npC3k/P1B2Yk+Pnfn1HQrMBYbAu2qIpg7evv1C9c5eeOcec+
         38Vw==
X-Gm-Message-State: AOAM533InNgaosGEoxEgNqIvFJFuL1a+d9lxtFHEcD3nWykEts1+WdgE
        mroNDg4CzuFsKhZMT30S56w=
X-Google-Smtp-Source: ABdhPJx2viG2YUIcT9pxnUmh9SMKJ+iaGPuLa9sp1d1smXeKSZjMmg4Jo+Hs7YyRPHzhOtS6yXj/uA==
X-Received: by 2002:a0c:f7cc:: with SMTP id f12mr5949753qvo.0.1606239537123;
        Tue, 24 Nov 2020 09:38:57 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id b3sm13138042qte.85.2020.11.24.09.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:38:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 12:38:34 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 17/45] init: refactor name_to_dev_t
Message-ID: <X71FGgQtvXHTHU0V@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-18-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:23PM +0100, Christoph Hellwig wrote:
> Split each case into a self-contained helper, and move the block
> dependent code entirely under the pre-existing #ifdef CONFIG_BLOCK.
> This allows to remove the blk_lookup_devt stub in genhd.h.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
