Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B8FEDCD7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfKDKtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:49:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45329 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbfKDKtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:49:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id z4so5879382pfn.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2019 02:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y3+1oxLkBWqYhlfZFqeAByZ3EtluoqxPsa6w3RZjvWM=;
        b=L0UHxeMwYcwPXeVh2uURVkI8DjGYoeFSDDECtu0IJyD/8v85nHeGlOvSVUaEzNZc+k
         bZQguL8s/YfkMHB7DTXu/b9W8XC9Wsoht/3zTwlJV2GH43votFzdtDxNKHWul8A5/ZXp
         sMeTbspZKSx+Ub1iV4jUZQtDlipTDUCyFkfOO25QVEB0GX8qnlg2nn1eu1fa+rhU0QLl
         Sw+sIfessUESxnx+poQlGyYeHNHdsHKZjGbFMqKPfIvMGkxxtZrxOKkbTr/qALm64Mnw
         7/GiirhDgYUlOSlLtdTNA5wHaVlarUr1QNS5C+r0nxRlHg2i/cPzsv6GLrSQf69x39+l
         sxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y3+1oxLkBWqYhlfZFqeAByZ3EtluoqxPsa6w3RZjvWM=;
        b=VrrLy4uCimErDsnwfzP2vkkFsu03DPiW6CQLOIqEM42wzJhRraVfyNaTeQHm9RK/RG
         MB3dLyRVvS/sHjThujzenAHhtTHzslNOK5tCfwSes5LGx/XurzHahOFQjlPWT1UVAqd2
         3lqNUWPUay9Z+hBa+gbTyScSg16YHyDosXljRahW/W81N/NEG4T8+88GLECR1ScOpxr+
         AcwpW3qXutNkvJPHtXQRgn3Dur3Y+TR9wXi9Lz6o41ZZEjEGweFuoSWcfWGoETS0pJE2
         XSED251tBMmhsT85Icakt+MtQGTQiGWShI/Herq7lKVK+OGOEw1kjKnoLoGy4r8NNQPi
         M5VQ==
X-Gm-Message-State: APjAAAW8eRsinINLe1dvVju8J0LPaOqCO8VY9g8r+E/wujEFn62DrLhB
        tIur22TNtunJP3Go1q/5YhbN
X-Google-Smtp-Source: APXvYqz7YDtuxmOS6RWZ3jmqF6RBwJ+dWOL7EftrJ2BmFBQz+rIuo1jRAsJSDvSgKP2UME5GmQvNmA==
X-Received: by 2002:a63:ee44:: with SMTP id n4mr11490821pgk.137.1572864560928;
        Mon, 04 Nov 2019 02:49:20 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id w26sm26108633pfj.123.2019.11.04.02.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 02:49:20 -0800 (PST)
Date:   Mon, 4 Nov 2019 21:49:14 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/5] Ext4: Add support for blocksize < pagesize for
 dioread_nolock
Message-ID: <20191104104913.GC27115@bobrowski>
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
 <20191023232614.GB1124@mit.edu>
 <20191029071925.60AABA405B@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20191103191606.GB8037@mit.edu>
 <20191104101623.GB27115@bobrowski>
 <20191104103759.4085C4C046@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104103759.4085C4C046@d06av22.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:07:56PM +0530, Ritesh Harjani wrote:
> On 11/4/19 3:46 PM, Matthew Bobrowski wrote:
> > On Sun, Nov 03, 2019 at 02:16:06PM -0500, Theodore Y. Ts'o wrote:
> > > On Tue, Oct 29, 2019 at 12:49:24PM +0530, Ritesh Harjani wrote:
> > > > 
> > > > So it looks like these failed tests does not seem to be because of this
> > > > patch series. But these are broken in general for at least 1K blocksize.
> > > 
> > > Agreed, I failed to add them to the exclude list for diread_nolock_1k.
> > > Thanks for pointing that out!
> > > 
> > > After looking through these patches, it looks good.  So, I've landed
> > > this series on the ext4 git tree.
> > > 
> > > There are some potential conflicts with Matthew's DIO using imap patch
> > > set.  I tried resolving them in the obvious way (see the tt/mb-dio
> > > branch[1] on ext4.git), and unfortunately, there is a flaky test
> > > failure with generic/270 --- 2 times out 30 runs of generic/270, the
> > > file system is left inconsistent, with problems found in the block
> > > allocation bitmap.
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=tt/mb-dio
> > > 
> > > I've verified that generic/270 isn't a problem on -rc3, and it's not a
> > > problem with just your patch series.  So, it's almost certain it's
> > > because I screwed up the merge.  I applied each of Matthew's patch one
> > > at a time, and conflict was in changes in ext4_end_io_dio, which is
> > > dropped in Matthew's patch.  It wasn't obvious though where the
> > > dioread-nolock-1k change should be applied in Matthew's patch series.
> > > Could you take a look?  Thanks!!
> > 
> > Hang on a second.
> > 
> > Are we not prematurely merging this series in with master? I thought
> > that this is something that should've come after the iomap direct I/O
> > port, no? The use of io_end's within the new direct I/O implementation
> > are effectively redundant...
> 
> It sure may be giving a merge conflict (due to io_end structure).
> But this dioread_nolock series was not dependent over iomap series.

Uh ha. Well, there's been a chunk of code injected into
ext4_end_io_dio() here and by me removing it, I'm not entirely sure
what the downstream effects will be for this specific change...

/M
