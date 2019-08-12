Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B37B89F9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 15:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfHLNZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 09:25:43 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:40790 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfHLNZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:25:43 -0400
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hxAKR-00033l-Iv; Mon, 12 Aug 2019 14:25:39 +0100
Message-ID: <53df9d81bfb4ee7ec64fabf1089f91d80dceb491.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 04/20] mount: Add mount warning for impending
 timestamp expiry
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Aug 2019 14:25:38 +0100
In-Reply-To: <CABeXuvruROn7j1DiCDbP6MLBt9SB4Pp3HoKqcQbUNPDJgGWLgw@mail.gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
         <20190730014924.2193-5-deepa.kernel@gmail.com>
         <c508fe0116b77ff0496ebb17a69f756c47be62b7.camel@codethink.co.uk>
         <CABeXuvruROn7j1DiCDbP6MLBt9SB4Pp3HoKqcQbUNPDJgGWLgw@mail.gmail.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2019-08-10 at 13:44 -0700, Deepa Dinamani wrote:
> On Mon, Aug 5, 2019 at 7:14 AM Ben Hutchings
> <ben.hutchings@codethink.co.uk> wrote:
> > On Mon, 2019-07-29 at 18:49 -0700, Deepa Dinamani wrote:
> > > The warning reuses the uptime max of 30 years used by the
> > > setitimeofday().
> > > 
> > > Note that the warning is only added for new filesystem mounts
> > > through the mount syscall. Automounts do not have the same warning.
> > [...]
> > 
> > Another thing - perhaps this warning should be suppressed for read-only
> > mounts?
> 
> Many filesystems support read only mounts only. We do fill in right
> granularities and limits for these filesystems as well. In keeping
> with the trend, I have added the warning accordingly. I don't think I
> have a preference either way. But, not warning for the red only mounts
> adds another if case. If you have a strong preference, I could add it
> in.

It seems to me that the warning is needed if there is a possibility of
data loss (incorrect timestamps, potentially leading to incorrect
decisions about which files are newer).  This can happen only when a
filesystem is mounted read-write, or when a filesystem image is
created.

I think that warning for read-only mounts would be an annoyance to
users retrieving files from old filesystems.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

