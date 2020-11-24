Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055C62C2EC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 18:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403868AbgKXRht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 12:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390613AbgKXRhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:37:48 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48784C0613D6;
        Tue, 24 Nov 2020 09:37:48 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so21555405qkf.0;
        Tue, 24 Nov 2020 09:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wOTAYzxGcPu7PN/+w1SzvPIVnfCkyOLysxq7PCKNFLc=;
        b=S5nEHa589iEpXYy2XcA6lRL7T7kP7ehDm9Bouqy1TnodFVSNw+U8eEGfZTJYqfio3r
         aIIXt6yzwSLgwAXuhqGZj4J0YKEc8mQF148TodMgN6CoPRzSm84R92521SCDHI4hoxuk
         PrhKXiEWiiWgA90gCoz9PIlh8ZPWrsLSXPz4r2Y++1aYQUvVlK+d6BRd/FHjM9xPm2Hs
         6bb0egK3xiad8BkBdBGUWpDfzh4paEIzt947869TGDizd9+eyC5CHgWZWOK8SY4CO5vu
         4gCZeAvqJwOZ5TwMcQFDDPh62cYWKSsPb62iSf4+2HH9Z1OX9VZ9xWj9lq9Oe9yG0Mbo
         CB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wOTAYzxGcPu7PN/+w1SzvPIVnfCkyOLysxq7PCKNFLc=;
        b=TqZYeZPHaEhbXPbpYQyJqoq5bF8q/inTAIB+k7V9wq+nHQ4pwpP6gKWHWkjgv3ISb1
         hU1ToBEWNNqaSlHfNlrWPMnLnJcFp6WPrG78TKLSCZe0Cv14GfyGDYxDU2YHi/fY2TU1
         HrUkmwtyNM1YdxIJ/nXozsykV0824qMUqDA2EO0vWTlGuWFmFcq+odsx8RM7/L8umEhX
         ELrEwtzFpX3GQIVMRqciZPG9/7vyWIZdPKCltBnvyJo+IL7wKFRzMtqkdbOIkAuf4tmu
         5v4DXwbZOLPxgxmFbSJ4LZmCpK7scfTcVrn+dNGEu5yIE/k0llpyoM2w8npr9WP0YAkN
         GweA==
X-Gm-Message-State: AOAM5322ps+eibgsuQUPYbGhiQn70k/FcDm7M2Cv3KMFYcZPFRBZWcKT
        aAQxdEjtFLxEhYJ1bD365ms=
X-Google-Smtp-Source: ABdhPJyBD8adSd77vYvAq958zJMB+ltr44tGztKokoaCAzhoNqA4YXMUBiY2USQm4Mo3NyM012Iq6w==
X-Received: by 2002:a05:620a:11a4:: with SMTP id c4mr6030355qkk.8.1606239467443;
        Tue, 24 Nov 2020 09:37:47 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id s3sm13993894qtd.49.2020.11.24.09.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:37:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 12:37:23 -0500
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
Subject: Re: [PATCH 13/45] block: add a bdev_kobj helper
Message-ID: <X71E05jyb3JdxRti@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-14-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:19PM +0100, Christoph Hellwig wrote:
> Add a little helper to find the kobject for a struct block_device.

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
