Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3E60A3A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfGEQZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 12:25:52 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56512 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728384AbfGEQZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:25:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5EA708EE1F7;
        Fri,  5 Jul 2019 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562343951;
        bh=j5siNec8f0KH3zaO1peKSkgc0P9jF/HcPXFGD6ywRP4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H1ikrP/GE4tzcp7wG8mCbdPi/qV/0kxUTTuDwIGAhFh/cIQEXPiCi1YbHJ0pZe9EV
         hPQgOUtB7mST5pqwnsODhYaKRGKTlsrl7oFkSKWh2gIaAb6ReSLlsoWmBwDW7htwXG
         ugKnzzrZZa9YbCOw4FSolNKMibLpecJf/VO+pDGk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hhg3ZBtRYrRg; Fri,  5 Jul 2019 09:25:51 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E1A488EE0CF;
        Fri,  5 Jul 2019 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562343951;
        bh=j5siNec8f0KH3zaO1peKSkgc0P9jF/HcPXFGD6ywRP4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H1ikrP/GE4tzcp7wG8mCbdPi/qV/0kxUTTuDwIGAhFh/cIQEXPiCi1YbHJ0pZe9EV
         hPQgOUtB7mST5pqwnsODhYaKRGKTlsrl7oFkSKWh2gIaAb6ReSLlsoWmBwDW7htwXG
         ugKnzzrZZa9YbCOw4FSolNKMibLpecJf/VO+pDGk=
Message-ID: <1562343948.2953.8.camel@HansenPartnership.com>
Subject: Question about ext4 testing: need to produce a high depth extent
 tree to verify mapping code
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Date:   Fri, 05 Jul 2019 09:25:48 -0700
In-Reply-To: <20190702203937.GG3032@mit.edu>
References: <1562021070.2762.36.camel@HansenPartnership.com>
         <20190702002355.GB3315@mit.edu>
         <1562028814.2762.50.camel@HansenPartnership.com>
         <20190702173301.GA3032@mit.edu>
         <1562095894.3321.52.camel@HansenPartnership.com>
         <20190702203937.GG3032@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've got preliminary ext4 support for palo completed.  My original plan
was to switch our boot loader (iplboot) to using libext2fs, but that
proved to be impossible due to the external dependencies libext2fs
needs which we simply can't provide in a tiny bootloader, so I switched
to simply adding support for variable sized groups and handling extent
based files in our original code.  Right at the moment we only support
reading files for the kernel and the initrd, so we have a simple
routine that loads blocks monotonically by mapping from inode relative
to partition absolute.  It's fairly simple to cache the extent tree at
all depths and use a similar resolution scheme for extent based
filesystems.  I'll add this list on cc to the initial patch so you can
check it.

Now the problem: I'd like to do some testing with high depth extent
trees to make sure I got this right, but the files we load at boot are
~20MB in size and I'm having a hard time fragmenting the filesystem
enough to produce a reasonable extent (I've basically only got to a two
level tree with two entries at the top).  Is there an easy way of
producing a high depth extent tree for a 20MB file?

Thanks,

James

