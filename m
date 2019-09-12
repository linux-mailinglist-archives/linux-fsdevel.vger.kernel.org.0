Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE894B0B52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfILJ0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 05:26:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33231 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbfILJ0W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:26:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so13181694pgn.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2019 02:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dt0j6/Dbs+dwW1SIPthaW+qziOAlFsuqXt20b4c12nE=;
        b=12hCQat9jUcgSa47++/HQI/Kl7LxMpOdcs5vqzMW95pKZMUHEhyw9ZMTKknS+6Z2Rx
         K9qJNKmsGVjwgxprs5gDVl8K+aUT2VnsLU60nF0AzZqv5zXtsCwN++iPfEVHgWC+J7j+
         dzo27W3kuN+k10OHxZQp4JFaIL0RYtJn0rAoEKVV3Tjp/yso+xeP3PIyvRGhxb2KSfST
         ffoFGuMIjtreThdQ+W41KGD+0jkLetWQM+B1FTVLAr6v++nXXRuC0Pw6a6KKqO9IL1Es
         KlgfJcVrWGFzhtJHgrA+FEtA/80mCRFIS7z+ma8tpq3q4vca8MZ/qHfHgMp7DzPy84Ad
         FAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dt0j6/Dbs+dwW1SIPthaW+qziOAlFsuqXt20b4c12nE=;
        b=PsE/KmMoT7AB0PSwvEeTlDeJyxghYDCN5YceFEwxXB2sILLxFhnb6S9RkhChbDMj+S
         3zazqj7HImXgYgADMY3puL+2Xpyq+ao/xAdA+MOwNt92Z1meYKzsy/5x9oQhOhAxoxA2
         TWEtS6IK9rew/zsln24YwX3MrrYmk1+4h3LxS6/50Mf0srUftgo8ub/KmY7Xos4iimnC
         NJd8LXRvocUzjyRaI3vBXbaKIiTdm/2Mn4u+q5bItlKsV/Xnzx5URb+QT2fpn4KVa0K8
         pYMXuZ/Jnovf0UH+IOAkJ3md62BP7mgGt9rRb3tARbclafgrKL8i+sPi73Vdbf9gqQFl
         x2lQ==
X-Gm-Message-State: APjAAAVoADlN9xaPieHIEmWrSIFPOxmatsWTg2sXqPNXNEKndiWahmfP
        Sbfe2D4dXdCSVhf5HQnRIpeM
X-Google-Smtp-Source: APXvYqwyIDlF1caDTpNVqUKoLG7l8JslVWsCl4azAP5rgYV6Wp1tuclPnO2lsBQan2QfColr2D8A2g==
X-Received: by 2002:a63:211c:: with SMTP id h28mr36886434pgh.438.1568280381146;
        Thu, 12 Sep 2019 02:26:21 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id c62sm29491396pfa.92.2019.09.12.02.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 02:26:20 -0700 (PDT)
Date:   Thu, 12 Sep 2019 19:26:14 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, hch@infradead.org, andres@anarazel.de,
        david@fromorbit.com, linux-f2fs-devel@lists.sourceforge.net,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 2/3] ext4: fix inode rwsem regression
Message-ID: <20190912092614.GB9747@bobrowski>
References: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
 <20190911164517.16130-1-rgoldwyn@suse.de>
 <20190911164517.16130-3-rgoldwyn@suse.de>
 <20190912085236.7C51642042@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912085236.7C51642042@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 12, 2019 at 02:22:35PM +0530, Ritesh Harjani wrote:
> cc'd Matthew as well.
> 
> > This is similar to 942491c9e6d6 ("xfs: fix AIM7 regression")
> > Apparently our current rwsem code doesn't like doing the trylock, then
> > lock for real scheme.  So change our read/write methods to just do the
> > trylock for the RWF_NOWAIT case.
> > 
> > Fixes: 728fbc0e10b7 ("ext4: nowait aio support")
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This patch will conflict with recent iomap patch series.
> So if this is getting queued up before, so iomap patch series will
> need to rebase and factor these changes in the new APIs.

Noted. I've been keeping my eye on this thread, so I'm aware of this.

--<M>--
