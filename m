Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FA57C74C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 17:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfGaPrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 11:47:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38105 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfGaPrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:47:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id n11so67033681qtl.5;
        Wed, 31 Jul 2019 08:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83OSe7y2aU72IIQHUhZp7X/NaI9ahxBDb1zvEgcPWYg=;
        b=stvDV/xL+VOq1KnvigR23c8LqadzJBpq7gku4pd7eBzYzbbd74+SNY3tPA5WvVQuTy
         SGzXMdHLU3ITXUfPgnhC3hCyCwOYgDfgl+izJPjZMUTEnCxMrfeS7tpb4spbzl50hAIR
         zROeaUOOaBW58TSR7H6lLtUyOIBdu23oM7N/4bwba05eCWZd26W4QGbJ5j9gMWUeD2ZJ
         fDIPs3UBfdppH7m4v3bEAOzgLoTVqJeDdWhKVF4DtGO4rfHMNYooFf8g/paKicylCcG1
         B3ikbi1liLsYSnXro7cJrqYRVmUebEqfmexBfPczc4xVkQ8UgxnADFA9etLFevPz0vOS
         kSVw==
X-Gm-Message-State: APjAAAVNGbix6pwlmZtLTjVqNjHbcdKw8d1VJMX0GN8PMvzxOPxRhVGF
        I0jOA8GZUn+cbDEpm7HHO2liQRYDtaBP682FQN0=
X-Google-Smtp-Source: APXvYqyxedT2V2Y2ueteq5CdjTWcyt+qnzC20u56SIyvSN4Tvj+mYfIXi7Eg+U3QdqrIQo3qfLl+9AJWummnynXCsSA=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr88044697qve.45.1564588070611;
 Wed, 31 Jul 2019 08:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190730192552.4014288-1-arnd@arndb.de> <20190730195819.901457-1-arnd@arndb.de>
 <20190730195819.901457-3-arnd@arndb.de> <20190731105039.GB3488@osiris>
In-Reply-To: <20190731105039.GB3488@osiris>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 31 Jul 2019 17:47:33 +0200
Message-ID: <CAK8P3a05o37-JPU4RcDGACbhXtLXLn8hWYfkmZskh1r7z8Zo0g@mail.gmail.com>
Subject: Re: [PATCH v5 15/29] compat_ioctl: move tape handling into drivers
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        =?UTF-8?Q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:51 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> On Tue, Jul 30, 2019 at 09:55:31PM +0200, Arnd Bergmann wrote:
> > MTIOCPOS and MTIOCGET are incompatible between 32-bit and 64-bit user
> > space, and traditionally have been translated in fs/compat_ioctl.c.
> >
> > To get rid of that translation handler, move a corresponding
> > implementation into each of the four drivers implementing those commands.
> >
> > The interesting part of that is now in a new linux/mtio.h header that
> > wraps the existing uapi/linux/mtio.h header and provides an abstraction
> > to let drivers handle both cases easily. Using an in_compat_syscall()
> > check, the caller does not have to keep track of whether this was
> > called through .unlocked_ioctl() or .compat_ioctl().
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Besides the two minor things below
>
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Thanks a lot for the reviewed. Both issues are fixed now, and
I'm pushing out new git branches after adding the other Acks
I got so far.

      Arnd
