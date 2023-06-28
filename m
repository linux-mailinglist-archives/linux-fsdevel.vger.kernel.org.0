Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B137740B6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjF1I1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjF1IZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:25:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A3B420E
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:15:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8033987baso4881665ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687940136; x=1690532136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvEuhE7V/s2leNt36xMTkTseKzYK2M8Qy+lofTFX35w=;
        b=oUK24B2A8Za5WrrazM1S/hRxwFkp9BjOmHqST8CZRgRZB3fRcOUafhKzNZJvruuPFG
         7xCOOR92lTz2TnNk/7CTzDrWmi+VdtsBCOORsRJ0bONLTPYDNeyQzxfoGVt3PNkla1+e
         Y8rCCTnXp8I/X8yqf7004diDn+hVkoCB0+FWeKa3gaJ+7dGf+fwKgkOYxnLxKqeNuLSF
         Ap/0PgC80TefnDQ4rWEo7IvDW42FCASsBkYpbiMj8zIYzEGPDUxofylxKqJkD6DM9zFx
         pRr9IzzhrA0YYufhFDmZEVtALVIgI2fVt+/50UBjviVGsXj76m+yW0y7LAIS6Hc9CJ79
         gVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940136; x=1690532136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvEuhE7V/s2leNt36xMTkTseKzYK2M8Qy+lofTFX35w=;
        b=PuoKHAlJ4R7sW1chYKoIip1VWpxzXOWYV3v/yQJZiHfH5+cS0XeyWxKIK9llyDhtcZ
         VFhfhYWAH8HVapsQx6/1l9ESQFopNNDDv/5GhBFTLFnFUzHKq/6ABpeGVYO52dN/dYw3
         2bZQCvouubqF5HX30uMBThsyundfwaOt9CTGcNC7XThH82r+Pbx1Gjep483TLDgtZZwV
         FX8IqSB/JdCv7W2DsfpEWdNAEvkklBW3BMzCrMl10ehKzJ2gFlVwJGMuOIIifffWksEv
         Ic1uhzk0Y9WBgNYgd8gl8BMJ35WYNnp3rQdNYek0kk644sIIyab2kyLGKEOFsEuCCD/2
         j6Og==
X-Gm-Message-State: AC+VfDx7eop2KVb6Fl+vkqn6JW+vTpKh3hw5VV1cS/zqkPaViw7IoPRW
        uVoWWAdW5aYbN/poaj9AxvU0pQ==
X-Google-Smtp-Source: ACHHUZ5Y9FFEdf/ewaJbRjkYhd/dEAfNkLm0Ytbay14Tn3/dYZKh7+9KYeMo/EErTxGUf4ZTtlOgiA==
X-Received: by 2002:a17:903:22c3:b0:1b6:783d:9ba7 with SMTP id y3-20020a17090322c300b001b6783d9ba7mr866965plg.27.1687940135978;
        Wed, 28 Jun 2023 01:15:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00192aa53a7d5sm7191824plr.8.2023.06.28.01.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 01:15:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qEQKq-00H9cE-1z;
        Wed, 28 Jun 2023 18:15:32 +1000
Date:   Wed, 28 Jun 2023 18:15:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Reproducer] Corruption, possible race between splice and
 FALLOC_FL_PUNCH_HOLE
Message-ID: <ZJvsJJKMPyM77vPv@dread.disaster.area>
References: <ZJq6nJBoX1m6Po9+@casper.infradead.org>
 <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
 <ZJp4Df8MnU8F3XAt@dread.disaster.area>
 <3299543.1687933850@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3299543.1687933850@warthog.procyon.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 07:30:50AM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > > Expected behavior:
> > > > Punching holes in a file after splicing pages out of that file into a pipe
> > > > should not corrupt the spliced-out pages in the pipe buffer.
> 
> I think this bit is the key.  Why would this be the expected behaviour?  As
> you say, splice is allowed to stuff parts of the pagecache into a pipe and
> these may get transferred, say, to a network card at the end to transmit
> directly from.  It's a form of direct I/O.  If someone has the pages mmapped,
> they can change the data that will be transmitted; if someone does a write(),
> they can change that data too.  The point of splice is to avoid the copy - but
> it comes with a tradeoff.

I wouldn't call "post-splice filesystem modifications randomly
corrupts pipe data" a tradeoff. I call that a bug. 

-Dave.
-- 
Dave Chinner
david@fromorbit.com
