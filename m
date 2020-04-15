Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E651AAFA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411030AbgDOR1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 13:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411013AbgDOR1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:27:43 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B974FC061A0F
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 10:27:42 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s29so6038085edc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQn/ANk0pwHlFuEamxgp0PrtqC/xvAZ3EDlh2VOe0m0=;
        b=yd+J2FgA/lmkvwZA0iSAyzd7KBbCuB/XPFMuZjRayE9JGURa/42PqYHqh7VHqG6yED
         /nIczfFJbvdoQAofGTftRvfbs5J6uDzfmUI7zWxFs+8D4fq0K2r/F4vzakBSi+Gwk7Bx
         X0xvX3stfs4GjV5EQpXvDPsua3QTuXUI9TSVNKzn1db2Q+eV16gw9MpJQd57dpb6Sr/D
         1E623YfOYHf9Av67Mp04BaCkBoZRhDoZNiVRCSubUb/X8dM1J+YRK975cPajYodiP5EX
         jhAtPq7673DF9HC3HsRN0ErLQCEH1HelkhzITVfbeLqLsX5cmWmt1bDXCJmLiAloPWcj
         YC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQn/ANk0pwHlFuEamxgp0PrtqC/xvAZ3EDlh2VOe0m0=;
        b=LS9JMXoXD5yIS9j8QQWPfr8Qh3DUZhLK11f6bt2B7XO7q6gKy7vB1zV4FXhWDestX7
         1i4dd0u3yILCPgVW7jNKgkhwmMheoXx/XXlAJWWhy54kQ3qFQdZXEauXIWKyPZmZ1pDs
         /nidS6jCGOI/BtCc4tDtC40fgWpvbU0dswjG6JPRW3hY34ymjAX7qVo9hXqfScO2gHvt
         C6uZQcrIfGfTfkDD+Z7GleHGu1BzmaQkcZmdW5QwXKjuEKOkU5EOrh0QdOwByYJKm0on
         KV5FWgA412bSS+6/Cr7KraxAm4PbcFlQNrOSSxv0EbVv9LEJdRngMCs6Si6LHZX0Thpi
         Pf3Q==
X-Gm-Message-State: AGi0PuaGGz6RxUG+WojXyIO7d8dy93/fAa1wUh03NK4DbDPz2ROVa6hd
        hIGc4DVP3Mh67M2b4EtAE9zsbHSrQCrUfLvyy/BG3LQI7O4=
X-Google-Smtp-Source: APiQypJQto6RgiMwvrOJoJJZzQ2YMTpz2NolWBUDftzJdaKnsDAKa/cP6mTGhuplHbMRPC1NtLSayFuBX50THyRB8Ng=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr5854049ejj.317.1586971661463;
 Wed, 15 Apr 2020 10:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200414040030.1802884-1-ira.weiny@intel.com> <20200414040030.1802884-4-ira.weiny@intel.com>
 <20200415160307.GJ90651@mit.edu>
In-Reply-To: <20200415160307.GJ90651@mit.edu>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 Apr 2020 10:27:30 -0700
Message-ID: <CAPcyv4jmBRsexpW2=SxqatbMK_u2aZcGnjeF+76=XwrCHfPoXA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/8] fs/ext4: Disallow encryption if inode is DAX
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 9:03 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Apr 13, 2020 at 09:00:25PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Encryption and DAX are incompatible.  Changing the DAX mode due to a
> > change in Encryption mode is wrong without a corresponding
> > address_space_operations update.
> >
> > Make the 2 options mutually exclusive by returning an error if DAX was
> > set first.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> The encryption flag is inherited from the containing directory, and
> directories can't have the DAX flag set, so anything we do in
> ext4_set_context() will be safety belt / sanity checking in nature.
>
> But we *do* need to figure out what we do with mount -o dax=always
> when the file system might have encrypted files.  My previous comments
> about the verity flag and dax flag applies here.
>
> Also note that encrypted files are read/write so we must never allow
> the combination of ENCRPYT_FL and DAX_FL.  So that may be something
> where we should teach __ext4_iget() to check for this, and declare the
> file system as corrupted if it sees this combination.  (For VERITY_FL
> && DAX_FL that is a combo that we might want to support in the future,
> so that's probably a case where arguably, we should just ignore the
> DAX_FL for now.)

We also have a pending consideration for what MKTME (inline memory
encryption with programmable hardware keys) means for file-encryption
+ dax. Certainly kernel based software encryption is incompatible with
dax, but one of the hallway track discussions I wanted to have at LSF
is whether fscrypt is the right interface for managing inline memory
encryption. For now, disallowing ENCRPYT_FL + DAX_FL seems ok if
ENCRPYT_FL always means software encryption, but this is something to
circle back to once we get MKTME implemented for volume encryption and
start to look at finer grained (per-directory key) encryption.
