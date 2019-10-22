Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA29DFB51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 04:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfJVCE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 22:04:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32887 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfJVCE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:04:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id i76so8968183pgc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 19:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U8zC0pi58HNVgvXRenNwHhavuGCdq6iq04EqcnI0YUs=;
        b=hWHneUkVIlFf/L2jf24QvvpkHGg00gWSIVCG12Za7BdQfI2Sn5YkxZYiEPgJrH1olM
         3HF1ynjdPeNKpYGI9DKjN4+gQ857ec82EGR57N/0MjnMoRuwMctvyFsrD6zrysm1XbmK
         gP3QagMh7Vfyc5KLV0ZmCnuvjPbmxcFmn50A/Ow5X4Vm0SV9yE89jorAolYdALRonZ4w
         PhV6jd0wXz0PbpOLN0kyUK3Wawr959bg0mFOC8+uw4/heTPiR/6k0K3jM7vr1ppWxMkw
         +zvsC3Ff2oYB8a4PxB6AsbSq7JEcwwCWzjpK9WmYU6av7am08nLGb7uSnmuzzccMkPsG
         rwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U8zC0pi58HNVgvXRenNwHhavuGCdq6iq04EqcnI0YUs=;
        b=EO1Y+L1H6DGvXqAkAKJdu15TnQWFOCcRkdOL7U3BmVP8CJMo6a0YScSB2HUqjkjnL9
         SklUxqAs1eaaUsp3QOdkvoQKgVDpHij3Yde2xvrWlDSE2UpsFW2Trl7Jbfe2L8qQcH0u
         hYgmAC3w5hKiJm8bKzHE4rH04nVyb9nYxaozs1nq/UVeD/bdOnqjMF+AgokMmmqUdR0H
         Lj0uxOCYl9FEwLspGtvXv3F8vML1kvTTip+PmlGM24zJG4MmsPIh5femF+zAe3c8ZLd0
         XFtdX2zHrmS5NiQa9JnNJdmvqsOrW0kfMN69LPVGk/v/W+z4Njp7TRPrMWA13+3mnBA0
         5yxQ==
X-Gm-Message-State: APjAAAUg+jAoW+T+lI1ycTKQ60k1GcIkjtLei1rhGf0ElnVB8qjhuyho
        rg4D4RAAPfKOYZeoDwBFl3Q0Jnxubg==
X-Google-Smtp-Source: APXvYqzFAkZsZIT8MOJGD07UTklnqavTHs8f2jsjcXVut8tJmT++SdYQES1hJLEcqsIl6DKqCJGEYg==
X-Received: by 2002:a17:90a:ec10:: with SMTP id l16mr1462745pjy.37.1571709868097;
        Mon, 21 Oct 2019 19:04:28 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id 127sm21245928pfw.6.2019.10.21.19.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 19:04:27 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:04:21 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 08/12] ext4: update direct I/O read to do trylock in
 IOCB_NOWAIT cases
Message-ID: <20191022020421.GE5092@athena.bobrowski.net>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <5ee370a435eb08fb14579c7c197b16e9fa0886f0.1571647179.git.mbobrowski@mbobrowski.org>
 <20191021134817.GG25184@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021134817.GG25184@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 03:48:17PM +0200, Jan Kara wrote:
> On Mon 21-10-19 20:18:46, Matthew Bobrowski wrote:
> > This patch updates the lock pattern in ext4_dio_read_iter() to only
> > perform the trylock in IOCB_NOWAIT cases.
> 
> The changelog is actually misleading. It should say something like "This
> patch updates the lock pattern in ext4_dio_read_iter() to not block on
> inode lock in case of IOCB_NOWAIT direct IO reads."
> 
> Also to ease backporting of easy fixes, we try to put patches like this
> early in the series (fixing code in ext4_direct_IO_read(), and then the
> fixed code would just carry over to ext4_dio_read_iter()).

OK, understood. Now I know this for next time. :)

Providing that I have this patch precede the ext4_dio_read_iter()
patch and implement this lock pattern in ext4_direct_IO_read(), am I
OK to add the 'Reviewed-by' tag?

--<M>--
