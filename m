Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8846958D4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 23:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF0VnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 17:43:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38576 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0VnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:43:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id z75so1602478pgz.5;
        Thu, 27 Jun 2019 14:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ECxEwBAkmZlz+R/U2GMCP+JOckImbThC+rsHcI4sg+k=;
        b=TkfF+jy9hX0y1Fb7WeNjVZckuzrpSj/PEFiwZNrSEg0RS3Wz2GlpiRc7VcVnedGGul
         iLPPDtrWHW5CFnXt8I+kZWDug1j6pV8X5Zct8HuHu7j40oXvkRIgmUpqrOyujB98/1Pc
         uzBDqIY5ddd2DB1F4b1xrKZIAdn/8s5KamFCRWh/sNHvgTbaaBgYno5RqwiU/hdNuq05
         TeVfE45rvow/xL5CkcdP2api6QvYGcbXIz3IwQMaaZ8GsrGziOXut2nJ4qplMz87uDat
         MYQoHOqoxsHlnfliu7y95qCqdwCZD8vtqFSD8TF7C4ucSFANg/ucj8tlzgbRAjAXZs98
         sk2A==
X-Gm-Message-State: APjAAAWz2+q2AFTYAhoWHvQ3qWtbEzFS8cysigtMtxIhzTm10dxTQP2I
        Q7CjiNhLGqozBabgxtHYqUbT7+2Gs+A=
X-Google-Smtp-Source: APXvYqy2MGlCLhKyFvZENP7n6Kdifoe3fs08NkTB518uSykdPFtEZtx8UHzGH9ePb0r/WXB1b8bkLg==
X-Received: by 2002:a65:6083:: with SMTP id t3mr5790410pgu.342.1561671786661;
        Thu, 27 Jun 2019 14:43:06 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b135sm56397pfb.44.2019.06.27.14.43.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 14:43:05 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DF873403ED; Thu, 27 Jun 2019 21:43:04 +0000 (UTC)
Date:   Thu, 27 Jun 2019 21:43:04 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Zorro Lang <zlang@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] xfs: allow merging ioends over append boundaries
Message-ID: <20190627214304.GB30113@42.do-not-panic.com>
References: <20190627104836.25446-1-hch@lst.de>
 <20190627104836.25446-8-hch@lst.de>
 <20190627182309.GP5171@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627182309.GP5171@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:23:09AM -0700, Darrick J. Wong wrote:
> On Thu, Jun 27, 2019 at 12:48:30PM +0200, Christoph Hellwig wrote:
> > There is no real problem merging ioends that go beyond i_size into an
> > ioend that doesn't.  We just need to move the append transaction to the
> > base ioend.  Also use the opportunity to use a real error code instead
> > of the magic 1 to cancel the transactions, and write a comment
> > explaining the scheme.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reading through this patch, I have a feeling it fixes the crash that
> Zorro has been seeing occasionally with generic/475...
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Zorro, can you confirm? If so it would be great to also refer to
the respective bugzilla entry #203947 [0].

[0] https://bugzilla.kernel.org/show_bug.cgi?id=203947

  Luis
