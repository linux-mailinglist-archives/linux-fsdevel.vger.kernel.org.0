Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1003EED8CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 07:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfKDGEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 01:04:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42666 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKDGEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:04:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id s23so7181268pgo.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Nov 2019 22:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XvoalgHkeJYVA1m59VqwYPB0jL7bT8NQ3r5ipKUnu84=;
        b=P7vqFsa9ppPiE5gy875KwUB+sQ2UTxUffP2yPRaXvdFQkeEx94zWCWCK1p+edZqzcK
         eE8zPapq3g6RYdTqdzQiD4uavII+WdQHANBeDRblr/u2QfzRp5m/94ag5k3WlMcHXiFc
         zfspgk+TqRKC1s0xuFWVe+Q1/pLlTc5ILwOV4KmzGZnIrJTG99BgGRX3dc6DtyJwNrkg
         AVzXHhQNNfZftFP4xvbMWcAjUpY9K5s5oKwCatwmKDbEjlcPUFAi/bY6YsLMjIdsW8A1
         cBbGwGvw9CAVy/JW+85R58OSiVTp54wzRj+FxQzE809e2b/mZCI6Pe5DRNmCLVCTQHuF
         JAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XvoalgHkeJYVA1m59VqwYPB0jL7bT8NQ3r5ipKUnu84=;
        b=snz8oJaw70rLB8jn24yoB+miA3Q4veLTV4cWopXQDix5kLcd41aOVHLQniBS4Vs84/
         dZbF9ym8W7Ih1ke65YlSJ9NJBIMl20jNRrsOT3FqQlKX1rCD2anLDYOz+HGNH2FdWxRF
         8sDsbsf//Emr6MVwJVSJgiFsgimxGs2PBa/kX2ZDNrglKlgDySyQ5FX79aS4i6SqEJje
         KARxIak9fsLy09tCFOa8Cy+LM6k4ltNVtug69wHqLgRYR6u8+mfnJyiS+sftj/WyiCRu
         toEvigvqM/9X9cNbWKKaYn4O++wVCAfH8lnvyQbyKdIxw2y4O4z0N15iB2WHDFOTz2Bh
         iUQQ==
X-Gm-Message-State: APjAAAU4UWu5XrhzfXB1u+amAnKB63rB7RsRXoM3+kQuVdBNRtKb22nA
        VdRpx6fhm3KjtSjvddNgEWK4
X-Google-Smtp-Source: APXvYqz2R5pEkootFGm2PTDz5+c3Oder8COlYEVXArETC3svxCgNGukkTYgcruMKwN2fMOYbAhqtRg==
X-Received: by 2002:a63:c411:: with SMTP id h17mr5998304pgd.360.1572847454718;
        Sun, 03 Nov 2019 22:04:14 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id t13sm14476121pfh.12.2019.11.03.22.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 22:04:14 -0800 (PST)
Date:   Mon, 4 Nov 2019 17:04:07 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v6 00/11] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191104060405.GA27115@bobrowski>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <20191103192040.GA12985@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103192040.GA12985@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Howdy Ted!

On Sun, Nov 03, 2019 at 02:20:40PM -0500, Theodore Y. Ts'o wrote:
> Hi Matthew, could you do me a favor?  For the next (and hopefully
> final :-) spin of this patch series, could you base it on the
> ext4.git's master branch.  Then pull in Darrick's iomap-for-next
> branch, and then apply your patches on top of that.
> 
> I attempted to do this with the v6 patch series --- see the tt/mb-dio
> branch --- and I described on another e-mail thread, I appear to have
> screwed up that patch conflicts, since it's causing a failure with
> diroead-nolock using a 1k block size.  Since this wasn't something
> that worked when you were first working on the patch set, this isn't
> something I'm going to consider blocking, especially since a flay test
> failure which happens 7% of the time, and using dioread_nolock with a
> sub-page blocksize isn't something that is going to be all that common
> (since it wasn't working at all up until now).
> 
> Still, I'm hoping that either Ritesh or you can figure out how my
> simple-minded handling of the patch conflict between your and his
> patch series can be addressed properly.

OK, I will try get around to this tonight. :)

--<M>--
