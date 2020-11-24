Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48882C314D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 20:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgKXTrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 14:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgKXTrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:47:12 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E715C0613D6;
        Tue, 24 Nov 2020 11:47:12 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id v143so50574qkb.2;
        Tue, 24 Nov 2020 11:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V2TOjLdoUaYrySYqHg0oeA6ickZUCz64YonJi1MX7zw=;
        b=jOV4zvc5ykqwIR5EZxEdhoTt8gbdvwT6+6X/TSUVT/z8HYM0C2tjvbbgLMctpzeJXh
         RGgnK/f6uWChM4BxAbOX4p18Fwq1/chEXov7aPAYOwuKTjdA655sPluEae6103/B37UZ
         mtHW9DvASGebX6RreWH7qhpVzv5BxklJgKQSxfx5joha57iIHUUTiDQJHNfLS9atfGSt
         ExNgjoQWPu/xgn5sRgfmq3jVVaBwbHob8XGT+JoMXjhTpfpEBrU2/+S555WpdkNVIh4j
         Jpy0MqgRWGJT79DbBEN/JVT9ea84He6RSeOcPWGIlVmK+xMy8dzyAD0z3NQbnkk9QV/T
         mQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=V2TOjLdoUaYrySYqHg0oeA6ickZUCz64YonJi1MX7zw=;
        b=YRvY7c2xKSnJV3yvYWiG08+v/DQ2nGoyc/2LGn2yAXfQgvGcXBfVhQMBmb3zE126uK
         OLjhKXOZITyqdTo5Gcy+54QehkGnPv4L0f29+vY3DcjSNPO45cNVK496RWvaZQjaL0YZ
         2MYx2Eug6R8+AL9QZVcFc/FU9T0Q4veUpw7i8W3+NwysgxTfhcUjv89Tk9zrqqr7wRmY
         lqyx2ULkovbXTk3gX4j9G9N8PCaeqsa2HtrdBipfrdTueXzPwRS745nxuG/1/dOq9luo
         mifyXdkb2ILiafoajQXgxRy5QviOJIVhy+IMXu0xr86WAQ4i8XXUoOpZpBpbks9KSESM
         si8A==
X-Gm-Message-State: AOAM530x4TWl6ZSFlbDmjo2ZU3HLerQ+An25XMWD3HRZWIfyww5wGlWS
        p7via9J4dEBPHwdj+V89fg8=
X-Google-Smtp-Source: ABdhPJzCbEzsnsSHZbAP8aBMoagyKuXkYbNxYHgU470rrYkN9D5aTPe0QJyzDBb8iwv2DZpxdq68Ww==
X-Received: by 2002:a37:6cd:: with SMTP id 196mr3775536qkg.96.1606247231211;
        Tue, 24 Nov 2020 11:47:11 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id 137sm123792qkj.109.2020.11.24.11.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:47:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 14:46:47 -0500
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
Subject: Re: [PATCH 24/45] blk-cgroup: stop abusing get_gendisk
Message-ID: <X71jJywIZTSxLoqQ@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-25-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:30PM +0100, Christoph Hellwig wrote:
> Properly open the device instead of relying on deep internals by
> using get_gendisk.  Note that this uses FMODE_NDELAY without either
> FMODE_READ or FMODE_WRITE, which is a special open mode to allow
> for opening without media access, thus avoiding unexpexted interactions
> especially on removable media.

I'm not sure FMODE_NDELAY does that. e.g. sd_open() does media change check
and full revalidation including disk spin up regadless of NDELAY and it's
odd and can lead to nasty surprises to require cgroup configuration updates
to wait for SCSI EH.

Thanks.

-- 
tejun
