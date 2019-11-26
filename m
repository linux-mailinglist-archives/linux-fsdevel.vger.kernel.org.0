Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2731110A62A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 22:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKZVrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 16:47:20 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39735 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfKZVrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 16:47:19 -0500
Received: by mail-pj1-f66.google.com with SMTP id v93so5644715pjb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 13:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KFhdOn90Fti7JE5QyN26X7BwGNx6h4gloValNPbrSLg=;
        b=IfCawLHbaEt8FD7nRs/gvbRk47OJhOhEHuv0lWdW3MuIJK8M414nyXPgo47mJIFeN7
         PaBMCVfl1x0wwVWip+WmSBigPOHJJiuZ0B+TXeZ9RBNdvd5OpFgGDj2I/pMuuRNvlsno
         stVl4+y5iGv1PMWKQJxgrUFe2r9kDtKxtRFufA0wt8dd78h7dn56xwa9R4MTPEGhXwd0
         GS/ubITYNkLp5iBjzjJ+Gggjyfypkx+sZsjIB5UxweZzLOWZVIB9CVWzS8n9fEUHItDi
         4hUgNm/87MQDcsfWVnWVtuiqEPBdErYSij7cdo7G+r9pVbB3g0Kbdnp/hnb5UrE6Ji3V
         4JWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KFhdOn90Fti7JE5QyN26X7BwGNx6h4gloValNPbrSLg=;
        b=qaqDhMv3IfOCJCzNMeUudbYtHAcDgvvaVpWIQqd6WClr79i7rHPeK1cLxtx2klzxoq
         hxZ62k/ulCwNCh+eTjVY1vK4PiLbbs7I/o6l5fy1jZ2ziuto0gosS0OwFoLJg1OVFvGv
         wIjFtiK2k3qttiiXcruWDQhxeXixqXm8k5pH68+1nhuo+G1EMnkVC/gbsoDmrdyVFGjZ
         5M0eYjtHnB/o+bcmkmt3k6LRzKZtJU4ZBpawKSFQzRQllc7vgN6b+3ZHFbCKBGs1YeSb
         sY2k0xdO6POR716GRbZ3DqRTNHUdYI+NAxnvIGQgEvT/BpMBXFTpHGMEahbIP8+xGwE5
         TpJg==
X-Gm-Message-State: APjAAAWHyt0ztVo8rLxuw9CENvDuEuCkF2YFE6NoQig+3wcLmZ1Tl2b6
        a0XuJJwiELlhEFqPoYhgKDUp
X-Google-Smtp-Source: APXvYqyIY6rc51MCcvspRmZcVyOW9dwwtHhFMhC7SrUpiiXWoM1Cn/6GCIJVGKi2KqAoGfANcVftJA==
X-Received: by 2002:a17:90a:1424:: with SMTP id j33mr1733161pja.2.1574804838387;
        Tue, 26 Nov 2019 13:47:18 -0800 (PST)
Received: from bobrowski (bobrowski.net. [110.232.114.101])
        by smtp.gmail.com with ESMTPSA id o124sm13924729pfb.56.2019.11.26.13.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 13:47:17 -0800 (PST)
Date:   Wed, 27 Nov 2019 08:47:11 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] iomap: Do not create fake iter in iomap_dio_bio_actor()
Message-ID: <20191126214707.GB23868@bobrowski>
References: <20191125083930.11854-1-jack@suse.cz>
 <20191125111901.11910-1-jack@suse.cz>
 <20191125211149.GC3748@bobrowski>
 <20191126151216.GD20752@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126151216.GD20752@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 26, 2019 at 07:12:16AM -0800, Matthew Wilcox wrote:
> On Tue, Nov 26, 2019 at 08:11:50AM +1100, Matthew Bobrowski wrote:
> > > +	 * are operating on right now.  The iter will be re-expanded once
> >   	       		    	      ^^
> > 				      Extra whitespace here.
> 
> That's controversial, not wrong.  We don't normally enforce a style there.
> https://www.theatlantic.com/science/archive/2018/05/two-spaces-after-a-period/559304/
> (for example.  you can find many many many pieces extolling one or
> two spaces).

Indeed controversial, a good read, and thank you for sharing. I guess
that I haven't been brought up with two spaces after a period being a
"thing", so it makes my wires trip when glancing over a snippet of
text.

At least I'll know this for next time. :)

/M
