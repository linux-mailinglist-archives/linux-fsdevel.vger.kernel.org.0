Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF61A8158
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 13:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfIDLqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 07:46:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfIDLqf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:46:35 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8493881F13
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2019 11:46:35 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id 71so559863otv.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2019 04:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tp/gMW5v4pRlyKiUIDPuxfxvbFDJhPkzWLdm0oGHyVo=;
        b=FKqNW0IN0QHCwLvYGFuBFOpwrtVITUciQHgNBrI3Tthp3sXyEw9MaY/PCfOLhqZhsj
         bpJfdQMuQAemf/OJEUpqytCY6mtPw4Do7fego/V3xiE5TWh3d6dFI4AFGP5FNQ3QUwFs
         xXqcqh3cJYvzWyrz1OQKwzV02VXD0oFWagsUA/WAQikFu+OmOE+IUJ6pjr3sRPPWyRpl
         wX/Ldza8A8MAcStGjNYdikejxJJC6V6oeSstTl9KEFP2wzVC/Ki6GO/1cDPFE73pi/FU
         0FqeGbXs7TYaA9ovoyDyWv5TEoZtwOvdn3ryrEFRzt7L3JepRbp3oY6NxAn7czgVgah+
         1iOg==
X-Gm-Message-State: APjAAAVAvWmxY+RD46Zy6Xi3zpvUTmraIIiPxLiEabdna9OTDERf67sB
        CLfNwMknv+v29RGOG+uWOc9juYfWLEQBT50Ph7BKckLDxwIpK0AfuhDtwwB/+rpAXzEaEQWEwKX
        cPHe8Bp9H4ryLLa1iSVd2Hgcr9+sslXua+bspC4ArZg==
X-Received: by 2002:a05:6808:183:: with SMTP id w3mr1672969oic.147.1567597594999;
        Wed, 04 Sep 2019 04:46:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy9/OmGWIzNj7/oNV2D+qH0GsqfH+nNIlG264im72fFSE+LZi5x7kKnT+39cyWeIYPXVV56F9ZSFe3zo3LwHYA=
X-Received: by 2002:a05:6808:183:: with SMTP id w3mr1672956oic.147.1567597594780;
 Wed, 04 Sep 2019 04:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190903130327.6023-1-hch@lst.de> <20190903221621.GH568270@magnolia>
 <20190904051229.GA9970@lst.de>
In-Reply-To: <20190904051229.GA9970@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 4 Sep 2019 13:46:23 +0200
Message-ID: <CAHc6FU42hsk9Ld7+mezh6Ba++5yvzJk30AyJzHOq3Ob7YASDgg@mail.gmail.com>
Subject: Re: iomap_dio_rw ->end_io improvements
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 4, 2019 at 7:12 AM Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Sep 03, 2019 at 03:16:21PM -0700, Darrick J. Wong wrote:
> > The biggest problem with merging these patches (and while we're at it,
> > Goldwyn's patch adding a srcmap parameter to ->iomap_begin) for 5.4 is
> > that they'll break whatever Andreas and Damien have been preparing for
> > gfs2 and zonefs (respectively) based off the iomap-writeback work branch
> > that I created off of 5.3-rc2 a month ago.
>
> Does Andreas have changes pending that actually pass an end_io call
> back to gfs2?  So far it just passed NULL so nothing should change.

Right, we don't currently use that and there's nothing in queue in
that direction.

Andreas
