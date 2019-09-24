Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95EF1BC4EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 11:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504271AbfIXJf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 05:35:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36922 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390805AbfIXJf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:35:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id u20so755899plq.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dPh+JpTLjCIVwxmx95KJZ0NpzB5+5xF3geaxRmhZXUY=;
        b=Md8sInKXx+nLOC5WRO/TzotH18BKWYkKP5M/SWSMCs9LukDuFAfmOvNsUFCk5UgbAn
         pt4S6Zl3NfnaHWtAbSK9RGO3KOY2ibH2zGtPF8h2LARlQczOTtEI436+y4WV9wiBYVhD
         E/SJZFygnDMFQGTbKw5yhbcRwSXaq3QDMxEYfWGjscK4c9vvikETYkZ1lY35fUNJ4wCv
         BjcZTpMCDiJrGdQgs+9BNwv35eS2156C848HcnZ69aKN52GYe12a7TSETtGLkpR0lZCp
         4qAl++TmVWsF/OCeUL1bRvB9H4QIHIofGDPEdW/BMR2NXkRbMNv7JUcteHAAbo39dMb5
         1uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dPh+JpTLjCIVwxmx95KJZ0NpzB5+5xF3geaxRmhZXUY=;
        b=jmcCU0AZki7ldQVjo4GccpWkCSdQfeYeh+Pojj31iQk6iw4aqyudaLRSiYv2h/72Vt
         FvNf2OJp5dmP+6SoW+YCkogRhMvPMMpffAY9ByR6O7DoJY2mlONZzE6ax+vCFhYzmPCq
         7fEgrRDpFMMtBCh6tnkHxJ20xtyVIg8+k+dOYYH7/A/1Bh4fZoNpbMQdwfiAiR4aicxs
         OknHtgAfLAKruLXDeFf1+EkBSqI5JxNeWxq0FqqHWmXKnbMMR84QJl0L5P47FPQnXGt4
         OimV3fd6NGPMPgaS5Lmx2ABqk8eGGBbOTyHkfgLFJ4wW850MEpstR7LF0ZXUUvTgGkSU
         FnQg==
X-Gm-Message-State: APjAAAXW9/W4JMRDyCwQFu2n2G4b5lNM3nXbPfdw0lhK33nJ94AqD5EL
        NrpZmWGv0ZQi3Ncj5cte+Ix9
X-Google-Smtp-Source: APXvYqzzUxDROeJi7amXTJYypG760P6DgTDmMkBs/QN2n/BH1J4I9I+hKeml07e+XivDgswgZs8gDg==
X-Received: by 2002:a17:902:8bc8:: with SMTP id r8mr1901293plo.338.1569317724915;
        Tue, 24 Sep 2019 02:35:24 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id q42sm4167344pja.16.2019.09.24.02.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 02:35:24 -0700 (PDT)
Date:   Tue, 24 Sep 2019 19:35:18 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 4/6] ext4: reorder map.m_flags checks in
 ext4_iomap_begin()
Message-ID: <20190924093518.GA17526@bobrowski>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <8aa099e66ece73578f32cbbc411b6f3e52d53e52.1568282664.git.mbobrowski@mbobrowski.org>
 <20190923150856.GE20367@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923150856.GE20367@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 05:08:56PM +0200, Jan Kara wrote:
> On Thu 12-09-19 21:04:30, Matthew Bobrowski wrote:
> > For iomap direct IO write code path changes, we need to accommodate
> > for the case where the block mapping flags passed to ext4_map_blocks()
> > will result in m_flags having both EXT4_MAP_MAPPED and
> > EXT4_MAP_UNWRITTEN bits set. In order for the allocated unwritten
> > extents to be converted properly in the end_io handler, iomap->type
> > must be set to IOMAP_UNWRITTEN, so we need to reshuffle the
> > conditional statement in order to achieve this.
> > 
> > This change is a no-op for DAX code path as the block mapping flag
> > passed to ext4_map_blocks() when IS_DAX(inode) never results in
> > EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN being set at once.
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thank you Jan!

Note that the updated patch series that I'll send through shortly has slightly
changed in the sense that I've split up a whole bunch of the iomap code. The
idea behind this was to reduce the overall clutter that exists within the
->iomap_begin() callback. This was recommended by Christoph, and I really like
the idea because moving forward it makes complete sense to do so. This
specific patch will remain as is though.

--<M>--
