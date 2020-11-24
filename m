Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9352C2ECF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 18:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403891AbgKXRiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 12:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgKXRiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:38:23 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15138C0613D6;
        Tue, 24 Nov 2020 09:38:23 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q22so21500261qkq.6;
        Tue, 24 Nov 2020 09:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m2ZvAloMQE/4x6qZGlu4klEd6I1OFmrdg9L02bbThZY=;
        b=mQ/2SdU+idAG7rNq1qMaVxb9CR+RcWt1BHKTZWsDVy8fWCHqwJhHCvkgRkFmG5gG6l
         63dI7pIc19199ylq2PWs338wpUAaIlVHv4bO05m/1Tk1mu08D8CqxB2E3PYFAkryMgfE
         H/1POZOqIABmkG6petf6pD/3aOMnkDRssdWhk0UsaRx2ckUhxiT3bRltu9ZmDeO6w6xs
         euBOjZvBw84KJ31lUkNXglzMy/nzFsEPPBt7GRVCqAEkecyLnn3pxEkW/JpPGKSWAdFb
         ar0JpCcxfg2HCjARPmkDqdzRoKlh3PeHrwbTzFIOvsccSM84XNZBR0TOpFWESYxO6GeG
         MgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=m2ZvAloMQE/4x6qZGlu4klEd6I1OFmrdg9L02bbThZY=;
        b=RSPG6Xu6ca7BZ2H6f5G/+Mbl7J29tF+//+O111y0wbvfZzCC0P1eDjlPPbntfN997b
         wOP7C+szPaTxcMIkY0sSwEFVdxbNTQGts1Lv99wOkNGYySI0Dw8lmqPO73bB2M95heM1
         lOV0+xumu6Tenfc0/JXIGxQU0z8dR/7Pwq7s9+7CHcicdY3qXR4yUP9g/Fr59lBFA/d1
         bTW72H4S8rmRDrYQ4o74txdKRAWVviW7S1Rm/aulKF36YAd2tqYAQP0dsToz0z3XUaI8
         xBqHk1q25F20x2dau10b05rOZBIhl+xsFl1arkGydGnWbKEghbM706ueoqxTkEZIR0Qz
         tTQw==
X-Gm-Message-State: AOAM533c4LfOX5jTEYJdnvNhLW/A00sm/3hJrdOAwqJ0EyMqiZpOxgEa
        gaAVAe5BgdDFeIbhlnGwfWw=
X-Google-Smtp-Source: ABdhPJydGVRMFQ1+r3+Z46PpDtXJ8+bSnv4nPK+7aFRRl1d4ZdhaX+JqGpjWBGRDvXsi5fkaK49s7A==
X-Received: by 2002:ae9:e80d:: with SMTP id a13mr6004436qkg.140.1606239502291;
        Tue, 24 Nov 2020 09:38:22 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id x21sm13062842qkx.31.2020.11.24.09.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:38:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 12:37:58 -0500
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
Subject: Re: [PATCH 15/45] block: use put_device in put_disk
Message-ID: <X71E9mG4sw2WiIEj@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-16-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:21PM +0100, Christoph Hellwig wrote:
> Use put_device to put the device instead of poking into the internals
> and using kobject_put.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
