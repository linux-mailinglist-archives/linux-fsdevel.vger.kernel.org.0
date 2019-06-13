Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F0843870
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbfFMPFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:05:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46783 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732432AbfFMOMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:12:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so22648411qtn.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GDhqdSFdNrJkUzLZKLANjMrDzCWc+1BFxgZR9EoSJWc=;
        b=o9ysYyAYYAkKDCEjOpEcA8dHcyUIgiishqyzWE+RGyB0CPD0qX9BMV8V2Ph7rpuhQ2
         K8NR9n3H2e8PDC40efcl/XPNsZvrJzaA26yNoknpyzgEflgHS0LCRUJZDIxSiwaskZOx
         wVtjRQyVJFXdvVLENdH2e5X3E+kNGZusxml91Hhgrxkdi0137ew7YVLbQca3LK9zF88/
         ajD2LpyQ70yJdzGRaInaMTvnMegeomU9tWJ7wrO/cd9dwWrkG3s41kbgxjMsoVvaBYhS
         JdQZnPb7pa+AfGg8+n8JdN/2O+vKRsl7thrK0YyHBoE/x0JUOpZD1nFq32wrn+4+Pmlh
         8wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDhqdSFdNrJkUzLZKLANjMrDzCWc+1BFxgZR9EoSJWc=;
        b=XanSfCrhbPhtdx6fb5MXFAvAiUMFC8C7HNr0Wcz03PD55F4IJcY7ragadu3xsWNQGF
         FA4rhEko6yP9OiJcI1eN0/1Fli7sFw2f7LEwUowvYoIANGGGroa4SmvfJLeFkXq7aBwU
         sjSKmKHaqJYYbHYdOIUoqi2QdOYW5YwpD96/hnJP2dvg7cr1vHPjGhCAqOnuPgTu1Esi
         MjsF4hc4o42pcBjk1/zATyvYGLyK/JXVQ5DE2kGKK3Qm1Muoho4ZHFG3tzqOmgNmNOnh
         +/v7hAixdE20CQM0PyVCUtgdt7ouwquq6Npn4BgADehgeaDAiy8zvVaR2LJ91hOOGML8
         C7pw==
X-Gm-Message-State: APjAAAVybOuLkOPeedGkl0CP/edYD3TBO0cBDPd+XdiwmBluAPOkPmOI
        OI6Dq9uRdxt3yWAm8BxKpHIS0w==
X-Google-Smtp-Source: APXvYqxb/kePzso30q0J3LDebGmnh0NZA/pxwsejwKpoIHkaoRXf9QORb3+scacfUjYllSbAb0hUTg==
X-Received: by 2002:ac8:18f0:: with SMTP id o45mr74804877qtk.273.1560435156338;
        Thu, 13 Jun 2019 07:12:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id k15sm1394975qtg.22.2019.06.13.07.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:12:35 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:12:34 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 09/19] btrfs: limit super block locations in HMZONED mode
Message-ID: <20190613141232.nud7gqz622ewcyzp@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-10-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-10-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:15PM +0900, Naohiro Aota wrote:
> When in HMZONED mode, make sure that device super blocks are located in
> randomly writable zones of zoned block devices. That is, do not write super
> blocks in sequential write required zones of host-managed zoned block
> devices as update would not be possible.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/disk-io.c     | 11 +++++++++++
>  fs/btrfs/disk-io.h     |  1 +
>  fs/btrfs/extent-tree.c |  4 ++++
>  fs/btrfs/scrub.c       |  2 ++
>  4 files changed, 18 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7c1404c76768..ddbb02906042 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3466,6 +3466,13 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
>  	return latest;
>  }
>  
> +int btrfs_check_super_location(struct btrfs_device *device, u64 pos)
> +{
> +	/* any address is good on a regular (zone_size == 0) device */
> +	/* non-SEQUENTIAL WRITE REQUIRED zones are capable on a zoned device */

This is not how you do multi-line comments in the kernel.  Thanks,

Josef
