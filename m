Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56258EDC4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfKDKQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:16:33 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40683 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfKDKQd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:16:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id r4so11853303pfl.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2019 02:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TJQGiAgKCYWh8wNF9k7wkhKxBP/cvA1DOhIr1NkfKYk=;
        b=bnFQ/lnRqK7i8gWmTJsldq0Hr6vmT9CXNi5Q6o1STOtybU9UETnS0w/5Pn/7CfSUqH
         LCgveX3/8TAKefnhtcB2/6NRv4v9dv0VRWSoDXvPDmYaU1wEkhFk7xfwhSnSDA7Y74Fp
         NT1C7VEQg1XW1g9ygiAW2XrE5JFXgRxvjztdvvz9WGXn69j5gTf5vfJufhqhpKLbJjin
         xo17wfNWU16mp/qR68iNQ5ULGcuxIynjnLOKiABXvGCObKkKYQAS1gM8SiojLXL2PjGy
         DU/RjM6Xs8I4jexzoy3CiHminxwDjJykiYYOH/Ll0DRiOk7r7Xkds8weXF1Pu/bnrMwk
         TPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TJQGiAgKCYWh8wNF9k7wkhKxBP/cvA1DOhIr1NkfKYk=;
        b=qNYTDiOTYTlSdRj7/Y5BxQ8rRXkB17lBS+anjCNDf8lxrbm19QHIKCo4b8XbUhYk04
         wsmbzpbif+8+1YlkXPwUYnZziib//I+09oaOuQe2GFgxXe3y7xIJL5btbs8DR/ekP2Jt
         eDrmYPXWxXjO/GTvT5QfBAWwbShfsJ+Yp9p/QWEI1csKzSMzjTcXNos+6N3xUFWqri8N
         uvW8/nItGvoUBgC2aYZjElrAfooTtg85srUNyk2/gT41ClftW5VGEKn+LoOHSBXYhY7P
         xjjoQlH5m0mq7e4tQ8jeuEO1cbyYQee0mIOA+TGz9jRY8KjMTpf+zIA9rTZU9axMkaOb
         2fQw==
X-Gm-Message-State: APjAAAUYKAyLbrRv0/jGk5Q3dpgHBL4gSTx6CgqbJhJ/dUmh4FT85l0v
        2qbanM1Rfso3V4AI2Yx9h0qc
X-Google-Smtp-Source: APXvYqwAcq82ncb22/mkCdVpY5vng7hH4oNlmpx0znO99V1yS8O9yUtNgWanilHNxX3wDyRaeJyJyQ==
X-Received: by 2002:a17:90a:eb18:: with SMTP id j24mr22020776pjz.85.1572862591457;
        Mon, 04 Nov 2019 02:16:31 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id y2sm16122582pfe.126.2019.11.04.02.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 02:16:30 -0800 (PST)
Date:   Mon, 4 Nov 2019 21:16:25 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/5] Ext4: Add support for blocksize < pagesize for
 dioread_nolock
Message-ID: <20191104101623.GB27115@bobrowski>
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
 <20191023232614.GB1124@mit.edu>
 <20191029071925.60AABA405B@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20191103191606.GB8037@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103191606.GB8037@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 03, 2019 at 02:16:06PM -0500, Theodore Y. Ts'o wrote:
> On Tue, Oct 29, 2019 at 12:49:24PM +0530, Ritesh Harjani wrote:
> > 
> > So it looks like these failed tests does not seem to be because of this
> > patch series. But these are broken in general for at least 1K blocksize.
> 
> Agreed, I failed to add them to the exclude list for diread_nolock_1k.  
> Thanks for pointing that out!   
> 
> After looking through these patches, it looks good.  So, I've landed
> this series on the ext4 git tree.
> 
> There are some potential conflicts with Matthew's DIO using imap patch
> set.  I tried resolving them in the obvious way (see the tt/mb-dio
> branch[1] on ext4.git), and unfortunately, there is a flaky test
> failure with generic/270 --- 2 times out 30 runs of generic/270, the
> file system is left inconsistent, with problems found in the block
> allocation bitmap.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=tt/mb-dio
> 
> I've verified that generic/270 isn't a problem on -rc3, and it's not a
> problem with just your patch series.  So, it's almost certain it's
> because I screwed up the merge.  I applied each of Matthew's patch one
> at a time, and conflict was in changes in ext4_end_io_dio, which is
> dropped in Matthew's patch.  It wasn't obvious though where the
> dioread-nolock-1k change should be applied in Matthew's patch series.
> Could you take a look?  Thanks!!

Hang on a second.

Are we not prematurely merging this series in with master? I thought
that this is something that should've come after the iomap direct I/O
port, no? The use of io_end's within the new direct I/O implementation
are effectively redundant...

/M
