Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37BA7D0CF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 12:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfJIKmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 06:42:31 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:42147 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbfJIKmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:42:31 -0400
Received: by mail-pl1-f172.google.com with SMTP id e5so853483pls.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bm58YBswdlISkDr/Ri9rK9T+YxLaZyKmJp4DGvcJTBg=;
        b=I8aIhyJ8I7eXY+MUGOunHtMn6yXr1flIzb64UdLjR6f4S4S4HW8P+ydbg8Mb5x771M
         gfFVAxGILf6ALC5vbppKVpqPeMUBIYR/HzP4TRvu7eU2b/3QdGcpB3Zxdg5pmyUHSS40
         pG1/gNBxuLT7YP6uFqNm6lJ6oSB2mO/t8svE5FpbAxxxYqkFXSb6GVI96UPQ0B2cKLZX
         wjiGJ5q4MCR5Ad6C14cQA1Bn9quHwGmphku24TcrlJLffYjbrwqhk5R0Jj5SAqQnXh7C
         gOA/Yu39oCaUbjKNNjevJxzyhs21oJ8a28wh98pu49VvKNANvtGMG4aEv1+52Lvywoqd
         Janw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bm58YBswdlISkDr/Ri9rK9T+YxLaZyKmJp4DGvcJTBg=;
        b=trS63qXERMpOU5x1Wi3VHZiyCBHC/Fu9y86XwkInLYZNRkQ8xH2lXBqxyr8cAjDYQx
         Dp6gIRaXpi3qQgR9+67aKzsOd8/hNjB2C97DfFb1D3DeIppShgNkfCTrX3SDPGmEbsp3
         NQiAvQDblN3HUtQYGmD2yr38EI6UKNh+1uqD8mLWgj9B+PuW71hoHdCLZtZrlp9Z/G8q
         Iyb9va6giGx42bQ3I3Ows9+JnBr81w+11ObHkBkQyXkApSGOCYrXSIUiUkMlXBjPMEzl
         +sSovEuBkWJXuNMzHMBoTAzlIZTVJvX9jdwaFz2GRHNdjlGW1tT/vVd2/ouEVQ8AdlAA
         BUNw==
X-Gm-Message-State: APjAAAV5IbSpZVYaA0pZOpZk9NMaqTPojOPFq9Hy14E7MI1qthMJu/NP
        Of6ik9XjUOdMAf0Hrl+z9RUc
X-Google-Smtp-Source: APXvYqxN69Tjyhd5JrhDTftfgmmWiJND0nFIpMG9lopTpbZTDjnDe4p+ppTyjeoIFhyMtSomAzn2fQ==
X-Received: by 2002:a17:902:930b:: with SMTP id bc11mr2488108plb.284.1570617748885;
        Wed, 09 Oct 2019 03:42:28 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id f128sm1955760pfg.143.2019.10.09.03.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:42:28 -0700 (PDT)
Date:   Wed, 9 Oct 2019 21:42:22 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 7/8] ext4: reorder map.m_flags checks in
 ext4_set_iomap()
Message-ID: <20191009104220.GD14749@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <3551610e53aa1984210a4de04ad6e1a89f5bf0a3.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008113012.GJ5078@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008113012.GJ5078@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 01:30:12PM +0200, Jan Kara wrote:
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks Jan!

> Just those 72 columns limited comment lines... ;)

*nod* - will be fixed!

--<M>--
