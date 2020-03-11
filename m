Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F43181EC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 18:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgCKRHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 13:07:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40348 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgCKRHu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:07:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id y71so2606843oia.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2lvDdSLPhmcM0nXdmXNuB/sfxCFsfZa1DAwoATiN2U=;
        b=C9ioYl0fzU/vmkecoyhX5BivhKG5b1jtS5V7vkjWOi0PiELjheJ1R7QdbXo9TuQysN
         1IY2fq/TBnNmInGLeEDCh9Qg2FQPnwr45qh6swtd5Q15fbPVwPnXkCsXB+xAGAvG4adz
         4pNukYlTfGqeQfrlNRzbfK46LmVnw+4AdBzAKJ4KQ+UvRNhB5A0lbDMBYMN58JDrQch+
         oX7mhxiYWNyX5vHzUU02K0pFLjUB+uLzDkt4Ih+CrGHBmXGEGor3jeQlS9bS4aed6zJR
         BNVlWCs49Q2ZXXJf0Kl9+b5Oc1HBCpMZOUmjYXZdiHusPlLa5qph+Sy0JONGt0kTD9Q4
         qxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2lvDdSLPhmcM0nXdmXNuB/sfxCFsfZa1DAwoATiN2U=;
        b=jyaQMnGGMjzJYNFfVDUyqDFaiHVz++7+c4cpNIxNWmO/AUUlF0diX+zZnuQlKZ4SUS
         sfiyMl2TjtOk3Q7RZvlmlIz/48IPm5/s1R3MuJA3ZGECmBttmMOhMfmCU5vQ48mcuNAJ
         MykMtR5Sxa5XUzOi9b63I8bBjcLDUH2cAS86NJyarAOgaTEuNYNhMbHhjpo991u5JakE
         VPBGjEkliJVVxzzPqN8slryrTgMMfW1IfJe6L451L0pNremSumtn5tIHVkvGU2p4Pd0n
         Vi+iKr3AQet44VIAV2FsFRYOhvD2MJBA/xjWSwXV5248GMt3pgC2ySXcMNhU0HqsDCS+
         iL5Q==
X-Gm-Message-State: ANhLgQ3ggq2iyjaCUK8FkJfPs8u7qMBNsE5qZoc9BSvLPOUWb7X+oQFR
        BbHjf7NTGOcwVwo21V1oBCt5GviwUMl3Lv+340lmGg==
X-Google-Smtp-Source: ADFU+vtHWaxjCHodf/i8X2TsY67+jZq3h7w3Q9evQy7tS+y4d+px/3vFxbGvBUdESzEm1GeGh5OUonvksn5m8/27xO4=
X-Received: by 2002:a54:4585:: with SMTP id z5mr2651107oib.149.1583946470021;
 Wed, 11 Mar 2020 10:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200227052442.22524-1-ira.weiny@intel.com> <20200305155144.GA5598@lst.de>
 <20200309170437.GA271052@iweiny-DESK2.sc.intel.com> <20200311033614.GQ1752567@magnolia>
 <20200311063942.GE10776@dread.disaster.area> <20200311064412.GA11819@lst.de>
In-Reply-To: <20200311064412.GA11819@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Mar 2020 10:07:38 -0700
Message-ID: <CAPcyv4jk5i0hPpqbZNPhUH8wKPS66pd48xNoPnQpy6vt72+i=w@mail.gmail.com>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:44 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Mar 11, 2020 at 05:39:42PM +1100, Dave Chinner wrote:
> > IOWs, the dax_associate_page() related functionality probably needs
> > to be a filesystem callout - part of the aops vector, I think, so
> > that device dax can still use it. That way XFS can go it's own way,
> > while ext4 and device dax can continue to use the existing mechanism
> > mechanisn that is currently implemented....
>
> s/XFS/XFS with rmap/, as most XFS file systems currently don't have
> that enabled we'll also need to keep the legacy path around.

Agree, it needs to be an opt-in capability as ext4 and xfs w/o rmap
will stay on the legacy path for the foreseeable future.
