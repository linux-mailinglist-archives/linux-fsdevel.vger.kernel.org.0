Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0615AD0A8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 11:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfJIJJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 05:09:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38714 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJIJJN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:09:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so1212412pfe.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/2CUrXw7XGcGK4lh6prcL9SsnSHFpgYxj56Dh9K0z+g=;
        b=qCYCgUqetwF0SaHfnB1vasHMYkLC2n0nF+iuzl7nP6WZcd/sRP0FWYG4d3LUbuJ4Gh
         l+Uthr0kJKlB8T7mDR3AfIqORDufvpWnOIBFbdLU3F6TlyE3YwGquBOhNXwk3Mwk31Yk
         h17oiAr2enqom3iFXzs+pbP6ePknl391r+tPSc4XSvGsVg4hSPcDWBqdMOHYNK2QTw5I
         0hZszJUXWGr9G5GmmLWnmSis67Pfk43SLhKT68I+cbH+LePVNgcw5GNZ8ELkksIA9ZKK
         gprGvIFF7ybVMXVSerZzm6cqhOF0SClEvgsp/cViUATnhoROzJXzyaOnxknHyZc2HF6E
         2vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2CUrXw7XGcGK4lh6prcL9SsnSHFpgYxj56Dh9K0z+g=;
        b=uLQGjRaGxTZx8iemrFqFPVu1WinckRTe8bfMobLAHnQdRjuGb6Cjz/ZRqLROzkDYNb
         uA0dQRtFuLBz5fqL1vf1LF36YZyLjeMHV72t8C57YOZveUwNjPHQuk4RMQ/VZRTBWRe1
         RKElzdpKP+PxRmshh3XgnWH9eoYxNPL0djmFfRVvAOkb3qEYVlq4O1+Yp4LLwNOzWZIj
         8AzB/uNVzqvOTu1n+9hh35pr+M+UECNd9NSZ7G1+S4nvkS9Le8lcYUTIulXGig5l4Cxb
         7+FDXMrEIck39DiKIaLNeWZPIuNrbezYhS6LgIRmuHVCaaOf2uscI5Qe7KXzlqGvoQKR
         H8Hw==
X-Gm-Message-State: APjAAAUnZ87PMs4V/muiMn63JjSsRv09Ly5M2febIH1Xb9+6TfkUw0VH
        RthT8CHGddPWEX6hO9mtH8vE
X-Google-Smtp-Source: APXvYqyLxk5NmxLppMjRU0bokVzTSlBropM0ly7tfd0bvTL2+Oh1J2ffLSfZ3jt6Zsye2nNtmhyR1Q==
X-Received: by 2002:a17:90a:b38c:: with SMTP id e12mr2855688pjr.114.1570612152588;
        Wed, 09 Oct 2019 02:09:12 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id b14sm1792133pfi.95.2019.10.09.02.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:09:11 -0700 (PDT)
Date:   Wed, 9 Oct 2019 20:09:05 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH v4 1/8] ext4: move out iomap field population into
 separate helper
Message-ID: <20191009090903.GA2125@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <8b4499e47bea3841194850e1b3eeb924d87e69a5.1570100361.git.mbobrowski@mbobrowski.org>
 <20191009060255.8055742049@d06av24.portsmouth.uk.ibm.com>
 <20191009070745.GA32281@infradead.org>
 <20191009075018.8BA0A4203F@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009075018.8BA0A4203F@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 01:20:17PM +0530, Ritesh Harjani wrote:
> On 10/9/19 12:37 PM, Christoph Hellwig wrote:
> > On Wed, Oct 09, 2019 at 11:32:54AM +0530, Ritesh Harjani wrote:
> > > We can also get rid of "first_block" argument here.
> > 
> > That would just duplicate filling it out in all callers, so why?
> > 
> 
> What I meant is "first_block" is same as map->m_lblk.
> (unless ext4_map_blocks can change map->m_lblk, which AFAICT, it should
> not).
> So why pass an extra argument when we are already passing 'map'
> structure.
> So we can fill iomap->offset using map->m_lblk in ext4_set_iomap()
> function.

What you're saying makes sense Ritesh and I will update it as such. I
believe what Christoph was actually referring to was what I explained
to Jan to the email that I just sent out. This was around the possible
code duplication and having some iomap value setting related logic
outside ext4_set_iomap(), when in fact there's no real reason why it
can't be inside.

--<M>--

