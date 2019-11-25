Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6451094F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 22:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfKYVL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 16:11:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43421 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfKYVL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 16:11:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id 3so7968633pfb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 13:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6o5NYyDBGL/EVz4SYOfBWL21/h3T7rTFl1vCLW5trJo=;
        b=pWeihM7DhgnJf/RVP8a6WJktdbhg8qq3XzSSnNjbIgzDBwzfKIgZ/Sk8PHixYuLuXq
         Cqu+0QQdBoAkIDbaBtvtuUknO1lnBj2dWK4jaMaKDIGdaJ9gqsCOrVtmTHW03nyP9cyk
         z252G3A3wEhTPUsllVCG6Ur4sQZLMQi82pqXjMSsVOifyDunoa3YvjRp1Hoc+3PI6UGt
         HN/kRygG8VFgco6C/SZS6MNk13qgf1ZBWCmfOjU18gD8FIoGa6gRHSaI26Cy1+0w5BXz
         SQo85fKRKsaJ0nAoMOxAIku2H/Af2JQmHEsTH3EMWOvUhsanJo+55jpJwZGV1URDoiof
         qTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6o5NYyDBGL/EVz4SYOfBWL21/h3T7rTFl1vCLW5trJo=;
        b=o0IzYtUfwgLhGKyfcR0udXGelbG1OuISWED0skRI+WDyLQLXlCcpC0P3wjw44dQQZs
         Q7olN/gHHsW41wT1bk3GzO1oC5qV9Yo3P8IYAb8sviseEIdDf0BkkXptS8kQOg5PoYK6
         +YT47RFIQ3ova0LVPXYf+xCD/KwVbHdgbgd7gq4RP8NQMHMNk+m3SrDjbQI9gUJqwvA1
         1FNFRteSPxCx5g56SDV+QF3+o9uJTBhtK/xuVVavE43S/NkjvxHAt6IC4dEtO9W79xa/
         WbEV4eXNoS1skSYQfeVRlD+QMdxAbDJb2M/TgZQRqiGo7F9R/zI+419GFE0u7AJmbqi5
         +kuA==
X-Gm-Message-State: APjAAAXD23NiPnv7FIIEN33ORSQKmIUHiA0nfpDJJviXG3ot0GtEKCcT
        1c3nD7NfzasOL9UdTlkfAp09
X-Google-Smtp-Source: APXvYqyNxrJ0GiUGghtnWJeHNGQUaMXo5agaWRTUhP36Enj/MThXP7IdSj3hHsMIx0J4l0mHvt3CiQ==
X-Received: by 2002:a63:fb04:: with SMTP id o4mr17115078pgh.122.1574716317349;
        Mon, 25 Nov 2019 13:11:57 -0800 (PST)
Received: from bobrowski (bobrowski.net. [110.232.114.101])
        by smtp.gmail.com with ESMTPSA id w69sm9666920pfc.164.2019.11.25.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 13:11:56 -0800 (PST)
Date:   Tue, 26 Nov 2019 08:11:50 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] iomap: Do not create fake iter in iomap_dio_bio_actor()
Message-ID: <20191125211149.GC3748@bobrowski>
References: <20191125083930.11854-1-jack@suse.cz>
 <20191125111901.11910-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125111901.11910-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 25, 2019 at 12:18:57PM +0100, Jan Kara wrote:
> iomap_dio_bio_actor() copies iter to a local variable and then limits it
> to a file extent we have mapped. When IO is submitted,
> iomap_dio_bio_actor() advances the original iter while the copied iter
> is advanced inside bio_iov_iter_get_pages(). This logic is non-obvious
> especially because both iters still point to same shared structures
> (such as pipe info) so if iov_iter_advance() changes anything in the
> shared structure, this scheme breaks. Let's just truncate and reexpand
> the original iter as needed instead of playing games with copying iters
> and keeping them in sync.

Looks good. Just one minor nit below which is eating me. I guess
Darrick can fix it up when applying it to his tree, if deemed
necessary to fix up.

Feel free to add:

Reviewed-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

>  	/*
> -	 * Operate on a partial iter trimmed to the extent we were called for.
> -	 * We'll update the iter in the dio once we're done with this extent.
> +	 * Save the original count and trim the iter to just the extent we
> +	 * are operating on right now.  The iter will be re-expanded once
  	       		    	      ^^
				      Extra whitespace here.

IMO, I think we can word the last sentence a little better too i.e.

/*                                                                               
 * Save the original count and trim the iter to the extent that we're            
 * currently operating on right now. The iter will then again be                 
 * expanded out once we're done.                                                 
 */

/M
