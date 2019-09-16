Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D46B3AFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbfIPNHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 09:07:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33524 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732852AbfIPNHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:07:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so22989056pfl.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2019 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XBRZTGkG6F9z2g/QPkwkH5mhWZBFzDCgMo6crL6U7yo=;
        b=ppo40voW+CoG9AVCAvDvAuDz2DDa2y31W/V6ZXaazTbrmlCci50pwAGGz/1Kv2EBdd
         sbDDvK7gLTkE1JMJUbGJAP0o+o9wBYx8SyOqB6fwXzFuCGLSsf11FdOzY3gYrwGHtMaB
         iIOFPQkebw1ade/WtANUphIS49oJ6omKLLCOMB0K4QhxiD2BzZaJKKIW3t+bZNKCF/EE
         axRVY9ZqRLm4rmTAFwzkYVv661DTlqPTasO+XKuJSPvVDWu1ul1F2OU1fg1nhT33OSyD
         aAS+Ej8aYxZIec5oyRejwFD2Nbfa8YGLrJLfYlEHXforlICwrl5ynMR62rm18txGimfG
         Z0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XBRZTGkG6F9z2g/QPkwkH5mhWZBFzDCgMo6crL6U7yo=;
        b=gp2/HpDHhmcHRtIvblqDOqdK1v471XSzDTay/JsjH/Qo26CwMCwJ0eo3ut5iYa3Cv0
         i32cV5gq/SyEhmVenx1v4Q+zCypW5OK7QCtJn9eDb/0ZjgFSL30PNdnAPzyB6FWV3Lqa
         /3eEn/eVFMgMGZEJxe4BiAMpvk542FOpA01yJREVzW34bshYwBcbWMkqhL6NpCSGKNVW
         vRp4EKBAHs7/149DzRVoTYYHQLhSp6oQ02NOP3n9S/hF35xXQF5/M+OndlVrvSx/O6CO
         7x4SkEODhdT5UJhmm0/4+9w9TQs7k/POD0YJr+SIc99SpUGdbuXDDz2RQV6LXK8NC9bs
         v+lg==
X-Gm-Message-State: APjAAAXK9RckYzJPSDM/c6tqJnERbkJJSvyQENT73Q/QSGY1b2VGxZ6r
        IyhTax7MWQFYQOKU25qrCKOZ
X-Google-Smtp-Source: APXvYqw7/18KjBp2QVB/2yBpM1+xOVaUae3H+kQAuJaCI8c36c2en+/CjhlXyAgQeWl/jervkWnoHA==
X-Received: by 2002:a17:90a:d356:: with SMTP id i22mr19690052pjx.24.1568639261615;
        Mon, 16 Sep 2019 06:07:41 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id e10sm59500188pfh.77.2019.09.16.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 06:07:40 -0700 (PDT)
Date:   Mon, 16 Sep 2019 23:07:35 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v3 1/6] ext4: introduce direct IO read path using iomap
 infrastructure
Message-ID: <20190916130735.GD4024@bobrowski>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <532d8deae8e522a27539470457eec6b1a5683127.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916120032.GA4005@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916120032.GA4005@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 16, 2019 at 05:00:32AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 12, 2019 at 09:03:44PM +1000, Matthew Bobrowski wrote:
> > +static bool ext4_dio_checks(struct inode *inode)
> > +{
> > +#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
> > +	if (IS_ENCRYPTED(inode))
> > +		return false;
> > +#endif
> > +	if (ext4_should_journal_data(inode))
> > +		return false;
> > +	if (ext4_has_inline_data(inode))
> > +		return false;
> > +	return true;
> 
> Shouldn't this function be called ext4_dio_supported or similar?

Yeah, let's run with your suggestion. I think 'ext4_dio_supported' reads far
better than what I've named this helper.
 
> Also bonus points of adding a patch that defines a IS_ENCRYPTED stub
> for !CONFIG_FS_ENCRYPTION to make this a little cleaner.

I like this idea and I will try to do this.

> Also the iomap direct I/O code supports inline data, so the above
> might not be required (at least with small updates elsewhere).

I did see this, but to be perfectly honest I haven't looked at what needs to
be done on the ext4 side of things to get it all plumbed up and working. I
wanted to get clear of these main bits and revisit after the fact within a
separate patch series.

--<M>--
