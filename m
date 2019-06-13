Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E443866
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfFMPFe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:05:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34081 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732442AbfFMOPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:15:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so22722983qtu.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OdDaHrZjCVjfx0F7I84Ms3iqXEsw9YFLBG1e37K/zSk=;
        b=sYqQ6uKns66zBU93j9yEeT/LvK5SGvAWuiWz7tHFKP7mn86ErCaTm0z6ueEaaYTBtg
         dppoEWF3t5KwmGEiTyNyELHfy/K4HBjO63VBJld10Wczby5Bgw0JqRryBbLcTInMngZF
         sP9X0zKnUXr6BFW7dvX+xwYtaeoQpjJAJggqP317rGAKYhQtp+saVK4UXI3ItKnbhCoA
         hU9taLmEZSCOBzlLEaGANGcNtWJISSQt/5H+szYc4JyKWmFRwxx/WK/9aEzTWn1UGDte
         qjTdAr4LhHnD/vXiT4bAdYs4gHhceTk9y66k9SNnyJAQEtt21xVoHV5QE13CHyrq6LlU
         p0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OdDaHrZjCVjfx0F7I84Ms3iqXEsw9YFLBG1e37K/zSk=;
        b=CscHECtA+T5hSQa6ub16whK2S/kRY0zAxlPkXFxcXlvDW6Hhz5anxR20/Cw3XkiAui
         IUfcT7jvf5JI4WttTsLaopg68UKU3uXCUA2RUM4XdZMXUwgBJSoj67X79lf+lARpPRWH
         am77yP9ACdqWqYUfooB3xc4wa7aIgUhNbzuIvWm5I9yTa8jZoPh4hQ09tCWligbhC+D3
         piOXcrMDvD1XXGIaL2N0kFEeaMU7uPATGgdC9mh0kcJG5xNGNVCJyR/G724bH994gybp
         EJXseFlpWuK5y5phbf8Xun1XRAnGxeDOmzvhtQBIHZYTHMhUEOLIa+Str1s2SZ0nMP+E
         R3eQ==
X-Gm-Message-State: APjAAAWge7+bXlIBtNNtLrOIusF4d2KjbzjtsRHFO026khf9XlLpw10Y
        BogxtzxT/I4Lf9PG6kXpSkIbHw==
X-Google-Smtp-Source: APXvYqwfgzv3MjJXLyZteAyuEZAIwVB7UsULqWyzo3LfoE3U2tnrGhHZdPH8Rlk1v5y4hE8yrkdv2w==
X-Received: by 2002:a0c:9891:: with SMTP id f17mr790499qvd.49.1560435300381;
        Thu, 13 Jun 2019 07:15:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id w16sm1898172qtc.41.2019.06.13.07.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:14:59 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:14:58 -0400
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
Subject: Re: [PATCH 11/19] btrfs: introduce submit buffer
Message-ID: <20190613141457.jws5ca63wfgjf7da@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-12-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-12-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:17PM +0900, Naohiro Aota wrote:
> Sequential allocation is not enough to maintain sequential delivery of
> write IOs to the device. Various features (async compress, async checksum,
> ...) of btrfs affect ordering of the IOs. This patch introduces submit
> buffer to sort WRITE bios belonging to a block group and sort them out
> sequentially in increasing block address to achieve sequential write
> sequences with __btrfs_map_bio().
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

I hate everything about this.  Can't we just use the plugging infrastructure for
this and then make sure it re-orders the bios before submitting them?  Also
what's to prevent the block layer scheduler from re-arranging these io's?
Thanks,

Josef
